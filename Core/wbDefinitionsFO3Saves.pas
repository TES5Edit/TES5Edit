{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbDefinitionsFO3Saves;

interface

procedure DefineFO3Saves;
procedure SwitchToFO3CoSave;

implementation

uses
  Types,
  Classes,
  SysUtils,
  Math,
  Variants,
  wbInterface,
  wbSaveInterface,
  wbImplementation,
  wbLocalization,
  wbDefinitionsCommon,
  wbDefinitionsFO3;

var
  wbActorValueLabels : array of string;

var // forward type directives
  wbChangeTypes    : IwbEnumDef;
  wbSaveChapters   : IwbStructDef;
  wbCoSaveChapters : IwbStructDef;
  wbSaveHeader     : IwbStructDef;
  wbCoSaveHeader   : IwbStructDef;

procedure DefineFO3SavesA;
var
  i: Integer;
begin
  SetLength(wbActorValueLabels, wbActorValueEnum.NameCount);
  for i := 0 to wbActorValueEnum.NameCount - 1 do
    wbActorValueLabels[i] := wbActorValueEnum.Names[i];
end;

{ FO3saves }

function SaveFormVersionDecider(aMinimum: Integer; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := aElement;
  while Assigned(Element.Container) do
    Element := Element.Container;

  if Supports(Element, IwbContainer, Container) then begin
    Element := Container.ElementByPath['Save File Header\Form Version'];
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      if aType>aMinimum then
        Result := 1;
    end;
  end;
end;

function SaveFormVersion55Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := aElement;
  while Assigned(Element.Container) do
    Element := Element.Container;

  if Supports(Element, IwbContainer, Container) then begin
    Element := Container.ElementByPath['Save File Header\Form Version'];
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      if aType = 55 then
        Result := 1;
    end;
  end;
end;

// Seen version checked so far 36*, 55, 64, 73* and 74

function SaveFormVersionGreaterThan35Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
    Result := SaveFormVersionDecider(36, aBasePtr, aEndPtr, aElement);
end;

function SaveFormVersionGreaterThan72Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
    Result := SaveFormVersionDecider(73, aBasePtr, aEndPtr, aElement);
end;

function ScreenShotDataCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := aElement;
  while Assigned(Element.Container) do
    Element := Element.Container;

  if Supports(Element, IwbContainer, Container) then begin
    Element := Container.ElementByPath['Save File Header\Header\Screenshot Width'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
      Element := Container.ElementByPath['Save File Header\Header\Screenshot Height'];
      if Assigned(Element) then begin
        Result := 3 * Result * Element.NativeValue;
      end;
    end;
  end;
end;

function FileLocationTableCountCounter(aName: String; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := aElement;
  while Assigned(Element.Container) do
    Element := Element.Container;

  if Supports(Element, IwbContainer, Container) then begin
    Element := Container.ElementByPath['Save File Header\File Location Table\'+aName+' Count'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function GlobalDataCounter(aIndex: Integer; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := FileLocationTableCountCounter('Global Data Table '+IntToStr(aIndex), aBasePtr, aEndPtr, aElement);
end;

function GlobalData1Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := GlobalDataCounter(1, aBasePtr, aEndPtr, aElement);
end;

function GlobalData2Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := GlobalDataCounter(2, aBasePtr, aEndPtr, aElement);
end;

function GlobalData3Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := GlobalDataCounter(3, aBasePtr, aEndPtr, aElement) + 1;  // +1 due to the bug as seen on UESP
end;

function ChangedFormsCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := FileLocationTableCountCounter('Changed Forms', aBasePtr, aEndPtr, aElement);
end;

function GlobalData2TableSizeCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('Global Data 2', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Size'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function GlobalDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := aElement;
  while (Pos('Global Data ', Element.Name)=0) and Assigned(Element.Container) do
    Element := Element.Container;

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      if (aType >= 0) and (aType <= 11) then // 0 to 11 = 12
        Result := aType + 1
      else  if (aType >= 1000) and (aType <= 1000) then // 1000 to 1000 = 1
        Result := aType - 1000 + 12 + 1;
    end;
    if (Result > 12) then Result := 0; //Others are not decoded yet
    if Assigned(ChaptersToSkip) and ChaptersToSkip.Find(IntToStr(aType), aType)  then // "Required" time optimisation (can save "hours" if used on 1001)
      Result := 0;
  end;
end;

var
  WorldspaceTableCount : Integer = -1;

procedure WorldspaceTableAfterLoad(const aElement: IwbElement);
begin
  if WorldspaceTableCount < 0 then begin
    WorldspaceTableCount := (aElement as IwbContainer).ElementCount;
    InitializeSaveWorldspaceArray(aElement as IwbContainer);
  end;
end;

var
  RefIDTableCount : Integer = -1;

procedure RefIDTableAfterLoad(const aElement: IwbElement);
begin
  if RefIDTableCount < 0 then begin
    RefIDTableCount := (aElement as IwbContainer).ElementCount;
    InitializeSaveRefIDArray(aElement as IwbContainer);
  end;
end;

function Unknown1000_00001Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aValue : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Unknown1000_0000', aElement);
  Assert(Element.BaseName='Unknown1000_0000');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Unknown1000_00000'];
    if Assigned(Element) then begin
      aValue := Element.NativeValue;
      case aValue of
        0: Result := 0;
      else
        Result := 1;
      end;
    end;
  end;
end;

function GlobalDataGetChapterType(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container : IwbContainer;
begin
  Result := -1;
  if Supports(aElement, IwbContainer, Container) then
    Element := Container.ElementByName['Type'];
  if Assigned(Element) then
    Result := Element.NativeValue;
end;

function GlobalDataGetChapterTypeName(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): String;
var
  Element    : IwbElement;
  Container : IwbContainer;
begin
  if Supports(aElement, IwbContainer, Container) then
    Element :=  Container.ElementByPath['Type'];
  if Assigned(aElement) then
    begin
      Result := Element.Value;
      if (Pos(' ', Result)>0) and (Length(Result)>1) then
        Result := Copy(Result, Pos(' ', Result)+1, Length(Result));
      if (Pos(' ', Result)>0) and (Length(Result)>1) then
        Result := Copy(Result, 1, Pos(' ', Result)-1);
    end
  else
    Result := IntToStr(GlobalDataGetChapterType(aBasePtr, aEndPtr, aElement));
end;

function GlobalDataSizer(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; var CompressedSize: Integer): Cardinal;
begin
  CompressedSize := PCardinal(PByte(aBasePtr) + SizeOf(cardinal))^ + 2*SizeOf(Cardinal);
  Result := CompressedSize;
end;

function GetRelativeDeciderInteger(anOffset: Integer; aSize: Integer; aContainerName, anIntegerName: String;
  aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbContainer;
begin
  Result := MaxInt;
  if Assigned(aBasePtr) and Assigned(aEndPtr) and (Cardinal(aBasePtr)<=Cardinal(aEndPtr)) then begin
    Assert(anOffset>0); // Offset needs to be a positive number
    case aSize of
      4 : Result := (PCardinal(Cardinal(aBasePtr)-anOffset)^);
      3 : Result := wbReadInteger24(PCardinal(Cardinal(aBasePtr)-anOffset));
      2 : Result := (PWord(Cardinal(aBasePtr)-anOffset)^);
    else
      Result := (PByte(Cardinal(aBasePtr)-anOffset)^);
    end;
  end else begin
    Element := wbFindSaveElement(aContainerName, aElement);
    if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
      if Pos('\', anIntegerName)<>0 then
        Element := Container.GetElementByPath(anIntegerName)
      else
        Element := Container.GetElementByName(anIntegerName);
      if Assigned(Element) then begin
        Result := Element.NativeValue;
      end;
    end;
  end;
end;

function ChangedFormHavokMovedSubBufferCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('Havok Moved SubBuffer', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Length'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function ChangedFormHighProcessSubBufferCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('SubBuffer', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Length'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function ChangedFormGetRawType(var aElement: IwbElement): Integer;
const
  OffsetType = 7;
var
  Container : IwbDataContainer;
  BasePtr   : Pointer;
begin
  Result := -1;
  if not Assigned(aElement) then Exit;
  aElement := wbFindSaveElement('Changed Form', aElement);
  Assert(aElement.BaseName='Changed Form');

  if Supports(aElement, IwbDataContainer, Container) then begin
    with Container do if IsValidOffset(DataBasePtr, DataEndPtr, OffsetType) then begin // we are part a proper structure
      BasePtr := PByte(DataBasePtr) + OffsetType;
      Result := PByte(BasePtr)^;
    end;
  end;
end;

function ChangedFormGetType(var aElement: IwbElement): Integer;
begin
  Result := ChangedFormGetRawType(aElement);
  if Result > 0 then Result := (Result and $3f);
end;

function ChangedFormGetLengthCode(var aElement: IwbElement): Integer;
begin
  Result := ChangedFormGetRawType(aElement);
  if Result>=0 then Result := (Result shr 6);
end;

function IsCreatedDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  anID      : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Changed Form', aElement);
  Assert(Element.BaseName='Changed Form');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['RefID'];
    if Assigned(Element) then begin
      anID := Element.NativeValue;
      if anID shr 22 = 2 then begin
          Result := 1;
      end;
    end;
  end;
end;

function ChangedFormAnimationSubBufferCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('Animation SubBuffer', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Length'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function ChangedFormDataSizer(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; var CompressedSize: Integer): Cardinal;
const
  OffsetLength = 9;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
  BasePtr    : Pointer;
  SizeLength : Integer;
begin
  Result := 0;
  Element := aElement;
  SizeLength := ChangedFormGetLengthCode(Element);

  if (SizeLength >= 0) and Supports(Element, IwbDataContainer, Container) then begin
    BasePtr := Container.DataBasePtr;
    Element := Container.ElementByPath['Datas\CForm Data\Length'];
    if Assigned(Element) then begin
      CompressedSize := Element.NativeValue;
      Result := 0;
    end else with Container do if IsValidOffset(BasePtr, DataEndPtr, OffsetLength) then begin // we are part a proper structure
      aBasePtr := PByte(BasePtr) + OffsetLength;
      case sizeLength of
        0: CompressedSize := PByte(aBasePtr)^;
        1: CompressedSize := PWord(aBasePtr)^;
        2: CompressedSize := PCardinal(aBasePtr)^;
      end;
      Result := 0;
    end;
  end else
    CompressedSize := 0;
end;

function ChangedFormSizer(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; var CompressedSize: Integer): Cardinal;
var
  Struct : IwbStructCDef;
  i      : Integer;
  Size   : Int64;
begin
  CompressedSize := 0;
  if Assigned(aElement) and Supports(aElement.ValueDef, IwbStructCDef, Struct) then
    for i := 0 to Pred(Struct.MemberCount) do begin
      Size := Struct.Members[i].Size[aBasePtr, aEndPtr, aElement];
      if Size<>High(Integer) then begin
        aBasePtr := PByte(aBasePtr) + Size;
        Inc(CompressedSize, Size);
      end;
    end;
  Result := 0;
end;

function ChangedFormGetChapterType(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element : IwbElement;
begin
  Element := aElement;
  Result := ChangedFormGetType(Element);
  if Result >=0 then
    Result := wbChangedFormOffset + Result;
end;

function ChangedFormGetChapterTypeName(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): String;
var
  aType : Integer;
begin
  aType := ChangedFormGetChapterType(aBasePtr, aEndPtr, aElement);
  if (aType>=wbChangedFormOffset) and (aType < wbChangedFormOffset+wbChangeTypes.NameCount) then
    Result := wbChangeTypes.Names[aType-wbChangedFormOffset];
  {
  if (Pos(' ', Result)>0) and (Length(Result)>1) then
    Result := Copy(Result, Pos(' ', Result)+1, Length(Result));
  if (Pos(' ', Result)>0) and (Length(Result)>1) then
    Result := Copy(Result, 1, Pos(' ', Result)-1);
  }
  if Length(Result)=0 then
    Result := IntToStr(aType);
end;

function ChangedFormGetChapterName(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): String;
var
  Element : IwbElement;
begin
  Result := '';
  if not Assigned(aElement) then
    Exit;
  Element := (aElement as iwbContainer).ElementByName['RefID'];
  if not Assigned(Element) then
    Exit;
  Result := Element.Value;
end;

function ChangedFormDataLengthDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
begin
  Result := 3;
  Element := aElement;
  aType := ChangedFormGetLengthCode(Element);

  if aType>=0 then begin
    case aType of
      0: Result := 0;
      1: Result := 1;
      2: Result := 2;
    end;
  end;
end;

function ChangedFormDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType     : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Element := aElement;
  Result := ChangedFormGetType(Element);

  if (Result>=0) and Supports(Element, IwbDataContainer, Container) then begin
    Result := 1 + Result;
    if (Result > 42) then
      Result := 0;
    if Assigned(ChaptersToSkip) and ChaptersToSkip.Find(IntToStr(wbChangedFormOffset+Result), aType)  then // "Required" time optimisation (can save "hours" if used on 1001)
      Result := 0;
  end else
    Result := 0;
end;

function ChangedFormFlagsDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Element := aElement;
  Result := ChangedFormGetType(Element);

  if (Result>=0) and Supports(Element, IwbDataContainer, Container) then begin
    Result := 1 + Result;
    if (Result > 42) then
      Result := 0;
  end else
    Result := 0;
end;

var
  TempChangedFormFlags : Integer;

function ChangedFlagXXDecider(aMask: Cardinal; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;

  if not Assigned(aElement) then Exit;
  Element := nil;
  if Pos('\ Leveled Creature \', aElement.Path)>0 then
    Element := wbFindSaveElement('Leveled Creature', aElement);
  if Assigned(Element) then begin
    if (TempChangedFormFlags and aMask)<>0 then
      Result := 1;
  end else begin
    Element := wbFindSaveElement('Changed Form', aElement);
    Assert(Element.BaseName='Changed Form');

    if Supports(Element, IwbDataContainer, Container) then begin
      Element := Container.ElementByName['Change Flags'];
      if Assigned(Element) then
        if (Element.NativeValue and aMask)<>0 then
          Result := 1;
    end;
  end;
end;

function ChangedFlagBitXXDecider(aMask: Cardinal; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagXXDecider(aMask, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag00Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000001, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag01Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000002, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag02Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000004, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag01or02Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000006, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag03Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000008, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag04Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000010, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag05Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000020, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag06Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000040, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag07Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000080, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag08Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000100, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag09Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000200, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag10Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000400, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag11Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000800, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag11OrCreatedDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000800, aBasePtr, aEndPtr, aElement);
  if Result = 0 then
    Result := IsCreatedDecider(aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag12Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00001000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag13Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00002000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag14Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00004000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag15Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00008000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag16Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00010000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag17Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00020000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag18Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00040000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag19Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00080000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag20Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00100000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag21Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00200000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag22Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00400000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag23Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00800000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag24Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($01000000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag25Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($02000000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag03or25Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($02000008, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag26Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($04000000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag27Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($08000000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag05or27Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($08000020, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag28Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($10000000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag28NotActorDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element: IwbElement;
begin
  Element := aElement;
  Result := ChangedFlagBitXXDecider($10000000, aBasePtr, aEndPtr, aElement);
  if Result = 1 then if (ChangedFormGetType(Element) in [1, 2]) then Result := 0;
end;

function ChangedFlag28ActorDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element: IwbElement;
begin
  Element := aElement;
  Result := ChangedFlagBitXXDecider($10000000, aBasePtr, aEndPtr, aElement);
  if Result = 1 then if not (ChangedFormGetType(Element) in [1, 2]) then Result := 0;
end;

function ChangedFlag29Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($20000000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag30Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($40000000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag29or30Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($40000000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag31Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($80000000, aBasePtr, aEndPtr, aElement);
end;

var
  PlayerRefIndex : Cardinal = 0;

function IsActorPlayerDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  anID      : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Changed Form', aElement);
  Assert(Element.BaseName='Changed Form');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['RefID'];
    if Assigned(Element) then begin
      anID := Element.NativeValue;
      if anID > 0 then begin
        if PlayerRefIndex = 0 then
          if (anID shr 22) = 0 then
            if GetSaveRefID(anID) = wbPlayerRefID then
                PlayerRefIndex := anID;
        if anID = PlayerRefIndex then
          Result := 1;
      end;
    end;
  end;
end;

function InitialDataTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType     : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  Element := aElement;
  aType := ChangedFormGetType(Element);

  if (aType>=0) and Supports(Element, IwbDataContainer, Container) then begin
    if aType = 7 then // CELL
      if (ChangedFlag30Decider(aBasePtr, aEndPtr, aElement)<>0) and
         (ChangedFlag29Decider(aBasePtr, aEndPtr, aElement)<>0) then
        Result := 1
      else if (ChangedFlag30Decider(aBasePtr, aEndPtr, aElement)<>0) and
              (ChangedFlag28Decider(aBasePtr, aEndPtr, aElement)<>0) then
        Result := 2
      else if (ChangedFlag30Decider(aBasePtr, aEndPtr, aElement)<>0) then
        Result := 3;
    if aType in [0,1,2,3,4,5,6,44] then begin  // REFR or descendant
      Element := Container.ElementByName['RefID'];
      if Assigned(Element) and (2 = (Element.NativeValue shr 22)) then // Form is Constructed
        Result := 5
      else if (ChangedFlag03Decider(aBasePtr, aEndPtr, aElement)<>0) then
        Result := 6
      else if (ChangedFlag01or02Decider(aBasePtr, aEndPtr, aElement)<>0) then
        Result := 4;
    end;
  end;
end;

function ChangedFormCellIsInteriorDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  ExteriorOffsetEnd = $20;
begin
  Result := 0;
  // if we are in an Exterior cell, there will be a separor, 21 bytes down
  aBasePtr := PByte(aBasePtr) + ExteriorOffsetEnd;
  if PByte(aBasePtr)^ <> wbTerminator then Result := 1;
end;

function ChangedFormProjectileHasEntryDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('Changed Projectile', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Has Entry Data'];
    if Assigned(Element) and (Element.NativeValue<>0) then begin
      Result := 1;
    end;
  end;
end;

function ChangedFormQuestStageHasLogDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('Data', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Has Log Data'];
    if Assigned(Element) and (Element.NativeValue<>0) then begin
      Result := 1;
    end;
  end;
end;

function Lst0044HasArr0018DataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('Lst044 Data', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Unk00D0'];
    if Assigned(Element) and (Element.NativeValue<>0) then begin
      Result := 1;
    end;
  end;
end;

function Lst0044Has00D4DataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('Lst044 Data', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Unk00D0'];
    if Assigned(Element) and (Element.NativeValue<>0) then begin
      Result := 1;
    end;
  end;
end;

function ChangedFormExtraNonMagicTargetSubCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('Data', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Effect Item Length'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function ChangedFormPackageCreatedFEHasLocationDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Follow/Escort', 'Has Location', aBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) then
    Result := 0;
end;

function ChangedFormPackageCreatedAUEHasLocationDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Ambush/Use Item/Eat', 'Has Location', aBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) then
    Result := 0;
end;

function ChangedFormPackageCreatedDHasLocationDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Dialogue', 'Has Location', aBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) then
    Result := 0;
end;

function ChangedFormPackageCreatedUWHasLocationDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Use Weapon', 'Has Location', aBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) then
    Result := 0;
end;

function ChangedFormPackageCreatedUWHasTargetDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Use Weapon', 'Has Target', aBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) then
    Result := 0;
end;

function ChangedFormPackageLocationTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 7;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Location', 'Type', aBasePtr, aEndPtr, aElement);
  case Result of
    0, 1, 2, 3, 4: Result := 1;
    5: Result := 2;
  else
    Result := 0;
  end;
end;

function ChangedFormPackageTargetTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 12;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Target', 'Type', aBasePtr, aEndPtr, aElement);
  case Result of
    0, 1: Result := 1;
    2: Result := 2;
  else
    Result := 0;
  end;
end;

var // Remembers the offset of the first decider in the group
  ChangedFormPackageCreatedContentFlagsBit0DeciderBasePtr: Pointer = nil;

function ChangedFormPackageCreatedContentFlagsBit0Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  if Assigned(aBasePtr) then
    ChangedFormPackageCreatedContentFlagsBit0DeciderBasePtr := aBasePtr
  else
    ChangedFormPackageCreatedContentFlagsBit0DeciderBasePtr := nil;

  Result := GetRelativeDeciderInteger(Offset, 1, 'Data', 'Content Flags', ChangedFormPackageCreatedContentFlagsBit0DeciderBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 1) = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangedFormPackageCreatedContentFlagsBit1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Data', 'Content Flags', ChangedFormPackageCreatedContentFlagsBit0DeciderBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 2) = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangedFormPackageCreatedContentFlagsBit2Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Data', 'Content Flags', ChangedFormPackageCreatedContentFlagsBit0DeciderBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 4) = 0) then
    Result := 0
  else
    Result := 1;
end;

var // Remembers the offset of the first decider in the group
  ChangedFormPackageActorMoverContentFlagsBit0DeciderBasePtr: Pointer = nil;

function ChangedFormPackageActorMoverContentFlagsBit0Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  if Assigned(aBasePtr) then
    ChangedFormPackageActorMoverContentFlagsBit0DeciderBasePtr := aBasePtr
  else
    ChangedFormPackageActorMoverContentFlagsBit0DeciderBasePtr := nil;

  Result := GetRelativeDeciderInteger(Offset, 1, 'Actor Mover', 'Content Flags', ChangedFormPackageActorMoverContentFlagsBit0DeciderBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 1) = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangedFormPackageActorMoverContentFlagsBit1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Actor Mover', 'Content Flags', ChangedFormPackageActorMoverContentFlagsBit0DeciderBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 2) = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangedFormPackageActorMoverContentFlagsBit2Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Actor Mover', 'Content Flags', ChangedFormPackageActorMoverContentFlagsBit0DeciderBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 4) = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangedFormPackageActorMoverContentFlagsBit3Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Actor Mover', 'Content Flags', ChangedFormPackageActorMoverContentFlagsBit0DeciderBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 8) = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangedFormPathingRequestTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Pathing Request', 'Type', aBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) then
    Result := 0;
end;

function ChangedFormPathingRequestSubStructHasUnk00CDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 25;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'PathingRequest subStruct', 'Byt020', aBasePtr, aEndPtr, aElement);
  if (Result <> 1) then
    Result := 0;
end;

//function ChangedFormPackageCreatedPackageTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
//const
//  Offset = 2;
//begin
//  Result := GetRelativeDeciderInteger(Offset, 1, 'Data', 'Current Package', aBasePtr, aEndPtr, aElement);
//  case Result of
//    0, 4, 5, 6, 7, 10, 11, 12, 14: Result := 0;
//    1, 2: Result := 1;
//    3, 8, 9: Result := 2;
//    13: Result := 3;
//    15, 29: Result := 4;
//    16: Result := 5;
//  else
//    Result := 0;
//  end;
//end;

function ChangedFormPackageCreatedPackageDataTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = (13 - 4) + 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Data', 'General\Type', ChangedFormPackageCreatedContentFlagsBit0DeciderBasePtr, aEndPtr, aElement);
  case Result of
    0, 4, 5, 6, 7, 10, 11, 12, 14: Result := 0;
    1, 2: Result := 1;
    3, 8, 9: Result := 2;
    13: Result := 3;
    15, 28: Result := 4;
    16: Result := 5;
  else
    Result := 0;
  end;
end;

function ChangedFormExtraDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType     : Integer;
  Element   : IwbElement;
begin
  Result := 0;
  Element := aElement;
  aType := ChangedFormGetType(Element);

  if aType>=0 then begin
    if aType in [0,3,4,5,6,44] then  // REFR or descendant
      if ChangedFlagXXDecider($A4021C40, aBasePtr, aEndPtr, aElement)<>0 then
        Result := 1;
    if aType in [1,2] then  // Actor or descendant
      if ChangedFlagXXDecider($A4061840, aBasePtr, aEndPtr, aElement)<>0 then
        Result := 1;
  end;
end;

function ChangedFormExtraScriptEventDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbContainer;
  Value     : Int64;
begin
  Result := 0;
  Element := wbFindSaveElement('Data', aElement);
  if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
    Element := Container.GetElementByName('FlagAndVarID');
    if Assigned(Element) then begin
      Value := Element.NativeValue;
      if ((Value and $80000000) = 0) then
        Result := 1;
    end;
  end;
end;

function ChangedFormEventListHasStruct010Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbContainer;
  Value     : Int64;
begin
  Result := 0;
  Element := wbFindSaveElement('Script Event List', aElement);
  if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
    Element := Container.GetElementByName('has Struct010');
    if Assigned(Element) then begin
      Value := Element.NativeValue;
      if (Value > 0) then
        Result := 1;
    end;
  end;
end;

function ChangedFormActorBaseDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType     : Integer;
  Element   : IwbElement;
  Container : IwbContainer;
begin
  Element := aElement;
  aType := ChangedFormGetType(Element);

  case aType of
    1: Result := 1;
    2: Result := 2;
  else
    Result := 0;
  end;
  if Result > 0 then begin
    Element := wbFindSaveElement('Leveled Creature', aElement);
    if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
      Element := Container.GetElementByName('Actor Base Changed Flags');
      if Assigned(Element) then begin
        TempChangedFormFlags := Element.NativeValue;
      end else
        Result := 0;
    end;
  end;
end;

function ChangeFormExtraPackageTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Package Data', 'Package Data Type', aBasePtr, aEndPtr, aElement);
  case Result of
    0, 1, 3..11, 15: Result := 0;
     2 : Result := 1;
    12 : Result := 2;
    13 : Result := 3;
    14 : Result := 4;
    16 : Result := 5;
  else  // Maxint or 255
    Result := 0;
  end; //   0,5,5,5,5,5,5,5,5,5,1,2,3,5,4
end;

function ChangedExtraUnionDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  ExtraTypeToDecider : array [0..$85] of Byte = (
    $0,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$1,
    $3C,2,3,4,5,6,7,8,9,$3C,
    $0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$3C,$12,
    $13,$14,$3C,$15,$16,$17,$3C,$18,$19,$3C,
    $1A,$3C,$3C,$3C,$1B,$3C,$3C,$1C,$3C,$1D,
    $1E,$3C,$3C,$3C,$3C,$3C,$1F,$20,$3C,$3C,
    $21,$22,$3C,$3C,$23,$24,$3C,$25,$3C,$3C,
    $3C,$26,$27,$28,$3C,$3C,$3C,$3C,$29,$2A,
    $2B,$2C,$2D,$2E,$3C,$3C,$3C,$3C,$3C,$3C,
    $3C,$3C,$3C,$3C,$3C,$2F,$3C,$30,$3C,$31,
    $3C,$3C,$32,$33,$34,$3C,$3C,$3C,$3C,$3C,
    $3C,$35,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,
    $3C,$3C,$3C,$3C,$36,$3C,$37,$3C,$38,$3C,
    $39,$3A,$3A,$3B
  );
var
  aType     : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Extra', aElement);
  Assert(Element.BaseName='Extra');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Extra Type'];
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      if (aType>=$0D) and (aType<=$0D+$85) then
        Result := 1+ExtraTypeToDecider[aType-$0D];
      if Result=$3C+1 then Result := 0;
    end;
  end;
end;

function ChangedFormMobileObjectBaseProcessDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('Changed MobileObject', aElement);
  if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
    Element := Container.GetElementByName('Process Level');
    if Assigned(Element) then
      if Element.NativeValue <> -1 then
        Result := 1;
  end;
end;

function ChangedFormMobileObjectLowProcessDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('Changed MobileObject', aElement);
  if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
    Element := Container.GetElementByName('Process Level');
    if Assigned(Element) then
      if Element.NativeValue < 4 then
        Result := 1;
  end;
end;

function ChangedFormMobileObjectMiddleLowProcessDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('Changed MobileObject', aElement);
  if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
    Element := Container.GetElementByName('Process Level');
    if Assigned(Element) then
      if Element.NativeValue < 3 then
        Result := 1;
  end;
end;

function ChangedFormMobileObjectMiddleHighProcessDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('Changed MobileObject', aElement);
  if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
    Element := Container.GetElementByName('Process Level');
    if Assigned(Element) then
      if Element.NativeValue < 2 then
        Result := 1;
  end;
end;

function ChangedFormMobileObjectHighProcessDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('Changed MobileObject', aElement);
  if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
    Element := Container.GetElementByName('Process Level');
    if Assigned(Element) then
      if Element.NativeValue < 1 then
        Result := 1;
  end;
end;

function ChangedFormList44CData00CDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 3, 'Data', 'Unk020', aBasePtr, aEndPtr, aElement);
  if Result = 1 then
    Result := 1
  else
    Result := 0;
end;

function ChangedFormHasUnk3DCDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 25;
begin
  Result := GetRelativeDeciderInteger(Offset, 3, 'Unk000', 'Has Unk3DC', aBasePtr, aEndPtr, aElement);
  if Result = 1 then
    Result := 1
  else
    Result := 0;
end;

function ChangeFormBaseProcessCreatedPackageDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 4;
begin
  Result := GetRelativeDeciderInteger(Offset, 3, 'Package Struct', 'Package', aBasePtr, aEndPtr, aElement);
  if Result = MaxInt then
    Result := 0
  else if (Result shr 22) = 2 then
        Result := 1
  else
    Result := 0;
end;

function ChangeFormBaseProcessPackageDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 4;
begin
  Result := GetRelativeDeciderInteger(Offset, 3, 'Package Struct', 'Package', aBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) or (Result = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangeFormCreatedPackageDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Created Package Struct', 'Type', aBasePtr, aEndPtr, aElement);
  if Result = MaxInt then
    Result := 0
  else case 1+Result of
     0, 41, 256: Result := 1;  // nothing
    10: Result := 2;      // Change type to 9 (which it should already be), then nothing
    16, 29: Result := 3;  // TESDialoguePackage::Init
    18: Result := 4;      // Change type to 0, then nothing
    19: Result := 5;      // CombatController::Init
    22: Result := 6;      // AlarmPackage::Init
    23: Result := 7;      // FleePackage::Init
    24: Result := 8;      // TressPassPackage::Init
    25: Result := 9;      // SpectatorPackage::Init
    40: Result := 10;     // BackupPackage::Init
  else
    Result := 0;          // TESPackage::Init
  end;  // 0,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah 0
        // 1,0Ah,0Ah,0Ah,0Ah,0Ah,2,0Ah,3,4; 10
        // 0Ah,0Ah,5,6,7,8,0Ah,0Ah,0Ah,2; 20
        // 0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah; 30
        // 9,0                  ; 40
end;

function HasDialogueItemsDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Dialogue Struct', 'Has Dialogue Items', aBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) or (Result = 0) then
    Result := 0
  else
    Result := 1;
end;

var // Remembers the offset of the first decider in the group
  ChangeFormCreatedPackageHasContentFlagBit0DeciderBasePtr: Pointer = nil;

function ChangeFormCreatedPackageHasContentFlagBit0Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  if Assigned(aBasePtr) then
    ChangeFormCreatedPackageHasContentFlagBit0DeciderBasePtr := aBasePtr
  else
    ChangeFormCreatedPackageHasContentFlagBit0DeciderBasePtr := nil;

  Result := GetRelativeDeciderInteger(Offset, 1, 'Unk09C', 'Content Flags', ChangeFormCreatedPackageHasContentFlagBit0DeciderBasePtr,
    aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 1) = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangeFormCreatedPackageHasContentFlagBit1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Unk09C', 'Content Flags', ChangeFormCreatedPackageHasContentFlagBit0DeciderBasePtr,
    aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 2) = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangeFormCreatedPackageHasContentFlagBit2Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Unk09C', 'Content Flags', ChangeFormCreatedPackageHasContentFlagBit0DeciderBasePtr,
    aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 4) = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangeFormCreatedPackageHasContentFlagBit3Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Unk09C', 'Content Flags', ChangeFormCreatedPackageHasContentFlagBit0DeciderBasePtr,
    aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 8) = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangeFormCreatedPackageHasContentFlagBit4Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Unk09C', 'Content Flags', ChangeFormCreatedPackageHasContentFlagBit0DeciderBasePtr,
    aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 16) = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangeFormCreatedPackageHasContentFlagBit5Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Unk09C', 'Content Flags', ChangeFormCreatedPackageHasContentFlagBit0DeciderBasePtr,
    aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 32) = 0) then
    Result := 0
  else
    Result := 1;
end;

var // Remembers the offset of the first decider in the group
  ChangeFormCreatedPackageHasPresentFlagBit0DeciderBasePtr: Pointer = nil;

function ChangeFormCreatedPackageHasPresentFlagBit0Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  if Assigned(aBasePtr) then
    ChangeFormCreatedPackageHasPresentFlagBit0DeciderBasePtr := aBasePtr
  else
    ChangeFormCreatedPackageHasPresentFlagBit0DeciderBasePtr := nil;

  Result := GetRelativeDeciderInteger(Offset, 1, 'Unk09C', 'Present Flags', ChangeFormCreatedPackageHasPresentFlagBit0DeciderBasePtr,
    aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 1) = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangeFormCreatedPackageHasPresentFlagBit1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Unk09C', 'Present Flags', ChangeFormCreatedPackageHasPresentFlagBit0DeciderBasePtr,
    aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 2) = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangeFormCreatedPackageHasPresentFlagBit2Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Unk09C', 'Present Flags', ChangeFormCreatedPackageHasPresentFlagBit0DeciderBasePtr,
    aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 4) = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangeFormCreatedPackageHasPresentFlagBit3Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Unk09C', 'Present Flags', ChangeFormCreatedPackageHasPresentFlagBit0DeciderBasePtr,
    aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 8) = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangeFormCreatedPackageHasPresentFlagBit4Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Unk09C', 'Present Flags', ChangeFormCreatedPackageHasPresentFlagBit0DeciderBasePtr,
    aEndPtr, aElement);
  if (Result = MaxInt) or ((Result and 16) = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangeFormCombatControllerHasUnk0A0Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Combat Controller', 'Has Unk0A0', aBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) or (Result  = 0) then
    Result := 0
  else
    Result := 1;
end;

function ChangeFormCombatProcedureTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  Offset = 2;
begin
  Result := GetRelativeDeciderInteger(Offset, 1, 'Change Combat Procedure', 'Combat Procedure Type', aBasePtr, aEndPtr, aElement);
  if (Result = MaxInt) or (Result  > 14) then
    Result := 0
  else
    Result := 1 + Result;
end;

function ChangedFormRemainingDataCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
  EasC      : IwbDataContainer;
  Origin    : Cardinal;
  Consumed  : Cardinal;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('CForm Data', aElement);
  Assert(Element.BaseName='CForm Data');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Length'];
    if Assigned(Element) and Supports(Element, IwbDataContainer, EasC) then begin
      Result := Element.NativeValue;
    end;
  end;

  if Result > 0 then begin
    Element := wbFindSaveElement('Changed Form Data', aElement);
    Assert(Element.BaseName='Changed Form Data');

    if Supports(Element, IwbDataContainer, Container) then begin
      Assert(Container.ElementCount = 3);
      Origin := Cardinal(Container.DataBasePtr);
      Element := Container.Elements[2];
      if Assigned(Element) and Supports(Element, IwbDataContainer, EasC) then begin
        Consumed := Cardinal(EasC.DataBasePtr) - Origin;
        Result := Result - Consumed;
      end;
    end;
  end;
end;

function SkipCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := wbBytesToSkip;
end;

function DumpCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  if wbBytesToDump = $FFFFFFFF then
    Result := ( Cardinal(aEndPtr) - Cardinal(aBasePtr) ) div wbBytesToGroup + 1
  else
    Result := wbBytesToDump div wbBytesToGroup + 1;
end;

function DataLengthCounter(aName: String; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aModifier: Integer = 0): Cardinal;
var
  Element   : IwbElement;
  Container : IwbDataContainer;

begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement(aName, aElement);
  Assert(Element.BaseName=aName);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['DataLength'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
      case aModifier of
        1: Result := Result div wbBytesToGroup;
        2: Result := Result mod wbBytesToGroup;
      end;
    end;
  end;
end;

function DataLengthRemainderCounter(aName: String; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aModifier: Integer = 0): Cardinal;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
  EasC      : IwbDataContainer;
  Origin    : Cardinal;
  Consumed   : Cardinal;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement(aName, aElement);
  Assert(Element.BaseName=aName);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['DataLength'];
    if Assigned(Element) and Supports(Element, IwbDataContainer, EasC) then begin
      Result := Element.NativeValue + SizeOf(Cardinal);
      Origin := Cardinal(EasC.DataBasePtr);
      Element := Container.ElementByName['Remainder'];
      if Assigned(Element) and Supports(Element, IwbDataContainer, EasC) then begin
        Consumed := Cardinal(EasC.DataBasePtr) - Origin;
        Result := Result - Consumed;
        case aModifier of
          1: Result := Result div wbBytesToGroup;
          2: Result := Result mod wbBytesToGroup;
        end;
      end;
    end;
  end;
end;

function DataCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := DataLengthCounter('Global Data', aBasePtr, aEndPtr, aElement, 0);
end;

function DataQuartetCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := DataLengthRemainderCounter('Global Data', aBasePtr, aEndPtr, aElement, 1);
end;

function DataQuartetRemainderCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := DataLengthRemainderCounter('Global Data', aBasePtr, aEndPtr, aElement, 2);
end;


function CounterCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Quest Runtime Data', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Counter'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function DivByteBy4Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Factions', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Factions Length'];
    if Assigned(Element) then begin
      Result := Element.NativeValue div 4;
    end;
  end;
end;

function FOSEChaptersDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Chunk', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then
      if Element.Value = 'MODS' then
        Result := 1
      else
        Result := 2;
  end;
end;

function wbCoordXYZ(aName: String): IwbArrayDef;
begin
  Result := wbArrayT(aName, wbFloat('Coord'), 3, ['X', 'Y', 'Z'], nil);
end;

procedure DefineFO3SavesS;  // This is all based on the Runtime
var
  wbHeader                   : IwbStructDef;
  wbFileLocationTable        : IwbStructDef;
  wbGlobalData               : IwbStructDef;
  wbChangedForm              : IwbStructDef;
  wbChangedFormData          : IwbStructDef;
  wbNull                     : IwbValueDef;
  wbChangeFlags              : IwbUnionDef;
  wbQuestFlags               : IwbIntegerDef;
  wbInitialDataType01        : IwbStructDef;
  wbInitialDataType02        : IwbStructDef;
  wbInitialDataType03        : IwbStructDef;
  wbInitialDataType04        : IwbStructDef;
  wbInitialDataType05        : IwbStructDef;
  wbInitialDataType06        : IwbStructDef;
  wbInitialDataType          : IwbUnionDef;
  wbChangeFlags010Flags      : IwbFlagsDef;
  wbCoSaveChunk              : IwbStructDef;
  wbCoSaveChunks             : IwbArrayDef;
  wbCoSavePlugin             : IwbStructDef;
  wbCoSavePlugins            : IwbArrayDef;

  wbChangeFlags000        : IwbIntegerDef;
  wbChangeFlags001        : IwbIntegerDef;
  wbChangeFlags002        : IwbIntegerDef;
  wbChangeFlags003        : IwbIntegerDef;
  wbChangeFlags004        : IwbIntegerDef;
  wbChangeFlags005        : IwbIntegerDef;
  wbChangeFlags006        : IwbIntegerDef;
  wbChangeFlags007        : IwbIntegerDef;
  wbChangeFlags008        : IwbIntegerDef;
  wbChangeFlags009        : IwbIntegerDef;
  wbChangeFlags010        : IwbIntegerDef;
  wbChangeFlags011        : IwbIntegerDef;
  wbChangeFlags012        : IwbIntegerDef;
  wbChangeFlags013        : IwbIntegerDef;
  wbChangeFlags014        : IwbIntegerDef;
  wbChangeFlags015        : IwbIntegerDef;
  wbChangeFlags016        : IwbIntegerDef;
  wbChangeFlags017        : IwbIntegerDef;
  wbChangeFlags018        : IwbIntegerDef;
  wbChangeFlags019        : IwbIntegerDef;
  wbChangeFlags020        : IwbIntegerDef;
  wbChangeFlags021        : IwbIntegerDef;
  wbChangeFlags022        : IwbIntegerDef;
  wbChangeFlags023        : IwbIntegerDef;
  wbChangeFlags024        : IwbIntegerDef;
  wbChangeFlags025        : IwbIntegerDef;
  wbChangeFlags026        : IwbIntegerDef;
  wbChangeFlags027        : IwbIntegerDef;
  wbChangeFlags028        : IwbIntegerDef;
  wbChangeFlags029        : IwbIntegerDef;
  wbChangeFlags030        : IwbIntegerDef;
  wbChangeFlags031        : IwbIntegerDef;
  wbChangeFlags032        : IwbIntegerDef;
  wbChangeFlags033        : IwbIntegerDef;
  wbChangeFlags034        : IwbIntegerDef;
  wbChangeFlags035        : IwbIntegerDef;
  wbChangeFlags036        : IwbIntegerDef;
  wbChangeFlags037        : IwbIntegerDef;
  wbChangeFlags038        : IwbIntegerDef;
  wbChangeFlags039        : IwbIntegerDef;
  wbChangeFlags040        : IwbIntegerDef;
  wbChangeFlags041        : IwbIntegerDef;

  wbChangedActorBase      : IwbStructDef;
  wbChangedCREA           : IwbStructDef;
  wbChangedNPC            : IwbStructDef;
  wbChangedExtra          : IwbUnionDef;
  wbChangedREFR           : IwbStructDef;
  wbChangedACHR           : IwbStructDef;
  wbChangedACTI           : IwbStructDef;
  wbChangedMobileObject   : IwbStructDef;
  wbChangedProjectile     : IwbStructDef;
  wbChangedActor          : IwbStructDef;
  wbChangedCharacter      : IwbStructDef;
  wbChangedCreature       : IwbStructDef;
  wbChangedExtraData      : IwbArrayDef;
  wbChangedInventory      : IwbArrayDef;
  wbEntryData             : IwbStructDef;
  wbChangeScriptEventList : IwbStructDef;
  wbPackageLocationData   : IwbStructDef;
  wbPackageTargetData     : IwbStructDef;
//  wbCreatedPackagePackageData : IwbUnionDef;
  wbCreatedPackageDataType : IwbUnionDef;
  wbActorPackageData      : IwbUnionDef;
  wbDialogueItemsData     : IwbStructDef;
  wbDialogueItems         : IwbStructDef;
  wbGlobalDialogueItems   : IwbStructDef;
  wbPackageStruct         : IwbStructDef;
  wbChangePackageStruct   : IwbStructDef;
  wbPathingLocation       : IwbStructDef;
  wbOtherPathingLocation  : IwbStructDef;
  wbPathingCoverLocation  : IwbStructDef;
  wbStructPathing         : IwbStructDef;
  wbStructUnk128or164     : IwbStructDef;
  wbCombatProcedure       : IwbStructDef;
  wbChangeCombatProcedure : IwbStructDef;
  wbNonActorMagicTarget   : IwbArrayDef;
  wbPathingRequest        : IwbStructDef;
  wbPathingRequestSubStruct : IwbStructDef;

  wbUnionCHANGE_FORM_FLAGS : IwbUnionDef;
// no actual data    wbUnionCHANGE_REFR_MOVE : IwbUnionDef;
  wbUnionCHANGE_REFR_HAVOK_MOVE : IwbUnionDef;
// no actual data    wbUnionCHANGE_REFR_CELL_CHANGED : IwbUnionDef;
  wbUnionCHANGE_REFR_SCALE : IwbUnionDef;
  wbUnionCHANGE_REFR_INVENTORY : IwbUnionDef;
// included in Extra...      wbUnionCHANGE_REFR_EXTRA_OWNERSHIP : IwbUnionDef;
// included in Extra...      wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA : IwbUnionDef;
// included in Extra...      wbUnionCHANGE_OBJECT_EXTRA_AMMO : IwbUnionDef;
// no actual data    wbUnionCHANGE_OBJECT_EXTRA_LOCK : IwbUnionDef;
  wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE : IwbUnionDef;
// no actual data    wbUnionCHANGE_OBJECT_OPEN_STATE : IwbUnionDef;
// included in Extra...      wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN : IwbUnionDef;
// identical to wbUnionCHANGE_REFR_INVENTORY  wbUnionCHANGE_REFR_LEVELED_INVENTORY : IwbUnionDef;
  wbUnionCHANGE_REFR_ANIMATION : IwbUnionDef;
// included in Extra...      wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE : IwbUnionDef;
  wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY : IwbUnionDef;
// included in Extra...      wbUnionCHANGE_REFR_EXTRA_GAME_ONLY : IwbUnionDef;
  wbUnionCHANGE_ACTOR_LIFESTATE : IwbUnionDef;
// included in Extra...      wbUnionCHANGE_ACTOR_EXTRA_PACKAGE_DATA : IwbUnionDef;
// included in Extra...      wbUnionCHANGE_ACTOR_EXTRA_MERCHANT_CONTAINER : IwbUnionDef;
// included in Extra...      wbUnionCHANGE_ACTOR_EXTRA_DISMEMBERED_LIMBS : IwbUnionDef;
// included in Extra...      wbUnionCHANGE_ACTOR_LEVELED_ACTOR : IwbUnionDef;
  wbUnionCHANGE_ACTOR_DISPOSITION_MODIFIERS : IwbUnionDef;
  wbUnionCHANGE_ACTOR_TEMP_MODIFIERS : IwbUnionDef;
  wbUnionCHANGE_ACTOR_DAMAGE_MODIFIERS : IwbUnionDef;
  wbUnionCHANGE_ACTOR_OVERRIDE_MODIFIERS : IwbUnionDef;
  wbUnionCHANGE_ACTOR_PERMANENT_MODIFIERS : IwbUnionDef;
  wbUnionCHANGE_CELL_FLAGS : IwbUnionDef;
  wbUnionCHANGE_CELL_FULLNAME : IwbUnionDef;
  wbUnionCHANGE_CELL_OWNERSHIP : IwbUnionDef;
  wbUnionCHANGE_CELL_EXTERIOR_SHORT : IwbUnionDef;
  wbUnionCHANGE_CELL_EXTERIOR_CHAR : IwbUnionDef;
  wbUnionCHANGE_CELL_DETACHTIME : IwbUnionDef;
  wbUnionCHANGE_CELL_SEENDATA : IwbUnionDef;
// no actual data    wbUnionCHANGE_TOPIC_SAIDONCE : IwbUnionDef;
  wbUnionCHANGE_QUEST_FLAGS : IwbUnionDef;
  wbUnionCHANGE_QUEST_SCRIPT_DELAY : IwbUnionDef;
  wbUnionCHANGE_QUEST_OBJECTIVES : IwbUnionDef;
  wbUnionCHANGE_QUEST_SCRIPT : IwbUnionDef;
  wbUnionCHANGE_QUEST_STAGES : IwbUnionDef;
  wbUnionCHANGE_ACTOR_BASE_DATA : IwbUnionDef;
  wbUnionCHANGE_ACTOR_BASE_ATTRIBUTES : IwbUnionDef;
  wbUnionCHANGE_ACTOR_BASE_AIDATA : IwbUnionDef;
  wbUnionCHANGE_ACTOR_BASE_SPELLLIST : IwbUnionDef;
  wbUnionCHANGE_ACTOR_BASE_FULLNAME : IwbUnionDef;
  wbUnionCHANGE_NPC_SKILLS : IwbUnionDef;
  wbUnionCHANGE_NPC_CLASS : IwbUnionDef;
  wbUnionCHANGE_NPC_FACE : IwbUnionDef;
  wbUnionCHANGE_NPC_GENDER : IwbUnionDef;
  wbUnionCHANGE_NPC_RACE : IwbUnionDef;
  wbUnionCHANGE_CREATURE_SKILLS : IwbUnionDef;
  wbUnionCHANGE_BASE_OBJECT_VALUE : IwbUnionDef;
  wbUnionCHANGE_BASE_OBJECT_FULLNAME : IwbUnionDef;
  wbUnionCHANGE_TALKING_ACTIVATOR_SPEAKER : IwbUnionDef;
  wbUnionCHANGE_BOOK_TEACHES_SKILL : IwbUnionDef;

  wbUnionCHANGE_ENCOUNTER_ZONE_FLAGS : IwbUnionDef;
  wbUnionCHANGE_ENCOUNTER_ZONE_GAME_DATA : IwbUnionDef;
  wbUnionCHANGE_CLASS_TAG_SKILLS : IwbUnionDef;
  wbUnionCHANGE_FACTION_FLAGS : IwbUnionDef;
  wbUnionCHANGE_FACTION_REACTIONS : IwbUnionDef;
  wbUnionCHANGE_FACTION_CRIME_COUNTS : IwbUnionDef;

// no actual data  wbUnionCHANGE_PACKAGE_WAITING : IwbUnionDef;
// no actual data  wbUnionCHANGE_PACKAGE_NEVER_RUN : IwbUnionDef;

  wbUnionCHANGE_FORM_LIST_ADDED_FORM : IwbUnionDef;

  wbUnionCHANGE_LEVELED_LIST_ADDED_OBJECT : IwbUnionDef;

  wbUnionCHANGE_WATER_REMAPPED : IwbUnionDef;

  wbUnionCHANGE_PACKAGE_CREATED : IwbUnionDef;

begin
  wbNull := wbByteArray('Unused', -255);

  wbOtherPathingLocation := wbStruct('Pathing Location', [
    wbCoordXYZ('Coords'),
    wbRefIDT('Cell/Worldspace')
  ]);

  wbPathingLocation := wbStruct('Pathing Location', [
    wbCoordXYZ('Coords'),
    wbRefIDT('NavMesh'),              // NavMeshInfo.map[Navmesh] goes into 010
    wbRefIDT('Cell'),                 // Goes into 018
    wbRefIDT('Worldspace'),           // goes into 01C
    wbIntegerT('CoordXandY', itU32),  // key into WorldspaceMap of NavMeshInfo, seems someone created the DEADDEAD key :)
    wbIntegerT('Wrd024', itS16),
    wbIntegerT('Byt026', itU8),
    wbIntegerT('Unknown', itU8)       // if set, combines Worldspace and Unk020 for the value of unk014 then does the same with cell
  ]);

  wbDialogueItemsData := wbStruct('Dialogue Items Data', [
    wbArrayPT('Dialogue Items', wbStruct('Dialogue Item', [
      wbArrayPT('Dialogue Responses', wbStruct('Dialogue Response', [
        wbLenStringT('Response Text', -3),
        wbLenStringT('Voice Filename', -3),
        wbIntegerT('Emotion Type', itU32),
        wbIntegerT('Emotion Value', itU32),
        wbIntegerT('Use emotion animation', itU8),
        wbRefIDT('Speaker Idle'),
        wbRefIDT('Listener Idle'),
        wbRefIDT('Sound')
      ]), -254),
      wbIntegerT('Index', itS16),
      wbRefIDT('TopicInfo'),
      wbRefIDT('Topic'),
      wbRefIDT('Quest'),
      wbRefIDT('Speaker')
    ]), -254),
    wbIntegerT('Index', itS16)
  ]);

  wbDialogueItems := wbStruct('Dialogues Struct', [
    wbIntegerT('Has Dialogue Items', itU8),
    wbUnion('Dialogues', HasDialogueItemsDecider, [
      wbNull,
      wbStruct('Data', [
        wbDialogueItemsData,
        wbIntegerT('Dialogue Item Index', itS16),
        wbIntegerT('Dialogue Response Index', itS16)
      ])
    ])
  ]);

  wbGlobalDialogueItems := wbStruct('Dialogues Struct', [
    wbIntegerT('Has Dialogue Items', itU8),
    wbUnion('Dialogues', HasDialogueItemsDecider, [
      wbNull,
      wbDialogueItemsData
    ])
  ]);

  wbGlobalData := wbStructC('Global Data', GlobalDataSizer, GlobalDataGetChapterType, GlobalDataGetChapterTypeName, nil, [
    wbInteger('Type', itU32),
    wbInteger('DataLength', itU32),
    wbUnion('Data', GlobalDataDecider, [
      wbByteArray('Unknown', DataCounter),  // Single line
      // 0 to 11
      wbArrayPT('Global Data 0', wbIntegerT('Data', itU32), -1),
      wbStruct('Global Data 1', [
        wbIntegerT('Unknown', itU32),
        wbRefIDT('Worldspace'),
        wbIntegerT('CoordX', itS32),
        wbIntegerT('CoordY', itS32),
        wbRefIDT('RefID'),
        wbArray('Coords', wbFloat(''), ['X', 'Y', 'Z']), wbString('Unused', 1),
        wbStruct('Current objective', [
          wbRefIDT('Quest'),
          wbIntegerT('Objective ID', itU32),
          wbFloatT('Unknown'),
          wbIntegerT('Player Level', itU32),
          wbIntegerT('Unknown', itU8)
        ])
      ]),
      wbStruct('Global Data 2', [
        wbArrayPT('TESActorBase', wbStruct('Data', [
          wbRefIDT('TESActorBase'),
          wbIntegerT('Unknown', itU16)
        ]), -254),
        wbIntegerT('Size', itU32),
        wbArrayPT('Rows', wbArrayPT('Columns', wbRefIDT('RefID'), GlobalData2TableSizeCounter), GlobalData2TableSizeCounter)
      ]),
      wbArrayPT('Global Variables', wbStruct('Global', [
        wbRefIDT('Variable'),
        wbFloatT('Value')
      ]), -254),
      wbStruct('Global Data 4', [
        wbIntegerT('Unk0154', itU32),
        wbIntegerT('Unk0158', itU32),         // if form version 18 or later
        wbIntegerT('Unk0103B4', itU32),
        wbIntegerT('Unk0103B8', itU32),
        wbArrayPT('Lst0044s', wbArrayPT('Lst0044', wbStruct('Data', [
            wbIntegerT('Unk0000', itU32),
            wbIntegerT('Unk0004', itU32),
            wbIntegerT('Unk0010', itU32),
            wbIntegerT('Unk0018', itU32),
            wbIntegerT('Unk0028', itU32),
            wbIntegerT('Unk002C', itU32),
            wbIntegerT('Unk0030', itU32),
            wbFloatT('Flt0034'),
            wbIntegerT('Unk0008', itU32),
            wbIntegerT('Unk000C', itU32),
            wbRefIDT('Bound Object'),
            wbRefIDT('Form0024'),
            wbArrayPT('Lst001C', wbFormIDT('FormID'), -254),
            wbArrayPT('Lst0038', wbFormIDT('Faction'), -254)
          ]), -254),
        5)
      ]),
      wbStruct('Global Data 5', [
        wbIntegerT('Unk0034', itU32),
        wbArrayPT('Lst0044', wbStruct('Lst044 Data', [
            wbIntegerT('Unknown', itU32),
            wbIntegerT('Unknown', itU32),
            wbArrayPT('Pathing Locations', wbStruct('Pathing Location', [
              wbByteArrayT('Unk0000', 16),
              wbIntegerT('Unk0010', itU32)
            ]), -254),
            wbArrayPT('Combattants', wbStruct('Data', [
              wbRefIDT('Combattant'),
              wbIntegerT('Unk0004', itU32),
              wbIntegerT('Wrd0048', itU16),
              wbIntegerT('Wrd004A', itU16),
              wbIntegerT('Byt0064', itU8),
              wbIntegerT('Byt0065', itU8),
              wbOtherPathingLocation,
              wbOtherPathingLocation,
              wbOtherPathingLocation,
              wbOtherPathingLocation,      // if form version 14 or later
              wbFloatT('Tim0050'),
              wbFloatT('Tim0054'),
              wbFloatT('Tim0058'),
              wbFloatT('Tim004C'),
              wbFloatT('Tim005C'),
              wbFloatT('Tim0060')    // if form version 13 or later
            ]), -254),
            wbArrayPT('Arr0018', wbStruct('Data', [
              wbRefIDT('RefID'),
              wbIntegerT('Unk0004', itU32),
              wbIntegerT('Unk0008', itU32),
              wbIntegerT('Unk000C', itU32),
              wbIntegerT('Byte', itS8)      // if not 0xFF then dup in array at offset 0x0138
            ]), -254),
            wbIntegerT('Combat Group Strategy Type', itS8),
            wbIntegerT('Byt002C', itU8),
            wbFloatT('Flt0030'),          // Paired
            wbFloatT('Flt0034'),
            wbFloatT('Flt0038'),          // Paired
            wbFloatT('Flt003C'),
            wbIntegerT('Unk0040', itU32),
            wbFloatT('Tim0044'),
            wbFloatT('Flt0048'),          // Paired
            wbFloatT('Flt004C'),
            wbFloatT('Flt00B0'),          // Paired
            wbFloatT('Flt00B4'),
            wbFloatT('Flt00A8'),          // Paired
            wbFloatT('Flt00AC'),
            wbArray('Arr0058', wbStruct('Data', [
              wbFloatT('Flt0000'),          // Paired
              wbFloatT('Flt0004')
            ]), 10),
            wbIntegerT('Unk00D0', itU32),
            wbUnion('Arr0018 Data', Lst0044HasArr0018DataDecider, [ wbNull,
              wbStruct('Data', [
                wbRefIDT('RefID00EC'),
                wbCoordXYZ('Coords'),
                wbFloatT('Flt00D8'),          // Paired
                wbFloatT('Flt00DC'),
                wbFloatT('Flt00E0'),          // Paired
                wbFloatT('Flt00E4'),
                wbFloatT('Tim00E8'),          // if form version 5 or later
                wbOtherPathingLocation,            // 00F0
                wbIntegerT('Unk010C', itU32),
                wbArrayPT('Arr0110', wbStruct('Data', [
                  wbOtherPathingLocation,
                  wbIntegerT('Unk0018', itU32),
                  wbRefIDT('RefID0014'),
                  wbFloatT('Tim0010')
                ]), -254),
                wbArrayPT('Arr0120', wbStruct('Data', [
                  wbRefIDT('Ref0000'),
                  wbRefIDT('Ref0004'),
                  wbIntegerT('Byt0008', itU8),
                  wbIntegerT('Byt0009', itU8),
                  wbIntegerT('Byt000A', itU8)
                ]), -254),
                wbIntegerT('Has Data00D4', itU8),
                wbUnion('Data00D4', Lst0044Has00D4DataDecider, [ wbNull,
                  wbStruct('Data', [
                    wbArrayPT('Arr0004', wbStruct('Data', [
                      wbRefIDT('RefID'),    // key
                      wbRefIDT('Navmesh'),
                      wbArrayPT('Arr000', wbStruct('Data', [
                        wbIntegerT('Byt0000', itU8),
                        wbIntegerT('Unk0018', itU32),
                        wbArrayPT('Arr0004', wbIntegerT('Byte', itU8), -254)
                      ]), -254)
                    ]), -254),
                    wbIntegerT('Unk0018', itU32),
                    wbIntegerT('Unk0044', itU32),
                    wbIntegerT('Unk0048', itU32),
                    wbPathingLocation
                  ])
                ])
              ])
            ]),
            wbFloatT('Flt0050'),          // Paired
            wbFloatT('Flt0054'),
            wbIntegerT('Unk00C0', itU32),
            wbIntegerT('Unk00C4', itU32),
            wbIntegerT('Unk00C8', itU32),
            wbIntegerT('Unk00CC', itU32),
            wbFloatT('Flt00B8'),          // Paired
            wbFloatT('Flt00BC'),
            wbIntegerT('Byt0154', itU8)
          ]), -254),
          wbArrayPT('Arr0014', wbStruct('Data', [
            wbRefIDT('RefID'),
            wbIntegerT('Unk0004', itU32),
            wbFloatT('Tim0008'),
            wbFloatT('Tim000C'),
            wbIntegerT('Unk0010', itU32)
          ]), -254),
          wbArrayPT('Combatant List', wbRefIDT('Combattant'), -254),
          wbFloatT('Tim0020'),
          wbFloatT('Flt0024'),          // Paired
          wbFloatT('Flt0028'),
          wbFloatT('Flt002C'),          // Paired
          wbFloatT('Flt0030')
      ]),
      wbStruct('Global Data 6', [
        wbIntegerT('Unknown', itU32),
        wbIntegerT('Byte', itU8),
        wbIntegerT('Byte', itU8),
        wbIntegerT('Byte', itU8),
        wbIntegerT('Unknown', itU32),
        wbIntegerT('Unknown', itU32),
        wbIntegerT('Length', itU32),      // if form version 12 or greater
        wbByteArray('Unknown')            // if form version 12 or greater
          // it is interpreted as an array of array of 8 bytes, but the save is truncated, pretty hard to code
      ]),
      wbArrayPT('Global Data 7', wbStruct('Data', [
        wbFloatT('Unknown'),
        wbFloatT('Unknown'),               // if form version 14 or greater
        wbRefIDT('Image Space Modifier')
      ]), -254),
      wbStruct('Sky', [
        wbRefIDT('Weather0010'),
        wbRefIDT('Weather0014'),
        wbRefIDT('Weather0018'),
        wbRefIDT('Weather001C'),
        wbIntegerT('Unk00EC', itU32),
        wbIntegerT('Unk00F0', itU32),
        wbIntegerT('Unk00F4', itU32),
        wbIntegerT('Flags0118 bit 3', itU32),
        wbIntegerT('Unk0110', itU32),
        wbStruct('Unk00B4', [                   // if form version 18 or greater
          wbIntegerT('Unk000', itU32),
          wbIntegerT('Unk004', itU32),
          wbIntegerT('Unk008', itU32)
        ]), // else a 12 bytes array
        wbIntegerT('Unk00E4', itU32),
        wbIntegerT('Unk00E8', itU32),
        wbIntegerT('Unk00F8', itU32)
      ]),
      wbStruct('Global Data 9', [
        wbIntegerT('Unknown 11D60CC', itU32),
        wbArrayPT('List 11D6124', wbStruct('Data', [
          wbCoordXYZ('Coords'),
          wbIntegerT('Unk0014', itU32),
          wbRefIDT('RefID'),
          wbArrayPT('Lst0004', wbStruct('Data', [
            wbRefIDT('Form000'),
            wbIntegerT('Unk004', itU8),
            wbIntegerT('Unk008', itU32),
            wbCoordXYZ('Coords'),
            wbFloatT('Tim018'),
            wbIntegerT('Byt01E', itU8),
            wbIntegerT('Byt01C', itU8),
            wbIntegerT('Byt01D', itU8),
            wbIntegerT('Unk020', itU32),
            wbIntegerT('Byt01F', itU8)      // if form version 8 or newer
          ]), -254)
        ]), -254)
      ]),
      wbStruct('Global Data 10', [
        wbIntegerT('Unknown 11DD428', itU32),
        wbIntegerT('Byte 11DD434', itU8),
        wbLenStringT('String 11DD448', -3),
        wbArrayPT('List 11DD58C', wbStruct('Data', [
          wbRefIDT('FormID'),
          wbIntegerT('Byt001C', itU8),
          wbIntegerT('Byt001D', itU8),
          wbIntegerT('Byt001E', itU8),
          wbIntegerT('Byt001F', itU8)
        ]), -254),
        wbArrayPT('List 11DD554', wbStruct('Data', [
          wbRefIDT('RefID'),
          wbStruct('Unk0004', [
            wbIntegerT('Unk0008', itU32),
            wbIntegerT('Unk000C', itU32),
            wbIntegerT('Byt0010', itU8),
            wbIntegerT('Byt0011', itU8),
            wbIntegerT('Unk0014', itU32),
            wbArrayPT('Lst0018', wbRefIDT('RefID'), -254),
            wbGlobalDialogueItems
          ])
        ]), -254),
        wbRefIDT('BoundObject 11DD42C'),
        wbRefIDT('BoundObject 11DD430'),
        wbArrayPT('Radios', wbRefIDT('Radio'), -254)   // if form version 10 or greater
      ]),
      wbRefIDT('Sound'),
      // 1000 to 1000
      wbNull
    ])
//    ,wbByteArray('Remainder', DataRemainderCounter)  // Single line
    ,wbArray('Remainder', wbByteArray('Unknown', wbBytesToGroup), DataQuartetCounter) // per Quartet
    ,wbByteArray('Unknown', DataQuartetRemainderCounter)
  ]);

  wbQuestFlags := wbInteger('Flags', itU16, wbFlags([
    {0x0001} 'Start Game Enabled',
    {0x0002} 'Unknown 2',
    {0x0004} 'Unknown 3',
    {0x0008} 'Allow repeated stages',
    {0x0010} 'Unknown 5',
    {0x0020} 'Unknown 6',
    {0x0040} 'Unknown 7',
    {0x0080} 'Unknown 8',
    {0x0100} 'Run Once',
    {0x0200} 'Exclude from dialogue export',
    {0x0400} 'Warn on alias fill failure',
    {0x0800} 'Unknown 12',
    {0x1000} 'Unknown 13'
  ]));

  wbChangeTypes := wbKey2Data6Enum([
    '00 (03A : REFR)',
    '01 (03B : ACHR)',
    '02 (03C : ACRE)',
    '03 (03D : PMIS)',
    '04 (03E : PGRE)',
    '05 (03F : PBEA)',
    '06 (040 : PFLA)',
    '07 (039 : CELL)',
    '08 (046 : INFO)',
    '09 (047 : QUST)',
    '10 (02A : NPC_)',
    '11 (02B : CREA)',
    '12 (015 : ACTI)',
    '13 (016 : TACT)',
    '14 (017 : TERM)',
    '15 (018 : ARMO)',
    '16 (019 : BOOK)',
    '17 (01A : CLOT)',
    '18 (01B : CONT)',
    '19 (01C : DOOR)',
    '20 (01D : INGR)',
    '21 (01E : LIGH)',
    '22 (01F : MISC)',
    '23 (020 : STAT)',
    '24 (022 : MSTT)',
    '25 (027 : FURN)',
    '26 (028 : WEAP)',
    '27 (029 : AMMO)',
    '28 (02E : KEYM)',
    '29 (02F : ALCH)',
    '30 (030 : IDLM)',
    '31 (031 : NOTE)',
    '32 (061 : ECZN)',
    '33 (007 : CLAS)',
    '34 (008 : FACT)',
    '35 (049 : PACK)',
    '36 (043 : NAVM)',
    '37 (055 : FLST)',
    '38 (02C : LVLC)',
    '39 (02D : LVLN)',
    '40 (034 : LVLI)',
    '41 (04E : WATR)'
  ]);

  // changeType: 000 = formType: 058 : REFR
  wbChangeFlags000 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'CHANGE_OBJECT_EXTRA_ITEM_DATA', // Item Data Extra
    {11} 'CHANGE_OBJECT_EXTRA_AMMO', // Ammo Extra
    {12} 'CHANGE_OBJECT_EXTRA_LOCK', // Lock Extra
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'CHANGE_OBJECT_OPEN_DEFAULT_STATE', // Open Default State
    {23} 'CHANGE_OBJECT_OPEN_STATE', // Open State
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 001 = formType: 059 : ACHR
  wbChangeFlags001 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'CHANGE_ACTOR_LIFESTATE', // Life State
    {11} 'CHANGE_ACTOR_EXTRA_PACKAGE_DATA', // Package Data Extra
    {12} 'CHANGE_ACTOR_EXTRA_MERCHANT_CONTAINER', // Merchant Container
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'CHANGE_ACTOR_EXTRA_DISMEMBERED_LIMBS', // Dismembered Limbs
    {18} 'CHANGE_ACTOR_LEVELED_ACTOR', // Leveled Actor
    {19} 'CHANGE_ACTOR_DISPOSITION_MODIFIERS', // Disp Modifiers
    {20} 'CHANGE_ACTOR_TEMP_MODIFIERS', // Temp Modifiers
    {21} 'CHANGE_ACTOR_DAMAGE_MODIFIERS', // Damage Modifiers
    {22} 'CHANGE_ACTOR_OVERRIDE_MODIFIERS', // Override Modifiers
    {23} 'CHANGE_ACTOR_PERMANENT_MODIFIERS', // Permanent Modifiers
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 002 = formType: 060 : ACRE
  wbChangeFlags002 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'CHANGE_ACTOR_LIFESTATE', // Life State
    {11} 'CHANGE_ACTOR_EXTRA_PACKAGE_DATA', // Package Data Extra
    {12} 'CHANGE_ACTOR_EXTRA_MERCHANT_CONTAINER', // Merchant Container
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'CHANGE_ACTOR_EXTRA_DISMEMBERED_LIMBS', // Dismembered Limbs
    {18} 'CHANGE_ACTOR_LEVELED_ACTOR', // Leveled Actor
    {19} 'CHANGE_ACTOR_DISPOSITION_MODIFIERS', // Disp Modifiers
    {20} 'CHANGE_ACTOR_TEMP_MODIFIERS', // Temp Modifiers
    {21} 'CHANGE_ACTOR_DAMAGE_MODIFIERS', // Damage Modifiers
    {22} 'CHANGE_ACTOR_OVERRIDE_MODIFIERS', // Override Modifiers
    {23} 'CHANGE_ACTOR_PERMANENT_MODIFIERS', // Permanent Modifiers
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 003 = formType: 061 : PMIS
  wbChangeFlags003 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'CHANGE_OBJECT_EXTRA_ITEM_DATA', // Item Data Extra
    {11} 'CHANGE_OBJECT_EXTRA_AMMO', // Ammo Extra
    {12} 'CHANGE_OBJECT_EXTRA_LOCK', // Lock Extra
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'CHANGE_OBJECT_OPEN_DEFAULT_STATE', // Open Default State
    {23} 'CHANGE_OBJECT_OPEN_STATE', // Open State
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 004 = formType: 062 : PGRE
  wbChangeFlags004 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'CHANGE_OBJECT_EXTRA_ITEM_DATA', // Item Data Extra
    {11} 'CHANGE_OBJECT_EXTRA_AMMO', // Ammo Extra
    {12} 'CHANGE_OBJECT_EXTRA_LOCK', // Lock Extra
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'CHANGE_OBJECT_OPEN_DEFAULT_STATE', // Open Default State
    {23} 'CHANGE_OBJECT_OPEN_STATE', // Open State
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 005 = formType: 063 : PBEA
  wbChangeFlags005 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'CHANGE_OBJECT_EXTRA_ITEM_DATA', // Item Data Extra
    {11} 'CHANGE_OBJECT_EXTRA_AMMO', // Ammo Extra
    {12} 'CHANGE_OBJECT_EXTRA_LOCK', // Lock Extra
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'CHANGE_OBJECT_OPEN_DEFAULT_STATE', // Open Default State
    {23} 'CHANGE_OBJECT_OPEN_STATE', // Open State
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 006 = formType: 064 : PFLA
  wbChangeFlags006 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'CHANGE_OBJECT_EXTRA_ITEM_DATA', // Item Data Extra
    {11} 'CHANGE_OBJECT_EXTRA_AMMO', // Ammo Extra
    {12} 'CHANGE_OBJECT_EXTRA_LOCK', // Lock Extra
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'CHANGE_OBJECT_OPEN_DEFAULT_STATE', // Open Default State
    {23} 'CHANGE_OBJECT_OPEN_STATE', // Open State
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 007 = formType: 057 : CELL
  wbChangeFlags007 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_CELL_FLAGS', // Flags
    {02} 'CHANGE_CELL_FULLNAME', // Full name
    {03} 'CHANGE_CELL_OWNERSHIP', // Ownership
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'CHANGE_CELL_EXTERIOR_SHORT', // Exterior Short
    {29} 'CHANGE_CELL_EXTERIOR_CHAR', // Exterior Char
    {30} 'CHANGE_CELL_DETACHTIME', // Detach Time
    {31} 'CHANGE_CELL_SEENDATA' // Seen Data
  ]));

  // changeType: 008 = formType: 070 : INFO
  wbChangeFlags008 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_TOPIC_SAIDONCE' // Said Once
  ]));

  // changeType: 009 = formType: 071 : QUST
  wbChangeFlags009 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_QUEST_FLAGS', // Quest Flags
    {02} 'CHANGE_QUEST_SCRIPT_DELAY', // Quest Script Delay
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'CHANGE_QUEST_OBJECTIVES', // Quest Objectives
    {30} 'CHANGE_QUEST_SCRIPT', // Quest Script
    {31} 'CHANGE_QUEST_STAGES' // Quest Stages
  ]));

  // changeType: 010 = formType: 042 : NPC_
  wbChangeFlags010Flags := wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_ACTOR_BASE_DATA', // Base Data
    {02} 'CHANGE_ACTOR_BASE_ATTRIBUTES', // Attributes
    {03} 'CHANGE_ACTOR_BASE_AIDATA', // AI Data
    {04} 'CHANGE_ACTOR_BASE_SPELLLIST', // Spell List
    {05} 'CHANGE_ACTOR_BASE_FULLNAME', // Full Name
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'CHANGE_NPC_SKILLS', // NPC Skills
    {10} 'CHANGE_NPC_CLASS', // Class
    {11} 'CHANGE_NPC_FACE', // Face
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'CHANGE_NPC_GENDER', // Gender
    {25} 'CHANGE_NPC_RACE', // Race
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]);
  wbChangeFlags010 := wbInteger('Change Flags', itU32 , wbChangeFlags010Flags);

  // changeType: 011 = formType: 043 : CREA
  wbChangeFlags011 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_ACTOR_BASE_DATA', // Base Data
    {02} 'CHANGE_ACTOR_BASE_ATTRIBUTES', // Attributes
    {03} 'CHANGE_ACTOR_BASE_AIDATA', // AI Data
    {04} 'CHANGE_ACTOR_BASE_SPELLLIST', // Spell List
    {05} 'CHANGE_ACTOR_BASE_FULLNAME', // Full Name
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'CHANGE_CREATURE_SKILLS', // Creature Skills
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 012 = formType: 021 : ACTI
  wbChangeFlags012 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 013 = formType: 022 : TACT
  wbChangeFlags013 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'CHANGE_TALKING_ACTIVATOR_SPEAKER', // Speaker
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 014 = formType: 023 : TERM
  wbChangeFlags014 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 015 = formType: 024 : ARMO
  wbChangeFlags015 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 016 = formType: 025 : BOOK
  wbChangeFlags016 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'CHANGE_BOOK_TEACHES_SKILL', // Teaches Skill
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 017 = formType: 026 : CLOT
  wbChangeFlags017 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 018 = formType: 027 : CONT
  wbChangeFlags018 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 019 = formType: 028 : DOOR
  wbChangeFlags019 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 020 = formType: 029 : INGR
  wbChangeFlags020 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 021 = formType: 030 : LIGH
  wbChangeFlags021 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 022 = formType: 031 : MISC
  wbChangeFlags022 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 023 = formType: 032 : STAT
  wbChangeFlags023 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 024 = formType: 034 : MSTT
  wbChangeFlags024 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 025 = formType: 039 : FURN
  wbChangeFlags025 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 026 = formType: 040 : WEAP
  wbChangeFlags026 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 027 = formType: 041 : AMMO
  wbChangeFlags027 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 028 = formType: 046 : KEYM
  wbChangeFlags028 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 029 = formType: 047 : ALCH
  wbChangeFlags029 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 030 = formType: 048 : IDLM
  wbChangeFlags030 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 031 = formType: 049 : NOTE
  wbChangeFlags031 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_NOTE_READ' // Note Read
  ]));

  // changeType: 032 = formType: 097 : ECZN
  wbChangeFlags032 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_ENCOUNTER_ZONE_FLAGS', // Zone Flags
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_ENCOUNTER_ZONE_GAME_DATA' // Game Data
  ]));

  // changeType: 033 = formType: 007 : CLAS
  wbChangeFlags033 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_CLASS_TAG_SKILLS', // Tag Skills
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 034 = formType: 008 : FACT
  wbChangeFlags034 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_FACTION_FLAGS', // Faction Flags
    {02} 'CHANGE_FACTION_REACTIONS', // Faction Reactions
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_FACTION_CRIME_COUNTS' // Faction Crime Counts
  ]));

  // changeType: 035 = formType: 073 : PACK
  wbChangeFlags035 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'CHANGE_PACKAGE_WAITING', // Waiting Flag
    {31} 'CHANGE_PACKAGE_NEVER_RUN' // Never Run Flag
  ]));

  // changeType: 036 = formType: 067 : NAVM
  wbChangeFlags036 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 037 = formType: 085 : FLST
  wbChangeFlags037 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_FORM_LIST_ADDED_FORM' // Added Form
  ]));

  // changeType: 038 = formType: 044 : LVLC
  wbChangeFlags038 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_LEVELED_LIST_ADDED_OBJECT' // Added Object
  ]));

  // changeType: 039 = formType: 045 : LVLN
  wbChangeFlags039 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_LEVELED_LIST_ADDED_OBJECT' // Added Object
  ]));

  // changeType: 040 = formType: 052 : LVLI
  wbChangeFlags040 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_LEVELED_LIST_ADDED_OBJECT' // Added Object
  ]));

  // changeType: 041 = formType: 078 : WATR
  wbChangeFlags041 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_WATER_REMAPPED' // Remapped
  ]));

  wbChangeFlags := wbUnion('Change Flags', ChangedFormFlagsDecider, [
    wbNull,
    wbChangeFlags000,
    wbChangeFlags001,
    wbChangeFlags002,
    wbChangeFlags003,
    wbChangeFlags004,
    wbChangeFlags005,
    wbChangeFlags006,
    wbChangeFlags007,
    wbChangeFlags008,
    wbChangeFlags009,
    wbChangeFlags010,
    wbChangeFlags011,
    wbChangeFlags012,
    wbChangeFlags013,
    wbChangeFlags014,
    wbChangeFlags015,
    wbChangeFlags016,
    wbChangeFlags017,
    wbChangeFlags018,
    wbChangeFlags019,
    wbChangeFlags020,
    wbChangeFlags021,
    wbChangeFlags022,
    wbChangeFlags023,
    wbChangeFlags024,
    wbChangeFlags025,
    wbChangeFlags026,
    wbChangeFlags027,
    wbChangeFlags028,
    wbChangeFlags029,
    wbChangeFlags030,
    wbChangeFlags031,
    wbChangeFlags032,
    wbChangeFlags033,
    wbChangeFlags034,
    wbChangeFlags035,
    wbChangeFlags036,
    wbChangeFlags037,
    wbChangeFlags038,
    wbChangeFlags039,
    wbChangeFlags040,
    wbChangeFlags041
  ]);

  wbChangeScriptEventList := wbStruct('Script Event List', [
    wbArrayPT('Vars', wbStruct('Data', [
      wbIntegerT('FlagAndVarID', itU32),
      wbUnion('Var', ChangedFormExtraScriptEventDecider, [
        wbRefIDT('RefID'),
        wbDoubleT('Value')
      ])
    ]), -254),
    wbIntegerT('has Struct010', itU8),
    wbUnion('Unknown', ChangedFormEventListHasStruct010Decider, [ wbNull, wbByteArrayT('Struct010', 8)]),
    wbIntegerT('Set kEvent_OnLoad', itU8)  // only if form version is 0x15 or greater
  ]);

  wbUnionCHANGE_FORM_FLAGS := wbUnion('Flags', ChangedFlag00Decider, [wbNull, wbIntegerT('Flags', itu32, wbFlags(wbFlagsList([])))]);

