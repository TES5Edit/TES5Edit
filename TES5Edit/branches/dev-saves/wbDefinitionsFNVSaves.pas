{*******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

*******************************************************************************}

unit wbDefinitionsFNVSaves;

interface

procedure DefineFNVSaves;

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
  wbDefinitionsFNV;

var
  wbActorValueLabels : array of string;

var // forward type directives
  wbChangeTypes : IwbEnumDef;

procedure DefineFNVSavesA;
var
  i: Integer;
begin
  SetLength(wbActorValueLabels, wbActorValueEnum.NameCount);
  for i := 0 to wbActorValueEnum.NameCount - 1 do
    wbActorValueLabels[i] := wbActorValueEnum.Names[i];
end;

{ FNVsaves }

function FindElement(aName: String; aElement: IwbElement): IwbElement;
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
  if (not Sametext(aName, Result.BaseName)) then begin // try again in reverse
    Result := aElement;
    if Supports(Result, IwbContainer, Container) then
      FindOurself(aName, Container, Result);
  end;
end;

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

function ScreenShotDataCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
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

function FileLocationTableCountCounter(aName: String; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
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

function GlobalDataCounter(aIndex: Integer; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := FileLocationTableCountCounter('Global Data Table '+IntToStr(aIndex), aBasePtr, aEndPtr, aElement);
end;

function GlobalData1Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := GlobalDataCounter(1, aBasePtr, aEndPtr, aElement);
end;

function GlobalData2Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := GlobalDataCounter(2, aBasePtr, aEndPtr, aElement);
end;

function GlobalData3Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := GlobalDataCounter(3, aBasePtr, aEndPtr, aElement) + 1;  // +1 due to the bug as seen on UESP
end;

function ChangedFormsCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := FileLocationTableCountCounter('Changed Forms', aBasePtr, aEndPtr, aElement);
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
    if {(Result < (1001-1000+9+15+1)) and} (Result > 2) then Result := 0; //Others are not decoded yet
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
  Element := FindElement('Unknown1000_0000', aElement);
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
  CompressedSize := PCardinal(Pointer(Cardinal(aBasePtr)+SizeOf(cardinal)))^ + 2*SizeOf(Cardinal);
  Result := CompressedSize;
end;

function ChangedFormHavokMovedSubBufferCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := FindElement('Havok Moved SubBuffer', aElement);

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
  aElement := FindElement('Changed Form', aElement);
  Assert(aElement.BaseName='Changed Form');

  if Supports(aElement, IwbDataContainer, Container) then begin
    with Container do if IsValidOffset(DataBasePtr, DataEndPtr, OffsetType) then begin // we are part a proper structure
      BasePtr := Pointer(Cardinal(DataBasePtr) + OffsetType);
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
  Element := FindElement('Changed Form', aElement);
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

function ChangedFormAnimationSubBufferCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := FindElement('Animation SubBuffer', aElement);

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
      aBasePtr := Pointer(Cardinal(BasePtr) + OffsetLength);
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
        aBasePtr := Pointer(Cardinal(aBasePtr) + Size);
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
  if (Pos(' ', Result)>0) and (Length(Result)>1) then
    Result := Copy(Result, Pos(' ', Result)+1, Length(Result));
  if (Pos(' ', Result)>0) and (Length(Result)>1) then
    Result := Copy(Result, 1, Pos(' ', Result)-1);
  if Length(Result)=0 then
    Result := IntToStr(aType);
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
    if (Result > 55) then
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
    if (Result > 55) then
      Result := 0;
  end else
    Result := 0;
end;

var
  SwappedChangedFormFlags : Boolean;
  TempChangedFormFlags   : Integer;

function ChangedFlagXXDecider(aMask: Cardinal; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if SwappedChangedFormFlags then begin
    if (TempChangedFormFlags and aMask)<>0 then
      Result := 1;
  end else begin
    if not Assigned(aElement) then Exit;
    Element := FindElement('Changed Form', aElement);
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
  Element := FindElement('Changed Form', aElement);
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
  aBasePtr := Pointer(Cardinal(aBasePtr) + ExteriorOffsetEnd);
  if PByte(aBasePtr)^ <> wbTerminator then Result := 1;
end;

function ChangedFormQuestStageHasLogDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := FindElement('Data', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Has Log Data'];
    if Assigned(Element) and (Element.NativeValue<>0) then begin
      Result := 1;
    end;
  end;
end;

function ChangedFormExtraNonMagicTargetSubCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := FindElement('Data', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Effect Item Length'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function ChangedFormPackageCreatedContentFlagsBit0Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := FindElement('Data', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Content Flags'];
    if Assigned(Element) then begin
      Result := Element.NativeValue and $1;
    end;
  end;
end;

function ChangedFormPackageCreatedFEHasLocationDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := FindElement('Follow/Escort', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Has Location'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function ChangedFormPackageCreatedAUEHasLocationDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := FindElement('Ambush/Use Item/Eat', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Has Location'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function ChangedFormPackageCreatedDHasLocationDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := FindElement('Dialogue', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Has Location'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function ChangedFormPackageCreatedUWHasLocationDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := FindElement('Use Weapon', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Has Location'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function ChangedFormPackageCreatedUWHasTargetDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := FindElement('Use Weapon', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Has Target'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function ChangedFormPackageLocationTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := FindElement('Location', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      case Element.NativeValue of
        0, 1, 2, 3, 4: Result := 1;
        5: Result := 2;
      end;
    end;
  end;
end;

function ChangedFormPackageTargetTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := FindElement('Target', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      case Element.NativeValue of
        0, 1: Result := 1;
        2: Result := 2;
      end;
    end;
  end;
end;

function ChangedFormPackageCreatedContentFlagsBit1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := FindElement('Data', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Content Flags'];
    if Assigned(Element) then begin
      Result := Element.NativeValue and $2;
    end;
  end;
end;

function ChangedFormPackageCreatedContentFlagsBit2Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := FindElement('Data', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Content Flags'];
    if Assigned(Element) then begin
      Result := Element.NativeValue and $4;
    end;
  end;
end;

function ChangedFormPackageCreatedPackageTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := FindElement('Data', aElement);

  if Assigned(Element) and Supports(Element, IwbDataContainer, Container) then
    Element := Container.ElementByPath['General\Type']
  else begin
    Element := FindElement('Current Package', aElement);

    if Assigned(Element) and Supports(Element, IwbDataContainer, Container) then
      Element := Container.ElementByPath['Type']
  end;
  if Assigned(Element) then begin
    case Element.NativeValue of
      0, 4, 5, 6, 7, 10, 11, 12, 14: Result := 0;
      1, 2: Result := 1;
      3, 8, 9: Result := 2;
      13: Result := 3;
      15: Result := 4;
      16: Result := 5;
    end;
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
  Element := FindElement('Data', aElement);
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
  Element := FindElement('Script Event List', aElement);
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
    Element := FindElement('Leveled Creature', aElement);
    if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
      Element := Container.GetElementByName('Actor Base Changed Flags');
      if Assigned(Element) and (Element.NativeValue<>0) then begin
        TempChangedFormFlags := Element.NativeValue;
        SwappedChangedFormFlags := True;
      end else
        Result := 0;
    end;
  end;
end;

function ChangeFormExtraPackageTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbContainer;
begin
  Result := 0;
  Element := nil;
//  if Pos('PROCESS', UpperCase(aElement.BaseName))=0 then
    Element := FindElement('Package Data', aElement);
  if not Assigned(Element) or (Element.BaseName <> 'Package Data') then begin
    Element := FindElement('Package Data', aElement);
    if not Assigned(Element) or (Element.BaseName <> 'Package Data') then
      Element := nil;
  end;

  if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
    Element := Container.GetElementByName('Package Type');
    if Assigned(Element) then begin
      case Element.NativeValue of
        0, 1, 3..11, 15: Result := 0;
         2 : Result := 1;
        12 : Result := 2;
        13 : Result := 3;
        14 : Result := 4;
        16 : Result := 5;
      end; //   0,5,5,5,5,5,5,5,5,5,1,2,3,5,4
    end;
  end;
end;

function ChangedFormActorBaseRestorer(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;
  SwappedChangedFormFlags := False;
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
  Element := FindElement('Extra', aElement);
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
  Element := FindElement('Changed MobileObject', aElement);
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
  Element := FindElement('Changed MobileObject', aElement);
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
  Element := FindElement('Changed MobileObject', aElement);
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
  Element := FindElement('Changed MobileObject', aElement);
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
  Element := FindElement('Changed MobileObject', aElement);
  if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
    Element := Container.GetElementByName('Process Level');
    if Assigned(Element) then
      if Element.NativeValue < 1 then
        Result := 1;
  end;
end;

function ChangeFormBaseProcessCreatedPackageDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbContainer;
begin
  Result := 0;
  Element := FindElement('Package Struct', aElement);
  if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
    Element := Container.GetElementByName('Package');
    if Assigned(Element) then begin
      if (Element.NativeValue shr 22) = 2 then
        Result := 1;
    end;
  end;
end;

function ChangeFormBaseProcessPackageDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbContainer;
begin
  Result := 0;
  Element := FindElement('Package Struct', aElement);
  if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
    Element := Container.GetElementByName('Package');
    if Assigned(Element) then begin
      if Element.NativeValue <> 0 then
        Result := 1;
    end;
  end;
end;

function ChangeFormBaseProcessCreatedPackageDecider2(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbContainer;
begin
  Result := 0;
  Element := FindElement('Package Struct 2', aElement);
  if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
    Element := Container.GetElementByName('Package');
    if Assigned(Element) then
      if (Element.NativeValue shr 22) = 2 then
        Result := 1;
  end;
end;

function ChangeFormCreatedPackageDecider2(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbContainer;
begin
  Result := 0;
  Element := FindElement('Created Package Struct', aElement);
  if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
    Element := Container.GetElementByName('Type');
    if Assigned(Element) then
      case 1+Element.NativeValue of
         0, 41: Result := 1;
        10: Result := 2;
        16, 29: Result := 3;
        18: Result := 4;
        19: Result := 5;
        22: Result := 6;
        23: Result := 7;
        24: Result := 8;
        25: Result := 9;
        40: Result := 10;
      end;  // 0,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah 0
            // 1,0Ah,0Ah,0Ah,0Ah,0Ah,2,0Ah,3,4; 10
            // 0Ah,0Ah,5,6,7,8,0Ah,0Ah,0Ah,2; 20
            // 0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah; 30
            // 9,0                  ; 40

  end;
end;

function ChangeFormBaseProcessPackageDecider2(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbContainer;
begin
  Result := 0;
  Element := FindElement('Package Struct 2', aElement);
  if Assigned(Element) and Supports(Element, IwbContainer, Container) then begin
    Element := Container.GetElementByName('Package');
    if Assigned(Element) then begin
      if Element.NativeValue <> 0 then
        Result := 1;
    end;
  end;
end;

function ChangedFormRemainingDataCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
  EasC      : IwbDataContainer;
  Origin    : Cardinal;
  Consumed  : Cardinal;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('CForm Data', aElement);
  Assert(Element.BaseName='CForm Data');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Length'];
    if Assigned(Element) and Supports(Element, IwbDataContainer, EasC) then begin
      Result := Element.NativeValue;
    end;
  end;

  if Result > 0 then begin
    Element := FindElement('Changed Form Data', aElement);
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

function SkipCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := wbBytesToSkip;
end;

function DumpCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  if wbBytesToDump = $FFFFFFFF then
    Result := ( Cardinal(aEndPtr) - Cardinal(aBasePtr) ) div wbBytesToGroup + 1
  else
    Result := wbBytesToDump div wbBytesToGroup + 1;
end;

function DataLengthCounter(aName: String; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aModifier: Integer = 0): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;

begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement(aName, aElement);
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

function DataLengthRemainderCounter(aName: String; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aModifier: Integer = 0): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
  EasC      : IwbDataContainer;
  Origin    : Cardinal;
  Consumed   : Cardinal;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement(aName, aElement);
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

function DataCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := DataLengthCounter('Global Data', aBasePtr, aEndPtr, aElement, 0);
end;

function DataQuartetCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := DataLengthRemainderCounter('Global Data', aBasePtr, aEndPtr, aElement, 1);
end;

function DataQuartetRemainderCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := DataLengthRemainderCounter('Global Data', aBasePtr, aEndPtr, aElement, 2);
end;


function CounterCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Quest Runtime Data', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Counter'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function DivByteBy4Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Factions', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Factions Length'];
    if Assigned(Element) then begin
      Result := Element.NativeValue div 4;
    end;
  end;
end;

function ToBeDeterminedDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;
end;

function ToBeDeterminedCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;
end;

function ToBeDeterminedCountCallback(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;
end;

procedure DefineFNVSavesS;  // This is all based on current UESP, and HexDump, Triria TESSaveLib and the Runtime
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
  wbChangeFlags042        : IwbIntegerDef;
  wbChangeFlags043        : IwbIntegerDef;
  wbChangeFlags044        : IwbIntegerDef;
  wbChangeFlags045        : IwbIntegerDef;
  wbChangeFlags046        : IwbIntegerDef;
  wbChangeFlags047        : IwbIntegerDef;
  wbChangeFlags048        : IwbIntegerDef;
  wbChangeFlags049        : IwbIntegerDef;
  wbChangeFlags050        : IwbIntegerDef;
  wbChangeFlags051        : IwbIntegerDef;
  wbChangeFlags052        : IwbIntegerDef;
  wbChangeFlags053        : IwbIntegerDef;
  wbChangeFlags054        : IwbIntegerDef;
  wbChangedActorBase      : IwbStructDef;
  wbChangedCREA           : IwbStructDef;
  wbChangedNPC            : IwbStructDef;
  wbChangedExtra          : IwbUnionDef;
  wbChangedREFR           : IwbStructDef;
  wbChangedMobileObject   : IwbStructDef;
  wbChangedActor          : IwbStructDef;
  wbChangedCharacter      : IwbStructDef;
  wbChangedCreature       : IwbStructDef;
  wbChangedExtraData      : IwbArrayDef;
  wbChangedInventory      : IwbArrayDef;
  wbChangeScriptEventList : IwbStructDef;
  wbPackageLocationData   : IwbStructDef;
  wbPackageTargetData     : IwbStructDef;
  wbCreatedPackageData    : IwbUnionDef;
  wbActorPackageData      : IwbUnionDef;
  wbPackageStruct         : IwbStructDef;
  wbPackageStruct2        : IwbStructDef;
  wbChangePackageStruct   : IwbStructDef;

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
// idetical to wbUnionCHANGE_REFR_INVENTORY  wbUnionCHANGE_REFR_LEVELED_INVENTORY : IwbUnionDef;
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
// no actual data    wbUnionCHANGE_NOTE_READ : IwbUnionDef;
  wbUnionCHANGE_ENCOUNTER_ZONE_FLAGS : IwbUnionDef;
  wbUnionCHANGE_ENCOUNTER_ZONE_GAME_DATA : IwbUnionDef;
  wbUnionCHANGE_CLASS_TAG_SKILLS : IwbUnionDef;
  wbUnionCHANGE_FACTION_FLAGS : IwbUnionDef;
  wbUnionCHANGE_FACTION_REACTIONS : IwbUnionDef;
  wbUnionCHANGE_FACTION_CRIME_COUNTS : IwbUnionDef;
// no actual data  wbUnionCHANGE_PACKAGE_WAITING : IwbUnionDef;
// no actual data  wbUnionCHANGE_PACKAGE_NEVER_RUN : IwbUnionDef;
  wbUnionCHANGE_LEVELED_LIST_ADDED_OBJECT : IwbUnionDef;
  wbUnionCHANGE_WATER_REMAPPED : IwbUnionDef;
  wbUnionCHANGE_FORM_LIST_ADDED_FORM : IwbUnionDef;

  wbUnionCHANGE_PACKAGE_CREATED : IwbUnionDef;

begin
  wbNull := wbByteArray('Unused', -255);

  wbGlobalData := wbStructC('Global Data', GlobalDataSizer, GlobalDataGetChapterType, GlobalDataGetChapterTypeName, [
    wbInteger('Type', itU32),
    wbInteger('DataLength', itU32),
    wbUnion('Data', GlobalDataDecider, [
      wbByteArray('Unknown', DataCounter),  // Single line
      // 0 to 11
      wbArrayT('Player Locations', wbIntegerT('Location', itU32), -1),
      wbStruct('TES', [
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
      wbStruct('Global Variables', [
        wbArrayT('TESActorBase', wbStruct('', [
          wbRefIDT('TESActorBase'),
          wbIntegerT('Unknown', itU16)
        ]), -254)
        // wbArrayT('xx', wbArrayT('samecount', wbRefID
      ]),
      wbArray('Process List', wbInteger('', itU8), -2),
      wbArray('Combat', wbInteger('', itU8), -2),
      wbArray('Interface', wbInteger('', itU8), -2),
      wbArray('Effects', wbInteger('', itU8), -2),
      wbStruct('Misc Stats Struct', [
        wbArray('Misc Stats', wbStruct('Misc Stat',[
          wbLenString('Misc Stat Name', 2),
          wbInteger('Category', itU8, wbEnum([
            '0 = General',
            '1 = Quest',
            '2 = Combat',
            '3 = Magic',
            '4 = Crafting',
            '5 = Crime',
            '6 = Perks?'
          ])),
          wbInteger('Value', itU32)
        ]), -1)
      ]),
      wbArray('Weather', wbInteger('', itU8), -2),
      wbArray('Actor Causes', wbInteger('', itU8), -2),
      wbArray('Radio', wbInteger('', itU8), -2),
      wbArray('Audio', wbInteger('', itU8), -2),
      // 1000 to 1000
      wbStruct('Temp Effect', [
        wbStruct('Unknown1000_00', [
          wbArray('Unknown1000_000', wbStruct('Unknown1000_0000', [
            wbInteger('Unknown1000_00000', itU8),
            wbUnion('Unknown1000_00001', Unknown1000_00001Decider, [
              wbRefID('REFR'),
              wbStruct('Unknown1000_000011', [
                wbRefID('CELL'),
                wbInteger('Unknown', itU32)
              ])
            ]),
            wbRefID('Texture Set'),
            wbRefID('Texture Set'),
            wbArray('Unknown1000_00002', wbInteger('Unknown', itU32), 3),
            wbArray('Unknown1000_00003', wbInteger('Unknown', itU32), 3),
            wbInteger('Unknown', itU32),
            wbInteger('Unknown', itU32),
            wbInteger('Unknown', itU32),
            wbArray('Unknown1000_00004', wbInteger('Unknown', itU32), 4), // Check for float
            wbInteger('Unknown', itU8),
            wbInteger('Unknown', itU8),
            wbInteger('Unknown', itU8),
            wbInteger('Unknown', itU8),
            wbInteger('Unknown', itU32),
            wbInteger('Unknown', itU8),
            wbInteger('Unknown', itU32),
            wbInteger('Unknown', itU32),
            wbInteger('Unknown', itU32),
            wbInteger('Unknown', itU32),
            wbInteger('Unknown', itU32),
            wbInteger('Unknown', itU8),
            wbInteger('Unknown', itU8),
            wbUnion('Unknown1000_00005', SaveFormVersionGreaterThan35Decider, [
              wbNull,
              wbInteger('Unknown', itU32)
            ])
          ]), -254)
        ]),
        wbInteger('Next ID', itU32),
        wbArray('Unknown1000_01', wbStruct('Unknown', [
          wbInteger('Unknown', itU32),
          wbStruct('Unknown', []) // Needs sample to continue
        ]), -254),
        wbArray('Unknown1000_02', wbStruct('Unknown', [
          wbInteger('Unknown', itU32),
          wbStruct('Unknown', []) // Needs sample to continue
        ]), -254),
        wbArray('Unknown1000_03', wbStruct('Unknown', [
          wbInteger('Unknown', itU32),
          wbStruct('Unknown', []) // Needs sample to continue
        ]), -254)
      ])
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
    '41 (04E : WATR)',
    '42 (067 : IMOD)',
    '43 (068 : REPU)',
    '44 (069 : PCBE)',
    '45 (06A : RCPE)',
    '46 (06B : RCCT)',
    '47 (06C : CHIP)',
    '48 (06D : CSNO)',
    '49 (06E : LSCT)',
    '50 (071 : CHAL)',
    '51 (072 : AMEF)',
    '52 (073 : CCRD)',
    '53 (074 : CMNY)',
    '54 (075 : CDCK)'
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

  // changeType: 042 = formType: 103 : IMOD
  wbChangeFlags042 := wbInteger('Change Flags', itU32 , wbFlags([
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

  // changeType: 043 = formType: 104 : REPU
  wbChangeFlags043 := wbInteger('Change Flags', itU32 , wbFlags([
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

  // changeType: 044 = formType: 105 : PCBE
  wbChangeFlags044 := wbInteger('Change Flags', itU32 , wbFlags([
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

  // changeType: 045 = formType: 106 : RCPE
  wbChangeFlags045 := wbInteger('Change Flags', itU32 , wbFlags([
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

  // changeType: 046 = formType: 107 : RCCT
  wbChangeFlags046 := wbInteger('Change Flags', itU32 , wbFlags([
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

  // changeType: 047 = formType: 108 : CHIP
  wbChangeFlags047 := wbInteger('Change Flags', itU32 , wbFlags([
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

  // changeType: 048 = formType: 109 : CSNO
  wbChangeFlags048 := wbInteger('Change Flags', itU32 , wbFlags([
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

  // changeType: 049 = formType: 110 : LSCT
  wbChangeFlags049 := wbInteger('Change Flags', itU32 , wbFlags([
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

  // changeType: 050 = formType: 113 : CHAL
  wbChangeFlags050 := wbInteger('Change Flags', itU32 , wbFlags([
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

  // changeType: 051 = formType: 114 : AMEF
  wbChangeFlags051 := wbInteger('Change Flags', itU32 , wbFlags([
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

  // changeType: 052 = formType: 115 : CCRD
  wbChangeFlags052 := wbInteger('Change Flags', itU32 , wbFlags([
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

  // changeType: 053 = formType: 116 : CMNY
  wbChangeFlags053 := wbInteger('Change Flags', itU32 , wbFlags([
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

  // changeType: 054 = formType: 117 : CDCK
  wbChangeFlags054 := wbInteger('Change Flags', itU32 , wbFlags([
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
    wbChangeFlags041,
    wbChangeFlags042,
    wbChangeFlags043,
    wbChangeFlags044,
    wbChangeFlags045,
    wbChangeFlags046,
    wbChangeFlags047,
    wbChangeFlags048,
    wbChangeFlags049,
    wbChangeFlags050,
    wbChangeFlags051,
    wbChangeFlags052,
    wbChangeFlags053,
    wbChangeFlags054
  ]);

  wbChangeScriptEventList := wbStruct('Script Event List', [
    wbArrayT('Vars', wbStruct('Data', [
      wbIntegerT('FlagAndVarID', itU32),
      wbUnion('Var', ChangedFormExtraScriptEventDecider, [
        wbRefIDT('RefID'),
        wbDoubleT('Value')
      ])
    ]), -254),
    wbIntegerT('has Struct010', itU8),
    wbUnion('Unknown', ChangedFormEventListHasStruct010Decider, [ wbNull, wbByteArray('Struct010', 8+1)]),
    wbIntegerT('Set kEvent_OnLoad', itU8)  // only if form version is 0x15 or greater
  ]);

  wbUnionCHANGE_FORM_FLAGS := wbUnion('Flags', ChangedFlag00Decider, [wbNull, wbIntegerT('Flags', itu32, wbRecordFlagsFlags)]);

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

  wbUnionCHANGE_ACTOR_LIFESTATE := wbUnion('Life State', ChangedFlag10Decider, [wbNull, wbNull]);
// included in Extra...      wbUnionCHANGE_ACTOR_EXTRA_PACKAGE_DATA := wbUnion('Package Data Extra', ChangedFlag11Decider, [wbNull, wbNull]);        // CHANGE_REFR_EXTRAS
// included in Extra...      wbUnionCHANGE_ACTOR_EXTRA_MERCHANT_CONTAINER := wbUnion('Merchant Container', ChangedFlag12Decider, [wbNull, wbNull]);  // CHANGE_REFR_EXTRAS
// included in Extra...      wbUnionCHANGE_ACTOR_EXTRA_DISMEMBERED_LIMBS := wbUnion('Dismembered Limbs', ChangedFlag17Decider, [wbNull, wbNull]);    // CHANGE_REFR_EXTRAS
// included in Extra...      wbUnionCHANGE_ACTOR_LEVELED_ACTOR := wbUnion('Leveled Actor', ChangedFlag18Decider, [wbNull, wbNull]);                  // CHANGE_REFR_EXTRAS
  wbUnionCHANGE_ACTOR_DISPOSITION_MODIFIERS := wbUnion('Disp Modifiers', ChangedFlag19Decider, [wbNull, wbNull]);

  wbUnionCHANGE_ACTOR_TEMP_MODIFIERS := wbUnion('Temp Modifiers', ChangedFlag20Decider, [wbNull,
    wbArrayT('Temp Modifier List', wbStruct('Temp Modifier', [
      wbIntegerT('Actor Value', itU8),
      wbFloatT('Modifier')
    ]), -254)
  ]);

  wbUnionCHANGE_ACTOR_DAMAGE_MODIFIERS := wbUnion('Damage Modifiers', ChangedFlag21Decider, [wbNull,
    wbArrayT('Damage Modifier List', wbStruct('Damage Modifier', [
      wbIntegerT('Actor Value', itU8),
      wbFloatT('Modifier')
    ]), -254)
  ]);

  wbUnionCHANGE_ACTOR_OVERRIDE_MODIFIERS := wbUnion('Override Modifiers', ChangedFlag22Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_PERMANENT_MODIFIERS := wbUnion('Permanent Modifiers', ChangedFlag23Decider, [wbNull, wbNull]);

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
        wbArrayT('Unknown', wbStruct('Data', [
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
    wbArrayT('Change Objectives', wbStruct('Objective', [
      wbIntegerT('Objective ID', itU32),
      wbIntegerT('Objective Data', itU32)
    ]), -254)
  ]);

  wbUnionCHANGE_QUEST_SCRIPT := wbUnion('Quest Script', ChangedFlag30Decider, [wbNull, wbChangeScriptEventList]);

  wbUnionCHANGE_QUEST_STAGES := wbUnion('Quest Stages', ChangedFlag31Decider, [wbNull,
    wbArrayT('Change Stages', wbStruct('Data', [
      wbIntegerT('StageID', itU8),
      wbIntegerT('Status?', itU8),
      wbArrayT('Log Entries', wbStruct('Data', [
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
    {00} wbInteger('Aggression', itU8, wbAgressionEnum),
    {01} wbInteger('Confidence', itU8, wbConfidenceEnum),
    {02} wbInteger('Energy Level', itU8),
    {03} wbInteger('Responsibility', itU8),
    {04} wbInteger('Mood', itU8, wbMoodEnum),
         wbByteArray('Unused', 3),
    {08} wbInteger('Buys/Sells and Services', itU32, wbServiceFlags),
    {0C} wbInteger('Teaches', itS8, wbSkillEnum),
    {0D} wbInteger('Maximum training level', itU8),
    {0E} wbInteger('Assistance', itS8, wbAssistanceEnum),
    {0F} wbInteger('Aggro Radius Behavior', itU8, wbAggroRadiusFlags),
         wbIntegerT('Aggro Radius', itS32)
  ])]);

  wbUnionCHANGE_ACTOR_BASE_SPELLLIST := wbUnion('Spell List', ChangedFlag04Decider, [wbNull, wbStruct('Data', [
      wbArrayT('Spell List', wbRefIDT('Spell'), -254),
      wbArrayT('Leveled Spell List', wbRefIDT('Leveled Spell'), -254)
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
//      wbArray('First Array',
//        {wbArray('Second Array',} wbStruct('Flattened arrays', [
//          wbArray('Third Array 1', wbIntegerT('Unknown', itU32), 50),
//          wbArray('Third Array 2', wbIntegerT('Unknown', itU32), 30)
//        ]), {2),}
//      2),
      wbByteArray('FaceGenData', 650),
      wbRefIDT('Hair'),
      wbRefIDT('Eyes'),
      wbFloatT('Hair Length'),
      wbIntegerT('Hair Color', itU32),
      wbArrayT('HeadParts', wbRefIDT('HeadPart'), -254)
    ])
  ]);

  wbUnionCHANGE_NPC_GENDER := wbUnion('Gender', ChangedFlag24Decider, [wbNull, wbIntegerT('Gender', itU8, wbSexEnum)]);

  wbUnionCHANGE_NPC_RACE := wbUnion('Race', ChangedFlag25Decider, [wbNull, wbRefIDT('Race')]);

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

  wbUnionCHANGE_ENCOUNTER_ZONE_GAME_DATA := wbUnion('Game Data', ChangedFlag31Decider, [wbNull, wbByteArray('Change Game Data', 10+1)]);
    // Prior to form version 8, only 8+1

  wbUnionCHANGE_CLASS_TAG_SKILLS := wbUnion('Tag Skills', ChangedFlag01Decider, [wbNull,
    wbArray('Skills', wbIntegerT('Skill', itS32), 4)
  ]);

  wbUnionCHANGE_FACTION_FLAGS := wbUnion('Faction Flags', ChangedFlag01Decider, [wbNull, wbIntegerT('Flags', itU32)]);

  wbUnionCHANGE_FACTION_REACTIONS := wbUnion('Faction Reactions', ChangedFlag02Decider, [wbNull,
    wbArrayT('Reactions', wbStruct('Reaction', [
      wbRefIDT('Faction'),
      wbIntegerT('Modifier', itS32),
      wbIntegerT('Reaction', itU32)
    ]), -254)
  ]);

  wbUnionCHANGE_FACTION_CRIME_COUNTS := wbUnion('Faction Crime Counts', ChangedFlag31Decider, [wbNull, wbStruct('Crime Counts', [
    wbIntegerT('Unk044', itU32),
    wbIntegerT('Unk048', itU32)
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

  wbCreatedPackageData := wbUnion('Specific Data', ChangedFormPackageCreatedPackageTypeDecider, [
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
        wbInteger('Type', itU8),
        wbByteArray('Unused', 1),
        wbInteger('Fallout Behavior Flags', itU16),
        wbIntegerT('Specific Type Flags', itU32)
      ]),
      wbIntegerT('Content Flags', itU8),
      wbUnion('Location Data', ChangedFormPackageCreatedContentFlagsBit0Decider, [wbNull, wbPackageLocationData]),
      wbUnion('Target Data', ChangedFormPackageCreatedContentFlagsBit1Decider, [wbNull, wbPackageTargetData]),
      wbUnion('Created Package Data', ChangedFormPackageCreatedContentFlagsBit2Decider, [wbNull, wbCreatedPackageData])
    ]);

  wbUnionCHANGE_PACKAGE_CREATED := wbUnion('Created Package', ChangedFlag11OrCreatedDecider, [wbNull, wbChangePackageStruct]);

  wbUnionCHANGE_FORM_LIST_ADDED_FORM := wbUnion('Added Form', ChangedFlag31Decider, [wbNull, wbArrayT('Forms', wbRefIDT('RefID'), -1)]);

  wbUnionCHANGE_LEVELED_LIST_ADDED_OBJECT := wbUnion('Added Object', ChangedFlag31Decider, [wbNull,
    wbStruct('Objects List', [
      wbArrayT('Objects', wbStruct('Object', [
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

  wbActorPackageData := wbUnion('Package Specific Data', ChangeFormExtraPackageTypeDecider, [    // 031
    wbNull,
    wbStruct('Escort Actor Package Data', [
      wbRefIDT('Package'),
      wbArrayT('Unknown', wbRefID('Unknown'), -254)
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
      wbByteArray('Unk05C', 6), wbString('Unused', 1),
      wbRefIDT('Unk010'),
      wbRefIDT('Unk03C'),
      wbRefIDT('Unk044'),
      wbArrayT('Unknown', wbStruct('Unknown', [
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
      wbArrayT('Patrol Points', wbRefIDT('Patrol Point'), -254)
    ]),
    wbStruct('Guard Actor Package Data', [
      wbIntegerT('Unknown', itU32),
      wbIntegerT('Unknown', itU32),
      wbIntegerT('Unknown', itU32),
      wbRefIDT('Unknown')
    ]),
    wbNull  // UseWeaponActorPackageData nothing loaded ???
  ]);

  wbChangedExtraData := wbArrayT('Extras', wbStruct('Extra', [
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
     wbArrayT('RunOncePacks', wbStruct('RunOncePack', [         // 005
       wbRefIDT('Package'),
       wbIntegerT('Unk004', itU8)
     ]), -254),
     wbRefIDT('Reference Pointer'),                             // 006
     wbArrayT('Follower Array', wbRefIDT('Follower'), -254),    // 007
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
       wbUnion('Changed Actor Base', ChangedFormActorBaseDecider, [wbNull, wbChangedNPC, wbChangedCREA]),
       wbUnion('Hidden : Hack to restore change flags', ChangedFormActorBaseRestorer, [wbNull])
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
      wbArrayT('Magic Item List', wbStruct('Data', [
        wbRefIDT('Magic Form'),
        wbIntegerT('Effect Index', itU8),
        wbIntegerT('Unk098', itU6to30),
        wbIntegerT('Effect Item Length', itU6to30),
        wbByteArray('Effect Item Data', ChangedFormExtraNonMagicTargetSubCounter)
      ]), -254)
    ]),
    wbArrayT('Player Crimes', wbStruct('Data', [                // 01A
      wbIntegerT('Unknown', itU32),
      wbIntegerT('Unknown', itU32)
    ]), -254),
    wbRefIDT('Item Dropper'),                                   // 01B
    wbRefIDT('Merchant Container'),                             // 01C
    wbNull, // ExtraCannotWear no data                          // 01D
    wbRefIDT('Poison'),                                         // 01E
    wbArrayT('Friendly Hits', wbFloatT('Time'), -254),          // 01F
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
    wbArrayT('Faction Changes', wbStruct('Data', [                // 02C
      wbRefIDT('Faction'),
      wbIntegerT('Rank', itS8)
    ]), -254),
    wbStruct('Dismembered Limbs', [                               // 02D
      wbIntegerT('Unk00C', itU16),
      wbIntegerT('Unk010', itU32),
      wbIntegerT('Unk018', itU32),
      wbIntegerT('Unk01C', itU8),
      wbRefIDT('Unk014'),
      wbArrayT('Unk020', wbStruct('Data', [
        wbIntegerT('Unk000', itU8),
        wbIntegerT('Unk001', itU8),
        wbIntegerT('Unk002', itU8),
        wbIntegerT('Unk003', itU8), // Field "added" since form version 0x10
        wbArrayT('Unk004', wbRefIDT('Data'), -254)
      ]), -254)
    ]),
    wbIntegerT('Actor Cause', itU32),                             // 02E
    wbRefIDT('Open/Close Activate Ref'),                          // 02F
    wbStruct('Ammo', [                                            // 030
      wbRefIDT('Ammo'),
      wbIntegerT('Count?', itS32)
    ]),
    wbStruct('Package Data', [
      wbIntegerT('Package Type', itU8, wbPKDTType),
      wbActorPackageData
    ]),
    wbArrayT('Say TopicInfo once a day', wbStruct('Data', [       // 032
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
    wbArrayT('Guarded Ref Data', wbRefIDT('Guarded Ref Data'), -254),   // 035
    wbRefIDT('AshPile Ref'),                                      // 036
    wbStruct('Follower SwimBreadcrumbs', [                        // 037
      wbByteArray('Unk010', $0C), wbString('Unused', 1),
      wbRefIDT('Unk01C'),   // Present only for form version 0x12 and later
      // wbIntegerT('Unk01C', itU32), // Present only for form version lower than 0x12
      wbIntegerT('Unk00C', itU32),
      wbArrayT('Unk020', wbStruct('Data', [
        wbByteArray('Unk000', $0C), wbString('Unused', 1),
        wbRefIDT('Unk00C'),   // Present only for form version 0x12 and later
        // wbIntegerT('Unk00C', itU32), // Present only for form version lower than 0x12
        wbByteArray('Unk010', $0C), wbString('Unused', 1),
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

  wbChangedInventory := wbArrayT('Entry Datas', wbStruct('Entry Data', [
    wbRefIDT('Type'),
    wbIntegerT('Delta', itS32),
    wbArrayT('Extend Datas', wbStruct('Extra Data List', [wbChangedExtraData]), -254)
  ]), -254);

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

  wbPackageStruct := wbStruct('Package Struct', [
    wbRefIDT('Package'),
    wbUnion('Package Info', ChangeFormBaseProcessPackageDecider, [wbNull,
      wbStruct('Package Data', [
        wbUnion('Created Package', ChangeFormBaseProcessCreatedPackageDecider, [ wbNull, wbIntegerT('Type', itU8)]),
        wbIntegerT('Package Type', itU8),
        wbActorPackageData,
        wbIntegerT('Unk00C', itU32),
        wbFloatT('Unk010'),
        wbIntegerT('Flags', itU32),
        wbRefIDT('TargetRef')
      ])
    ])
  ]);

  wbPackageStruct2 := wbStruct('Package Struct 2', [ // Duplicating this avoids a false negative size detection.
    wbRefIDT('Package'),
    wbUnion('Package Info', ChangeFormBaseProcessPackageDecider2, [wbNull,
      wbStruct('Package Data', [
        wbUnion('Created Package', ChangeFormBaseProcessCreatedPackageDecider2, [ wbNull,
          wbStruct('Created Package Struct', [
            wbIntegerT('Type', itS8)
//            wbUnion('Created Package', ChangeFormCreatedPackageDecider2, [
//              wbNull
//            ])
          ])
        ])
//        wbIntegerT('Package Type', itU8),
//        wbActorPackageData,
//        wbIntegerT('Unk00C', itU32),
//        wbFloatT('Unk010'),
//        wbIntegerT('Flags', itU32),
//        wbRefIDT('TargetRef')
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
//            // wbIntegerT('Unused', itU32), Older than form version 6
//            // wbIntegerT('Unused', itU32), Older than form version 6
//            wbIntegerT('Byt030', itU8),
//            wbIntegerT('Unk0A4', itU32),
//            wbRefIDT('Bound Object'),     // 034
//            wbIntegerT('Unk058', itU32),
//            wbIntegerT('Unk0A8', itU32),
//            wbIntegerT('Unk0AC', itU32),
//            wbIntegerT('Byt0B0', itU8),
//            wbIntegerT('Wrd050', itU16),
//            wbFloatT('Unk038.Flt000'),
//            wbFloatT('Unk038.Flt004'),
//            wbRefIDT('Unk040'),
//            wbRefIDT('Unk044'),
//            wbRefIDT('Unk048'),
//            wbRefIDT('Form List'),        // 04C
//            wbRefIDT('Unk054'),
//            wbArrayT('List006C', wbRefIDT('Unknown'), -254),
//            wbUnionCHANGE_ACTOR_DAMAGE_MODIFIERS
          ])
        ]),
        wbUnion('Middle Low Process', ChangedFormMobileObjectMiddleLowProcessDecider, [wbNull,
          wbStruct('Data', [
//            wbIntegerT('Unk0B4', itU32),
//            wbUnionCHANGE_ACTOR_TEMP_MODIFIERS
          ])
        ]),
        wbUnion('Middle High Process', ChangedFormMobileObjectMiddleHighProcessDecider, [wbNull,
          wbStruct('Data', [
//            wbIntegerT('Unk134', itU8),
//            wbIntegerT('Unk135', itU8),
//            wbIntegerT('Unk168', itU8),
//            wbIntegerT('Unk170', itU32),
//            wbIntegerT('Unk174', itU32),
//            wbIntegerT('Unk108', itU32),
//            wbIntegerT('Unk1DA', itU8),
//            wbByteArray('Unk0FC', 12+1),
//            wbIntegerT('Unk0DC', itU32),
//            wbIntegerT('Byt13D', itU8),
//            wbIntegerT('Byt144', itU8),
//            wbIntegerT('Byt156', itU8),
//            wbIntegerT('Wrd154', itU16),
//            wbByteArray('Unk148', 12+1),
//            wbIntegerT('Bool', itU8),     // if actor and Byt13D then call actor.func0108
//            wbIntegerT('Byt0E0', itU8),
//            wbIntegerT('Byt188', itU8),
//            wbIntegerT('Byt189', itU8),
//            wbIntegerT('Unk0D8', itU32),
//            wbIntegerT('Byt18B', itU8),
//            wbIntegerT('Unk1D0', itU32),
//            wbIntegerT('Unk1D4', itU32),
//            wbIntegerT('Byt1D8', itU8),
//            wbIntegerT('Byt1D9', itU8),
//            wbIntegerT('Byt228', itU8),
//            wbIntegerT('Wrd22A', itU16),
//            wbIntegerT('Unk1A8', itU32),
//            wbIntegerT('Byt0E1', itU8),
//            wbIntegerT('Unk190', itU32),
//            wbIntegerT('Unk198', itU32),
//            wbIntegerT('Byt19C', itU8),
//            wbIntegerT('Byt19D', itU8),
//            wbIntegerT('Unk234', itU32),
//            wbIntegerT('Unk238', itU32),
//            wbIntegerT('Unk23C', itU32),    // if form version 0xA or later
//            wbIntegerT('Unk244', itU32),    // if form version 0x3 or later
//            wbIntegerT('Unk110', itU8),     // if form version 0x7 or later
//            wbRefIDT('IdleForm10C'),
//            wbRefIDT('IdleForm194'),
//            wbRefIDT('Unk158'),
//            wbRefIDT('Unk140'),
//            wbIntegerT('Unknown', itU32),
//            wbArrayT('List0C8', wbRefIDT('Unknown'), -254),
//            wbPackageStruct2
          ])
        ]),
        wbUnion('High Process', ChangedFormMobileObjectHighProcessDecider, [wbNull,
          wbStruct('Data', [
          ])
        ])
      ])
    ])
  ]);

  wbChangedActor := wbStruct('Changed Actor', [
     wbChangedMobileObject
    ,wbUnionCHANGE_ACTOR_LIFESTATE
    ,wbUnionCHANGE_ACTOR_DISPOSITION_MODIFIERS
//    ,wbUnionCHANGE_ACTOR_TEMP_MODIFIERS
//    ,wbUnionCHANGE_ACTOR_DAMAGE_MODIFIERS
    ,wbUnionCHANGE_ACTOR_OVERRIDE_MODIFIERS
    ,wbUnionCHANGE_ACTOR_PERMANENT_MODIFIERS
  ]);

  wbChangedCharacter := wbStruct('Changed Character', [
    wbChangedActor
  ]);
  wbChangedCreature := wbStruct('Changed Character', [
    wbChangedActor
  ]);

  wbChangedFormData := wbStruct('Changed Form Data', [
    wbInitialDataType,
    wbUnion('CForm Union', ChangedFormDataDecider, [
       wbNull
      ,wbChangedREFR  {03A}
      ,wbStruct('Change ACHR Data', [ {03B}
         wbUnion('Player specific', IsActorPlayerDecider, [wbNull, wbStruct('Player data', [
           wbArray('ActorValues244', wbFloatT('Actor Value'), wbActorValueLabels),
           wbArray('ActorValues378', wbFloatT('Actor Value'), wbActorValueLabels),
           wbArray('ActorValues4B0', wbFloatT('Actor Value'), wbActorValueLabels),
           wbIntegerT('Unk4AC', itU32)
         ])])
        ,wbChangedCharacter
        ,wbUnion('Player specific', IsActorPlayerDecider, [wbNull, wbStruct('Player data', [
         ])])
       ])
      ,wbStruct('Change ACRE Data', [ {03C}
         wbChangedCreature
       ])
      ,wbStruct('Change PMIS Data', [ {03D}
//         wbChangedREFR
       ])
      ,wbStruct('Change PGRE Data', [ {03E}
//         wbChangedREFR
       ])
      ,wbStruct('Change PBEA Data', [ {03F}
//         wbChangedREFR
       ])
      ,wbStruct('Change PFLA Data', [ {040}
//         wbChangedREFR
       ])
      ,wbStruct('Change CELL Data', [ {039}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_CELL_FLAGS
        ,wbUnionCHANGE_CELL_SEENDATA
        ,wbUnionCHANGE_CELL_FULLNAME
        ,wbUnionCHANGE_CELL_OWNERSHIP
       ])
      ,wbStruct('Change INFO Data', [ {046}
         wbUnionCHANGE_FORM_FLAGS
// no actual data        wbUnionCHANGE_TOPIC_SAIDONCE
       ])
      ,wbStruct('Change QUST Data', [ {047}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_QUEST_FLAGS
        ,wbUnionCHANGE_QUEST_SCRIPT_DELAY
        ,wbUnionCHANGE_QUEST_STAGES
        ,wbUnionCHANGE_QUEST_SCRIPT
        ,wbUnionCHANGE_QUEST_OBJECTIVES
       ])
      ,wbChangedNPC                   {02A}
      ,wbChangedCREA                  {02B}
      ,wbStruct('Change ACTI Data', [ {015}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change TACT Data', [ {016}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
        ,wbUnionCHANGE_TALKING_ACTIVATOR_SPEAKER
       ])
      ,wbStruct('Change TERM Data', [ {017}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change ARMO Data', [ {018}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change BOOK Data', [ {019}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
        ,wbUnionCHANGE_BOOK_TEACHES_SKILL
       ])
      ,wbStruct('Change CLOT Data', [ {01A}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change CONT Data', [ {01B}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change DOOR Data', [ {01C}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change INGR Data', [ {01D}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change LIGH Data', [ {01E}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change MISC Data', [ {01F}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change STAT Data', [ {020}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change MSTT Data', [ {022}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change FURN Data', [ {027}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
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
// no actual data        wbUnionCHANGE_PACKAGE_NEVER_RUN,
// no actual data        wbUnionCHANGE_PACKAGE_WAITING
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
      ,wbStruct('Change IMOD Data', [ {067}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change REPU Data', [ {068}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change PCBE Data', [ {069}
//         wbChangedREFR
       ])
      ,wbStruct('Change RCPE Data', [ {06A}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change RCCT Data', [ {06B}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change CHIP Data', [ {06C}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change CSNO Data', [ {06D}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change LSCT Data', [ {06E}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change CHAL Data', [ {071}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change AMEF Data', [ {072}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change CCRD Data', [ {073}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change CMNY Data', [ {074}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change CDCK Data', [ {075}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
    ]),
    wbByteArray('Undecoded Data', ChangedFormRemainingDataCounter)
  ]);

  wbChangedForm := wbStructC('Changed Form',
    ChangedFormSizer,
    ChangedFormGetChapterType,
    ChangedFormGetChapterTypeName,
    [
      wbRefID('RefID'),
      wbChangeFlags,
      wbInteger('Type', itU8, wbChangeTypes),
      wbInteger('Version', itU8),
      wbUnion('Datas', ChangedFormDataLengthDecider, [
        wbStruct('CForm Data', [
          wbInteger('Length', itU8),
          wbStructZ('Small Struct', ChangedFormDataSizer, ChangedFormGetChapterType, ChangedFormGetChapterTypeName,
            [ wbChangedFormData ])
        ]),
        wbStruct('CForm Data', [
          wbInteger('Length', itU16),
          wbStructZ('Medium Struct', ChangedFormDataSizer, ChangedFormGetChapterType, ChangedFormGetChapterTypeName,
            [ wbChangedFormData ])
        ]),
        wbStruct('CForm Data', [
          wbInteger('Length', itU32),
          wbStructZ('Large Struct', ChangedFormDataSizer, ChangedFormGetChapterType, ChangedFormGetChapterTypeName,
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

  wbFileHeader := wbStruct('Save File Header', [
     wbString('Magic', 11)
    ,wbInteger('Header Size', itU32)
    ,wbHeader
    ,wbByteArray('Hidden: Screenshot Data', ScreenShotDataCounter)
    ,wbInteger('Form Version', itU8)
    ,wbInteger('PluginInfo Size', itU32)
    ,wbArrayT(wbFilePlugins, wbLenStringT('PluginName', -3), -4)
    ,wbFileLocationTable
  ]);

  wbFileChapters := wbStruct('Save File Chapters', [
     wbArray('Global Data 1', wbGlobalData, [], GlobalData1Counter)
    ,wbArray('Changed Forms', wbChangedForm, [], ChangedFormsCounter)
    ,wbArray('Global Data 2', wbGlobalData, [], GlobalData2Counter)
    ,wbArray('FormIDs', wbFormID('FormID', cpFormID), -1, RefIDTableAfterLoad)
    ,wbArray('Visited Worldspace', wbFormID('FormID', cpFormID), -1, WorldspaceTableAfterLoad)
    ,wbArray('Unknown Table', wbInteger('Unknown', itU8), -1)
//    ,wbByteArray('Unused', SkipCounter) // Lets you skip an arbitrary number of byte, Setable from CommandLine -bts:n
//    ,wbArray('Remaining',  WbByteArray('Unknown', wbBytesToGroup), DumpCounter) // Lets you dump an arbitrary number of quartet, Setable from CommandLine -btd:n
  ]);
end;

var
  ExtractInfo: TByteSet = [3, 4]; // SaveFileChapters that should be initialized before dumping to get more information

procedure DefineFNVSaves;
begin
  wbFileMagic := 'FO3SAVEGAME';
  wbExtractInfo := @ExtractInfo;
  wbFilePlugins := 'Plugins';
  DefineFNV;
  DefineFNVSavesA;
  DefineFNVSavesS;
end;

initialization
end.

