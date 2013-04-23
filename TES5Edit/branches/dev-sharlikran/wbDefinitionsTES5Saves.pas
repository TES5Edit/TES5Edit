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

unit wbDefinitionsTES5Saves;

interface

procedure DefineTES5Saves;

implementation

uses
  Types,
  Classes,
  SysUtils,
  Math,
  Variants,
  wbInterface,
  wbImplementation,
  wbLocalization,
  wbDefinitionsTES5;

var
  wbSexEnum         : IwbEnumDef;
  wbPropTypeEnum    : IwbEnumDef;
  wbRecordFlagsEnum : IwbFlagsDef;

procedure DefineTES5SavesA;
begin
  wbPropTypeEnum := wbEnum([
    {00} '',
    {01} 'Object',
    {02} 'String',
    {03} 'Int32',
    {04} 'Float',
    {05} 'Bool',
    {06} '',
    {07} '',
    {08} '',
    {09} '',
    {10} '',
    {11} 'Array of Object',
    {12} 'Array of String',
    {13} 'Array of Int32',
    {14} 'Array of Float',
    {15} 'Array of Bool'
  ]);

  wbSexEnum := wbEnum(['Male','Female']);

  wbRecordFlagsEnum := wbFlags([
    {>>> 0x00000000 ACTI: Collision Geometry (default) <<<}
    {0x00000001}'ESM',
    {0x00000002}'Unknown 2',
    {>>> 0x00000004 ARMO: Not playable <<<}
    {0x00000004}'NotPlayable',
    {0x00000008}'Unknown 4',
    {0x00000010}'Unknown 5',
    {0x00000020}'Deleted',
    {>>> 0x00000040 ACTI: Has Tree LOD <<<}
    {>>> 0x00000040 REGN: Border Region <<<}
    {>>> 0x00000040 STAT: Has Tree LOD <<<}
    {>>> 0x00000040 REFR: Hidden From Local Map <<<}
    {0x00000040}'Constant HiddenFromLocalMap BorderRegion HasTreeLOD',
    {>>> 0x00000080 TES4: Localized <<<}
    {>>> 0x00000080 PHZD: Turn Off Fire <<<}
    {>>> 0x00000080 SHOU: Treat Spells as Powers <<<}
    {>>> 0x00000080 STAT: Add-on LOD Object <<<}
    {0x00000080}'Localized IsPerch AddOnLODObject TurnOffFire TreatSpellsAsPowers',
    {>>> 0x00000100 ACTI: Must Update Anims <<<}
    {>>> 0x00000100 REFR: Inaccessible <<<}
    {>>> 0x00000100 REFR for LIGH: Doesn't light water <<<}
    {0x00000100}'MustUpdateAnims Inaccessible DoesntLightWater',
    {>>> 0x00000200 ACTI: Local Map - Turns Flag Off, therefore it is Hidden <<<}
    {>>> 0x00000200 REFR: MotionBlurCastsShadows <<<}
    {0x00000200}'HiddenFromLocalMap StartsDead MotionBlurCastsShadows',
    {>>> 0x00000400 LSCR: Displays in Main Menu <<<}
    {0x00000400}'PersistentReference QuestItem DisplaysInMainMenu',
    {0x00000800}'InitiallyDisabled',
    {0x00001000}'Ignored',
    {0x00002000}'Unknown 14',
    {0x00004000}'Unknown 15',
    {>>> 0x00008000 STAT: Has Distant LOD <<<}
    {0x00008000}'VWD',
    {>>> 0x00010000 ACTI: Random Animation Start <<<}
    {>>> 0x00010000 REFR light: Never fades <<<}
    {0x00010000}'RandomAnimationStart NeverFades',
    {>>> 0x00020000 ACTI: Dangerous <<<}
    {>>> 0x00020000 REFR light: Doesn't light landscape <<<}
    {>>> 0x00020000 SLGM: Can hold NPC's soul <<<}
    {>>> 0x00020000 STAT: Use High-Detail LOD Texture <<<}
    {0x00020000}'Dangerous OffLimits DoesntLightLandscape HighDetailLOD CanHoldNPC',
    {0x00040000}'Compressed',
    {>>> 0x00080000 STAT: Has Currents <<<}
    {0x00080000}'CantWait HasCurrents',
    {>>> 0x00100000 ACTI: Ignore Object Interaction <<<}
    {0x00100000}'IgnoreObjectInteraction',
    {0x00200000}'Used by In Memory Changed Form',
    {0x00400000}'Unknown 23',
    {>>> 0x00800000 ACTI: Is Marker <<<}
    {0x00800000}'IsMarker',
    {0x01000000}'Unknown 25',
    {>>> 0x02000000 ACTI: Obstacle <<<}
    {>>> 0x02000000 REFR: No AI Acquire <<<}
    {0x02000000}'Obstacle NoAIAcquire',
    {>>> 0x04000000 ACTI: Filter <<<}
    {0x04000000}'NavMeshFilter',
    {>>> 0x08000000 ACTI: Bounding Box <<<}
    {0x08000000}'NavMeshBoundingBox',
    {>>> 0x10000000 STAT: Show in World Map <<<}
    {0x10000000}'MustExitToTalk ShowInWorldMap',
    {>>> 0x20000000 ACTI: Child Can Use <<<}
    {>>> 0x20000000 REFR: Don't Havok Settle <<<}
    {0x20000000}'ChildCanUse DontHavokSettle',
    {>>> 0x40000000 ACTI: GROUND <<<}
    {>>> 0x40000000 REFR: NoRespawn <<<}
    {0x40000000}'NavMeshGround NoRespawn',
    {>>> 0x80000000 REFR: MultiBound <<<}
    {0x80000000}'MultiBound'
  ]);

end;

{ TES5saves }

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
      if (aType >= 0) and (aType <= 8) then // 0 to 8 = 9
        Result := aType + 1
      else if (aType >= 100) and (aType <= 114) then  // 100 to 114 = 15
        Result := aType - 100 + 9 + 1
      else  if (aType >= 1000) and (aType <= 1005) then // 1000 to 1005 = 6
        Result := aType - 1000 + 9 + 15 + 1;
    end;
    if (Result < (1001-1000+9+15+1)) and (Result > 2) then Result := 0; //Others are not decoded yet
    if Assigned(ChaptersToSkip) and ChaptersToSkip.Find(IntToStr(aType), aType)  then // "Required" time optimisation (can save "hours" if used on 1001)
      Result := 0;
  end;
end;

function ArrayTableEntryOptionalStringDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Array Entry Data', aElement);
  Assert(Element.BaseName = 'Array Entry Data');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Array Type'];
    Assert(Assigned(Element));
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      case aType of
        1: Result := 2;
      else
        Result := 1;
      end;
    end;
  end;
end;

var
  StringTableCount : Integer = -1;

procedure StringTableAfterLoad(const aElement: IwbElement);
begin
  if StringTableCount < 0 then begin
    StringTableCount := (aElement as IwbContainer).ElementCount;
    InitializeStringTable(aElement as IwbContainer);
  end;
end;

var
  WorldspaceTableCount : Integer = -1;

procedure WorldspaceTableAfterLoad(const aElement: IwbElement);
begin
  if WorldspaceTableCount < 0 then begin
    WorldspaceTableCount := (aElement as IwbContainer).ElementCount;
    InitializeWorldspaceTable(aElement as IwbContainer);
  end;
end;

var
  RefIDTableCount : Integer = -1;

procedure RefIDTableAfterLoad(const aElement: IwbElement);
begin
  if RefIDTableCount < 0 then begin
    RefIDTableCount := (aElement as IwbContainer).ElementCount;
    InitializeRefIDTable(aElement as IwbContainer);
  end;
end;

var
  ObjectTableCount : Integer = -1;
  ObjectDetachedTableCount : Integer = -1;

procedure ObjectTableAfterLoad(const aElement: IwbElement);
begin
  if ObjectTableCount < 0 then begin
    ObjectTableCount := (aElement as IwbContainer).ElementCount;
    InitializeObjectTable(aElement as IwbContainer);
  end;
end;

procedure ObjectDetachedTableAfterLoad(const aElement: IwbElement);
begin
  if ObjectDetachedTableCount < 0 then begin
    ObjectDetachedTableCount := (aElement as IwbContainer).ElementCount;
    InitializeObjectDetachedTable(aElement as IwbContainer);
  end;
end;

var
  ArrayTableCount : Integer = -1;

procedure ArrayTableAfterLoad(const aElement: IwbElement);
begin
  if ArrayTableCount < 0 then begin
    ArrayTableCount := (aElement as IwbContainer).ElementCount;
    InitializeArrayTable(aElement as IwbContainer);
  end;
end;

function VariableDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Variable', aElement);
  Assert(Element.BaseName='Variable');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    Assert(Assigned(Element));
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      case aType of
         1: Result := 1;
         2: Result := 2;
         3: Result := 3;
         4: Result := 4;
         5: Result := 5;
        11: Result := 6;
        12: Result := 7;
        13: Result := 8;
        14: Result := 9;
        15: Result := 10;
      end;
    end;
  end;
end;

function ArrayElementsTableValueDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Element', aElement);
  Assert(Element.BaseName = 'Element');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    Assert(Assigned(Element));
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      case aType of
         1: Result := 1;
         2: Result := 2;
         3: Result := 3;
         4: Result := 4;
         5: Result := 5;
        11: Result := 6;
        12: Result := 7;
        13: Result := 8;
        14: Result := 9;
        15: Result := 10;
      end;
    end;
  end;
end;

var
  StackTableCount : Integer = -1;

procedure StackTableAfterLoad(const aElement: IwbElement);
begin
  if StackTableCount < 0 then begin
    StackTableCount := (aElement as IwbContainer).ElementCount;
  end;
end;

function StackDataTableValueDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Stack', aElement);
  Assert(Element.BaseName='Stack');

  if Supports(Element, IwbDataContainer, Container) and (Element.Name = 'Element') then begin
    Element := Container.ElementByName['Type'];
    Assert(Assigned(Element));
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      case aType of
         1: Result := 1;
         2: Result := 2;
         3: Result := 3;
         4: Result := 4;
         5: Result := 5;
        11: Result := 6;
        12: Result := 7;
        13: Result := 8;
        14: Result := 9;
        15: Result := 10;
      end;
    end;
  end;
end;

function ObjectDataTableCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  sElement  : IwbElement;
  Element   : IwbElement;
  Container : IwbDataContainer;

begin
  if ObjectTableCount<0 then begin
    Result := 0;
    if not Assigned(aElement) then Exit;
    sElement := FindElement('Papyrus Struct', aElement);
    Assert(sElement.BaseName='Papyrus Struct');

    if Supports(sElement, IwbDataContainer, Container) then begin
      Element := Container.ElementByName['Object Table'];
      if Supports(Element, IwbDataContainer, Container) then
        Result := Container.ElementCount;
    end;
    if Supports(sElement, IwbDataContainer, Container) then begin
      Element := Container.ElementByName['Detached Object Table'];
      if Supports(Element, IwbDataContainer, Container) then
        Inc(Result, Container.ElementCount);
    end;
  end else
    Result := ObjectTableCount+ObjectDetachedTableCount;
end;

function ArrayContentTableCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;

begin
  if ArrayTableCount<0 then begin
    Result := 0;
    if not Assigned(aElement) then Exit;
    Element := FindElement('Papyrus Struct', aElement);
    Assert(Element.BaseName='Papyrus Struct');

    if Supports(Element, IwbDataContainer, Container) then begin
      Element := Container.ElementByName['Array Table'];
      if Supports(Element, IwbDataContainer, Container) then
        Result := Container.ElementCount;
    end
  end else
    Result := ArrayTableCount;
end;

function StackContentTableCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;

begin
  if StackTableCount<0 then begin
    Result := 0;
    if not Assigned(aElement) then Exit;
    Element := FindElement('Papyrus Struct', aElement);
    Assert(Element.BaseName='Papyrus Struct');

    if Supports(Element, IwbDataContainer, Container) then begin
      Element := Container.ElementByPath['Stacks\Stack Table'];
      if Supports(Element, IwbDataContainer, Container) then
        Result := Container.ElementCount;
    end
  end else
    Result := StackTableCount;
end;

const
  ArrayContentEntryData = 'Array Content Entry Data';

function ArrayElementsTableElementCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element       : IwbElement;
  Container     : IwbDataContainer;
  DataContainer : IwbDataContainer;
  Handle        : Cardinal;
  i             : Integer;
begin
  Result := 0;
  Handle := 0;
  if not Assigned(aElement) then Exit;

  Element := FindElement(ArrayContentEntryData, aElement);
  Assert(Element.BaseName=ArrayContentEntryData);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Array Handle'];
    if Assigned(Element) then
      Handle := Element.NativeValue
    else
      Exit;
  end;

  if ArrayTableCount<0 then begin
    Element := FindElement('Papyrus Struct', aElement);
    Assert(Element.BaseName='Papyrus Struct');

    if Supports(Element, IwbDataContainer, Container) then begin
      Element := Container.ElementByName['Array Table'];
      if Supports(Element, IwbDataContainer, Container) then
        for i := 0 to Pred(Container.ElementCount) do
          if Supports(Container.Elements[i], IwbDataContainer, DataContainer) then
            if DataContainer.ElementByName['Array Handle'].NativeValue = Handle then begin
              Result := DataContainer.ElementByName['Count'].NativeValue;
              Break;
            end;
    end;
  end else
    Result := QueryArrayHandleCount(Handle);
end;

function ObjectDataTableEntryExtraDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aFlags    : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Script', aElement);
  Assert(Element.BaseName='Script');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Unknown Flags'];
    if Assigned(Element) then begin
      aFlags := Element.NativeValue;
      case (aFlags and $4) of
        4: Result := 1;
      else
        Result := 0;
      end;
    end;
  end;
end;

function CodeParameterTypeValueDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType     : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Parameter', aElement);
  Assert(Element.BaseName='Parameter');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      Result := aType;
    end;
  end;
end;

function OpcodeVariableParameterDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
  anOpcode  : Integer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Code', aElement);
  Assert(Element.BaseName='Code');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Opcode'];
    if Assigned(Element) then begin
      anOpcode := Element.NativeValue;
      if anOpcode in [23, 24, 25] then
        Result := 1;
    end;
  end;
end;

function OpcodeParameterCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
  anOpcode  : Integer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Code', aElement);
  Assert(Element.BaseName='Code');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Opcode'];
    if Assigned(Element) then begin
      anOpcode := Element.NativeValue;
      case anOpcode of
        000: Result := 0;
        010,
        011,
        012,
        013,
        014: Result := 2;
        020: Result := 1;
        021,
        022,
        024: Result := 2;
        026: Result := 1;
        030,
        031: Result := 2;
        034,
        035: Result := 4;
      else
        Result := 3;
      end;
    end;
  end;
end;

function FrameExtraVariablesCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Frame', aElement);
  Assert(Element.BaseName='Frame');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Extra Variables'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function StackTableDataEntryStackExtraDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aFlags    : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Stack', aElement);
  Assert(Element.BaseName='Stack');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Extra Flag'];
    if Assigned(Element) then begin
      aFlags := Element.NativeValue;
      if (aFlags and $1)= 1 then
        Result := 1
      else if (aFlags and $2)= 2 then
        Result := 2
      else
        Result := 0;
    end;
  end;
end;

function StackCallBackTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType     : String;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Callback', aElement);
  Assert(Element.BaseName='Callback');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      if SameText(aType, 'TopicInfo') then
        Result := 0 // no parameters
      else if SameText(aType, 'QuestStage') then
        Result := 1
      else if SameText(aType, 'ScenePhaseResults') then
        Result := 2
      else if SameText(aType, 'SceneActionResults') then
        Result := 2
      else if SameText(aType, 'SceneResults') then
        Result := 3
      else
        Assert(False);
    end;
  end;
end;

function StackTableDataEntryStackTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType     : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Stack', aElement);
  Assert(Element.BaseName='Stack');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      case aType of
        1: Result := 1;
        2: Result := 2;
        3: Result := 3;
      else
        Result := 0;
      end;
    end;
  end;
end;

function VMVersionDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aVersion  : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Papyrus Struct', aElement);
  Assert(Element.BaseName='Papyrus Struct');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['SkyrimVM_version'];
    if Assigned(Element) then begin
      aVersion := Element.NativeValue;
      case aVersion of
        1: Result := 1;
        2: Result := 2;
        3: Result := 3;
        4: Result := 4;
      else
        Result := 0;
      end;
    end;
  end;
end;

function SaveIsValidDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aVersion  : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Papyrus Struct', aElement);
  Assert(Element.BaseName='Papyrus Struct');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Save File Version'];
    if Assigned(Element) then begin
      aVersion :=Element.NativeValue;
      if (0 <= aVersion) and (aVersion <=5) then
        Result := 1;
    end;
  end;
end;

function VersionGreaterThan1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aVersion  : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Papyrus Struct', aElement);
  Assert(Element.BaseName='Papyrus Struct');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Save File Version'];
    if Assigned(Element) then begin
      aVersion :=Element.NativeValue;
      if (1 < aVersion) then
        Result := 1;
    end;
  end;
end;

function VersionGreaterThan3Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aVersion  : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Papyrus Struct', aElement);
  Assert(Element.BaseName='Papyrus Struct');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Save File Version'];
    if Assigned(Element) then begin
      aVersion :=Element.NativeValue;
      if (3 < aVersion) then
        Result := 1;
    end;
  end;
end;

function VersionGreaterThan4Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aVersion  : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Papyrus Struct', aElement);
  Assert(Element.BaseName='Papyrus Struct');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Save File Version'];
    if Assigned(Element) then begin
      aVersion :=Element.NativeValue;
      if (4 < aVersion) then
        Result := 1;
    end;
  end;
end;

function FunctionTypeAndFlagsDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aValue    : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  aValue := VMversionDecider(aBasePtr, aEndPtr, aElement);
  if aValue >1 then begin
    Element := FindElement('Frame Data', aElement);
    Assert(Element.BaseName='Frame Data');

    if Supports(Element, IwbDataContainer, Container) then begin
      Element := Container.ElementByName['Flags'];
      if Assigned(Element) then begin
        aValue := Element.NativeValue;
        if (aValue and $1) = 0 then begin
          Element := Container.ElementByPath['Function Type'];
          if Assigned(Element) then begin
            aValue := Element.NativeValue;
            if aValue = 0 then
              Result := 1;
          end;
        end;
      end;
    end;
  end else
    Result := 1;
end;

function HasUnknownS1Decider(aName: String; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aValue    : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  aValue := VMversionDecider(aBasePtr, aEndPtr, aElement);
  if aValue >1 then begin
    Element := FindElement(aName, aElement);
    Assert(Element.BaseName=aName);

    if Supports(Element, IwbDataContainer, Container) then begin
      Element := Container.ElementByName['Has UnknownS1'];
      if Assigned(Element) then
        Result := Element.NativeValue;
    end;
  end;
end;

function HasFunctionUnknownS1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := HasUnknownS1Decider('Function Call/Return Message', aBasePtr, aEndPtr, aElement);
end;

function HasStackUnknownS1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := HasUnknownS1Decider('Suspended Stack', aBasePtr, aEndPtr, aElement);
end;

function PreviousUnknownDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aValue    : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  aValue := VMversionDecider(aBasePtr, aEndPtr, aElement);
  if aValue >1 then begin
    Element := FindElement('Papyrus Struct', aElement);
    Assert(Element.BaseName='Papyrus Struct');

    if Supports(Element, IwbDataContainer, Container) then begin
      Element := Container.ElementByName['Previous Unknown'];
      if Assigned(Element) then
        if Element.NativeValue > 0 then
          Result := 1;
    end;
  end;
end;

function FunctorDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aValue    : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Functor', aElement);
  Assert(Element.BaseName='Functor');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      aValue := Element.NativeValue;
      if (aValue >= 0) or (aValue<25) then
        Result := aValue+1;
    end;
  end;
end;

function FirstCountCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Dual RefID Table', aElement);
  Assert(Element.BaseName='Dual RefID Table');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['First Count'];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

function SecondCountCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Dual RefID Table', aElement);
  Assert(Element.BaseName='Dual RefID Table');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Second Count'];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

function Data6Key2Counter(aParent, aName: String; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement(aParent, aElement);
  Assert(Element.BaseName=aParent);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName[aName];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

function Unknown1000Counter(aName: String; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := Data6Key2Counter('Temp Effect', aName, aBasePtr, aEndPtr, aElement);
end;

function Unknown1000_000Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := Data6Key2Counter('Unknown1000_00', 'Unknown1000_000 Count', aBasePtr, aEndPtr, aElement);
end;

function Unknown1000_01Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := Unknown1000Counter('Unknown1000_01 Count', aBasePtr, aEndPtr, aElement);
end;

function Unknown1000_02Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := Unknown1000Counter('Unknown1000_02 Count', aBasePtr, aEndPtr, aElement);
end;

function Unknown1000_03Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := Unknown1000Counter('Unknown1000_03 Count', aBasePtr, aEndPtr, aElement);
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

function ChangedFormDataLengthDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Changed Form', aElement);
  Assert(Element.BaseName='Changed Form');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      aType := Element.NativeValue shr 6;
      case aType of
        0: Result := 0;
        1: Result := 1;
        2: Result := 2;
      else
        Result := 3;
      end;
    end;
  end;
end;

function ChangedFormDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType     : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Changed Form', aElement);
  Assert(Element.BaseName='Changed Form');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    aType := Element.NativeValue and $3F;
    if Assigned(Element) then begin
      Result := 1 + aType;
    end;
    if (Result > 9) and (Result > 0) then
      Result := 0;
    if Assigned(ChaptersToSkip) and ChaptersToSkip.Find(IntToStr(aType), aType)  then // "Required" time optimisation (can save "hours" if used on 1001)
      Result := 0;
  end;
end;

function ChangedFormDataSizer(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; var CompressedSize: Integer): Cardinal;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('CForm Data', aElement);
  Assert(Element.BaseName='CForm Data');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Uncompressed Length'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
    Element := Container.ElementByName['Length'];
    if Assigned(Element) then begin
      CompressedSize := Element.NativeValue;
    end;
  end;
end;

function ChangedFlagXXDecider(aMask: Cardinal; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
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

function ChangedFlag28Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($10000000, aBasePtr, aEndPtr, aElement);
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
      if (anID and $3F) = $14 then
        Result := 1;
    end;
  end;
end;

function StageDataCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := Data6Key2Counter('Stages Data', 'Stage Count', aBasePtr, aEndPtr, aElement);
end;

function ObjectiveDataCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := Data6Key2Counter('Objectives Data', 'Objective Count', aBasePtr, aEndPtr, aElement);
end;

function QuestRuntimeDataTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('UnknownRA004S', aElement);
  Assert(Element.BaseName='UnknownRA004S');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function QuestRuntimeHasStructDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Runtime Data', aElement);
  Assert(Element.BaseName='Runtime Data');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['HasStruct'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function QuestRuntimeTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('UnknownRA00A001A008S', aElement);
  Assert(Element.BaseName='UnknownRA00A001A008S');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
      if Result>4 then
        Result := 0
      else
        Inc(Result);
    end;
  end;
end;

function InstanceCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := Data6Key2Counter('Instance Data', 'Instance Count', aBasePtr, aEndPtr, aElement);
end;

function InstanceUnknownIA008SCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := Data6Key2Counter('Instance', 'Instance UnknownIA008S Count', aBasePtr, aEndPtr, aElement);
end;

function InstanceGlobalCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := Data6Key2Counter('Instance', 'Instance Global Count', aBasePtr, aEndPtr, aElement);
end;

function InitialDataTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType     : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('Changed Form', aElement);
  Assert(Element.BaseName='Changed Form');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      if aType = 6 then // CELL
        if (ChangedFlag30Decider(aBasePtr, aEndPtr, aElement)<>0) and
           (ChangedFlag29Decider(aBasePtr, aEndPtr, aElement)<>0) then
          Result := 1
        else if (ChangedFlag30Decider(aBasePtr, aEndPtr, aElement)<>0) and
                (ChangedFlag28Decider(aBasePtr, aEndPtr, aElement)<>0) then
          Result := 2
        else if (ChangedFlag30Decider(aBasePtr, aEndPtr, aElement)<>0) then
          Result := 3;
      if aType in [0,1,2,3,4,5,40,41,42] then begin  // REFR or descendant
        Element := Container.ElementByName['RefID'];
        if Assigned(Element) and (Element.NativeValue>=$FF000000) then // Form is Constructed
          Result := 5
        else if (ChangedFlag03or25Decider(aBasePtr, aEndPtr, aElement)<>0) then
          Result := 6
        else if (ChangedFlag01or02Decider(aBasePtr, aEndPtr, aElement)<>0) then
          Result := 4;
      end;
    end;
  end;
end;

function ChangedFormDataCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := FindElement('CForm Data', aElement);
  Assert(Element.BaseName='CForm Data');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Uncompressed Length'];
    if Assigned(Element) then
      if Element.NativeValue >0 then
        Result := Element.NativeValue
      else begin
        Element := Container.ElementByName['Length'];
        if Assigned(Element) then begin
          Result := Element.NativeValue;
        end;
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
    Element := Container.ElementByName['Uncompressed Length'];
    if Assigned(Element) and Supports(Element, IwbDataContainer, EasC) then begin
      Result := Element.NativeValue;
      if Result = 0 then begin
        Element := Container.ElementByName['Length'];
        if Assigned(Element) and Supports(Element, IwbDataContainer, EasC) then begin
          Result := Element.NativeValue;
        end;
      end;
    end;
  end;

  if Result > 0 then begin
    Element := FindElement('Changed Form Data', aElement);
    Assert(Element.BaseName='Changed Form Data');

    if Supports(Element, IwbDataContainer, Container) and (Container.ElementCount = 4) then begin
      Origin := Cardinal(Container.DataBasePtr);
      Element := Container.Elements[3];
      if Assigned(Element) and Supports(Element, IwbDataContainer, EasC) then begin
        Consumed := Cardinal(EasC.DataBasePtr) - Origin;
        Result := Result - Consumed;
      end;
    end;
  end;
end;

function SkipCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := BytesToSkip;
end;

function DumpCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  if BytesToDump = $FFFFFFFF then
    Result := ( Cardinal(aEndPtr) - Cardinal(aBasePtr) ) div BytesToGroup + 1
  else
    Result := BytesToDump div BytesToGroup + 1;
end;

function GlobalDataSizer(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; var CompressedSize: Integer): Cardinal;
begin
  Result := PCardinal(Pointer(Cardinal(aBasePtr)+SizeOf(cardinal)))^ + 2*SizeOf(Cardinal);
  CompressedSize := Result;
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
        1: Result := Result div BytesToGroup;
        2: Result := Result mod BytesToGroup;
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
          1: Result := Result div BytesToGroup;
          2: Result := Result mod BytesToGroup;
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

procedure DefineTES5SavesS;  // This is all based on current UESP, and HexDump, Triria TESSaveLib and the Runtime
var
  wbHeader                   : IwbStructDef;
  wbFileLocationTable        : IwbStructDef;
  wbGlobalData               : IwbStructDef;
  wbChangedForm              : IwbStructDef;
  wbChangedFormData          : IwbStructDef;
  wbNull                     : IwbValueDef;
  wbChangeFlags              : IwbIntegerDef;
  wbChangeTypes              : IwbEnumDef;
  wbQuestFlags               : IwbIntegerDef;
  wbTypeData                 : IwbStructDef;
  wbVariable                 : IwbStructDef;
  wbCodeOpcodes              : IwbEnumDef;
  wbCodeParameter            : IwbStructDef;
  wbCode                     : IwbStructDef;
  wbFunction                 : IwbStructDef;
  wbObjectTableEntry         : IwbStructDef;
  wbObjectDetachedTableEntry : IwbStructDef;
  wbArrayTableEntry          : IwbStructDef;
  wbStackTableEntry          : IwbStructDef;
  wbObjectDataTableEntry     : IwbStructDef;
  wbArrayElementsTableEntry  : IwbStructDef;
  wbCallbackParameters       : IwbUnionDef;
  wbStackTableDataEntry      : IwbStructDef;
  wbUnknownS1                : IwbStructDef;
  wbFunctionMessageDataEntry : IwbStructDef;
  wbSuspendedStackDataEntry  : IwbStructDef;
  wbQueuedUnbindDataEntry    : IwbStructDef;
  wbStackTimeUpdateOffset    : IwbStructDef;
  wbObjectTimeUpdateOffset   : IwbStructDef;
  wbFunctor                  : IwbStructDef;
  wbFunctors                 : IwbStructDef;
  wbUnknown0900              : IwbArrayDef;
  wbInitialDataType01        : IwbStructDef;
  wbInitialDataType02        : IwbStructDef;
  wbInitialDataType03        : IwbStructDef;
  wbInitialDataType04        : IwbStructDef;
  wbInitialDataType05        : IwbStructDef;
  wbInitialDataType06        : IwbStructDef;
  wbInitialDataType          : IwbUnionDef;
  wbExtraDataChanges         : IwbStructDef;
  wbREFRChanges              : IwbStructDef;
  wbACHRChanges              : IwbStructDef;
begin
  wbNull := wbByteArray('Unused', -255);
  wbTypeData := wbStruct('SkyrimVM Type Data', [      // UESP : scriptInstance
    wbInteger('Script Name', itU16, wbStringIndex),
    wbInteger('Script Type', itU16, wbStringIndex),
    wbArray('Script Variables', wbStruct('Variable', [
      wbInteger('Name', itU16, wbStringIndex),
      wbInteger('Type', itU16, wbStringIndex)
    ]), -1)
  ]);

  wbObjectTableEntry := wbStruct('Object Table Entry', [  // UESP : reference
    wbInteger('Object Handle', itU32),
    wbInteger('Name', itU16, wbStringIndex),
    wbStruct('Grouped', [
      wbInteger('Flag2bits', itU16, wbDumpInteger),
      wbInteger('Unknown', itS16, wbDumpInteger),   // returned as Dword = Word or (10000 * Flag2bits)
      wbRefID('RefID')                              // returned as 0 if unknown is -1/FFFFFFFF
    ]),
    wbInteger('Unknown', itU8, wbDumpInteger)
  ]);

  wbObjectDetachedTableEntry := wbStruct('Object Table Entry', [   // UESP : detachedReference
    wbInteger('Object Handle', itU32),
    wbInteger('Name', itU16, wbStringIndex)
  ]);

  wbVariable := wbStruct('Variable', [
    wbInteger('Type', itU8, wbPropTypeEnum),
    wbUnion('Value', VariableDecider, [
      wbInteger('Int32', itS32),
      wbStruct('Object', [
        wbInteger('Object Type', itU16, wbStringIndex),
        wbInteger('Object Handle', itU32, wbObjectHandle)
      ]),
      wbInteger('String', itU16, wbStringIndex),
      wbInteger('Int32', itU32),
      wbFloat('Float'),
      wbInteger('Bool', itU32, wbEnum(['False', 'True'])),
      wbStruct('Object Array', [
        wbInteger('Object Type', itU16, wbStringIndex),
        wbInteger('Array Handle', itU32)
      ]),
      wbInteger('String Array Handle', itU32),
      wbInteger('Int32 Array Handle', itU32),
      wbInteger('Float Array Handle', itU32),
      wbInteger('Bool Array Handle', itU32)
    ])
  ]);

  wbCodeOpcodes := wbEnum([
    {000} 'Noop()',
    {001} 'IAdd(String, Integer, Integer)',
    {002} 'FAdd(String, Float, Float)',
    {003} 'ISubtract(String, Integer, Integer)',
    {004} 'FSubtract(String, Float, Float)',
    {005} 'IMultiply(String, Integer, Integer)',
    {006} 'FMultiply(String, Float, Float)',
    {007} 'IDivide(String, Integer, Integer)',
    {008} 'FDivide(String, Float, Float)',
    {009} 'IMod(String, Integer, Integer)',
    {010} 'Not(String, Any)',
    {011} 'INegate(String, Integer)',
    {012} 'FNegate(String, Float)',
    {013} 'Assign(String, Any)',
    {014} 'Cast(String, Any)',
    {015} 'CompareEQ(String, Any, Any)',
    {016} 'CompareLT(String, Any, Any)',
    {017} 'CompareLTE(String, Any, Any)',
    {018} 'CompareGT(String, Any, Any)',
    {019} 'CompareGTE(String, Any, Any)',
    {020} 'Jump(Label)',
    {021} 'JumpT(Any, Label)',
    {022} 'JumpF(Any, Label)',
    {023} 'CallMethod(N, String, String, *)',
    {024} 'CallParent(N, String, *)',
    {025} 'CallStatic(N, N, String, *)',
    {026} 'Return(Any)',
    {027} 'StrCat(String, Q, Q)',
    {028} 'PropGet(N, String, String)',
    {029} 'PropSet(N, String, Any)',
    {030} 'ArrayCreate(String, U)',
    {031} 'ArrayLength(String, String)',
    {032} 'ArrayGetElement(String, String, Integer)',
    {033} 'ArraySetElement(String, Integer, Any)',
    {034} 'ArrayFindElement(String, String, Any, Integer)',
    {035} 'ArrayRFindElement(String, String, Any, Integer)'
  ]);

  wbCodeParameter := wbStruct('Parameter', [
    wbInteger('Type', itU8, wbDumpInteger),  // Lower than 8 and lower than 5
    wbUnion('Value', CodeParameterTypeValueDecider, [
      wbNull,
      wbInteger('Object Type', itU16, wbStringIndex),
      wbInteger('String', itU16, wbStringIndex),
      wbInteger('Unsigned Integer', itU32),
      wbFloat('Float'),
      wbInteger('Boolean', itU8, wbEnum(['False', 'True']))
    ])
  ]);

  wbCode := wbStruct('Code', [
    wbInteger('Opcode', itU8, wbCodeOpcodes),  // Lower than 36
    wbArray('Parameters', wbCodeParameter, OpcodeParameterCounter),
    wbUnion('Variable Parameters', OpcodeVariableParameterDecider, [
      wbNull,
      wbStruct('Variable Parameters', [
        wbInteger('Const', itU8),
        wbArray('Var. Parameters', wbCodeParameter, -1)
      ])
    ])
  ]);

  wbFunction := wbStruct('Function', [
    wbInteger('Return Type', itU16, wbStringIndex),
    wbInteger('DocString', itU16, wbStringIndex),
    wbInteger('User Flags', itU32, wbDumpInteger),
    wbInteger('Flags', itU8, wbDumpInteger),
    wbArray('Parameters', wbStruct('Parameter', [
      wbInteger('Name', itU16, wbStringIndex),
      wbInteger('Type', itU16, wbStringIndex)
    ]), -2),
    wbArray('Locals', wbStruct('Local', [
      wbInteger('Name', itU16, wbStringIndex),
      wbInteger('Type', itU16, wbStringIndex)
    ]), -2),
    wbArray('Codes', wbCode, -2)
  ]);

  wbObjectDataTableEntry := wbStruct('Object Data Table Entry', [  //  UESP: scriptData
    wbInteger('Object Handle', itU32, wbObjectHandle),
    wbStruct('Script', [
      wbInteger('Unknown Flags', itU8),
      wbInteger('String Index', itU16, wbStringIndex),
      wbInteger('Unknown', itU32, wbDumpInteger),
      wbUnion('Unknown', ObjectDataTableEntryExtraDecider, [
        wbNull,
        wbInteger('Unknown', itU32, wbDumpInteger)
      ]),
      wbArray('Variables', wbVariable, -1)
    ])
  ]);

  wbArrayTableEntry := wbStruct('Array Entry Data', [  // UESP: arrayInfo
    wbInteger('Array Handle', itU32),
    wbInteger('Array Type', itU8, wbPropTypeEnum),    // valid values : 0 to 5, 0B to 0F
    wbUnion('Data', ArrayTableEntryOptionalStringDecider, [
      wbNull,
      wbNull,
      wbInteger('Name', itU16, wbStringIndex)
    ]),
    wbInteger('Count', itU32)
  ]);

  wbArrayElementsTableEntry := wbStruct(ArrayContentEntryData, [   // UESP: arrayData
    wbInteger('Array Handle', itU32),
    wbArrayS('Elements', wbvariable, ArrayElementsTableElementCounter)
  ]);

  wbStackTableEntry := wbStruct('Stack Entry Data', [
    wbInteger('Stack ID', itU32),
    wbInteger('Stack Type', itU8)
  ]);

  wbCallbackParameters := wbUnion('Parameters', StackCallBackTypeDecider, [
    wbNull,
    wbStruct('StageItemFinishedParameters', [
      wbRefID('RefID'),
      wbInteger('Unknown', itU16, wbDumpInteger),
      wbInteger('Unknown', itU8, wbDumpInteger)
    ]),
    wbStruct('SceneActionOrPhaseResultsParameters', [
      wbRefID('RefID'),
      wbInteger('Unknown', itU32, wbDumpInteger)
    ]),
    wbStruct('SceneResultsParameters', [
      wbRefID('RefID')
    ])
  ]);

  wbStackTableDataEntry := wbStruct('Stack Data Entry Data', [ // UESP: activeScriptData
    wbInteger('Stack ID', itU32),
    wbStruct('Stack', [
      wbInteger('Unknown', itU8),  // Should be lower than 9    UESP: Major version
      wbInteger('Unknown', itU8),  // Should be lower than 3    UESP: Minor version
      wbVariable,
      wbInteger('Extra Flag', itU8),
      wbInteger('Unknown', itU8, wbDumpInteger),  // Should be lower than 3 also
      wbUnion('Extra 1', StackTableDataEntryStackExtraDecider, [ // Extra Flag and $1 = $1
        wbNull,
        wbInteger('Unknown', itU32, wbDumpInteger),
        wbNull
      ]),
      wbInteger('Type', itU8),  // Should be lower than 4
      wbUnion('Unknown', StackTableDataEntryStackTypeDecider, [
        wbNull,       // < 1 or > 3
        wbStruct('Callback', [   // = 1
          wbLenString('Type', 4),
          wbCallbackParameters
        ]),
        wbVariable,   // = 2
        wbStruct('Callback', [  // = 3
          wbLenString('Type', 4),
          wbCallbackParameters,
          wbVariable
        ])
      ]),
      wbArray('Frames', wbStruct('Frame', [
        wbInteger('Extra Variables', itU32),
        wbStruct('Frame Data', [
          wbInteger('Flags', itU8),
          wbUnion('Type', VMVersionDecider, [ // Should be lower than 3
            wbNull,
            wbNull,
            wbInteger('Function Type', itU8),
            wbInteger('Function Type', itU8),
            wbInteger('Function Type', itU8)
          ]),
          wbInteger('Unknown', itU16, wbStringIndex),
          wbInteger('Unknown', itU16, wbStringIndex),
          wbInteger('Unknown', itU16, wbStringIndex),
          wbUnion('Unknown', FunctionTypeAndFlagsDecider, [ // (version < 2 or Function Type = 0) and not Flags bit 0
            wbNull,
            wbInteger('Unknown', itU16, wbStringIndex)
          ]),
          wbInteger('Unknown', itU8, wbDumpInteger),
          wbInteger('Unknown', itU8, wbDumpInteger),
          wbFunction,
          wbInteger('Unknown', itU32, wbDumpInteger),
          wbVariable,
          wbArray('Variables', wbvariable, FrameExtraVariablesCounter)
        ])
      ]), -1),
      wbUnion('Extra 2', StackTableDataEntryStackExtraDecider, [ // Extra Flag and $2 = $2
        wbNull,
        wbNull,
        wbInteger('Unknown', itU8)  // Should be lower than 6
      ])
    ])
  ]);

  wbUnknownS1 := wbStruct('Unknown', [  // Shared between Function message and Suspended Stack
    wbInteger('Unknown', itU8, wbDumpInteger),  // lower than 4
    wbInteger('Unknown', itU16, wbStringIndex),
    wbInteger('Unknown', itU16, wbStringIndex),
    wbVariable,
    wbArray('Variables', wbVariable, -1)
  ]);

  wbFunctionMessageDataEntry := wbStruct('Function Message Data', [
    wbStruct('Function Call/Return Message', [
      wbInteger('Unknown', itU8, wbDumpInteger),  // lower than 3
      wbInteger('Unknown', itU32),
      wbInteger('Has UnknownS1', itU8, wbEnum(['False', 'True'])),
      wbUnion('Unknown', HasFunctionUnknownS1Decider, [
        wbNull,
        wbUnknownS1
      ])
    ])
  ]);

  wbSuspendedStackDataEntry := wbStruct('Suspended Stack', [
    wbInteger('Unknown', itU32),
    wbInteger('Has UnknownS1', itU8, wbEnum(['False', 'True'])),
    wbUnion('Unknown', HasStackUnknownS1Decider, [
      wbNull,
      wbUnknownS1
    ])
  ]);

  wbQueuedUnbindDataEntry := wbStruct('Queued Unbind Data', [
    wbInteger('Unknown', itU32),
    wbInteger('Unknown', itU32)
  ]);

  wbStackTimeUpdateOffset := wbStruct('Stack Time Update Offset', [
    wbInteger('Stack ID', itU32)
    ,wbInteger('Offset', itS32)
  ]);

  wbObjectTimeUpdateOffset := wbStruct('Stack Time Update Offset', [
    wbInteger('Unknown', itU8)
    ,wbInteger('Unknown', itU32)
    ,wbInteger('Unknown', itS32)
    ,wbInteger('Unknown', itU16)
    ,wbInteger('Unknown', itS16)
    ,wbRefID('RefID')
  ]);

  wbFunctor := wbStruct('Functor', [
    wbInteger('Type', itU8, wbEnum([
      'MoveTo',
      'MoveToOwnEditorLoc',
      'DamageObject',
      'Enable',
      'Disable',
      'Delete',
      'SetPosition',
      'SetAngle',
      'SetMotionType',
      'NonLatentDelete',
      'MoveToPackLoc',
      'SetScale',
      'DropObject',
      'Tether',
      'AttachAshPile',
      'AddRemoveConstraint',
      'ForceAddRemoveRagdoll',
      'ApplyHavokImpulse',
      'Reset',
      'SendPlayerToJail',
      'AddItem',
      'Resurrect',
      'Cast',
      'ScrollCast',
      'RemoveItem'
    ])),
    wbUnion('Data', FunctorDecider, [
      wbStruct('MoveTo', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU8),
        wbUnion('Unknown', VersionGreaterThan1Decider, [
          wbNull,
          wbInteger('Unknown', itU8)
        ])
      ]),
      wbStruct('MoveToOwnEditorLoc / Delete / NonLatentDelete', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID')
      ]),
      wbStruct('DamageObject / SetScale', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32)
      ]),
      wbStruct('Enable / Disable', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU8)
      ]),
      wbStruct('Enable / Disable', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU8)
      ]),
      wbStruct('MoveToOwnEditorLoc / Delete / NonLatentDelete', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID')
      ]),
      wbStruct('SetPosition / SetAngle', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32)
      ]),
      wbStruct('SetPosition / SetAngle', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32)
      ]),
      wbStruct('SetMotionType', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU8),
        wbInteger('Unknown', itU8),
        wbInteger('Unknown', itU8)
      ]),
      wbStruct('MoveToOwnEditorLoc / Delete / NonLatentDelete', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID')
      ]),
      wbStruct('MoveToPackLoc', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID')
      ]),
      wbStruct('DamageObject / SetScale', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32)
      ]),
      wbStruct('DropObject', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32)
      ]),
      wbStruct('Tether', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID')
      ]),
      wbStruct('AttachAshPile', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID')
      ]),
      wbStruct('AddRemoveConstraint', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID'),
        wbLenString('Unknown'),
        wbLenString('Unknown'),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU8)
      ]),
      wbStruct('ForceAddRemoveRagdoll', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU8)
      ]),
      wbStruct('ApplyHavokImpulse', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32)
      ]),
      wbStruct('Reset', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID')
      ]),
      wbStruct('SendPlayerToJail', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU8)
      ]),
      wbStruct('AddItem', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU8)
      ]),
      wbStruct('Resurrect', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID')
      ]),
      wbStruct('Cast', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID'),
        wbRefID('RefID'),
        wbRefID('RefID')
      ]),
      wbStruct('ScrollCast', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID'),
        wbRefID('RefID')
      ]),
      wbStruct('RemoveItem', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID'),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU8)
      ])
    ])
  ]);

  wbFunctors := wbStruct('Functors', [
    wbArray('First Functor Table', wbFunctor, -1),
    wbArray('Second Functor Table', wbFunctor, -1),
    wbArray('Third Functor Table', wbFunctor, -1),
    wbArray('Fourth Functor Table', wbFunctor, -1)
  ]);

  wbUnknown0900 := wbArray('Unknown0900', wbStruct('Unknown', [
    wbInteger('Boolean', itU8, wbEnum(['False', 'True'])),
    wbInteger('Unknown', itU32),
    wbInteger('Unknown', itU32)
   ]), -1);

  wbGlobalData := wbStructC('Global Data', GlobalDataSizer, [
    wbInteger('Type', itU32),
    wbInteger('DataLength', itU32),
    wbUnion('Data', GlobalDataDecider, [
      wbByteArray('Unknown', DataCounter),  // Single line
      // 0 to 8
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
      wbStruct('Player Location Struct', [  // Seems to be 30 bytes in version 64 and 31 in version 73 or 74
        wbByteArray('Unknown', 4)
        ,wbRefID('WorldSpace 1')
        ,wbInteger('Coord X', itS32)
        ,wbInteger('Coord Y', itS32)
        ,wbRefID('WorldSpace 2')
        ,wbFloat('Pos X')
        ,wbFloat('Pos Y')
        ,wbFloat('Pos Z')
        ,wbUnion('Added data', SaveFormVersionGreaterThan72Decider, [
          wbNull
          ,wbByteArray('Unknown', 1)
        ])
      ]),
      wbArray('TES', wbInteger('', itU8), -2),
      wbArray('Global Variables', wbInteger('', itU8), -2),
      wbArray('Created Objects', wbInteger('', itU8), -2),
      wbArray('Effects', wbInteger('', itU8), -2),
      wbArray('Weather', wbInteger('', itU8), -2),
      wbArray('Audio', wbInteger('', itU8), -2),
      wbArray('Sky Cells', wbInteger('', itU8), -2),
      // 100 to 114
      wbArray('Process List', wbInteger('', itU8), -2),
      wbArray('Combat', wbInteger('', itU8), -2),
      wbArray('Interface', wbInteger('', itU8), -2),
      wbArray('Actor Causes', wbInteger('', itU8), -2),
      wbArray('Unknown 104', wbInteger('', itU8), -2),
      wbArray('Detection Manager', wbInteger('', itU8), -2),
      wbArray('Location MetaData', wbInteger('', itU8), -2),
      wbArray('Quest Static Data', wbInteger('', itU8), -2),
      wbArray('Story Teller', wbInteger('', itU8), -2),
      wbArray('Magic Favorites', wbInteger('', itU8), -2),
      wbArray('Player Controls', wbInteger('', itU8), -2),
      wbArray('Story Event Manager', wbInteger('', itU8), -2),
      wbArray('Ingredient Shared', wbInteger('', itU8), -2),
      wbArray('Menu Controls', wbInteger('', itU8), -2),
      wbArray('Menu Topic Manager', wbInteger('', itU8), -2),
      // 1000 to 1005
      wbStruct('Temp Effect', [
        wbStruct('Unknown1000_00', [
          wbInteger('Unknown1000_000 Count', itU6to30),
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
          ]), Unknown1000_000Counter)
        ]),
        wbInteger('Next ID', itU32),
        wbInteger('Unknown1000_01 Count', itU6to30),
        wbArray('Unknown1000_01', wbStruct('Unknown', [
          wbInteger('Unknown', itU32),
          wbStruct('Unknown', []) // Needs sample to continue
        ]), Unknown1000_01Counter),
        wbInteger('Unknown1000_02 Count', itU6to30),
        wbArray('Unknown1000_02', wbStruct('Unknown', [
          wbInteger('Unknown', itU32),
          wbStruct('Unknown', []) // Needs sample to continue
        ]), Unknown1000_02Counter),
        wbInteger('Unknown1000_03 Count', itU6to30),
        wbArray('Unknown1000_03', wbStruct('Unknown', [
          wbInteger('Unknown', itU32),
          wbStruct('Unknown', []) // Needs sample to continue
        ]), Unknown1000_03Counter)
      ]),
      wbStruct('Papyrus Struct', [
        wbInteger('SkyrimVM_version', itU16)  // FFFF marks an invalid save, 4 seems current max     UESP: header
        ,wbArray('String Table for Internal VM save data', wbLenString('String', 2), -2, StringTableAfterLoad)  // UESP strings
        ,wbArray('Type table for internal VM save data', wbTypeData, -1)  // Type table for internal VM save data  USEP:script
        ,wbArray('Object Table', wbObjectTableEntry, -1, ObjectTableAfterLoad)  // UESP: scriptInstance
        ,wbArray('Detached Object Table', wbObjectDetachedTableEntry, -1, ObjectDetachedTableAfterLoad) // UESP: reference
        ,wbArrayS('Array Table', wbArrayTableEntry, -1, ArrayTableAfterLoad) // UESP: arrayInfo
        ,wbStruct('Stacks', [
          wbInteger('Next Active Script ID', itU32, wbDumpInteger)                // Part of Stack table
         ,wbArrayS('Stack Table', wbStackTableEntry, -1, StackTableAfterLoad) // UESP: activeScript
        ])
        ,wbArray('Object Data Table', wbObjectDataTableEntry, ObjectDataTableCounter)     // UESP: scriptData
        ,wbArray('Array Content Table', wbArrayElementsTableEntry, ArrayContentTableCounter) // UESP: arrayData
        ,wbArray('Stack Content Table', wbStackTableDataEntry, StackContentTableCounter)  // UESP: activeScriptData
        ,wbArray('Function Message Table', wbFunctionMessageDataEntry, -1)
        ,wbArray('First Suspended Stack Table', wbSuspendedStackDataEntry, -1)
        ,wbArray('Second Suspended Stack Table', wbSuspendedStackDataEntry, -1)
        ,wbInteger('Previous Unknown', itU32)
        ,wbUnion('Unknown', PreviousUnknownDecider, [
          wbNull,
          wbInteger('Unknown', itU32)
        ])
        ,wbArray('Unknown0', wbInteger('Unknown', itU32), -1)
        ,wbUnion('Version >= 4', VMVersionDecider, [
          wbNull,
          wbNull,
          wbNull,
          wbNull,
          wbArray('Queued Unbind Table', wbQueuedUnbindDataEntry, -1)
        ]) // End of .text:00C53760
        ,wbInteger('Save File Version', itS16)
        ,wbUnion('', SaveIsValidDecider, [
           wbNull,
           wbStruct('Save File', [
             wbArray('First Stack Time Update Table', wbStackTimeUpdateOffset, -1)
            ,wbArray('Second Stack Time Update Table', wbStackTimeUpdateOffset, -1)
            ,wbArray('Third Stack Time Update Table', wbStackTimeUpdateOffset, -1)
            ,wbArray('First Object Time Update Table', wbObjectTimeUpdateOffset, -1)
            ,wbArray('Second Object Time Update Table', wbObjectTimeUpdateOffset, -1)
            ,wbArray('Unknown01', wbLenString('Unknown', 4), -1)
            ,wbFunctors    // Untested, no suitable save found
            ,wbArray('Unknown02', wbStruct('Unknown', [
               wbRefID('RefID')
              ,wbRefID('RefID')
              ,wbInteger('Unknown', itU8) // Should be less than 3
              ,wbInteger('Unknown', itU8) // Should also be less than 3, would be skipped if previous greater than 2
            ]), -1)    // Untested, no suitable save found
            ,wbArray('Unknown03', wbStruct('Unknown', [
               wbInteger('Unknown', itU16)  // Check for String Index
              ,wbInteger('Unknown', itU16)
              ,wbRefID('RefID')
            ]), -1)
            ,wbUnion('Unknown04', VersionGreaterThan3Decider, [
               wbNull
              ,wbArray('Unknown040', wbStruct('Unknown', [
                 wbInteger('Unknown', itU16)  // Check for String Index
                ,wbInteger('Unknown', itU16)
                ,wbRefID('RefID')
              ]), -1)
            ])
            ,wbUnion('Unknown', VersionGreaterThan4Decider, [
               wbNull
              ,wbArray('Unknown05', wbStruct('Unknown', [
                 wbInteger('Unknown', itU16)  // Check for String Index
                ,wbInteger('Unknown', itU16)
                ,wbRefID('RefID')
                ,wbStruct('Dual RefID Table', [
                  wbInteger('First Count', itU32)
                  ,wbInteger('Second Count', itU32)
                  ,wbArray('Unknown050', wbRefID('RefID'), FirstCountCounter)
                  ,wbArray('Unknown051', wbRefID('RefID'), SecondCountCounter)
                ])
              ]), -1)
            ])
            ,wbArray('Unknown06', wbStruct('Unknown', [
               wbRefID('RefID')
              ,wbInteger('Unknown', itU8)
            ]), -1)
            ,wbArray('Unknown07', wbStruct('Unknown', [
               wbRefID('RefID')
              ,wbArray('Unknown070', wbStruct('Unknown', [
                 wbLenString('Unknown')
                ,wbArray('Unknown0700', wbStruct('Unknown', [
                   wbInteger('Unknown', itU32)
                  ,wbInteger('Unknown', itU32)
                 ]), -1)
                ,wbArray('Unknown0701', wbStruct('Unknown', [
                   wbInteger('Unknown', itU16)  // Check for String Index
                  ,wbInteger('Unknown', itU16)
                  ,wbRefID('RefID')
                 ]), -1)
               ]), -1)
             ]), -1)
           ,wbArray('Unknown08', wbStruct('Unknown', [
              wbInteger('Unknown', itU32)
             ,wbInteger('Unknown', itU32)
            ]), -1)
           ,wbStruct('Unknown09', [
              wbArray('Unknown090', wbStruct('Unknown', [
                wbRefID('RefID')
               ,wbUnknown0900
             ]), -1)
             ,wbArray('Unknown091', wbStruct('Unknown', [
                wbRefID('RefID')
               ,wbArray('Unknown0910', wbStruct('Unknown', [
                  wbInteger('Unknown', itU32)
                 ,wbArray('Unknown09100', wbInteger('Unknown', itU32), -1)
                 ,wbArray('Unknown09101', wbStruct('Unknown', [
                    wbInteger('Unknown', itU32)
                   ,wbInteger('Unknown', itU8, wbEnum(['False', 'True']))
                  ]), -1)
                 ,wbInteger('Unknown', itU32)
                ]), -1)
             ]), -1)
             ,wbArray('Unknown092', wbStruct('Unknown', [
                wbRefID('RefID')
               ,wbUnknown0900
             ]), -1)
            ])
           ,wbArray('Unknown0A', wbStruct('Unknown', [
              wbInteger('Unknown', itU32)
             ,wbArray('Unknown0A0', wbInteger('Unknown', itU32), -1)
           ]), -1)
          ])
        ])
      ]),
      wbArray('Anim Objects', wbStruct('Anim Object', [
        wbRefID('REFR'),
        wbRefID('ANIO'),
        wbInteger('Boolean', itU8, wbEnum(['False', 'True']))
      ]), -1),
      wbStruct('Timers', [
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32)
      ]),
      wbArray('Synchronized Animations', wbStruct('Unknown', [
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbArray('Unknown', wbStruct('Unknown', [
          wbRefID('REFR'),
          wbLenString('String', 2)
        ]), -1)
      ]), -1),
      wbStruct('Main', []) // Empty
    ])