// no actual data    wbUnionCHANGE_REFR_MOVE := wbUnion('Moved', ChangedFlag01Decider, [wbNull, wbNull]);

  wbUnionCHANGE_REFR_HAVOK_MOVE := wbUnion('Havok Moved', ChangedFlag02Decider, [wbNull,
    wbStruct('Havok Moved SubBuffer', [
      wbIntegerT('Length', itU6to30),
      wbByteArray('Data', ChangedFormHavokMovedSubBufferCounter)
    ])
  ]);

// no actual data    wbUnionCHANGE_REFR_CELL_CHANGED := wbUnion('Cell Changed', ChangedFlag03Decider, [wbNull, wbNull]);

  wbUnionCHANGE_REFR_SCALE := wbUnion('Scale', ChangedFlag04Decider, [wbNull, wbFloatT('Scale')]);

// included in Extra...    wbUnionCHANGE_REFR_EXTRA_OWNERSHIP := wbUnion('Ownership Extra', ChangedFlag06Decider, [wbNull, wbNull]);    // CHANGE_REFR_EXTRAS
// included in Extra...    wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA := wbUnion('Item Data Extra', ChangedFlag10Decider, [wbNull, wbNull]);  // CHANGE_REFR_EXTRAS
// included in Extra...    wbUnionCHANGE_OBJECT_EXTRA_AMMO := wbUnion('Ammo Extra', ChangedFlag11Decider, [wbNull, wbNull]);            // CHANGE_REFR_EXTRAS
// no actual data    wbUnionCHANGE_OBJECT_EXTRA_LOCK := wbUnion('Lock Extra', ChangedFlag12Decider, [wbNull, wbNull]);
  wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE := wbUnion('Open Default State', ChangedFlag22Decider, [wbNull, wbNull]);
// no actual data    wbUnionCHANGE_OBJECT_OPEN_STATE := wbUnion('Open State', ChangedFlag23Decider, [wbNull, wbNull]);
// included in Extra...      wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN := wbUnion('Activating Children', ChangedFlag26Decider, [wbNull, wbNull]); // CHANGE_REFR_EXTRAS

  wbUnionCHANGE_REFR_ANIMATION := wbUnion('Animation', ChangedFlag28NotActorDecider, [wbNull, wbStruct('Animation SubBuffer', [
    wbIntegerT('Length', itU6to30),
    wbByteArray('Data', ChangedFormAnimationSubBufferCounter)
  ])]);

// included in Extra...      wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE := wbUnion('Enc Zone Extra', ChangedFlag29Decider, [wbNull, wbNull]);           // CHANGE_REFR_EXTRAS
  wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY := wbUnion('Created Only Extra', ChangedFlag30Decider, [wbNull, wbNull]);
// included in Extra...      wbUnionCHANGE_REFR_EXTRA_GAME_ONLY := wbUnion('Game Only Extra', ChangedFlag31Decider, [wbNull, wbNull]);               // CHANGE_REFR_EXTRAS

  wbUnionCHANGE_ACTOR_LIFESTATE := wbUnion('Life State', ChangedFlag10Decider, [wbNull, wbIntegerT('Life State', itU8)]);