//    ,wbByteArray('Remainder', DataRemainderCounter)  // Single line
    ,wbArray('Remainder', wbByteArray('Unknown', BytesToGroup), DataQuartetCounter) // per Quartet
    ,wbByteArray('Unknown', DataQuartetRemainderCounter)
  ]);

  wbChangeFlags := wbInteger('Change Flags', itU32 , wbFlags([
    'CHANGE_FORM_FLAGS',
    'CHANGE_QUEST_FLAGS / CHANGE_REFR_MOVE / CHANGE_ACTOR_BASE_DATA',
    'CHANGE_REFR_HAVOK_MOVE',
    'CHANGE_REFR_CELL_CHANGED / CHANGE_ACTOR_BASE_AIDATA',
    'CHANGE_REFR_SCALE',
    'CHANGE_REFR_INVENTORY',
    'CHANGE_REFR_EXTRA_OWNERSHIP / CHANGE_ACTOR_BASE_FACTIONS',
    'CHANGE_REFR_BASEOBJECT',
    'UnnamedFlag_8',
    'CHANGE_NPC_SKILLS',
    'CHANGE_OBJECT_EXTRA_ITEM_DATA',
    'UnnamedFlag_11',
    'CHANGE_OBJECT_EXTRA_LOCK',
    'UnnamedFlag_13',
    'UnnamedFlag_14',
    'UnnamedFlag_15',
    'UnnamedFlag_16',
    'UnnamedFlag_17',
    'UnnamedFlag_18',
    'UnnamedFlag_19',
    'UnnamedFlag_20',
    'CHANGE_OBJECT_EMPTY',
    'UnnamedFlag_22',
    'CHANGE_OBJECT_OPEN_STATE',
    'UnnamedFlag_24',
    'CHANGE_REFR_PROMOTED',
    'CHANGE_QUEST_ALREADY_RUN / CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN',
    'CHANGE_QUEST_INSTANCES / CHANGE_REFR_LEVELED_INVENTORY',
    'CHANGE_QUEST_RUNDATA / CHANGE_REFR_ANIMATION',
    'CHANGE_QUEST_OBJECTIVES / CHANGE_REFR_EXTRA_ENCOUNTER_ZONE',
    'UnnamedFlag_30',
    'CHANGE_QUEST_STAGES / CHANGE_REFR_EXTRA_GAME_ONLY / CHANGE_TOPIC_SAIDONCE / CHANGE_QUEST_NODE_TIME_RUN'
  ]));

  wbChangeTypes := wbKey2Data6Enum([
    ' 0 REFR',
    ' 1 ACHR',
    ' 2 PMIS',
    ' 3 PGRE',
    ' 4 PBEA',
    ' 5 PFLA',
    ' 6 CELL',
    ' 7 INFO',
    ' 8 QUST',
    ' 9 NPC_',
    '10 ACTI',
    '11 TACT',
    '12 ARMO',
    '13 BOOK',
    '14 CONT',
    '15 DOOR',
    '16 INGR',
    '17 LIGH',
    '18 MISC',
    '19 APPA',
    '20 STAT',
    '21 MSTT',
    '22 FURN',
    '23 WEAP',
    '24 AMMO',
    '25 KEYM',
    '26 ALCH',
    '27 IDLM',
    '28 NOTE',
    '29 ECZN',
    '30 CLAS',
    '31 FACT',
    '32 PACK',
    '33 NAVM',
    '34 WOOP',
    '35 MGEF',
    '36 SMQN',
    '37 SCEN',
    '38 LCTN',
    '39 RELA',
    '40 PHZD',
    '41 PBAR',
    '42 PCON',
    '43 FLST',
    '44 LVLN',
    '45 LVLI',
    '46 LVSP',
    '47 PARW',
    '48 ENCH'
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

  wbInitialDataType01 := wbStruct('Detached CELL CHANGE_CELL_EXTERIOR_CHAR', [
    wbInteger('Worldspace Index', itU16, wbWorldspaceIndex),  // index into Worldspace table
    wbInteger('Unknown', itU8),
    wbInteger('Unknown', itU8),
    wbInteger('Unknown', itU32)
	]);

  wbInitialDataType02 := wbStruct('Detached CELL CHANGE_CELL_EXTERIOR_SHORT', [
    wbInteger('Unknown', itU16),
    wbInteger('Unknown', itU16),
    wbInteger('Unknown', itU16),
    wbInteger('Unknown', itU32)
	]);

  wbInitialDataType03 := wbStruct('Detached CELL', [
    wbInteger('Unknown', itU32)
	]);

  wbInitialDataType04 := wbStruct('Reference moved', [
    wbRefID('Cell/Worldspace'),
    wbFloat('PosX'),
    wbFloat('PosY'),
    wbFloat('PosZ'),
    wbFloat('RotX'),
    wbFloat('RotY'),
    wbFloat('RotZ')
	]);

  wbInitialDataType05 := wbStruct('Contructed Reference', [
    wbRefID('Cell/Worldspace'),
    wbFloat('PosX'),
    wbFloat('PosY'),
    wbFloat('PosZ'),
    wbFloat('RotX'),
    wbFloat('RotY'),
    wbFloat('RotZ'),
    wbInteger('Unknown', itU8),
    wbRefID('RefID')
	]);

  wbInitialDataType06 := wbStruct('Reference Changed Cell or Promoted', [
    wbRefID('Cell/Worldspace'),
    wbFloat('PosX'),
    wbFloat('PosY'),
    wbFloat('PosZ'),
    wbFloat('RotX'),
    wbFloat('RotY'),
    wbFloat('RotZ'),
    wbRefID('RefID'),
    wbInteger('Unknown', itS16),
    wbInteger('Unknown', itS16)
	]);

  wbInitialDataType := wbUnion('Initial Data Type', InitialDataTypeDecider, [
    wbNull,
    wbInitialDataType01,
    wbInitialDataType02,
    wbInitialDataType03,
    wbInitialDataType03,
    wbInitialDataType05,
    wbInitialDataType06
  ]);

  wbExtraDataChanges := wbStruct('ExtraData', [
  ]);

  wbREFRChanges := wbStruct('Reference data', [
     wbUnion('Base Object', ChangedFlag07Decider, [wbNull, wbRefID('New Base Form')])
    ,wbUnion('Scale', ChangedFlag04Decider, [wbNull, wbFloat('Scale')])   // Exception for Save Version 55 NOT DECODED
    ,wbExtraDataChanges
  ]);
  wbACHRChanges := wbStruct('Change Actor Data', [  // Field names based on SKSE
     wbInteger('Unknown', itU32)
    ,wbInteger('flags1', itU32)
    ,wbREFRChanges
    ]);

  wbChangedFormData := wbStruct('Changed Form Data', [
    wbInitialDataType,
    wbUnion('CForm Flags', ChangedFlag00Decider, [wbNull, wbStruct('Change Form Flags', [
        wbInteger('Mask Invert Flags', itU32, wbRecordFlagsEnum),
        wbInteger('Mask Set unk010', itU16)
      ])
    ]),
    wbUnion('CForm Union', ChangedFormDataDecider, [
	     wbNull
      ,wbREFRChanges
      ,wbUnion('Actor Type', IsActorPlayerDecider, [
         wbACHRChanges
        ,wbStruct('PlayerRef', [
           wbACHRChanges
         ])
       ])
      ,wbStruct('Projectile Missile Data', [
       ])
      ,wbStruct('Projectile Grenade Data', [
       ])
      ,wbStruct('PBEA Data', [
       ])
      ,wbStruct('Projectile Flame Data', [
       ])
      ,wbStruct('Cell Data', [
       ])
      ,wbStruct('Change Info Data', [ {no data} ])
      ,wbStruct('Change Quest Data', [
         wbUnion('Quest Flag', ChangedFlag01Decider, [wbNull, wbQuestFlags])
        ,wbUnion('Quest Script Delay', ChangedFlag02Decider, [wbNull, wbInteger('Script Delay', itU32)])
        ,wbUnion('Quest Stages Data', ChangedFlag31Decider, [
           wbNull,
           wbStruct('Stages Data', [
             wbInteger('Stage Count', itU6to30),
             wbArray('Stages', wbStruct('Stage', [
               wbInteger('Stage ID', itU16),
               wbInteger('Sets Flag bit 0', itU8, wbEnum(['False', 'True']))
             ]), StageDataCounter)
           ])
         ])
        ,wbUnion('Quest Objectives Data', ChangedFlag29Decider, [
           wbNull,
           wbStruct('Objectives Data', [
             wbInteger('Objective Count', itU6to30),
             wbArray('Objectives', wbStruct('Objective', [
               wbInteger('Objective ID', itU32),
               wbInteger('Objective Dqtq (Byte)', itU32)
             ]), ObjectiveDataCounter)
           ])
         ])
        ,wbUnion('Quest Runtime Data', ChangedFlag28Decider, [
           wbNull
          ,wbStruct('Runtime Data', [
             wbInteger('Unknown', itU8)
            ,wbArray('UnknownRA004', wbStruct('UnknownRA004S', [
               wbInteger('Unknown', itU32)
              ,wbInteger('Type', itU8)
              ,wbUnion('UnknownRA004S006', QuestRuntimeDataTypeDecider, [
                 wbStruct('UnknownRA004S006U000', [
                   wbRefID('RefID')
                 ])
                ,wbStruct('UnknownRA004S006U001', [
                   wbRefID('RefID')
                  ,wbRefID('BoundObject')
                  ,wbRefID('Location')
                  ,wbRefID('Location')
                 ])
              ])
             ]), -1)
            ,wbArray('UnknownRA008', wbStruct('UnknownRA008S', [
               wbInteger('Unknown', itU32)
              ,wbRefID('Location')
             ]), -1)
            ,wbInteger('HasStruct', itU8, wbEnum(['False', 'True']))
            ,wbUnion('UnknownRA00A', QuestRuntimeHasStructDecider, [
               wbNull
              ,wbStruct('UnknownRA00A001', [
                 wbInteger('Unknown', itU32)
                ,wbInteger('Unknown', itU32)
                ,wbArray('UnknownRA00A001A008', wbStruct('UnknownRA00A001A008S', [
                   wbInteger('Type', itU32)
                  ,wbUnion('UnknownRA001A008S004', QuestRuntimeTypeDecider, [
                    wbNull,
                    wbRefID('TESObjectREFR'),
                    wbRefID('RefID'),
                    wbRefID('Location'),
                    wbInteger('Unknown', itU32),
                    wbRefID('Keyword')
                   ])
                 ]), -1)
              ])
            ])
           ])
         ])
        ,wbUnion('Quest Instance Data', ChangedFlag27Decider, [
           wbNull
          ,wbStruct('Instance Data', [  // Multiple of 7 , no obvious array no obvious list
             wbInteger('Unknown', itU32)
            ,wbInteger('Instance Count', itU6to30)
            ,wbArray('Instances', wbStruct('Instance', [
               wbInteger('Unknown', itU32)
              ,wbInteger('Instance UnknownIA008S Count', itU6to30)
              ,wbArray('Instance UnknownA008', wbStruct('Instance UnknownA008S', [
                 wbInteger('Unknown', itU32),
                 wbRefID('RefID')
               ]), InstanceUnknownIA008SCounter)
              ,wbInteger('Instance Global Count', itU6to30)
              ,wbArray('Instance Globals', wbStruct('Instance Global', [
                 wbRefID('Global'),
                 wbFloat('Value')
               ]), InstanceGlobalCounter)
              ,wbInteger('Unknown', itU16)
              ,wbInteger('Unknown', itU8)
            ]), InstanceCounter)
           ])
         ])
        ,wbUnion('Quest Already Run', ChangedFlag26Decider, [wbNull, wbInteger('Already Run', itU8, wbEnum(['False', 'True']))])
      ])
      ,wbStruct('Change NPC_ Data', [
         wbUnion('Base Data', ChangedFlag01Decider, [wbNull, wbByteArray('Change NPC_ Base Data', 24)])
        ,wbUnion('Factions', ChangedFlag06Decider, [wbNull, wbStruct('Change NPC_ Factions', [
           wbInteger('Factions Length', itU8)
          ,wbArray('Factions and Ranks', wbStruct('Faction and Rank', [
              wbInteger('Faction', itU24, wbRefID)
             ,wbInteger('Rank', itU8)
          ]), DivByteBy4Counter)
        ])])
        ,wbUnion('AI Data', ChangedFlag03Decider, [wbNull, wbByteArray('Change NPC_ AI Data', 20)])
        ,wbUnion('Skills', ChangedFlag09Decider, [wbNull, wbArray('Change NPC_ Skills', wbInteger('Skill', itU8), 52)])
        ,wbUnion('Spell List', ChangedFlag04Decider, [wbNull, wbByteArray('Change NPC_ Spell List', 18)])
        ,wbUnion('Name', ChangedFlag05Decider, [wbNull, wbByteArray('Change NPC_ Full Name', 5)])
        ,wbUnion('Race', ChangedFlag25Decider, [wbNull, wbStruct('Change NPC_ Race', [
          wbInteger('New', itU24, wbRefID),
          wbInteger('Old', itU24, wbRefID)
        ])])
        ,wbUnion('Face', ChangedFlag11Decider, [wbNull, wbByteArray('Change NPC_ Face', 134)])
        ,wbUnion('Outfit', ChangedFlag12Decider, [wbNull, wbRefID('Change NPC_ Outfit')])
        ,wbUnion('Gender', ChangedFlag24Decider, [wbNull, wbInteger('Change NPC_ Gender', itU8)])
      ])
      ,wbStruct('Change Quest Node Data', [])
    ]),
    wbByteArray('Undecoded Data', ChangedFormRemainingDataCounter)
  ]);

  wbChangedForm := wbStruct('Changed Form', [
    wbRefID('RefID'),
    wbChangeFlags,
    wbInteger('Type', itU8, wbChangeTypes),
    wbInteger('Version', itU8),
    wbUnion('Datas', ChangedFormDataLengthDecider, [
      wbStruct('CForm Data', [
        wbInteger('Length', itU8),
        wbInteger('Uncompressed Length', itU8),   // added post save game version 50
        wbStructZ('Small Struct', ChangedFormDataSizer, [ wbChangedFormData ])
      ]),
      wbStruct('CForm Data', [
        wbInteger('Length', itU16),
        wbInteger('Uncompressed Length', itU16),
        wbStructZ('Medium Struct', ChangedFormDataSizer, [ wbChangedFormData ])
      ]),
      wbStruct('CForm Data', [
        wbInteger('Length', itU32),
        wbInteger('Uncompressed Length', itU32),
        wbStructZ('Large Struct', ChangedFormDataSizer, [ wbChangedFormData ])
      ]),
      wbUnknown() // If the type is invalid
    ])
  ]);

  wbHeader := wbStruct('Header', [
    wbInteger('Version', itU32),
    wbInteger('Save Number', itU32),
    wbLenString('Player Name', 2),
    wbInteger('Player Level', itU32),
    wbLenString('Save Cell', 2),
    wbLenString('Save Date', 2),
    wbLenString('Player Race Editor ID', 2),
    wbInteger('Player Sex', itU16, wbSexEnum),
    wbFloat('Player Current Experience'),
    wbFloat('Player LevelUp Experience'),
    wbStruct('Save Time', [
      wbInteger('Year', itU8),
      wbInteger('Month', itU8),
      wbInteger('Day Of Week', itU8),
      wbInteger('Day', itU8),
      wbInteger('Hour', itU8),
      wbInteger('Minute', itU8),
      wbInteger('Second', itU8),
      wbInteger('Millisecond', itU8)
    ]),
    wbInteger('Screenshot Width', itU32),
    wbInteger('Screenshot Height', itU32)
  ]);

  wbFileLocationTable := wbStruct('File Location Table', [
    wbInteger('RefID Array Count Offset', itU32),
    wbInteger('Unknown Table Offset', itU32),
    wbInteger('Global Data Table 1 Offset', itU32),
    wbInteger('Global Data Table 2 Offset', itU32),
    wbInteger('Changed Forms Offset', itU32),
    wbInteger('Global Data Table 3 Offset', itU32),
    wbInteger('Global Data Table 1 Count', itU32),
    wbInteger('Global Data Table 2 Count', itU32),
    wbInteger('Global Data Table 3 Count', itU32),
    wbInteger('Changed Forms Count', itU32),
    wbByteArray('Unused', 15 * 4)
  ]);

  SaveFileHeader := wbStruct('Save File Header', [
     wbString('Magic', 13)
    ,wbInteger('Header Size', itU32)
    ,wbHeader
    ,wbByteArray('Hidden: Screenshot Data', ScreenShotDataCounter)
    ,wbInteger('Form Version', itU8)
    ,wbInteger('PluginInfo Size', itU32)
    ,wbArray('Plugins', wbLenString('PluginName', 2), -4)
    ,wbFileLocationTable
  ]);

  SaveFileChapters := wbStruct('Save File Chapters', [
     wbArray('Global Data 1', wbGlobalData, [], GlobalData1Counter)
    ,wbArray('Global Data 2', wbGlobalData, [], GlobalData2Counter)
    ,wbArray('Changed Forms', wbChangedForm, [], ChangedFormsCounter)
    ,wbArray('Global Data 3', wbGlobalData, [], GlobalData3Counter)
    ,wbArray('FormIDs', wbFormID('FormID', cpFormID), -1, RefIDTableAfterLoad)
    ,wbArray('Visited Worldspace', wbFormID('FormID', cpFormID), -1, WorldspaceTableAfterLoad)
    ,wbInteger('Unknown Table Size', itU32)
    ,wbArray('Unknown Table', wbLenString('Unknown', 2), -1)
//    ,wbByteArray('Unused', SkipCounter) // Lets you skip an arbitrary number of byte, Setable from CommandLine -bts:n
//    ,wbArray('Remaining',  WbByteArray('Unknown', BytesToGroup), DumpCounter) // Lets you dump an arbitrary number of quartet, Setable from CommandLine -btd:n
  ]);
end;

var
  ExtractInfo: TByteSet = [4, 5]; // SaveFileChapters that should be initialized before dumping to get more information

procedure DefineTES5Saves;
begin
  DefineTES5;
  DefineTES5SavesA;
  DefineTES5SavesS;  // s for Saves
  wbExtractInfo := @ExtractInfo;
end;

initialization
end.