// included in Extra...      wbUnionCHANGE_ACTOR_EXTRA_PACKAGE_DATA := wbUnion('Package Data Extra', ChangedFlag11Decider, [wbNull, wbNull]);        // CHANGE_REFR_EXTRAS
// included in Extra...      wbUnionCHANGE_ACTOR_EXTRA_MERCHANT_CONTAINER := wbUnion('Merchant Container', ChangedFlag12Decider, [wbNull, wbNull]);  // CHANGE_REFR_EXTRAS
// included in Extra...      wbUnionCHANGE_ACTOR_EXTRA_DISMEMBERED_LIMBS := wbUnion('Dismembered Limbs', ChangedFlag17Decider, [wbNull, wbNull]);    // CHANGE_REFR_EXTRAS
// included in Extra...      wbUnionCHANGE_ACTOR_LEVELED_ACTOR := wbUnion('Leveled Actor', ChangedFlag18Decider, [wbNull, wbNull]);                  // CHANGE_REFR_EXTRAS

  wbUnionCHANGE_ACTOR_DISPOSITION_MODIFIERS := wbUnion('Disp Modifiers', ChangedFlag19Decider, [wbNull,
    wbArrayPT('Disp Modifier List', wbStruct('Disp Modifier', [
      wbRefIDT('Faction'),
      wbFloatT('Modifier')
    ]), -254)
  ]);

  wbUnionCHANGE_ACTOR_TEMP_MODIFIERS := wbUnion('Temp Modifiers', ChangedFlag20Decider, [wbNull,
    wbArrayPT('Temp Modifier List', wbStruct('Temp Modifier', [
      wbIntegerT('Actor Value', itU8),
      wbFloatT('Modifier')
    ]), -254)
  ]);

  wbUnionCHANGE_ACTOR_DAMAGE_MODIFIERS := wbUnion('Damage Modifiers', ChangedFlag21Decider, [wbNull,
    wbArrayPT('Damage Modifier List', wbStruct('Damage Modifier', [
      wbIntegerT('Actor Value', itU8),
      wbFloatT('Modifier')
    ]), -254)
  ]);

  wbUnionCHANGE_ACTOR_OVERRIDE_MODIFIERS := wbUnion('Override Modifiers', ChangedFlag22Decider, [wbNull,
    wbArrayPT('Override Modifier List', wbStruct('Override Modifier', [
      wbIntegerT('Actor Value', itU8),
      wbFloatT('Modifier')
    ]), -254)
  ]);

  wbUnionCHANGE_ACTOR_PERMANENT_MODIFIERS := wbUnion('Permanent Modifiers', ChangedFlag23Decider, [wbNull,
    wbArrayPT('Permanent Modifier List', wbStruct('Permanent Modifier', [
      wbIntegerT('Actor Value', itU8),
      wbFloatT('Modifier')
    ]), -254)
  ]);

  wbUnionCHANGE_CELL_FLAGS := wbUnion('Flags', ChangedFlag01Decider, [wbNull, wbIntegerT('Change Flags', itU8)]);

  wbUnionCHANGE_CELL_FULLNAME := wbUnion('Full name', ChangedFlag02Decider, [wbNull, wbLenStringT('Change Full Name', -3)]);

  wbUnionCHANGE_CELL_OWNERSHIP := wbUnion('Ownership', ChangedFlag03Decider, [wbNull, wbRefIDT('Change Owner')]);

  wbUnionCHANGE_CELL_EXTERIOR_SHORT := wbUnion('Exterior Short', ChangedFlag28Decider, [wbNull, wbNull]);
  wbUnionCHANGE_CELL_EXTERIOR_CHAR := wbUnion('Exterior Char', ChangedFlag29Decider, [wbNull, wbNull]);
  wbUnionCHANGE_CELL_DETACHTIME := wbUnion('Detach Time', ChangedFlag30Decider, [wbNull, wbNull]);

  wbUnionCHANGE_CELL_SEENDATA := wbUnion('Seen Data', ChangedFlag31Decider, [wbNull,
    wbUnion('Change Seen Data', ChangedFormCellIsInteriorDecider, [
      wbByteArray('Change Seen Data', 33),
      wbStruct('Change Interior Seen Data', [
        wbArrayPT('Unknown', wbStruct('Data', [
          wbIntegerT('Unknown', itU8),
          wbIntegerT('Unknown', itS8),
          wbByteArray('Change Seen Data', 33)
        ]), -254)
      ])
    ])
  ]);

// no actual data  wbUnionCHANGE_TOPIC_SAIDONCE := wbUnion('Said Once', ChangedFlag31Decider, [wbNull, wbNull]);

  wbUnionCHANGE_QUEST_FLAGS := wbUnion('Quest Flags', ChangedFlag01Decider, [wbNull, wbIntegerT('Change Flags', itU8)]);

  wbUnionCHANGE_QUEST_SCRIPT_DELAY := wbUnion('Quest Script Delay', ChangedFlag02Decider, [wbNull, wbFloatT('Change Delay')]);

  wbUnionCHANGE_QUEST_OBJECTIVES := wbUnion('Quest Objectives', ChangedFlag29Decider, [wbNull,
    wbArrayPT('Change Objectives', wbStruct('Objective', [
      wbIntegerT('Objective ID', itU32),
      wbIntegerT('Objective Data', itU32)
    ]), -254)
  ]);

  wbUnionCHANGE_QUEST_SCRIPT := wbUnion('Quest Script', ChangedFlag30Decider, [wbNull, wbChangeScriptEventList]);

  wbUnionCHANGE_QUEST_STAGES := wbUnion('Quest Stages', ChangedFlag31Decider, [wbNull,
    wbArrayPT('Change Stages', wbStruct('Data', [
      wbIntegerT('StageID', itU8),
      wbIntegerT('Status?', itU8),
      wbArrayPT('Log Entries', wbStruct('Data', [
        wbIntegerT('Log Entry ID', itU8),
        wbIntegerT('Has Log Data', itU8),
        wbUnion('Log Data', ChangedFormQuestStageHasLogDataDecider, [wbNull, wbStruct('Data', [
          wbInteger('Unknown', itU16),
          wbIntegerT('Unknown', itU16)
        ])])
      ]), -254)
    ]), -254)
  ]);

  wbUnionCHANGE_ACTOR_BASE_DATA := wbUnion('Base Data', ChangedFlag01Decider, [wbNull,
    wbStruct('Data', [
      {00} wbInteger('Flags', itU32, wbFlags([
             {0x000001} 'Female',
             {0x000002} 'Essential',
             {0x000004} 'Is CharGen Face Preset',
             {0x000008} 'Respawn',
             {0x000010} 'Auto-calc stats',
             {0x000020} '',
             {0x000040} '',
             {0x000080} 'PC Level Mult',
             {0x000100} 'Use Template',
             {0x000200} 'No Low Level Processing',
             {0x000400} '',
             {0x000800} 'No Blood Spray',
             {0x001000} 'No Blood Decal',
             {0x002000} '',
             {0x004000} '',
             {0x008000} '',
             {0x010000} '',
             {0x020000} '',
             {0x040000} '',
             {0x080000} '',
             {0x100000} 'No VATS Melee',
           {0x00200000} '',
           {0x00400000} 'Can be all races',
           {0x00800000} 'Autocalc Service',
           {0x01000000} '',
           {0x02000000} '',
           {0x03000000} 'No Knockdowns',
           {0x08000000} 'Not Pushable',
           {0x10000000} '', {28}
           {0x20000000} '',
           {0x40000000} 'No Rotating To Head-track',
           {0x80000000} ''
           ])),
      {04} wbInteger('Fatigue', itU16),
      {06} wbInteger('Barter gold', itU16),
      {08} //wbUnion('Level', wbCreaLevelDecider, [
             wbInteger('Level', itS16),
             //wbInteger('Level Mult', itS16, wbDiv(1000))
           //]),
      {10} wbInteger('Calc min', itU16),
      {12} wbInteger('Calc max', itU16),
      {14} wbInteger('Speed Multiplier', itU16),
      {16} wbFloat('Karma (Alignment)'),
      {20} wbInteger('Disposition Base', itS16),
      {22} wbIntegerT('Template Flags', itU16)
    ])
  ]);

  wbUnionCHANGE_ACTOR_BASE_ATTRIBUTES := wbUnion('Actor Base Attributes', ChangedFlag02Decider, [wbNull, wbStruct('Data', [
      wbArray('Attributes Array', wbInteger('Attribute', itU8), [
        'Strength',
        'Perception',
        'Endurance',
        'Charisma',
        'Intelligence',
        'Agility',
        'Luck'
      ]),
      wbString('Unused', 1)
    ])
  ]);

  wbUnionCHANGE_ACTOR_BASE_AIDATA := wbUnion('AI Data', ChangedFlag03Decider, [wbNull, wbStruct('Data', [
    {00} wbInteger('Aggression', itU8, wbAggressionEnum),
    {01} wbInteger('Confidence', itU8, wbConfidenceEnum),
    {02} wbInteger('Energy Level', itU8),
    {03} wbInteger('Responsibility', itU8),
    {04} wbInteger('Mood', itU8, wbMoodEnum),
         wbByteArray('Unused', 3),
    {08} wbInteger('Buys/Sells and Services', itU32, wbServiceFlags),
    {0C} wbInteger('Teaches', itS8, wbSkillEnum),
    {0D} wbInteger('Maximum training level', itU8),
    {0E} wbInteger('Assistance', itS8, wbAssistanceEnum),
    {0F} wbInteger('Aggro Radius Behavior', itU8, wbBoolEnum),
         wbIntegerT('Aggro Radius', itS32)
  ])]);

  wbUnionCHANGE_ACTOR_BASE_SPELLLIST := wbUnion('Spell List', ChangedFlag04Decider, [wbNull, wbStruct('Data', [
      wbArrayPT('Spell List', wbRefIDT('Spell'), -254),
      wbArrayPT('Leveled Spell List', wbRefIDT('Leveled Spell'), -254)
    ])
  ]);

  wbUnionCHANGE_ACTOR_BASE_FULLNAME := wbUnion('Full Name', ChangedFlag05Decider, [wbNull, wbLenStringT('Name', -3)]);

  wbUnionCHANGE_NPC_SKILLS := wbUnion('NPC Skills', ChangedFlag09Decider, [wbNull, wbStruct('Data', [
    {00} wbArray('Skill Values', wbInteger('Skill', itU8), [
           'Barter',
           'Big Guns (obsolete)',
           'Energy Weapons',
           'Explosives',
           'Lockpick',
           'Medicine',
           'Melee Weapons',
           'Repair',
           'Science',
           'Guns',
           'Sneak',
           'Speech',
           'Survival',
           'Unarmed'
         ]),
    {14} wbArray('Skill Offsets', wbInteger('Skill', itU8), [
           'Barter',
           'Big Guns (obsolete)',
           'Energy Weapons',
           'Explosives',
           'Lockpick',
           'Medicine',
           'Melee Weapons',
           'Repair',
           'Science',
           'Guns',
           'Sneak',
           'Speech',
           'Survival',
           'Unarmed'
         ]),
      wbString('Unused', 1)
    ])
  ]);

  wbUnionCHANGE_NPC_CLASS := wbUnion('Class', ChangedFlag10Decider, [wbNull, wbRefIDT('Class')]);

  wbUnionCHANGE_NPC_FACE := wbUnion('Face', ChangedFlag11Decider, [wbNull, wbStruct('Data', [
      wbIntegerT('Unknown', itU8),
      wbStruct('FaceGenData', [
        wbArray('FaceGen Geometry-Symmetric',  wbFloatT('Value'), 50),
        wbArray('FaceGen Geometry-Asymmetric', wbFloatT('Value'), 30),
        wbArray('FaceGen Texture-Symmetric',   wbFloatT('Value'), 50)
      ]),
      wbRefIDT('Hair'),
      wbRefIDT('Eyes'),
      wbFloatT('Hair Length'),
      wbIntegerT('Hair Color', itU32),
      wbArrayPT('HeadParts', wbRefIDT('HeadPart'), -254)
    ])
  ]);

  wbUnionCHANGE_NPC_GENDER := wbUnion('Gender', ChangedFlag24Decider, [wbNull, wbIntegerT('Gender', itU8, wbSexEnum)]);

  wbUnionCHANGE_NPC_RACE := wbUnion('Race', ChangedFlag25Decider, [wbNull, wbStruct('Races', [
    wbRefIDT('Race'),
    wbRefIDT('Previous Race')
  ])]);  // Looks like there are two races (previous race ?)

  wbUnionCHANGE_CREATURE_SKILLS := wbUnion('Creature Skills', ChangedFlag09Decider, [wbNull, wbStruct('Data', [
      wbIntegerT('Magic Skill', itU8),
      wbIntegerT('Combat Skill', itU8),
      wbIntegerT('Stealth Skill', itU8)
    ])
  ]);

  wbUnionCHANGE_BASE_OBJECT_VALUE := wbUnion('Object Value', ChangedFlag01Decider, [wbNull, wbIntegerT('Value', itU32)]);

  wbUnionCHANGE_BASE_OBJECT_FULLNAME := wbUnion('Object Full Name', ChangedFlag02Decider, [wbNull, wbLenStringT('Name', -3)]);

  wbUnionCHANGE_TALKING_ACTIVATOR_SPEAKER := wbUnion('Speaker', ChangedFlag23Decider, [wbNull, wbRefIDT('Change Speaker')]);

  wbUnionCHANGE_BOOK_TEACHES_SKILL := wbUnion('Teaches Skill', ChangedFlag05Decider, [wbNull, wbIntegerT('Bool?', itU8)]);

// no actual data    wbUnionCHANGE_NOTE_READ := wbUnion('Note Read', ChangedFlag31Decider, [wbNull, wbNull]);

  wbUnionCHANGE_ENCOUNTER_ZONE_FLAGS := wbUnion('Zone Flags', ChangedFlag01Decider, [wbNull, wbIntegerT('Change Flags', itU8)]);

  wbUnionCHANGE_ENCOUNTER_ZONE_GAME_DATA := wbUnion('Game Data', ChangedFlag31Decider, [wbNull, wbByteArrayT('Change Game Data', 16)]);
    // Prior to form version 8, only 8+1

  wbUnionCHANGE_CLASS_TAG_SKILLS := wbUnion('Tag Skills', ChangedFlag01Decider, [wbNull,
    wbArray('Skills', wbIntegerT('Skill', itS32), 4)
  ]);

  wbUnionCHANGE_FACTION_FLAGS := wbUnion('Faction Flags', ChangedFlag01Decider, [wbNull, wbIntegerT('Flags', itU32)]);

  wbUnionCHANGE_FACTION_REACTIONS := wbUnion('Faction Reactions', ChangedFlag02Decider, [wbNull,
    wbArrayPT('Reactions', wbStruct('Reaction', [
      wbRefIDT('Faction'),
      wbIntegerT('Modifier', itS32),
      wbIntegerT('Reaction', itU32)
    ]), -254)
  ]);

  wbUnionCHANGE_FACTION_CRIME_COUNTS := wbUnion('Faction Crime Counts', ChangedFlag31Decider, [wbNull, wbStruct('Crime Counts', [
    wbIntegerT('crimeCount40', itU32),
    wbIntegerT('crimeCount40', itU32)
  ])]);

// no actual data  wbUnionCHANGE_PACKAGE_WAITING := wbUnion('Waiting Flag', ChangedFlag30Decider, [wbNull, wbNull]);
// no actual data  wbUnionCHANGE_PACKAGE_NEVER_RUN := wbUnion('Never Run Flag', ChangedFlag31Decider, [wbNull, wbNull]);

  wbPackageLocationData := wbStruct('Location', [
    wbIntegerT('Type', itU8),
    wbIntegerT('Radius', itU32),
    wbUnion('ObjectType', ChangedFormPackageLocationTypeDecider, [ wbNull, wbRefIDT('Object'), wbIntegerT('Type', itU32)])
  ]);

  wbPackageTargetData := wbStruct('Target', [
        wbIntegerT('Type', itU8),
        wbIntegerT('Count or Distance', itU32),
        wbFloatT('Unk0C'),
        wbUnion('ObjectType', ChangedFormPackageTargetTypeDecider, [ wbNull, wbRefIDT('Object'), wbIntegerT('Type', itU32)])
      ]);

  wbCreatedPackageDataType := wbUnion('Specific Data', ChangedFormPackageCreatedPackageDataTypeDecider, [   // unverified for FO3
    wbNull,
    wbStruct('Follow/Escort', [
      wbIntegerT('Unknown', itU32),
      wbIntegerT('Has Location', itU8),
      wbUnion('Location Data', ChangedFormPackageCreatedFEHasLocationDecider, [wbNull, wbPackageLocationData])
    ]),
    wbStruct('Ambush/Use Item/Eat', [
      wbIntegerT('Has Location', itU8),
      wbUnion('Location Data', ChangedFormPackageCreatedAUEHasLocationDecider, [wbNull, wbPackageLocationData])
    ]),
    wbStruct('Patrol', [
      wbIntegerT('Unknown', itU8),
      wbIntegerT('Unknown', itU8)
    ]),
    wbStruct('Dialogue', [
      wbIntegerT('Unknown', itU32),
      wbIntegerT('Unknown', itU8),
      wbIntegerT('Unknown', itU8),
      wbIntegerT('Unknown', itU8),
      wbIntegerT('Unknown', itU32),
      wbIntegerT('Unknown', itU8),
      wbIntegerT('Unknown', itU32),
      wbRefIDT('Topic'),
      wbIntegerT('Has Location', itU8),
      wbUnion('Location Data', ChangedFormPackageCreatedDHasLocationDecider, [wbNull, wbPackageLocationData])
    ]),
    wbStruct('Use Weapon', [
      wbIntegerT('Unknown', itU8),
      wbIntegerT('Unknown', itU8),
      wbIntegerT('Unknown', itU8),
      wbIntegerT('Unknown', itU8),
      wbIntegerT('Unknown', itU8),
      wbIntegerT('Unknown', itU8),
      wbIntegerT('Unknown', itU16),
      wbIntegerT('Unknown', itU16),
      wbIntegerT('Unknown', itU16),
      wbIntegerT('Unknown', itU32),
      wbIntegerT('Unknown', itU32),
      wbRefIDT('Weapon'),
      wbIntegerT('Has Target', itU8),
      wbUnion('Target Data', ChangedFormPackageCreatedUWHasTargetDecider, [wbNull, wbPackageTargetData]),
      wbIntegerT('Has Location', itU8),
      wbUnion('Location Data', ChangedFormPackageCreatedUWHasLocationDecider, [wbNull, wbPackageLocationData])
    ])]);

  wbChangePackageStruct := wbStruct('Data', [
      wbStruct('General', [
        wbInteger('Flags', itU32),
        wbInteger('Type', itU8, wbPKDTType),
        wbByteArray('Unused', 1),
        wbInteger('Fallout Behavior Flags', itU16),
        wbIntegerT('Specific Type Flags', itU32)
      ]),
      wbIntegerT('Content Flags', itU8),
      wbUnion('Location Data', ChangedFormPackageCreatedContentFlagsBit0Decider, [wbNull, wbPackageLocationData]),
      wbUnion('Target Data', ChangedFormPackageCreatedContentFlagsBit1Decider, [wbNull, wbPackageTargetData]),
      wbUnion('Created Package Data', ChangedFormPackageCreatedContentFlagsBit2Decider, [wbNull, wbCreatedPackageDataType]),
      wbIntegerT('Procedure Array Index', itU32)
    ]);

  wbUnionCHANGE_PACKAGE_CREATED := wbUnion('Created Package', ChangedFlag11OrCreatedDecider, [wbNull, wbChangePackageStruct]);

  wbUnionCHANGE_FORM_LIST_ADDED_FORM := wbUnion('Added Form', ChangedFlag31Decider, [wbNull, wbArrayPT('Forms', wbRefIDT('RefID'), -1)]);

  wbUnionCHANGE_LEVELED_LIST_ADDED_OBJECT := wbUnion('Added Object', ChangedFlag31Decider, [wbNull,
    wbStruct('Objects List', [
      wbArrayPT('Objects', wbStruct('Object', [
        wbRefIDT('RefID'),
        wbIntegerT('Level', itU16),
        wbIntegerT('Count', itU16),
        wbFloatT('Health')
      ]), -254)
    ])
  ]);

  wbUnionCHANGE_WATER_REMAPPED := wbUnion('Remapped', ChangedFlag31Decider, [wbNull, wbRefIDT('Water form')]);

  wbChangedActorBase := wbStruct('Changed Actor Base', [
     wbUnionCHANGE_ACTOR_BASE_DATA
    ,wbUnionCHANGE_ACTOR_BASE_SPELLLIST
    ,wbUnionCHANGE_ACTOR_BASE_ATTRIBUTES
    ,wbUnionCHANGE_ACTOR_BASE_AIDATA
    ,wbUnionCHANGE_ACTOR_BASE_FULLNAME
  ]);

  wbChangedNPC := wbStruct('Change NPC_ Data', [ {02A}
     wbChangedActorBase
    ,wbUnionCHANGE_NPC_SKILLS
    ,wbUnionCHANGE_NPC_CLASS
    ,wbUnionCHANGE_NPC_RACE
    ,wbUnionCHANGE_NPC_FACE
    ,wbUnionCHANGE_NPC_GENDER
  ]);

  wbChangedCREA := wbStruct('Change CREA Data', [ {02B}
     wbChangedActorBase
    ,wbUnionCHANGE_CREATURE_SKILLS
  ]);

  wbInitialDataType01 := wbStruct('Detached CELL CHANGE_CELL_EXTERIOR_CHAR', [
    wbInteger('Worldspace Index', itU16, wbSaveWorldspaceIndex),  // index into Worldspace table
    wbInteger('coordX', itS8),
    wbInteger('coordY', itS8),
    wbIntegerT('detachTime', itU32),
    wbUnionCHANGE_CELL_EXTERIOR_SHORT,
    wbUnionCHANGE_CELL_EXTERIOR_CHAR,
    wbUnionCHANGE_CELL_DETACHTIME
  ]);

  wbInitialDataType02 := wbStruct('Detached CELL CHANGE_CELL_EXTERIOR_SHORT', [
    wbInteger('Worldspace Index', itU16, wbSaveWorldspaceIndex),  // index into Worldspace table
    wbInteger('coordX', itS16),
    wbInteger('coordY', itS16),
    wbIntegerT('detachTime', itU32),
    wbUnionCHANGE_CELL_EXTERIOR_SHORT,
    wbUnionCHANGE_CELL_EXTERIOR_CHAR,
    wbUnionCHANGE_CELL_DETACHTIME
  ]);

  wbInitialDataType03 := wbStruct('Detached CELL', [
    wbIntegerT('detachTime', itU32),
    wbUnionCHANGE_CELL_EXTERIOR_SHORT,
    wbUnionCHANGE_CELL_EXTERIOR_CHAR,
    wbUnionCHANGE_CELL_DETACHTIME
  ]);

  wbInitialDataType04 := wbStruct('Reference moved', [
    wbRefID('Cell/Worldspace'),
    wbFloat('PosX'),
    wbFloat('PosY'),
    wbFloat('PosZ'),
    wbFloat('RotX'),
    wbFloat('RotY'),
    wbFloatT('RotZ'),
// no actual data     wbUnionCHANGE_REFR_MOVE
    wbUnionCHANGE_REFR_HAVOK_MOVE
// no actual data     wbUnionCHANGE_REFR_CELL_CHANGED
  ]);

  wbInitialDataType05 := wbStruct('Constructed Reference', [
    wbRefID('Cell/Worldspace'),
    wbFloat('PosX'),
    wbFloat('PosY'),
    wbFloat('PosZ'),
    wbFloat('RotX'),
    wbFloat('RotY'),
    wbFloat('RotZ'),
    wbInteger('flags', itU8),
    wbRefIDT('baseFormID'),
// no actual data     wbUnionCHANGE_REFR_MOVE
    wbUnionCHANGE_REFR_HAVOK_MOVE
// no actual data     wbUnionCHANGE_REFR_CELL_CHANGED
  ]);

  wbInitialDataType06 := wbStruct('Reference Changed Cell or Promoted', [
    wbRefID('Cell/Worldspace'),
    wbFloat('PosX'),
    wbFloat('PosY'),
    wbFloat('PosZ'),
    wbFloat('RotX'),
    wbFloat('RotY'),
    wbFloat('RotZ'),
    wbRefID('new Cell/Worldspace'),
    wbInteger('CoordX', itS16),
    wbIntegerT('CoordY', itS16),
// no actual data     wbUnionCHANGE_REFR_MOVE
    wbUnionCHANGE_REFR_HAVOK_MOVE
// no actual data     wbUnionCHANGE_REFR_CELL_CHANGED
  ]);

  wbInitialDataType := wbUnion('Initial Data Type', InitialDataTypeDecider, [
    wbNull,
    wbInitialDataType01,
    wbInitialDataType02,
    wbInitialDataType03,
    wbInitialDataType04,
    wbInitialDataType05,
    wbInitialDataType06
  ]);

  wbNonActorMagicTarget := wbArrayPT('Magic Item List', wbStruct('Magic Item', [
    wbRefIDT('Magic Form'),
    wbIntegerT('ArchType', itU8, wbArchtypeEnum),
    wbIntegerT('Unk098', itU6to30),
    wbArrayPT('Effect Items', wbInteger('Effect Item', itU8), -254)
  ]), -254);

  wbActorPackageData := wbUnion('Package Specific Data', ChangeFormExtraPackageTypeDecider, [    // 031
    wbNull,
    wbStruct('Escort Actor Package Data', [
      wbRefIDT('Package'),
      wbArrayPT('Unknown', wbRefID('Unknown'), -254)
    ]),
    wbStruct('Sandbox Actor Package Data', [
      wbIntegerT('Unk004', itU32),
      wbIntegerT('Unk008', itU32),
      wbIntegerT('Unk00C', itU32),
      wbIntegerT('Unk014', itU32),
      wbIntegerT('Unk018', itU32),
      wbIntegerT('Unk01C', itU32),
      wbIntegerT('Unk00C', itU32),
      wbIntegerT('Unk030', itU32),
      wbIntegerT('Byt034', itU8),
      wbIntegerT('Byt035', itU8),
      wbIntegerT('Byt036', itU8),
      wbIntegerT('Byt037', itU8),
      wbIntegerT('Unk038', itU32),
      wbIntegerT('Byt040', itU8),
      wbIntegerT('Calc048', itU32),
      wbIntegerT('Unk04C', itU32),
      wbIntegerT('Unk050', itU32),
      wbIntegerT('Unk054', itU32),
      wbIntegerT('Unk058', itU32),
      wbByteArrayT('Unk05C', 6),
      wbRefIDT('Unk010'),
      wbRefIDT('Unk03C'),
      wbRefIDT('Unk044'),
      wbArrayPT('Unknown', wbStruct('Unknown', [
        wbIntegerT('Unknown', itU32),
        wbIntegerT('Unknown', itU32),
        wbIntegerT('Unknown', itU32),
        wbRefIDT('Unkown')
      ]), -254)
    ]),
    wbStruct('Patrol Actor Package Data', [
      wbIntegerT('Unknown', itU32),
      wbIntegerT('Unknown', itU32),
      wbIntegerT('Unknown', itU32),
      wbIntegerT('Unknown', itU8),
      wbIntegerT('Unknown', itU8),
      wbIntegerT('Unknown', itU32),
      wbRefIDT('Package'),
      wbArrayPT('Patrol Points', wbRefIDT('Patrol Point'), -254)
    ]),
    wbStruct('Guard Actor Package Data', [
      wbIntegerT('Unknown', itU32),
      wbIntegerT('Unknown', itU32),
      wbIntegerT('Unknown', itU32),
      wbRefIDT('Unknown')
    ]),
    wbNull  // UseWeaponActorPackageData nothing loaded ???
  ]);

  wbChangedExtraData := wbArrayPT('Extras', wbStruct('Extra', [
    wbIntegerT('Extra Type', itU8),
    wbUnion('Extra Union', ChangedExtraUnionDecider, [
     wbByteArray('<ERROR BAD CODE ******************>'), // wbNull,
     wbStruct('Script', [                                       // 000
       wbRefIDT('Script ID'),
       wbChangeScriptEventList
     ]),
     wbNull, // ExtraWornLeft no data                           // 001
     wbStruct('Package Start Location', [                       // 002
       wbRefIDT('WorldSpace or Cell'),
       wbFloat('PosX'),
       wbFloat('PosY'),
       wbFloatT('PosZ'),
       wbIntegerT('Unknown', itU32)
     ]),
     wbStruct('Package', [                                      // 003
       wbRefIDT('Package'),
       wbRefIDT('Unk014'),
       wbIntegerT('Unk010', itU32),
       wbIntegerT('Unk018', itU8),
       wbIntegerT('Unk019', itU8),
       wbIntegerT('Unk01A', itU8)
     ]),
     wbRefIDT('TressPass Package'),                             // 004
     wbArrayPT('RunOncePacks', wbStruct('RunOncePack', [         // 005
       wbRefIDT('Package'),
       wbIntegerT('Unk004', itU8)
     ]), -254),
     wbRefIDT('Reference Pointer'),                             // 006
     wbArrayPT('Follower Array', wbRefIDT('Follower'), -254),    // 007
     wbIntegerT('Leveled Creature Modifier', itU32),            // 008
     wbNull, // ExtraGhost no data                              // 009
     wbRefIDT('Ownership'),                                     // 00A
     wbRefIDT('Global'),                                        // 00B
     wbIntegerT('Rank', itS32),                                 // 00C
     wbIntegerT('Count', itS16),                                // 00D
     wbFloatT('Heath'),                                         // 00E
     wbIntegerT('Uses', itS8),                                  // 00F
     wbFloatT('Time Left'),                                     // 010
     wbFloatT('Charge'),                                        // 011
     wbStruct('Lock', [                                         // 012
       wbIntegerT('Lock Level', itU8),
       wbRefIDT('Key'),
       wbIntegerT('Flags', itU8),
       wbIntegerT('Unk00C', itU32),  // Rest added since form version 0x10
       wbIntegerT('Unk010', itU32)
     ]),
     wbStruct('Teleport', [                                     // 013
       wbFloat('PosX'),
       wbFloat('PosY'),
       wbFloatT('PosZ'),
       wbFloat('RotX'),
       wbFloat('RotY'),
       wbFloatT('RotZ'),
       wbIntegerT('Unk01C', itU8),
       wbRefIDT('Linked Door')
     ]),
     wbIntegerT('Map Marker', itU8),                            // 014
     wbStruct('Leveled Creature', [                             // 015
       wbRefIDT('Actor Base'),
       wbRefIDT('Selected Actor Base'),
       wbIntegerT('Actor Base Changed Flags', itU32, wbChangeFlags010Flags),
       wbUnion('Changed Actor Base', ChangedFormActorBaseDecider, [wbNull, wbChangedNPC, wbChangedCREA])
     ]),
    wbStruct('Leveled Item', [                                  // 016
      wbIntegerT('Unknown', itU32),
      wbIntegerT('Unknown', itU8)
    ]),
    wbFloatT('Scale'),                                          // 017
    wbStruct('Non Actor Magic Caster', [                        // 018
      wbRefIDT('Unk018'),
      wbRefIDT('Unk01C'),
      wbRefIDT('Unk020')
    ]),
    wbStruct('Non Actor Magic Target', [                        // 019
      wbRefIDT('Unk01C'),
      wbNonActorMagicTarget
    ]),
    wbArrayPT('Player Crimes', wbStruct('Data', [                // 01A
      wbIntegerT('Unknown', itU32),
      wbIntegerT('Unknown', itU32)
    ]), -254),
    wbRefIDT('Item Dropper'),                                   // 01B
    wbRefIDT('Merchant Container'),                             // 01C
    wbNull, // ExtraCannotWear no data                          // 01D
    wbRefIDT('Poison'),                                         // 01E
    wbArrayPT('Friendly Hits', wbFloatT('Time'), -254),          // 01F
    wbRefIDT('Heading Target'),                                 // 020
    wbRefIDT('Starting World or Cell'),                         // 021
    wbIntegerT('HotKey', itU8),                                 // 022
    wbStruct('Info General Topic', [                            // 023
      wbLenStringT('Unk000', -3),
      wbIntegerT('Unk008', itU8),
      wbIntegerT('Unk024', itU8),
      wbIntegerT('Unk025', itU8),
      wbIntegerT('Unk009', itU8),
      wbIntegerT('Unk00A', itU8),
      wbRefIDT('Quest'), // 014
      wbRefIDT('Topic028'),
      wbRefIDT('Topic01C'),
      wbRefIDT('TopicInfo') // 018
    ]),
    wbIntegerT('Has Rumors', itU8),                               // 024
    wbStruct('Terminal State', [                                  // 025
      wbIntegerT('Unk00C', itU8),
      wbIntegerT('Unk00D', itU8)
    ]),
    wbIntegerT('Activate Ref Children', itU32),                   // 026
    wbRefIDT('Talking Actor'),                                    // 027
    wbFloatT('Object Health'),                                    // 028
    wbStruct('Model Swap', [                                      // 029
      wbRefIDT('Unk00C'),
      wbIntegerT('Unk010', itU32)
    ]),
    wbFloatT('Radius'),                                           // 02A
    wbFloatT('Radiation'),                                        // 02B
    wbArrayPT('Faction Changes', wbStruct('Data', [                // 02C
      wbRefIDT('Faction'),
      wbIntegerT('Rank', itS8)
    ]), -254),
    wbStruct('Dismembered Limbs', [                               // 02D
      wbIntegerT('Unk00C', itU16),
      wbIntegerT('Unk010', itU32),
      wbIntegerT('Unk018', itU32),
      wbIntegerT('Unk01C', itU8),
      wbRefIDT('Unk014'),
      wbArrayPT('Unk020', wbStruct('Data', [
        wbIntegerT('Unk000', itU8),
        wbIntegerT('Unk001', itU8),
        wbIntegerT('Unk002', itU8),
        wbIntegerT('Unk003', itU8), // Since form version 0x10
        wbArrayPT('Unk004', wbRefIDT('Data'), -254)
      ]), -254)
    ]),
    wbIntegerT('Actor Cause', itU32),                             // 02E
    wbRefIDT('Open/Close Activate Ref'),                          // 02F
    wbStruct('Ammo', [                                            // 030
      wbRefIDT('Ammo'),
      wbIntegerT('Count?', itS32)
    ]),
    wbStruct('Package Data', [
      wbIntegerT('Package Data Type', itU8, wbPKDTType),
      wbActorPackageData
    ]),
    wbArrayPT('Say TopicInfo once a day', wbStruct('Data', [       // 032
      wbRefIDT('TopicInfo'),
      wbIntegerT('Unk004', itS32),
      wbFloatT('Unk008')
    ]), -254),
    wbRefIDT('Encounter Zone'),                                   // 033
    wbStruct('SayTo Topic Info', [                                // 034
      wbRefIDT('Topic'),
      wbRefIDT('TopicInfo'),
      wbIntegerT('Unknown', itU8)
    ]),
    wbArrayPT('Guarded Ref Data', wbRefIDT('Guarded Ref Data'), -254),   // 035
    wbRefIDT('AshPile Ref'),                                      // 036
    wbStruct('Follower SwimBreadcrumbs', [                        // 037
      wbByteArrayT('Unk010', $0C),
      wbRefIDT('Unk01C'),   // Present only for form version 0x12 and later
      // wbIntegerT('Unk01C', itU32), // Present only for form version lower than 0x12
      wbIntegerT('Unk00C', itU32),
      wbArrayPT('Unk020', wbStruct('Data', [
        wbByteArrayT('Unk000', $0C),
        wbRefIDT('Unk00C'),   // Present only for form version 0x12 and later
        // wbIntegerT('Unk00C', itU32), // Present only for form version lower than 0x12
        wbByteArrayT('Unk010', $0C),
        wbRefIDT('Unk01C'),   // Present only for form version 0x12 and later
        // wbIntegerT('Unk01C', itU32), // Present only for form version lower than 0x12
        wbIntegerT('Unk020', itU8)
      ]), -254)
    ]),
    wbIntegerT('Weapon Mod Flags', itU8),                         // 038
    wbStruct('Securitron Face', [                                 // 039
      wbLenStringT('Unk00C', -3),
      wbLenStringT('Unk014', -3)
    ]),
    wbNull, // no data, nothing                                   // 03A
    wbStruct('Special Render Flags', [                            // 03B
      wbIntegerT('Unk00C', itU32),
      wbIntegerT('Unk010', itU32)
    ])
  ])]), -254);

  wbEntryData :=   wbStruct('Entry Data', [
    wbRefIDT('Type'),
    wbIntegerT('Delta', itS32),
    wbArrayPT('Extend Datas', wbChangedExtraData, -254)
  ]);
  wbChangedInventory := wbArrayPT('Entry Datas', wbEntryData, -254);

  wbUnionCHANGE_REFR_INVENTORY := wbUnion('Inventory', ChangedFlag05or27Decider, [wbNull, wbChangedInventory]);
//identical to wbUnionCHANGE_REFR_INVENTORY  wbUnionCHANGE_REFR_LEVELED_INVENTORY := wbUnion('Leveled Inventory', ChangedFlag05or27Decider, [wbNull, wbChangedInventory]);

  // check against 10100100000000100001110001000000 if func0040 is null or
  //               31 29 26    17 12 11 10 6
  // check against 10100100000001100001100001000000 if func0040 is not null (at least actor)
  //               31 29 26 18 17 12 11    6
  // CHANGE_REFR_EXTRA_OWNERSHIP || OBJECT_EXTRA_AMMO || CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN || CHANGE_REFR_EXTRA_ENCOUNTER_ZONE ||
  //   CHANGE_REFR_EXTRA_GAME_ONLY || CHANGE_ACTOR_EXTRA_PACKAGE_DATA || CHANGE_ACTOR_EXTRA_MERCHANT_CONTAINER ||
  //   CHANGE_ACTOR_EXTRA_DISMEMBERED_LIMBS || (CHANGE_ACTOR_LEVELED_ACTOR)
  wbChangedExtra := wbUnion('Changed Extra', ChangedFormExtraDecider, [wbNull, wbChangedExtraData]);

  wbChangedREFR := wbStruct('Change REFR Data', [
// no actual data     wbUnionCHANGE_OBJECT_EXTRA_LOCK
     wbUnionCHANGE_FORM_FLAGS
    ,wbUnionCHANGE_REFR_SCALE
    ,wbChangedExtra
//    ,wbUnionCHANGE_REFR_EXTRA_OWNERSHIP
//    ,wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA
//    ,wbUnionCHANGE_OBJECT_EXTRA_AMMO        // same flag as ExtraPackageData
//    ,wbUnionCHANGE_ACTOR_EXTRA_PACKAGE_DATA // same flag as ExtraAmmo, needs type check !
//    ,wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN
//    ,wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE
//    ,wbUnionCHANGE_REFR_EXTRA_GAME_ONLY
//    ,wbUnionCHANGE_ACTOR_EXTRA_MERCHANT_CONTAINER
//    ,wbUnionCHANGE_ACTOR_EXTRA_DISMEMBERED_LIMBS
//    ,wbUnionCHANGE_ACTOR_LEVELED_ACTOR
    ,wbUnionCHANGE_REFR_INVENTORY
//    ,wbUnionCHANGE_REFR_LEVELED_INVENTORY
    ,wbUnionCHANGE_REFR_ANIMATION
// not checked !    ,wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE
// no actual data     ,wbUnionCHANGE_OBJECT_OPEN_STATE
// not checked !    ,wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY
  ]);

  wbPathingCoverLocation := wbStruct('Pathing Cover Location', [
    wbPathingLocation,
    wbCoordXYZ('Coords 028'),
    wbCoordXYZ('Coords 034'),
    wbCoordXYZ('Coords 040'),
    wbIntegerT('Byt04C', itU8),
    wbIntegerT('Byt04D', itU8),
    wbIntegerT('Byt04E', itU8),
    wbIntegerT('Byt04F', itU8),
    wbIntegerT('Byt050', itU8),
    wbIntegerT('Byt051', itU8),
    wbIntegerT('Byt052', itU8)
  ]);

  wbStructPathing := wbStruct('Pathing', [
    wbInteger('Byt001', itU8),
    wbInteger('Byt000', itU8),
    wbInteger('Byt002', itU8),
    wbInteger('Unk004', itU32),
    wbCoordXYZ('Coords'),
    wbPathingCoverLocation,
    wbIntegerT('Unk68', itU32),
    wbIntegerT('Unk6C', itU32),
    wbStruct('Unk070', [
      wbIntegerT('Byt000', itU8),
      wbIntegerT('Byt001', itU8),
      wbIntegerT('Byt002', itU8),
      wbIntegerT('Byt003', itU8),
      wbIntegerT('Byt004', itU8),
      wbIntegerT('Byt005', itU8)
    ])
  ]);

  wbStructUnk128or164 := wbStruct('Data', [
    wbCoordXYZ('Coords 000'),
    wbCoordXYZ('Coords 00C'), // ?? must be wrong, should check :)
    wbIntegerT('Unk018', itU32),
    wbIntegerT('Byt038', itU8),
    wbIntegerT('Unk030', itU32),
    wbIntegerT('Unk038', itU32),
    wbFloatT('Tim01C'),
    wbArrayPT('Unk020', wbPathingCoverLocation, -254)
  ]);

  wbCombatProcedure := wbStruct('Data', [wbIntegerT('Unk008', itU32)]);

  wbChangeCombatProcedure := wbStruct('Change Combat Procedure', [
    wbIntegerT('Combat Procedure Type', itU8, wbEnum([
      'Attack Ranged',
      'Attack Melee',
      'Attack Grenade',
      'Attack Low',
      'Evade',
      'Switch Weapon',
      'Move',
      'Be In Cover',
      'Activate Object',
      'Hide From Target',
      'Search',
      'Use Combat Item',
      'Engage Target'
    ], [$FF, 'None'])),
    wbUnion('Combat Procedure', ChangeFormCombatProcedureTypeDecider, [
      wbNull,
      wbStruct('Attack Ranged', [
        wbCombatProcedure,
        wbIntegerT('Unk010', itU32),
        wbCoordXYZ('Coords'),
        wbFloatT('Flt020'),             // Paired
        wbFloatT('Flt024'),
        wbFloatT('Flt030'),             // Paired
        wbFloatT('Flt034'),
        wbFloatT('Flt040'),             // Paired
        wbFloatT('Flt044'),
        wbFloatT('Flt028'),             // Paired
        wbFloatT('Flt02C'),
        wbFloatT('Flt038'),             // Paired, if form version 0x0A or greater
        wbFloatT('Flt03C')              // Paired, if form version 0x0A or greater
      ]),
      wbStruct('Attack Melee', [
        wbCombatProcedure,
        wbIntegerT('Unk010', itU32),
        wbIntegerT('Unk014', itU32),
        wbIntegerT('Unk018', itU32),
        wbFloatT('Unk01C'),
        wbFloatT('Flt020'),             // Paired
        wbFloatT('Flt024'),
        wbFloatT('Flt028'),             // Paired
        wbFloatT('Flt02C'),
        wbFloatT('Flt030'),             // Paired
        wbFloatT('Flt034'),
        wbFloatT('Flt038'),             // Paired
        wbFloatT('Flt03C'),
        wbFloatT('Flt040'),             // Paired
        wbFloatT('Flt044'),
        wbFloatT('Flt048'),             // Paired
        wbFloatT('Flt04C'),
        wbFloatT('Tim060'),             // if form version 0x12 or greater
        wbIntegerT('Byt050', itU8),
        wbIntegerT('Unk054', itU32)
      ]),
      wbStruct('Attack Grenade', [
        wbCombatProcedure,
        wbIntegerT('Unk010', itU32),
        wbIntegerT('Unk014', itU32),
        wbCoordXYZ('Coords 018'),
        wbCoordXYZ('Coords 024'),
        wbIntegerT('Byt030', itU8),
        wbFloatT('Flt034'),             // Paired
        wbFloatT('Flt038')
      ]),
      wbStruct('Attack Low', [
        wbCombatProcedure,
        wbIntegerT('Unk010', itU32),
        wbFloatT('Unk014'),
        wbIntegerT('Unk018', itU32),
        wbRefIDT('Weapon')
      ]),
      wbStruct('Evade', [
        wbCombatProcedure,
        wbIntegerT('Unk010', itU32),
        wbIntegerT('Unk014', itU32)
      ]),
      wbStruct('Switch Weapon', [
        wbCombatProcedure,
        wbRefIDT('Weapon'),
        wbIntegerT('Unk014', itU8)
      ]),
      wbStruct('Move', [
        wbCombatProcedure,
        wbIntegerT('Unk010', itU32),
        wbPathingLocation,              // Goes into 014
        wbPathingLocation,              // Goes into 024
        wbFloatT('Unk034'),
        wbRefIDT('Unk038'),
        wbIntegerT('Unk03C', itU32),
        wbIntegerT('Unk060', itU32),
        wbFloatT('Flt064'),             // Paired
        wbFloatT('Flt068'),
        wbFloatT('Flt040'),             // Paired
        wbFloatT('Flt044'),
        wbFloatT('Flt06C'),             // Paired
        wbFloatT('Flt070'),
        wbFloatT('Flt074'),             // Paired, if form version 0x08 or greater
        wbFloatT('Flt078'),             // Paired, if form version 0x08 or greater
        wbCoordXYZ('Coords'),
        wbIntegerT('Byt054', itU8),
        wbIntegerT('Byt05C', itU8)      // if form version 0x0C or greater
      ]),
      wbStruct('Be In Cover', [
        wbCombatProcedure,
        wbIntegerT('Unk010', itU32),
        wbIntegerT('Bool', itU8),       // Determines what goes into 014
        wbCoordXYZ('Coords 018'),
        wbCoordXYZ('Coords 024'),
        wbCoordXYZ('Coords 030'),
        wbFloatT('Flt03C'),             // Paired
        wbFloatT('Flt040'),
        wbFloatT('Flt044'),             // Paired
        wbFloatT('Flt048'),
        wbFloatT('Flt04C'),             // Paired
        wbFloatT('Flt050'),
        wbFloatT('Flt054'),             // Paired
        wbFloatT('Flt058'),
        wbFloatT('Flt05C'),             // Paired
        wbFloatT('Flt060'),
        wbFloatT('Flt064'),             // Paired
        wbFloatT('Flt068')
      ]),
      wbStruct('Activate Object', [
        wbCombatProcedure,
        wbRefIDT('Unk010'),
        wbRefIDT('Bound Object'),
        wbIntegerT('Unk018', itU8)
      ]),
      wbStruct('Hide From Target', [
        wbCombatProcedure,
        wbIntegerT('Unk010', itU32),
        wbFloatT('Unk014'),
        wbFloatT('Flt018'),             // Paired
        wbFloatT('Flt01C'),
        wbCoordXYZ('Coords 020'),
        wbCoordXYZ('Coords 02C'),
        wbIntegerT('Unk03C', itU8),
        wbIntegerT('Unk03D', itU8),
        wbIntegerT('Unknown', itU8)     // Determines what goes into 038
      ]),
      wbStruct('Search', [
        wbCombatProcedure,
        wbIntegerT('Unk010', itU32),
        wbPathingLocation,              // Goes into 02C
        wbFloatT('Flt01C'),             // Paired
        wbFloatT('Flt020'),
        wbFloatT('Flt014'),             // Paired
        wbFloatT('Flt018'),
        wbFloatT('Flt024'),             // Paired
        wbFloatT('Flt028'),
        wbRefIDT('Unk03C')
      ]),
      wbStruct('Use Combat Item', [
        wbCombatProcedure,
        wbRefIDT('Bound Object'),
        wbIntegerT('Unk014', itU8)
      ]),
      wbStruct('Engage Target', [
        wbCombatProcedure,
        wbIntegerT('Unk010', itU32),
        wbFloatT('Unk014'),
        wbFloatT('Unk018'),
        wbFloatT('Unk01C'),             // if form version 0x0E or greater, otherwise default value  10000.0
        wbFloatT('Flt020'),             // Paired
        wbFloatT('Flt024'),
        wbFloatT('Flt028'),             // Paired
        wbFloatT('Flt02C'),
        wbIntegerT('Byt030', itU8),
        wbIntegerT('Byt031', itU8),
        wbIntegerT('Byt032', itU8),
        wbCoordXYZ('Coords'),
        wbPathingLocation,              // Goes into 040
        wbPathingLocation,              // Goes into 050
        wbIntegerT('Byt033', itU8),
        wbFloatT('Tim060')
      ])
    ])
  ]);

  wbPackageStruct := wbStruct('Package Struct', [
    wbRefIDT('Package'),
    wbUnion('Package Info', ChangeFormBaseProcessPackageDecider, [wbNull,
      wbStruct('Package Data', [
        wbUnion('Created Package', ChangeFormBaseProcessCreatedPackageDecider, [ wbNull,
          wbStruct('Created Package Struct', [
            wbIntegerT('Type', itS8, wbPKDTType),
            wbUnion('Created Package', ChangeFormCreatedPackageDecider, [
              wbChangePackageStruct,
              wbNull,
              wbNull,
              wbStruct('Dialogue Package', [
                wbChangePackageStruct,
                wbRefIDT('Speaker'),
                wbRefIDT('Subject'),
                wbRefIDT('Target'),
                wbRefIDT('Unk0B8'),
                wbRefIDT('Unk09C'),
                wbRefIDT('Topic'),
                wbIntegerT('Unk090', itU32),
                wbIntegerT('Byt098', itU8),
                wbIntegerT('Byt0BC', itU8),
                wbIntegerT('Byt0BD', itU8),
                wbIntegerT('Byt0BE', itU8),
                wbIntegerT('Byt0BF', itU8),
                wbIntegerT('Byt0C0', itU8),
                wbIntegerT('Byt0C1', itU8),
                wbIntegerT('Unk0C4', itU32),
                wbIntegerT('Unk0C8', itU32),
                wbIntegerT('Byt0A0', itU8),
                wbIntegerT('Byt0CC', itU8),
                wbIntegerT('Byt0C2', itU8),   // if form version 03 or greater
                wbDialogueItems
              ]),
              wbNull,
              wbStruct('Combat Controller', [
                wbChangePackageStruct,
                wbRefIDT('Attacker'),
                wbRefIDT('Target'),
                wbIntegerT('Unknown', itU32),   // key to lookup unk080 in global array
                wbStruct('Unk09C', [
                  wbIntegerT('Byt000', itU8),
                  wbIntegerT('Unk004', itU32),  // $FFFF is converted to 0
                  wbArray('Unk00C', wbRefIDT('Weapon'), 6),
                  wbArrayPT('Unk024', wbRefIDT('Weapon'), -254),
                  wbRefIDT('Weapon'),           // goes into 034
                  wbIntegerT('Unk038', itU32),
                  wbArray('Unk03C', wbIntegerT('Unknown', itU32), 7),
                  wbIntegerT('Unk058', itU32),
                  wbIntegerT('Unk05C', itU32),
                  wbIntegerT('Unk064', itU32),
                  wbIntegerT('Unk068', itU32),
                  wbIntegerT('Unk06C', itU32),
                  wbIntegerT('Byt070', itU8),
                  wbIntegerT('Byt071', itU8),
                  wbIntegerT('Byt072', itU8),
                  wbIntegerT('Byt073', itS8),
                  wbIntegerT('Byt074', itU8),
                  wbIntegerT('Byt075', itU8),
                  wbIntegerT('Byt076', itU8),
                  wbIntegerT('Byt077', itU8),
                  wbRefIDT('Explosion'),        // goes into 078
                  wbIntegerT('Unk07C', itU32),
                  wbIntegerT('Unk080', itU32),
                  wbCoordXYZ('Coords'),
                  wbIntegerT('Unk090', itU32),
                  wbIntegerT('Byt0C8', itU8),
                  wbIntegerT('Byt0C8', itU8),
                  wbIntegerT('Unk0CC', itU32),
                  wbIntegerT('Unk0D0', itU32),
                  wbIntegerT('Unk0D4', itU32),
                  wbIntegerT('Unk008', itU32),
                  wbIntegerT('Byt0D8', itU8),
                  wbRefIDT('Unk0DC'),
                  wbFloatT('Tim094'),
                  wbFloatT('Tim098'),
                  wbFloatT('Tim09C'),
                  wbFloatT('Tim0A0'),
                  wbFloatT('Tim0A4'),
                  wbFloatT('UnkA8'),            // paired with 0AC
                  wbFloatT('UnkAC'),            // paired with 0A8
                  wbFloatT('UnkB0'),            // paired with 0B4
                  wbFloatT('UnkB4'),            // paired with 0B0
                  wbFloatT('Tim0C0'),
                  wbFloatT('UnkB8'),            // paired with 0B4, if form version 0x14 or greater
                  wbFloatT('UnkBC'),            // paired with 0B0, if form version 0x14 or greater
                  wbFloatT('Tim0E0'),           // if form version 0x14 or greater
                  wbIntegerT('Content Flags', itU8),
                  wbUnion('Struct flag bit 0', ChangeFormCreatedPackageHasContentFlagBit0Decider, [ wbNull, wbStructPathing]),
                  wbUnion('Struct flag bit 2', ChangeFormCreatedPackageHasContentFlagBit2Decider, [ wbNull, wbStructPathing]),
                  wbUnion('Struct flag bit 4', ChangeFormCreatedPackageHasContentFlagBit4Decider, [ wbNull,
                    wbStruct('Unk18C', [
                      wbStruct('Pathing Location', [
                        wbCoordXYZ('Coords'),
                        wbRefIDT('InteriorCellOrWorldspace')
                      ]),
                      wbIntegerT('Unk014', itU32),
                      wbIntegerT('Unk018', itU32),
                      wbIntegerT('Unk01C', itU32),
                      wbRefIDT('Unk010')
                    ])
                  ]),
                  wbUnion('Struct flag bit 5', ChangeFormCreatedPackageHasContentFlagBit5Decider, [ wbNull,
                    wbStruct('Unk18C', [
                      wbIntegerT('Unk000', itU8),
                      wbIntegerT('Unk001', itU8),
                      wbIntegerT('Unk018', itU32),
                      wbIntegerT('Unk01C', itU32),
                      wbRefIDT('Unk004'),
                      wbStruct('Pathing Location', [
                        wbCoordXYZ('Coords'),
                        wbRefIDT('InteriorCellOrWorldspace')
                      ])
                    ])
                  ]),
                  wbUnion('Struct flag bit 1', ChangeFormCreatedPackageHasContentFlagBit1Decider, [ wbNull, wbStructUnk128or164]),
                  wbUnion('Struct flag bit 3', ChangeFormCreatedPackageHasContentFlagBit3Decider, [ wbNull, wbStructUnk128or164]),
                  wbArrayPT('Unk164', wbStruct('Data', [
                    wbIntegerT('Unk000', itU32),
                    wbFloatT('Tim004')
                  ]), -254),
                  wbArrayPT('Unk174', wbStruct('Data', [
                    wbStruct('Unk000', [
                      wbCoordXYZ('Coords'),
                      wbRefIDT('InteriorCellOrWorldspace')
                    ]),
                    wbFloatT('Tim010')
                  ]), -254),
                  wbFloatT('Tim184'),
                  wbIntegerT('Byt0188', itS8),
                  wbIntegerT('Present Flags', itU8),
                  wbUnion('Present Bit 0', ChangeFormCreatedPackageHasPresentFlagBit0Decider, [wbNull, wbRefIDT('BoundObject')]),
                  wbUnion('Present Bit 1', ChangeFormCreatedPackageHasPresentFlagBit1Decider, [wbNull, wbRefIDT('BoundObject')]),
                  wbUnion('Present Bit 2', ChangeFormCreatedPackageHasPresentFlagBit2Decider, [wbNull, wbRefIDT('BoundObject')]),
                  wbUnion('Present Bit 3', ChangeFormCreatedPackageHasPresentFlagBit3Decider, [wbNull, wbRefIDT('BoundObject')]),
                  wbUnion('Present Bit 4', ChangeFormCreatedPackageHasPresentFlagBit4Decider, [wbNull, wbRefIDT('BoundObject')]),
                  wbArray('Unk1A4', wbStruct('Data', [
                    wbRefIDT('BoundObject'),
                    wbFloatT('Flt008'),       // Paired
                    wbFloatT('Flt00C')
                  ]), 2),
                  wbIntegerT('Unk1BC', itU32),
                  wbRefIDT('Unk1C0'),
                  wbIntegerT('Byt1C8', itU8),
                  wbIntegerT('Unk228', itU32),    // if form version is 0xF or greater
                  wbFloatT('Flt1CC'),             // Paired
                  wbFloatT('Flt1D0'),
                  wbFloatT('Flt1D4'),             // Paired
                  wbFloatT('Flt1D8'),
                  wbFloatT('Flt1DC'),             // Paired
                  wbFloatT('Flt1E0'),
                  wbFloatT('Flt1E4'),             // Paired
                  wbFloatT('Flt1E8'),
                  wbFloatT('Flt1EC'),             // Paired
                  wbFloatT('Flt1F0'),
                  wbFloatT('Flt1F4'),             // Paired
                  wbFloatT('Flt1F8'),
                  wbFloatT('Flt1FC'),             // Paired
                  wbFloatT('Flt200'),
                  wbFloatT('Flt20C'),             // Paired
                  wbFloatT('Flt210'),
                  wbFloatT('Flt204'),             // Paired
                  wbFloatT('Flt208'),
                  wbFloatT('Flt214'),             // Paired
                  wbFloatT('Flt218'),
                  wbFloatT('Flt21C'),             // Paired
                  wbFloatT('Flt220')
                ]),
                wbChangeCombatProcedure,
                wbChangeCombatProcedure,
                wbArrayPT('Combat Procedures 08C', wbChangeCombatProcedure, -254),
                wbIntegerT('Has Unk0A0', itU8),
                wbUnion('Unk0A0', ChangeFormCombatControllerHasUnk0A0Decider, [wbNull, wbStruct('Data', [
                  wbArrayPT('Unk000', wbStruct('Data', [
                    wbIntegerT('Index', itS8),        // Index into global array, that goes into 000
                    wbIntegerT('Unk00C', itU32)
                  ]), -1),
                  wbIntegerT('Unk008', itU32),
                  wbIntegerT('Index', itS8)           // Index into another global array, that goes into 00C
                ])]),
                wbIntegerT('Index', itS8),            // Index into the first global array, that goes into 0A8
                wbIntegerT('Unk0B0', itU32),
                wbFloatT('Flt0B4'),                   // Paired
                wbFloatT('Flt0B8'),
                wbIntegerT('Byt0C7', itU8),
                wbIntegerT('Unk0C8', itU32),
                wbIntegerT('Unk0D8', itU32),
                wbIntegerT('Unk0DC', itU32),
                wbIntegerT('Byt0E4', itU8),
                wbIntegerT('Byt125', itU8),
                wbIntegerT('Byt126', itU8),
                wbIntegerT('Unk144', itU32),
                wbIntegerT('Unk148', itU32),
                wbArray('Unk0128', wbStruct('Data', [
                  wbCoordXYZ('Coords'),                  // Fields stored in two separate array: 128
                  wbIntegerT('Unknown', itU8)           //                                      140
                ]), 2),
                wbIntegerT('Byt142', itU8),
                wbIntegerT('Byt0C6', itS8),             // if form version 0x0A or greater
                wbIntegerT('Byt0C5', itU8)              // if form version 0x0A or greater
              ]),
              wbStruct('Alarm Package', [
                wbChangePackageStruct,
                wbArrayPT('Crimes', wbStruct('Crime', [
                  wbIntegerT('Crime Index', itU8),
                  wbIntegerT('Crime List Index', itU16)
                ]), -254)
              ]),
              wbStruct('Flee Package', [
                wbChangePackageStruct,
                wbIntegerT('Byt080', itU8),
                wbIntegerT('Byt081', itU8),
                wbCoordXYZ('Coords'),
                wbFloatT('Flt090'),
                wbIntegerT('Byt094', itU8),
                wbIntegerT('Byt0A8', itU8),
                wbIntegerT('Byt0A9', itU8),
                wbRefIDT('Unk0A0'),
                wbRefIDT('Unk0A4'),
                wbArrayPT('Unk098', wbRefIDT('RefID'), -254)
              ]),
              wbStruct('TressPass Package', [
                wbChangePackageStruct,
                wbFloatT('Flt080'),
                wbIntegerT('Unk084', itU32),
                wbIntegerT('Unk090', itU32),
                wbIntegerT('Unk094', itU32),
                wbIntegerT('Unk098', itU32),
                wbRefIDT('Unk088'),
                wbRefIDT('Unk08C')
              ]),
              wbStruct('Spectator Package', [
                wbChangePackageStruct,
                wbIntegerT('Delta', itU32),     // dword_11F6394 - this goes into Unk080
                wbIntegerT('Unk084', itU32),
                wbFloatT('Unk088'),
                wbFloatT('Unk08C'),
                wbIntegerT('Byt090', itU8),
                wbCoordXYZ('Coords'),
                wbArrayPT('Spectator Threat Infos', wbSTruct('Spectator Threat Info', [
                  wbIntegerT('Unk008', itU32),
                  wbIntegerT('ElapsedTicks', itU32),   // GetTickCounts - this goes into 00C
                  wbIntegerT('Unk010', itU32),
                  wbCoordXYZ('Coords 014'),
                  wbCoordXYZ('Coords 020'),
                  wbIntegerT('Byt02C', itU8),
                  wbIntegerT('Byt02D', itU8),
                  wbRefIDT('Unk000'),
                  wbRefIDT('Unk004')
                ]), -254)
              ]),
              wbStruct('BackUp Package', [
                wbChangePackageStruct,
                wbCoordXYZ('Coords')
              ])
            ])
          ])
        ]),
        wbIntegerT('Package Data Type', itS8),
        wbActorPackageData,
        wbIntegerT('Unk00C', itU32),
        wbFloatT('Unk010'),
        wbIntegerT('Flags', itU32),
        wbRefIDT('TargetRef')
      ])
    ])
  ]);

  wbChangedMobileObject := wbStruct('Changed MobileObject', [
     wbIntegerT('Process Level', itS8)
    ,wbChangedREFR
    ,wbIntegerT('Byt084', itS8)
    ,wbIntegerT('Byt085', itS8)
    ,wbIntegerT('Byt07C', itS8)
    ,wbIntegerT('Byt07F', itS8)
    ,wbIntegerT('Byt080', itS8)
    ,wbIntegerT('Byt07D', itS8)
    ,wbIntegerT('Byt07E', itS8)
    ,wbIntegerT('Byt086', itS8)
    ,wbIntegerT('Unk074', itU32)
    ,wbIntegerT('Unk078', itU32)
    ,wbIntegerT('Byt081', itS8)
    ,wbIntegerT('Byt083', itU8)  // present since form version 0x08
    ,wbRefIDT('Unk06C')
    ,wbRefIDT('Unk070')
    ,wbUnion('Process Data', ChangedFormMobileObjectBaseProcessDecider, [wbNull,
      wbStruct('Processes', [
        wbStruct('Base Process', [
          wbIntegerT('Unk01C', itU32),
          wbIntegerT('Unk020', itU32),  // present since form version 0x06
          wbIntegerT('Unk024', itU32),   // idem
          wbPackageStruct
        ]),
        wbUnion('Low Process', ChangedFormMobileObjectLowProcessDecider, [wbNull,
          wbStruct('Data', [
            // wbIntegerT('Unused', itU32), Older than form version 6
            // wbIntegerT('Unused', itU32), Older than form version 6
            wbIntegerT('Byt030', itU8),
            wbIntegerT('Unk0A4', itU32),
            wbRefIDT('Bound Object'),     // 034
            wbIntegerT('Unk058', itU32),
            wbIntegerT('Unk0A8', itU32),
            wbIntegerT('Unk0AC', itU32),
            wbIntegerT('Byt0B0', itU8),
            wbIntegerT('Wrd050', itU16),
            wbFloatT('Unk038.Flt000'),
            wbFloatT('Unk038.Flt004'),
            wbRefIDT('Unk040'),
            wbRefIDT('Unk044'),
            wbRefIDT('Unk048'),
            wbRefIDT('Form List'),        // 04C
            wbRefIDT('Unk054'),
            wbArrayPT('List006C', wbRefIDT('Unknown'), -254),
            wbUnionCHANGE_ACTOR_DAMAGE_MODIFIERS
          ])
        ]),
        wbUnion('Middle Low Process', ChangedFormMobileObjectMiddleLowProcessDecider, [wbNull,
          wbStruct('Data', [
            wbIntegerT('Unk0B4', itU32),
            wbUnionCHANGE_ACTOR_TEMP_MODIFIERS
          ])
        ]),
        wbUnion('Middle High Process', ChangedFormMobileObjectMiddleHighProcessDecider, [wbNull,
          wbStruct('Data', [
            wbIntegerT('Unk134', itU8),
            wbIntegerT('Unk135', itU8),
            wbIntegerT('Unk168', itU8),
            wbIntegerT('Unk170', itU32),
            wbIntegerT('Unk174', itU32),
            wbIntegerT('Unk108', itU32),
            wbIntegerT('Unk1DA', itU8),
            wbCoordXYZ('Coords'),
            wbIntegerT('Unk0DC', itU32),
            wbIntegerT('Byt13D', itU8),
            wbIntegerT('Byt144', itU8),
            wbIntegerT('Byt156', itU8),
            wbIntegerT('Wrd154', itU16),
            wbCoordXYZ('Coords'),
            wbIntegerT('Bool', itU8),     // if actor and Byt13D then call actor.func0108
            wbIntegerT('Byt0E0', itU8),
            wbIntegerT('Byt188', itU8),
            wbIntegerT('Byt189', itU8),
            wbIntegerT('Unk0D8', itU32),
            wbIntegerT('Byt18B', itU8),
            wbIntegerT('Unk1D0', itU32),
            wbIntegerT('Unk1D4', itU32),
            wbIntegerT('Byt1D8', itU8),
            wbIntegerT('Byt1D9', itU8),
            wbIntegerT('Byt228', itU8),
            wbIntegerT('Wrd22A', itU16),
            wbIntegerT('Unk1A8', itU32),
            wbIntegerT('Byt0E1', itU8),
            wbIntegerT('Unk190', itU32),
            wbIntegerT('Unk198', itU32),
            wbIntegerT('Byt19C', itU8),
            wbIntegerT('Byt19D', itU8),
            wbIntegerT('Unk234', itU32),
            wbIntegerT('Unk238', itU32),
            wbIntegerT('Unk23C', itU32),    // if form version 0xA or later
            wbIntegerT('Unk244', itU32),    // if form version 0x3 or later
            wbIntegerT('Unk110', itU8),     // if form version 0x7 or later
            wbRefIDT('IdleForm10C'),
            wbRefIDT('IdleForm194'),
            wbRefIDT('Unk158'),
            wbRefIDT('Unk140'),
            wbIntegerT('Unknown', itU32),
            wbArrayPT('List0C8', wbRefIDT('Unknown'), -254),
            wbPackageStruct,
//FNV            wbUnionCHANGE_REFR_ANIMATION_Actor,
            wbNonActorMagicTarget,
            wbRefIDT('Unk164'),
            wbRefIDT('Unk160'),
            wbRefIDT('Unk1BC'),
            wbArrayPT('List230', wbStruct('Data', [
              wbRefIDT('Bound Object'),
              wbIntegerT('Unknown', itS32),
              wbIntegerT('Unk008', itU32),
              wbIntegerT('Unk00C', itU8),
              wbIntegerT('Unk00D', itU8),
              wbIntegerT('Unk00E', itU8),
              wbIntegerT('Unk00F', itU8),
              wbIntegerT('Unk010', itU8),
              wbIntegerT('Unk011', itU8)
            ]), -254)
          ])
        ]),
        wbUnion('High Process', ChangedFormMobileObjectHighProcessDecider, [wbNull,
          wbStruct('Data', [
            wbIntegerT('Unk32C', itU8),
            wbIntegerT('Unk340', itU8),
            wbIntegerT('Unk374', itU8),
            wbIntegerT('Unk375', itU8),
            wbIntegerT('Unk2FC', itU16),
            // wbIntegerT('Unknown', itU32),  // if form version is older than 0x8
            wbIntegerT('Unk2B4', itU32),
            wbIntegerT('Unk2F8', itU32),
            wbIntegerT('Unk310', itU32),
            wbIntegerT('Unk330', itU32),
            wbIntegerT('Unk334', itU32),
            wbIntegerT('Unk338', itU32),
            wbIntegerT('Unk34C', itU32),
            wbIntegerT('Unk294', itU32),
            wbIntegerT('Unk2B8', itU32),
            wbIntegerT('Unk2BC', itU32),
            wbIntegerT('Unk298', itU32),
            wbIntegerT('Unk2C0', itU16),
            wbIntegerT('Unk2C2', itU16),
            wbIntegerT('Unk2C4', itU16),
            wbIntegerT('Unk349', itU8),
            wbCoordXYZ('Coords'),
            wbIntegerT('Unk36C', itU32),
            wbIntegerT('Unk3E8', itU32),
            wbIntegerT('Unk3EC', itU32),
            wbIntegerT('Unk33C', itU32),
            wbIntegerT('Unk2A8', itU32),
            wbIntegerT('Unk378', itU32),
            wbIntegerT('Unk3A0', itU8),
            wbIntegerT('Unk39C', itU32),
            wbIntegerT('Unk3A8', itU8),
            wbIntegerT('Unk3A4', itU32),
            wbIntegerT('Unk420', itU8),
            wbIntegerT('Unk3BC', itU32),
            wbIntegerT('Unk3B0', itU32),
            wbIntegerT('Unk2C6', itU8),
            wbIntegerT('Unk2D0', itU32),
            wbIntegerT('Unk2D4', itU32),
            wbIntegerT('Unk2D8', itU32),
            wbIntegerT('Unk3B8', itU8),
            wbIntegerT('Unk2DC', itU8),   // The same member is loaded three times, first two must be obsolete
            wbIntegerT('Unk2E0', itU32),
            wbIntegerT('Unk344', itU32),
            wbIntegerT('Unk2DC', itU8),   // The same member is loaded three times, first two must be obsolete
            wbIntegerT('Unk2DC', itU8),   // The same member is loaded three times, first two must be obsolete
            wbIntegerT('Unk3D8modulo12', itU32),  // Unk3D8 = saveValue mod 12
            wbIntegerT('Unk448', itU32),
            wbIntegerT('Unk29D', itU8),
            wbIntegerT('Unk2B0', itU32),
            wbIntegerT('Unk2C8', itU32),
            wbIntegerT('Unk418', itU32),
            wbIntegerT('Unk43C', itU32),
            wbIntegerT('Unk440', itU32),
            wbIntegerT('Unk444', itU8),
            wbIntegerT('Unk445', itU8),
            wbIntegerT('Unk450', itU32),
            wbIntegerT('Unk458', itU8),
            wbIntegerT('Unk430', itU32),
            wbIntegerT('Unk3E0', itU8),   // if form version 1 or newer
            wbIntegerT('Unk459', itU8),   // if form version 10 or newer
            wbIntegerT('Unk2A0', itU32),  // if form version 12 or newer
            wbStruct('Unknown', [         // if form version 13 or newer
              wbIntegerT('Unk3D0', itU8),   // if null, set Unk3D1 to null
              wbIntegerT('Unk3D1', itU8),
              wbIntegerT('Unk348', itU8),
              wbIntegerT('Unknown', itU8)   // if not null, set Unk3D1 to 1 and Unk3D0 to 0
            ]),
            wbRefIDT('Unk30C'),
            wbRefIDT('Unk2A4'),
            wbRefIDT('Unk3F0'),
            wbRefIDT('Unk41C'),
            wbRefIDT('Unk37C'),
            wbRefIDT('Idle'),             // 350
            wbRefIDT('Unk2AC'),           // if form version 15 or newer
            wbArrayPT('Unknown', wbStruct('Data', [
              wbRefIDT('Unk3F8'),
              wbIntegerT('Unk410', itU8)
            ]), 6), // if form version 4 or newer, array count 5 before
            wbArrayPT('List38C', wbRefIDT('Unknown'), -254),
            wbArrayPT('List394', wbRefIDT('Unknown'), -254),
            wbArrayPT('List264', wbRefIDT('Unknown'), -254),   // if form version 18 or newer
            wbDialogueItems,
            wbArrayPT('List44C', wbStruct('Data', [
              wbStruct('Unk000', [
                wbIntegerT('Byt020', itU8),
                wbIntegerT('Unk018', itU32),
                wbIntegerT('Unk01C', itU32),
                wbCoordXYZ('Coords'),
                wbUnion('Data00C', ChangedFormList44CData00CDecider, [wbNull, wbCoordXYZ('Coords')])
              ]),
              wbFloatT('Unk024'),
              wbFloatT('Unk02C'),
              wbRefIDT('Static'),
              wbRefIDT('Form030')
            ]), -254),
            wbArrayPT('List25C', wbStruct('Data', [
              wbRefIDT('Form000'),
              wbIntegerT('Unk004', itU8),
              wbIntegerT('Unk008', itU32),
              wbCoordXYZ('Coords'),
              wbFloatT('Tim018'),
              wbIntegerT('Byt01E', itU8),
              wbIntegerT('Byt01C', itU8),
              wbIntegerT('Byt01D', itU8),
              wbIntegerT('Unk020', itU32),
              wbIntegerT('Byt01F', itU8)      // if form version 8 or newer
            ]), -254),
            wbArrayPT('List260', wbStruct('Data', [  // Same as List260 and GlobalData 9 Lst0004
              wbRefIDT('Form000'),
              wbIntegerT('Unk004', itU8),
              wbIntegerT('Unk008', itU32),
              wbCoordXYZ('Coords'),
              wbFloatT('Tim018'),
              wbIntegerT('Byt01E', itU8),
              wbIntegerT('Byt01C', itU8),
              wbIntegerT('Byt01D', itU8),
              wbIntegerT('Unk020', itU32),
              wbIntegerT('Byt01F', itU8)      // if form version 8 or newer
            ]), -254),
            wbIntegerT('Has Unk3DC', itU8),
            wbUnion('Data3DC', ChangedFormHasUnk3DCDecider, [wbNull,
              wbStruct('Unk3DC', [
                wbIntegerT('Unk000', itU32),
                wbCoordXYZ('Coords'),
                wbFloatT('Tim010'),
                wbIntegerT('Unk014', itU32),
                wbRefIDT('Form018')
              ])
            ]),
            wbStruct('SubBuffer', [
              wbIntegerT('Length', itU6to30),
              wbByteArray('Data', ChangedFormHighProcessSubBufferCounter)
            ])
          ])
        ])
      ])
    ])
  ]);

  wbPathingRequestSubStruct := wbStruct('PathingRequest subStruct', [
    wbIntegerT('Byt020', itU8),
    wbIntegerT('Unk018', itU32),
    wbIntegerT('Unk01C', itU32),
    wbCoordXYZ('Coords'),
    wbUnion('Unk00C', ChangedFormPathingRequestSubStructHasUnk00CDecider, [wbNull, wbCoordXYZ('Coords')])
  ]);

  wbPathingRequest := wbStruct('Pathing Request', [
    wbPathingLocation,
    wbPathingLocation,
    wbIntegerT('Unk068', itU32),
    wbIntegerT('Unk06C', itU32),
    wbIntegerT('Unk070', itU32),
    wbIntegerT('Unk074', itU32),
    wbIntegerT('Unk078', itU32),
    wbIntegerT('Unk088', itU32),
    wbIntegerT('Unk08C', itU32),
    wbIntegerT('Byt099', itU8),
    wbIntegerT('Byt098', itU8),
    wbIntegerT('Byt09A', itU8),
    wbIntegerT('Byt09B', itU8),
    wbIntegerT('Byt09C', itU8),
    wbIntegerT('Byt09D', itU8),
    wbIntegerT('Byt09F', itU8),     // if form version 13 or greater
    wbStruct('Unknown', [           // if form version 15 or greater
      wbIntegerT('Unk090', itU32),
      wbIntegerT('Byt0A0', itU8),
      wbIntegerT('Byte0A1', itU8)
    ]),
    wbStruct('Unknown', [
      wbCoordXYZ('Coords'),
      wbIntegerT('Byt0A2', itU8),
      wbIntegerT('Byt0A3', itU8),
      wbIntegerT('Byt0A4', itU8),
      wbIntegerT('Unk0A8', itU32)
    ]),
    wbIntegerT('Byt09E', itU8),     // if form version 20 or greater
    wbIntegerT('Byt0AC', itU8),     // if form version 21 or greater
    wbArrayPT('Unk094', wbPathingRequestSubStruct, -254)
  ]);

  wbChangedActor := wbStruct('Changed Actor', [
    wbChangedMobileObject,
    wbFloatT('Unk114'),
    wbIntegerT('Byt124', itU8),
    wbIntegerT('Byt125', itU8),
    wbIntegerT('Byt0BC', itU8),
    wbIntegerT('Byt0C4', itU8),
    wbIntegerT('Unk0C8', itU32),
    wbIntegerT('Byt07D', itU8),
    wbIntegerT('Unk110', itU32),
    wbIntegerT('Byt118', itU8),
    wbIntegerT('Byt126', itU8),
    wbIntegerT('Byt145', itU8),
    wbIntegerT('Byt146', itU8),
    wbIntegerT('Byt14C', itU8),
    wbIntegerT('Byt14D', itU8),
    wbIntegerT('Unk150', itU32),
    wbIntegerT('Unk154', itU32),
    wbIntegerT('Unk158', itU32),
    wbIntegerT('Byt174', itU8),
    wbIntegerT('Byt175', itU8),
    wbIntegerT('Byt18D', itU8),
    wbIntegerT('Unk1A4', itU32),
    wbIntegerT('Unk1A8', itU32),
    wbIntegerT('Byt0F0', itU8),
    wbIntegerT('Byt0F1', itU8),
    wbIntegerT('Unk10C', itU32),  // if form version 8 or greater
    wbStruct('Unk0138', [         // if form version 9 or greater
      wbIntegerT('Byt000', itU8),
      wbIntegerT('Unk004', itU32),
      wbIntegerT('Byt010', itU8),
      wbIntegerT('Unk008', itU32),
      wbIntegerT('Unk00C', itU32)
    ]),
    wbIntegerT('Unk120', itU32),  // if form version 13 or greater
    wbRefIDT('Form0C0'),
    wbRefIDT('Actor Base'),       // 148
    wbRefIDT('Form070'),
    wbUnionCHANGE_ACTOR_LIFESTATE,
    wbUnionCHANGE_ACTOR_DISPOSITION_MODIFIERS,
    wbUnionCHANGE_ACTOR_PERMANENT_MODIFIERS,
    wbUnionCHANGE_ACTOR_OVERRIDE_MODIFIERS,
    wbStruct('Actor Mover', [
      wbIntegerT('Wrd040', itU16),
      wbIntegerT('Wrd042', itU16),
      wbIntegerT('Byt070', itU8),
      wbIntegerT('Unk034', itU32),
      wbIntegerT('Byt071', itU8),
      wbIntegerT('Unk038', itU32),
      wbIntegerT('Byt072', itU8),
      wbIntegerT('Byt073', itU8),
      wbCoordXYZ('Coords 004'),
      wbCoordXYZ('Coords 010'),
      wbIntegerT('Unk03C', itU32),
      wbIntegerT('Byt074', itU8),
      wbIntegerT('Byt075', itU8),
      wbIntegerT('Byt077', itU8),
      wbIntegerT('Byt076', itU8),
      wbIntegerT('Byt078', itU8),
      wbIntegerT('Unk06C', itU32),
      wbStruct('Unknown', [             // if form version 14 or greater
        wbIntegerT('Unknown', itU32),   // Sub with globals to fill 07C
        wbIntegerT('Unk084', itU32)
      ]),
      wbPathingLocation,
      wbRefIDT('Form02C'),
      wbIntegerT('Content Flags', itU8),
      wbUnion('Pathing Request', ChangedFormPackageActorMoverContentFlagsBit0Decider, [wbNull, wbStruct('Data', [
          wbIntegerT('Type', itU8, wbEnum([
              'PathingRequest',                 // 00
              'PathingRequestCover',            // 01
              'PathingRequestClosePoint',       // 02
              'PathingRequestFlee',             // 03
              'PathingRequestHide',             // 04
              'PathingRequestLOS',              // 05
              '<bad type>',                     // 06
              'PathingRequestOptimalLocation',  // 07
              'PathingRequestCoveredMove'       // 08
            ])),
            wbUnion('Pathing Request Data', ChangedFormPathingRequestTypeDecider, [
              wbPathingRequest,
              wbStruct('PathingRequestCover', [
                wbPathingRequest
              ]),
              wbStruct('PathingRequestClosePoint', [
                wbPathingRequest,
                wbFloatT('Unk0B0'),
                wbFloatT('Unk0B4')
              ]),
              wbStruct('PathingRequestFlee', [
                wbPathingRequest,
                wbFloatT('Unk0B0')
              ]),
              wbStruct('PathingRequestHide', [
                wbPathingRequest,
                wbPathingLocation,
                wbFloatT('Unk0D8')
              ]),
              wbStruct('PathingRequestLOS', [
                wbPathingRequest,
                wbArrayPT('Unk0B4', wbCoordXYZ('NiPoint3'), -254),
                wbFloatT('Unk0C4'),
                wbCoordXYZ('Coords'),
                wbFloatT('Unk0D4')
              ]),
              wbNull,
              wbStruct('PathingRequestOptimalLocation', [
                wbPathingRequest,
                wbFloatT('Unk0B0'),
                wbFloatT('Unk0B4')
              ]),
              wbStruct('PathingRequestCoveredMode', [
                wbPathingRequest,
                wbFloatT('Unk0B0'),
                wbFloatT('Unk0B4'),
                wbFloatT('Unk0B8'),
                wbFloatT('Unk0BC'),
                wbFloatT('Unk0C0'),
                wbIntegerT('Unk0C4', itU32),
                wbCoordXYZ('Coords 0C8'),
                wbCoordXYZ('Coords 0D4'),
                wbIntegerT('Byt0E0', itU8),
                wbArrayPT('Unk0E4', wbIntegerT('Unknown', itU32), -254),
                wbArrayPT('Unk0F4', wbCoordXYZ('NiPoint3'), -254)
              ])
            ])
        ])
      ]),
      wbUnion('Pathing Solution', ChangedFormPackageActorMoverContentFlagsBit1Decider, [wbNull,
        wbStruct('Data', [
          wbIntegerT('Byt040', itU8),
          wbIntegerT('Unk018', itS32),
          wbIntegerT('Unk01C', itS32),
          wbArrayPT('Virtual Pathing Nodes', wbStruct('Virtual Pathing Node', [
            wbIntegerT('Unk000', itU32),
            wbRefIDT('Reference'),
            wbPathingLocation
          ]), -254),
          wbArrayPT('Pathing Nodes', wbStruct('Pathing Node', [
            wbIntegerT('Unk000', itU32),
            wbCoordXYZ('Coords'),
            wbRefIDT('Reference'),
            wbPathingLocation
          ]), -254),
          wbArrayPT('Unused', wbPathingRequestSubStruct, -254),
          wbArrayPT('Unk030', wbRefIDT('RefID'), -254)                   // if from version 18 or greater
        ])
      ]),
      // The next two are mutually exclusive
      wbUnion('Virtual Actor Path Handler', ChangedFormPackageActorMoverContentFlagsBit2Decider, [wbNull,
        wbStruct('Data', [
          wbIntegerT('Unk014', itU32),
          wbFloatT('Unk018'),
          wbFloatT('Unk01C')
        ])
      ]),
      wbUnion('Detailed Actor Path Handler', ChangedFormPackageActorMoverContentFlagsBit3Decider, [wbNull,
        wbStruct('Data', [
          wbCoordXYZ('Coords 01C'),
          wbCoordXYZ('Coords 028'),
          wbCoordXYZ('Coords 034'),
          wbCoordXYZ('Coords 040'),
          wbCoordXYZ('Coords 04C'),
          wbIntegerT('Unk060', itU32),
          wbIntegerT('Unk064', itU32),
          wbIntegerT('Unk068', itU32),
          wbIntegerT('Unk06C', itU32),
          wbIntegerT('Unk070', itU32),
          wbIntegerT('Unk074', itU32),
          wbIntegerT('Unk078', itU32),
          wbIntegerT('Unk07C', itU32),
          wbIntegerT('Unk080', itU32),
          wbIntegerT('Unk084', itU32),
          wbIntegerT('Unk088', itU32),
          wbIntegerT('Unk08C', itU32),
          wbIntegerT('Unk090', itU32),
          wbIntegerT('Unk094', itU32),
          wbIntegerT('Unk098', itU32),
          wbIntegerT('Unk09C', itU32),
          wbIntegerT('Unk0AC', itU32),
          wbIntegerT('Unk0B0', itU32),
          wbIntegerT('Unk0B4', itU32),
          wbIntegerT('Unk0B8', itU32),
          wbStruct('Unk014', [            // if form version 4 or greater
            wbIntegerT('Unk000', itU32),
            wbIntegerT('Unk004', itU32)
          ]),
          wbIntegerT('Unk0C8', itU32),
          wbIntegerT('Unk0CC', itU32),
          wbIntegerT('Unk0D0', itU32),
          wbIntegerT('Unk0D4', itU32),
          wbIntegerT('Byt0DC', itU8),
          wbIntegerT('Byt0DD', itU8),
          wbIntegerT('Byt0DE', itU8),
          wbIntegerT('Byt0DF', itU8),
          wbIntegerT('Byt0E0', itU8),
          wbIntegerT('Byt0E2', itU8),
          wbIntegerT('Byt0E1', itU8),
          wbStruct('Unk0C0', [             // if form version 12 or greater
            wbIntegerT('Byt000', itU8),
            wbIntegerT('Byt001', itU8),
            wbIntegerT('Unk004', itU32)
          ]),
          wbStruct('Unknown', [        // if form version 12 or greater
            wbCoordXYZ('Coords'),
            wbIntegerT('Unk0BC', itU32)
          ]),
          wbRefIDT('Form0D8'),
          wbArrayPT('List058', wbRefIDT('RefID'), -254)
        ])
      ]),
      wbUnion('Player specific', IsActorPlayerDecider, [wbNull, wbStruct('Player Mover', [
          wbCoordXYZ('Coords'),
          wbIntegerT('Unk094', itU32),
          wbIntegerT('Unk098', itU32),
          wbIntegerT('Unk09C', itU32)
        ])
      ])
    ])
  ]);

  wbChangedCharacter := wbStruct('Changed Character', [
    wbChangedActor,
    // wbIntegerT('Unused', itU8),    // if form version older than 9
    // wbIntegerT('Unused', itU32),   // if form version older than 9
    wbIntegerT('Byt1C0', itU8),
    wbIntegerT('Byt1C1', itU8)
    // wbIntegerT('Unused', itU8),    // if form version older than 9
    // wbIntegerT('Unused', itU32),   // if form version older than 9
    // wbIntegerT('Unused', itU32)    // if form version older than 9
  ]);

  wbChangedCreature := wbStruct('Changed Creature', [
    wbChangedActor
  ]);

  wbChangedACHR := wbStruct('Change ACHR Data', [ {03B}
     wbUnion('Player specific', IsActorPlayerDecider, [wbNull, wbStruct('Player data', [
       wbArray('ActorValues244', wbFloatT('Actor Value'), wbActorValueLabels),
       wbArray('ActorValues378', wbFloatT('Actor Value'), wbActorValueLabels),
       wbArray('ActorValues4B0', wbFloatT('Actor Value'), wbActorValueLabels),
       wbIntegerT('Unk4AC', itU32)
     ])])
    ,wbChangedCharacter
    ,wbUnion('Player specific', IsActorPlayerDecider, [wbNull, wbStruct('Player data', [
//FNV           wbUnionCHANGE_REFR_ANIMATION_Actor, // There really are two animation subBuffer for the player
       wbIntegerT('Byt64A', itU8),
       wbIntegerT('Byt64D', itU8),
       wbIntegerT('Byt651', itU8),
       wbIntegerT('Byt652', itU8),
       wbIntegerT('Unk654', itU32),
       wbIntegerT('Unk660', itU32),
       wbIntegerT('Unk664', itU32),
       wbIntegerT('Unk668', itU32),
       wbIntegerT('Byt66C', itU8),
       wbIntegerT('Byt6CC', itU8),
       wbIntegerT('Unk6D0', itU32),
       wbIntegerT('Unk6D4', itU32),
       wbIntegerT('Byt6D8', itU8),
       wbIntegerT('Unk6DC', itU32),
       wbIntegerT('Byt6E8', itU8),
       wbIntegerT('Byt681', itU8),
       wbIntegerT('Byt75C', itU8),        // linked to FaceGen somehow
       wbIntegerT('Byt7C6', itU8),
       wbIntegerT('Unk6E4', itU32),
       wbStruct('Refr6F4 Pos', [
         wbFloat('PosX'),
         wbFloat('PosY'),
         wbFloatT('PosZ')
       ]),
       wbIntegerT('Unk698', itU32),
       wbIntegerT('Unk67C', itU32),
       wbIntegerT('Unk738', itU32),
       wbIntegerT('Byt658', itU8),
       wbIntegerT('Unk65C', itU32),
       wbIntegerT('Unk674', itU32),
       wbIntegerT('Unk670', itU32),
       wbIntegerT('Byt75C', itU8),
       wbIntegerT('Unk730', itU32),
       wbIntegerT('Unk790', itU32),
       wbIntegerT('Byt680', itU8),
       wbIntegerT('Byt7C4', itU8),
       wbIntegerT('Unk63C', itU32),
       wbIntegerT('Unk640', itU32),
       wbIntegerT('Unk644', itU32),
       wbIntegerT('Unk200', itU32),
       wbIntegerT('Byt240', itU8),
       wbIntegerT('Byt64E', itU8),
       wbIntegerT('Byt66D', itU8),
       wbIntegerT('Unk794', itU32),
       wbFloatT('flt_11E0B5C'),
       wbIntegerT('UnkD6C', itU32),
       wbIntegerT('UnkD70', itU32),
       wbIntegerT('Unk228', itU32),
       wbIntegerT('Unk22C', itU32),
       wbIntegerT('Unk230', itU32),
       wbIntegerT('Unk234', itU32),
       wbIntegerT('Byt608', itU8),
       wbIntegerT('BytDF2', itU8),
       wbIntegerT('Byt64F', itU8),        // if form version 13 or greater
       wbIntegerT('Byt650', itU8),        // idem
       wbIntegerT('Byt7C7', itU8),        // if form version 16 or greater
       wbIntegerT('Byt5F8', itU8),        // if form version 18 or greater
       wbStruct('Unknown', [              // if form version 21 or greater
         wbIntegerT('Unk1FC', itU32),
         wbIntegerT('Unk684', itU32),
         wbArray('Unk744', wbIntegerT('Unknown', itU32), 5)
       ]),
       wbStruct('Unk878', [
         wbIntegerT('Byt000', itU8),
         wbIntegerT('Unk004', itU32)
       ]),
       wbRefIDT('Quest'),
       wbRefIDT('Class'),
       wbRefIDT('Refr6F4 Parent Cell'),
       wbRefIDT('Region'),
       wbRefIDT('Region Weather'),        // Goes into Region::Unk024
       wbRefIDT('Form208'),
       wbRefIDT('Form224'),               // if form version 18 or greater
       wbRefIDT('Form638'),
       wbRefIDT('Form604'),
       wbRefIDT('FormD2C'),
       wbRefIDT('FormD44'),
       wbArrayPT('List6A8', wbRefIDT('Topic'), -254),
       wbArrayPT('List5E4', wbRefIDT('Note'), -254),
       wbChangedInventory,
       wbArrayPT('ListD48', wbStruct('Data', [
         wbRefIDT('Form000'),
         wbIntegerT('Byt004', itU8),
         wbIntegerT('Byt005', itU8)
       ]), -254),
       wbArrayPT('Perks', wbStruct('Data', [
         wbRefIDT('Perk'),
         wbIntegerT('Byt004', itU8)
       ]), -254),
       wbArrayPT('List60C', wbStruct('Data', [
         wbIntegerT('Unk000', itU32),
         wbFloatT('Flt004'),
         wbRefIDT('FormID')
       ]), -254),
       wbArrayPT('List610', wbStruct('Data', [
         wbIntegerT('Unk000', itU32),
         wbIntegerT('Unk004', itU32),
         wbIntegerT('Wrd008', itU16)
       ]), -254),
       wbArrayPT('Cards 614', wbRefIDT('Card'), -254),
       wbArrayPT('Cards 618', wbRefIDT('Card'), -254),
       wbIntegerT('Unk61C', itU32),
       wbIntegerT('Unk620', itU32),
       wbIntegerT('Unk624', itU32),
       wbIntegerT('Unk628', itU32),
       wbIntegerT('Unk62C', itU32),
       wbArrayPT('Stages', wbStruct('Data', [
         wbRefIDT('Quest'),
         wbIntegerT('Stage', itU8),
         wbIntegerT('LogEntry', itU8)
       ]), -254),
       wbArrayPT('Objectives', wbStruct('Data', [
         wbRefIDT('Quest'),
         wbIntegerT('Objective', itU32)
       ]), -254),
       wbNonActorMagicTarget,
       wbIntegerT('KeyForUnkD64', itU32),
       wbStruct('Unknown', [                      // if form version 8 or greater
         wbFloatT('Unkown 11DFED4'),
         wbFloatT('Unkown 11DFED8')
       ]),
       wbArrayPT('Perks AD4', wbStruct('Data', [   // if form version 16 or greater
         wbRefIDT('Perk'),
         wbIntegerT('Byt004', itU8)
       ]), -254),
       wbIntegerT('HardcoreMode', itU8),          // if form version 17 or greater
       wbIntegerT('Clears HardcoreFlag', itU8),   // if form version 17 or greater
       wbIntegerT('Byt66E', itU8),                // if form version 19 or greater
       wbArrayPT('Unknown E3C', wbFormIDT('Form'), 8),  // if form version 1A or greater
       wbStruct('Lists 11CAC98', [                     // if form version 1B or greater
         wbArrayPT('Enabled',  wbRefIDT('RefID'), -254),
         wbArrayPT('Disabled', wbRefIDT('RefID'), -254),
         wbArrayPT('Unknown',  wbRefIDT('RefID'), -254),
         wbArrayPT('FadeOut',  wbRefIDT('RefID'), -254)
       ])
     ])])
   ]);

  wbChangedACTI := wbStruct('Change ACTI Data', [ {015}
     wbUnionCHANGE_FORM_FLAGS
    ,wbUnionCHANGE_BASE_OBJECT_VALUE    // listed but not checked !
    ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
  ]);

  wbChangedProjectile := wbStruct('Changed projectile', [  // Unverified for FO3
    wbChangedMobileObject,
    wbIntegerT('Unk00C8', itU32),
    wbIntegerT('Unk00CC', itU32),
    wbIntegerT('Unk00D4', itU32),
    wbIntegerT('Unk00D0', itU32),
    wbIntegerT('Unk00D8', itU32),
    wbIntegerT('Unk00DC', itU32),
    wbIntegerT('Unk00E0', itU32),
    wbIntegerT('Unk00E4', itU32),
    wbIntegerT('Unk00E8', itU32),
    wbRefIDT('Weapon'),
    wbRefIDT('Ref00FC'),
    wbRefIDT('Ref0100'),
    wbByteArrayT('Unk0104', $0C), // wbCoordXYZ('Coords'),
    wbIntegerT('Unk0110', itU32),
    wbIntegerT('Unk0118', itU8),
    wbIntegerT('Unk0124', itU32),
    wbStruct('Unk0094', [
      wbFloat('Unk000'), // Coefficient
      wbFloat('Unk004'), // triplet of values
      wbFloat('Unk008'),
      wbFloatT('Unk00C')
    ]),
    wbByteArrayT('Unk00B8', $0C), // if version >= 0D
    wbIntegerT('Unk00C4', itU32), // if version >= 0D
    wbIntegerT('Unk00EC', itU32), // if version >= 08
    wbIntegerT('Unk00F0', itU32), // if version >= 08
    wbIntegerT('Unk00F4', itU32), // if version >= 0E
    wbIntegerT('Unknown', itU32), // key in gList_11D6124, "result" goes int Unk0120
    wbIntegerT('Has Entry Data', itU8), // if version >= 03
    wbUnion('Entry Data Union', ChangedFormProjectileHasEntryDataDecider, [wbNull, wbEntryData]), // goes into Unk0144
    wbArrayPT('Lst0088',  wbStruct('Struct0088', [
      wbByteArrayT('Unk004', $0C), // thats' 3 iyU32/float ? wbCoordXYZ('Coords'),
      wbByteArrayT('Unk010', $0C),
      wbIntegerT('Unk020', itU32),
      wbIntegerT('Unk024', itU32),
      wbIntegerT('Unk028', itU8),
      wbIntegerT('Unk02A', itU16),  // if version >= 011
      wbIntegerT('Unk02C', itU16),  // if version >= 011
      wbRefIDT('RefID')             // goes into 000
    ]), -254), // if version >= 0E also , whats in Unk01C ?
    wbIntegerT('Unk0090', itU8) // if version >= 010
  ]);

  wbChangedFormData := wbStruct('Changed Form Data', [
    wbInitialDataType,
    wbUnion('CForm Union', ChangedFormDataDecider, [
       wbNull
      ,wbChangedREFR  {03A}
      ,wbChangedACHR  {03B}
      ,wbStruct('Change ACRE Data', [ {03C}
         wbChangedCreature
       ])
      ,wbStruct('Change PMIS Data', [ {03D}
        wbChangedProjectile
       ])
      ,wbStruct('Change PGRE Data', [ {03E}
        wbChangedProjectile
       ])
      ,wbStruct('Change PBEA Data', [ {03F}
        wbChangedProjectile
       ])
      ,wbStruct('Change PFLA Data', [ {040}
        wbChangedProjectile,
        wbIntegerT('Unk0150', itU32),
        wbIntegerT('Unk0154', itU32)
       ])
      ,wbStruct('Change CELL Data', [ {039}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_CELL_FLAGS
        ,wbUnionCHANGE_CELL_FULLNAME
        ,wbUnionCHANGE_CELL_OWNERSHIP
        ,wbUnionCHANGE_CELL_EXTERIOR_SHORT
        ,wbUnionCHANGE_CELL_EXTERIOR_CHAR
        ,wbUnionCHANGE_CELL_DETACHTIME
        ,wbUnionCHANGE_CELL_SEENDATA
       ])
      ,wbStruct('Change INFO Data', [ {046}
         wbUnionCHANGE_FORM_FLAGS
// no actual data        wbUnionCHANGE_TOPIC_SAIDONCE
       ])
      ,wbStruct('Change QUST Data', [ {047}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_QUEST_FLAGS
        ,wbUnionCHANGE_QUEST_SCRIPT_DELAY
        ,wbUnionCHANGE_QUEST_OBJECTIVES
        ,wbUnionCHANGE_QUEST_SCRIPT
        ,wbUnionCHANGE_QUEST_STAGES
       ])
      ,wbChangedNPC                   {02A}
      ,wbChangedCREA                  {02B}
      ,wbChangedACTI                  {015}
      ,wbStruct('Change TACT Data', [ {016}
         wbChangedACTI
        ,wbUnionCHANGE_TALKING_ACTIVATOR_SPEAKER
       ])
      ,wbStruct('Change TERM Data', [ {017}
         wbChangedACTI
       ])
      ,wbStruct('Change ARMO Data', [ {018}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME    // listed but not checked !
       ])
      ,wbStruct('Change BOOK Data', [ {019}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME    // listed but not checked !
        ,wbUnionCHANGE_BOOK_TEACHES_SKILL
       ])
      ,wbStruct('Change CLOT Data', [ {01A}   // loaded using the same procedure as ARMO
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change CONT Data', [ {01B}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE       // listed but not checked !
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME    // listed but not checked !
       ])
      ,wbStruct('Change DOOR Data', [ {01C}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE       // listed but not checked !
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME    // listed but not checked !
       ])
      ,wbStruct('Change INGR Data', [ {01D}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE       // listed but not checked !
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME    // listed but not checked !
       ])
      ,wbStruct('Change LIGH Data', [ {01E}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME    // listed but not checked !
       ])
      ,wbStruct('Change MISC Data', [ {01F}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME    // listed but not checked !
       ])
      ,wbStruct('Change STAT Data', [ {020}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE       // listed but not checked !
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME    // listed but not checked !
       ])
      ,wbStruct('Change MSTT Data', [ {022}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change FURN Data', [ {027}
         wbChangedACTI
       ])
      ,wbStruct('Change WEAP Data', [ {028}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change AMMO Data', [ {029}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change KEYM Data', [ {02E}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change ALCH Data', [ {02F}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change IDLM Data', [ {030}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change NOTE Data', [ {031}
         wbUnionCHANGE_FORM_FLAGS
// no actual data           wbUnionCHANGE_NOTE_READ
       ])
      ,wbStruct('Change ECZN Data', [ {061}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_ENCOUNTER_ZONE_FLAGS
        ,wbUnionCHANGE_ENCOUNTER_ZONE_GAME_DATA
       ])
      ,wbStruct('Change CLAS Data', [ {007}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_CLASS_TAG_SKILLS
       ])
      ,wbStruct('Change FACT Data', [ {008}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_FACTION_REACTIONS
        ,wbUnionCHANGE_FACTION_FLAGS
        ,wbUnionCHANGE_FACTION_CRIME_COUNTS
       ])
      ,wbStruct('Change PACK Data', [ {049}
// no actual data        wbUnionCHANGE_PACKAGE_WAITING
// no actual data        wbUnionCHANGE_PACKAGE_NEVER_RUN,
        wbUnionCHANGE_PACKAGE_CREATED
       ])
      ,wbStruct('Change NAVM Data', [ {043}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change FLST Data', [ {055}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_FORM_LIST_ADDED_FORM
       ])
      ,wbStruct('Change LVLC Data', [ {02C}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_LEVELED_LIST_ADDED_OBJECT
       ])
      ,wbStruct('Change LVLN Data', [ {02D}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_LEVELED_LIST_ADDED_OBJECT
       ])
      ,wbStruct('Change LVLI Data', [ {034}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_LEVELED_LIST_ADDED_OBJECT
       ])
      ,wbStruct('Change WATR Data', [ {04E}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_WATER_REMAPPED
       ])
    ]),
    wbByteArray('Undecoded Data', ChangedFormRemainingDataCounter)
  ]);

  wbChangedForm := wbStructC('Changed Form',
    ChangedFormSizer,
    ChangedFormGetChapterType,
    ChangedFormGetChapterTypeName,
    ChangedFormGetChapterName,
    [
      wbRefID('RefID'),
      wbChangeFlags,
      wbInteger('Type', itU8, wbChangeTypes),
      wbInteger('Version', itU8),
      wbUnion('Datas', ChangedFormDataLengthDecider, [
        wbStruct('CForm Data', [
          wbInteger('Length', itU8),
          wbStructZ('Small Struct', ChangedFormDataSizer, ChangedFormGetChapterType, ChangedFormGetChapterTypeName, nil,
            [ wbChangedFormData ])
        ]),
        wbStruct('CForm Data', [
          wbInteger('Length', itU16),
          wbStructZ('Medium Struct', ChangedFormDataSizer, ChangedFormGetChapterType, ChangedFormGetChapterTypeName, nil,
            [ wbChangedFormData ])
        ]),
        wbStruct('CForm Data', [
          wbInteger('Length', itU32),
          wbStructZ('Large Struct', ChangedFormDataSizer, ChangedFormGetChapterType, ChangedFormGetChapterTypeName, nil,
            [ wbChangedFormData ])
        ]),
        wbUnknown() // If the type is invalid
      ])
    ]);

  wbHeader := wbStruct('Header', [
    wbIntegerT('Version', itU32),
    wbStringT('Language', 64),
    wbIntegerT('Screenshot Width', itU32),
    wbIntegerT('Screenshot Height', itU32),
    wbIntegerT('Save Number', itU32),
    wbLenStringT('Player Name', -3),
    wbLenStringT('Player Status', -3),
    wbIntegerT('Player Level', itU32),
    wbLenStringT('Player Cell', -3),
    wbLenStringT('Save Duration', -3)
  ]);

  wbFileLocationTable := wbStruct('File Location Table', [
    wbInteger('RefID Array Count Offset', itU32),
    wbInteger('Unknown Table Offset', itU32),
    wbInteger('Global Data Table 1 Offset', itU32),
    wbInteger('Changed Forms Offset', itU32),
    wbInteger('Global Data Table 2 Offset', itU32),
    wbInteger('Global Data Table 1 Count', itU32),
    wbInteger('Global Data Table 2 Count', itU32),
    wbInteger('Changed Forms Count', itU32),
    wbInteger('Unknown Count', itU32),
    wbByteArray('Unused', $6e - 9*4)
  ]);

  wbSaveHeader := wbStruct('Save File Header', [
     wbString('Magic', 11)
    ,wbInteger('Header Size', itU32)
    ,wbHeader
    ,wbByteArray('Hidden: Screenshot Data', ScreenShotDataCounter)
    ,wbInteger('Form Version', itU8)
    ,wbInteger('PluginInfo Size', itU32)
    ,wbArrayPT(wbFilePlugins, wbLenStringT('PluginName', -3), -4)
    ,wbFileLocationTable
  ]);

  wbSaveChapters := wbStruct('Save File Chapters', [
     wbArray('Global Data 1', wbGlobalData, [], GlobalData1Counter)
    ,wbArray('Changed Forms', wbChangedForm, [], ChangedFormsCounter)
    ,wbArray('Global Data 2', wbGlobalData, [], GlobalData2Counter)
    ,wbArray('FormIDs', wbFormID('FormID', cpFormID), -1, RefIDTableAfterLoad)
    ,wbArray('Visited Worldspace', wbFormID('FormID', cpFormID), -1, WorldspaceTableAfterLoad)
    ,wbArray('Unknown Table', wbInteger('Unknown', itU8), -1)
//    ,wbByteArray('Unused', SkipCounter) // Lets you skip an arbitrary number of byte, Setable from CommandLine -bts:n
//    ,wbArray('Remaining',  WbByteArray('Unknown', wbBytesToGroup), DumpCounter) // Lets you dump an arbitrary number of quartet, Setable from CommandLine -btd:n
  ]);

  wbCoSaveHeader := wbStruct('CoSave File Header', [
     wbString('Magic', 4)
    ,wbInteger('Version', itU32)
    ,wbInteger('FOSE Version', itU16)
    ,wbInteger('FOSE Minor Version', itU16)
    ,wbInteger('Fallout Version', itU32)
    ,wbInteger('Plugins count', itU32)
  ]);

  wbCoSaveChunk := wbStructC('Chunk', nil, wbCoSaveChunkType, wbCoSaveChunkTypeName, nil, [
    wbInteger('Type', itU32, wbStr4),
    wbInteger('Version', itU32),
    wbInteger('Length', itU32),
    wbUnion('Data', FOSEChaptersDecider, [
      wbNull,
      wbArray('Modules', wbLenString('PluginName', 2), -4),
      wbNull,  // STVS String Var Map Start
      wbStruct('String_var', [
        wbInteger('Owning Module Index', itU8),
        wbInteger('ID', itU32),
        wbLenString('Value', 2)
      ]),
      wbNull,  // STVE String Var Map End
      wbNull,  // ARVS Array Var Map Start
      wbStruct('Array_var', [
        wbInteger('Owning Module Index', itU8),
        wbInteger('ID', itU32),
        wbInteger('Key Type', itU8, wbCoSaveArrayTypeEnum),
        wbInteger('Packed', itU8),
        wbArray('Refs', wbInteger('Ref', itU8), -1),
        wbArray('Elements', wbStruct('Element', [
          wbUnion('Key', wbCoSaveArrayKeyElementDecider, [
            wbNull,
            wbDouble('Numeric Key'),
            wbLenString('String Key', 2)
          ]),
          wbInteger('Data Type', itU8, wbCoSaveArrayTypeEnum),
          wbUnion('Data', wbCoSaveArrayDataElementDecider, [
            wbNull,
            wbDouble('Numeric Data'),
            wbFormID('Form Data'),
            wbLenString('String Data', 2),
            wbInteger('Array Data', itU32)
          ])
        ]), -1)
      ]),
      wbNull,  // ARVE Array Var Map End
      wbByteArray('Others', wbCoSaveChapterOtherCounter)  // For what we cannot hardcode
   ])
  ]);
//  wbCoSaveChunk.TreeLeaf := True;

  wbCoSaveChunks := wbArray('Chunks', wbCoSaveChunk, wbCoSaveChunkCounter, cpNormal, false, wbDontShowBranch);
  wbCoSavePlugin := wbStructC('Plugin', nil, wbCoSaveArrayType, wbCoSaveArrayTypeName, nil, [
    wbInteger('Opcode Base', itU32),
    wbInteger('Chunks count', itU32),
    wbInteger('Length', itU32),
    wbCoSaveChunks
  ]);
//  wbCoSavePlugin.TreeLeaf := True;
  wbCoSaveChunks.TreeBranch := True;
  wbCoSavePlugins := wbArray('Plugins', wbCoSavePlugin, wbCoSavePluginCounter);

  wbCoSaveChapters := wbStruct('CoSave File Chapters', [
    wbCoSavePlugins
  ]);

  wbFileChapters := wbSaveChapters;
  wbFileHeader := wbSaveHeader;
  wbSaveHeader.TreeHead := True;
  wbCoSaveHeader.TreeHead := True;
//  wbSaveHeader.TreeLeaf := True;
//  wbCoSaveHeader.TreeLeaf := True;
end;

var
  ExtractInfoSave:   TByteSet = [3, 4]; // SaveFileChapters that should be initialized before dumping to get more information
  ExtractInfoCoSave: TByteSet = [];     // CoSaveFileChapters that should be initialized before dumping to get more information

procedure DefineFO3Saves;
begin
  wbFileMagic := 'FO3SAVEGAME';
  wbExtractInfo := @ExtractInfoSave;
  wbFilePlugins := 'Plugins';
  DefineFO3;
  DefineFO3SavesA;
  DefineFO3SavesS;
end;

procedure SwitchToFO3CoSave;
begin
  wbFileMagic := 'FOSE';
  wbExtractInfo := @ExtractInfoCoSave;
  wbFilePlugins := 'Absolute:44';
  wbFileChapters := wbCoSaveChapters;
  wbFileHeader := wbCoSaveHeader;
end;

initialization
end.

