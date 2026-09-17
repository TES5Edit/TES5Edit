{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbDefinitionsTES3;

{$I wbDefines.inc}

interface

uses
  wbInterface;

type
  TwbGameDefTES3 = class(TwbGameDef)
  protected
    procedure Define; override;
  end;

implementation

uses
  System.SysUtils,

  wbDefinitionsCommon,
  wbDefinitionsSignatures,
  wbHelpers;

const
  wbKnownSubRecordSignaturesNoFNAM : TwbKnownSubRecordSignatures = (
    'NAME',
    '____',
    '____',
    '____',
    '____'
  );

  wbKnownSubRecordSignaturesLAND : TwbKnownSubRecordSignatures = (
    '____',
    '____',
    '____',
    'INTV',
    '____'
  );

  wbKnownSubRecordSignaturesREFR : TwbKnownSubRecordSignatures = (
    '____',
    '____',
    'NAME',
    '____',
    '____'
  );

  wbKnownSubRecordSignaturesINFO : TwbKnownSubRecordSignatures = (
    'INAM',
    'NAME',
    '____',
    '____',
    '____'
  );

  wbKnownSubRecordSignaturesINDX : TwbKnownSubRecordSignatures = (
    'INDX',
    'DESC',
    '____',
    '____',
    '____'
  );

  wbKnownSubRecordSignaturesSCPT : TwbKnownSubRecordSignatures = (
    'SCHD',
    '____',
    '____',
    '____',
    '____'
  );

  wbKnownSubRecordSignaturesSSCR : TwbKnownSubRecordSignatures = (
    'DATA',
    'NAME',
    '____',
    '____',
    '____'
  );

function wbCalcPGRCSize(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
  function ExtractCountFromLabel(const aElement: IwbElement; aCount: Integer): Integer;
  begin
    var i := Pos('#', aElement.Name);
    if i = 0 then
      Result := aCount
    else try
      Result := StrToInt(Trim(Copy(aElement.Name, i+1, Length(aElement.Name))))+1;
    except
      Result := aCount;
    end;
  end;
begin
  var Index := ExtractCountFromLabel(aElement, aElement.Container.ElementCount);
  Result := ((aElement.Container.Container as IwbMainRecord).RecordBySignature['PGRP'].Elements[Pred(Index)] as IwbContainer).Elements[2].NativeValue;
end;

procedure wbCELLAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  if aElement.ContextObj.BeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    if (Container.ElementNativeValues['DATA\Flags'] and 1) <> 0 then begin
      if not Assigned(MainRecord.ElementBySignature['WHGT']) then begin
        Container.ElementNativeValues['WHGT'] := Container.ElementNativeValues['INTV'];
        Container.RemoveElement('INTV');
      end;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbDeletedAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  if aElement.ContextObj.BeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    if Assigned(MainRecord.ElementBySignature['DELE']) then
      Container.ElementNativeValues['DELE'] := 0;
  finally
    wbEndInternalEdit;
  end;
end;

function wbEffectAreaDontShow(const aElement: IwbElement): Boolean;
begin
  Result := False;
  case Integer(aElement.Container.ElementNativeValues['Range']) of
    1,2: Result := True;
  end;
  if aElement.ContainingMainRecord.Signature = ALCH then
    Result := True;
end;

function wbEffectAttributeDontShow(const aElement: IwbElement): Boolean;
begin
  Result := True;
  case Integer(aElement.Container.ElementNativeValues['Magic Effect']) of
    17,22,74,79,85: Result := False;
  end;
end;

function wbEffectDurationDontShow(const aElement: IwbElement): Boolean;
begin
  Result := False;
  case Integer(aElement.Container.ElementNativeValues['Magic Effect']) of
    12,13,57,60,61,62,63,69,70,71,72,73,133: Result := True;
  end;
end;

function wbEffectSkillDontShow(const aElement: IwbElement): Boolean;
begin
  Result := True;
  case Integer(aElement.Container.ElementNativeValues['Magic Effect']) of
    21,26,78,83,89: Result := False;
  end;
end;

procedure wbEffectRangeAfterLoad(const aElement: IwbElement);
var
  Container: IwbContainer;
begin
  if aElement.ContextObj.BeginInternalEdit then try
    if not Supports (aElement, IwbContainer, Container) then
      Exit;

    if Container.ElementEditValues['Range'] = '0' then
      Container.ElementNativeValues['Range'] := 1;

  finally
    wbEndInternalEdit;
  end;
end;

procedure wbEffectRangeAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  aElement.Container.ElementByName['Range'].SetToDefault;
end;

function wbConditionFunctionDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container : IwbContainer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  case Integer(Container.ElementNativeValues['Type']) of
    50,51,67: Result := 1;
    52: Result := 2;
    53: Result := 3;
    54: Result := 4;
    55: Result := 5;
    56: Result := 6;
    57: Result := 7;
    65: Result := 8;
    66: Result := 9;
  end;
end;

function wbEffectRangeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container  : IwbContainer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  case Integer(Container.ElementNativeValues['Magic Effect']) of
    12,13,44,49,50,51,52,53,54,55,56,58,85,86,87,88,89,101,118,119,126: Result :=1;
  end;
end;

function wbEffectRangeDontShow(const aElement: IwbElement): Boolean;
begin
  Result := False;
  case Integer(aElement.Container.ElementNativeValues['Magic Effect']) of
    59,60,61,62,63,64,65,66,102,103,104,105,106,107,108,109,110,111,112,113,
    114,115,116,120,121,122,123,124,125,127,128,129,130,131,132,133,134,135,
    137,138,139,140,141,142: Result := True;
  end;
  if aElement.ContainingMainRecord.Signature = ALCH then
    Result := True;
end;

function wbEffectMagnitudeDontShow(const aElement: IwbElement): Boolean;
begin
  Result := False;
  case Integer(aElement.Container.ElementNativeValues['Magic Effect']) of
    0,2,39,45,46,58,60,61,62,63,69,70,71,72,73,102,103,104,105,106,107,108,
    109,110,111,112,113,114,115,116,120,121,122,123,124,125,126,127,128,129,
    130,131,132,133,134,136,137,138,139,140,141,142: Result := True;
  end;
end;

procedure wbFactionReactionToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  var Faction := Container.Elements[0];
  var Reaction := Container.Elements[1].NativeValue;
  aValue := IntToStr(Reaction) + ' ' + Faction.Value;
  if Reaction >= 0 then
    aValue := '+' + aValue;
end;

procedure wbForwardForReal(const aElement: IwbElement);
var
  Container : IwbContainer;
  Element   : IwbElement;
begin
  if aElement.ContextObj.BeginInternalEdit then try
    if Length(aElement.Value) > 0 then begin
      Container := aElement.Container;
      Element := Container.ElementbyName['Target'];
      if not Assigned(Element) then
        Element := Container.ElementbyName['Sound'];
        if not Assigned(Element) then
          Exit;

        var i := 1;
        while i <= Length(aElement.Value) do begin
          if aElement.Value[i] = AnsiChar(#0) then
            Break;
          Inc(i);
        end;
        var s := Copy(aElement.Value, 0, i);
        Element.NativeValue := s;
     end;
  finally
    wbEndInternalEdit;
  end;
end;

function wbFRMRToString(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  if aType in [ctToStr, ctToSummary, ctToSortKey, ctToEditValue] then begin
    Result := IntToHex(aInt, 8);
    if aType = ctToEditValue then
      Result := '$' + Result;
  end;
end;

procedure wbGlobalAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  if aElement.ContextObj.BeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    if Assigned(MainRecord.ElementBySignature['FLTV']) then
      if MainRecord.ElementBySignature['FNAM'].Value = 'Short' then //Only occurs on shorts.
        if (MainRecord.ElementBySignature['FLTV'].NativeValue = Single(-92233720368547758.1)) or
           (MainRecord.ElementBySignature['FLTV'].NativeValue = 0.04) or
           (MainRecord.ElementBySignature['FLTV'].Value = 'NaN') then
          Container.ElementNativeValues['FLTV'] := 0; //All errors are zero in the CS.
  finally
    wbEndInternalEdit;
  end;
end;

function wbGridCellToFormID(aFormIDBase: Byte; const aGridCell: TwbGridCell; out aFormID: TwbFormID): Boolean;
begin
  Result := False;
  with aGridCell do begin
    if (x < -512) or (x > 511) or (y < -512) or (y > 511) then
      Exit;
    aFormID := TwbFormID.FromCardinal((Cardinal(x + 512) shl 10) + Cardinal(y + 512) + (Cardinal(aFormIDBase) shl 16));
    Result := True;
  end;
end;

procedure wbIngredientAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  if aElement.ContextObj.BeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    var i : integer;
    for i := 0 to 3 do begin
      case Container.ElementNativeValues['IRDT\Effects\Magic Effects\Magic Effect #' + IntToStr(i)] of
        17, 22, 74, 79: Container.ElementNativeValues['IRDT\Effects\Skills\Skill #' + IntToStr(i)] := -1;
        21, 26, 78, 83: Container.ElementNativeValues['IRDT\Effects\Attributes\Attribute #' + IntToStr(i)] := -1;
      else
        Container.ElementNativeValues['IRDT\Effects\Skills\Skill #' + IntToStr(i)] := -1;
        Container.ElementNativeValues['IRDT\Effects\Attributes\Attribute #' + IntToStr(i)] := -1;
      end;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

function wbNPCDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;
  if Assigned(aElement) then
    if aElement.DataSize = 12 then
      Result := 1;
end;

function wbSkillDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container : IwbContainer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  Container := Container.Container;
  if not Assigned(Container) then
    Exit;

  var INDX := Container.ElementBySignature['INDX'];
  if not Assigned(INDX) then
    Exit;

  var i := INDX.NativeValue;
  case i of
    1: Result := 1;
    2,3,17,21: Result := 2;
    4,5,6,7,22,23,26: Result := 3;
    8: Result := 4;
    9: Result := 5;
    10,11,12,13,14,15: Result := 6;
    16: Result := 7;
    18: Result := 8;
    19: Result := 9;
    20: Result := 10;
    24: Result := 11;
    25: Result := 12;
  end;
end;

procedure wbTES3AfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  if aElement.ContextObj.BeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

      if Assigned(MainRecord.ElementBySignature['HEDR']) then
        if (Container.ElementNativeValues['HEDR\Record Flags'] and 1) = 1 then
          MainRecord.SetIsESM(True);
  finally
    wbEndInternalEdit;
  end;
end;

function wbAttributeEnum: IwbEnumDef;
begin
  Result :=
    wbEnum([
    {0} 'Strength',
    {1} 'Intelligence',
    {2} 'Willpower',
    {3} 'Agility',
    {4} 'Speed',
    {5} 'Endurance',
    {6} 'Personality',
    {7} 'Luck'
    ], [
    -1, 'None'
    ]);
end;

function wbDialogTypeEnum: IwbEnumDef;
begin
  Result :=
    wbEnum([
    {0} 'Regular Topic',
    {1} 'Voice',
    {2} 'Greeting',
    {3} 'Persuasion',
    {4} 'Journal'
    ]);
end;

function wbMagicEffectEnum: IwbEnumDef;
begin
  Result :=
    wbEnum([
    {0}   'Water Breathing',
    {1}   'Swift Swim',
    {2}   'Water Walking',
    {3}   'Shield',
    {4}   'Fire Shield',
    {5}   'Lightning Shield',
    {6}   'Frost Shield',
    {7}   'Burden',
    {8}   'Feather',
    {9}   'Jump',
    {10}  'Levitate',
    {11}  'Slow Fall',
    {12}  'Lock',
    {13}  'Open',
    {14}  'Fire Damage',
    {15}  'Shock Damage',
    {16}  'Frost Damage',
    {17}  'Drain Attribute',
    {18}  'Drain Health',
    {19}  'Drain Magicka',
    {20}  'Drain Fatigue',
    {21}  'Drain Skill',
    {22}  'Damage Attribute',
    {23}  'Damage Health',
    {24}  'Damage Magicka',
    {25}  'Damage Fatigue',
    {26}  'Damage Skill',
    {27}  'Poison',
    {28}  'Weakness To Fire',
    {29}  'Weakness To Frost',
    {30}  'Weakness To Shock',
    {31}  'Weakness To Magicka',
    {32}  'Weakness To Common Disease',
    {33}  'Weakness To Blight Disease',
    {34}  'Weakness To Corprus Disease',
    {35}  'Weakness To Poison',
    {36}  'Weakness To Normal Weapons',
    {37}  'Disintegrate Weapon',
    {38}  'Disintegrate Armor',
    {39}  'Invisibility',
    {40}  'Chameleon',
    {41}  'Light',
    {42}  'Sanctuary',
    {43}  'Night Eye',
    {44}  'Charm',
    {45}  'Paralyze',
    {46}  'Silence',
    {47}  'Blind',
    {48}  'Sound',
    {49}  'Calm Humanoid',
    {50}  'Calm Creature',
    {51}  'Frenzy Humanoid',
    {52}  'Frenzy Creature',
    {53}  'Demoralize Humanoid',
    {54}  'Demoralize Creature',
    {55}  'Rally Humanoid',
    {56}  'Rally Creature',
    {57}  'Dispel',
    {58}  'Soultrap',
    {59}  'Telekinesis',
    {60}  'Mark',
    {61}  'Recall',
    {62}  'Divine Intervention',
    {63}  'Almsivi Intervention',
    {64}  'Detect Animal',
    {65}  'Detect Enchantment',
    {66}  'Detect Key',
    {67}  'Spell Absorption',
    {68}  'Reflect',
    {69}  'Cure Common Disease',
    {70}  'Cure Blight Disease',
    {71}  'Cure Corprus Disease',
    {72}  'Cure Poison',
    {73}  'Cure Paralyzation',
    {74}  'Restore Attribute',
    {75}  'Restore Health',
    {76}  'Restore Magicka',
    {77}  'Restore Fatigue',
    {78}  'Restore Skill',
    {79}  'Fortify Attribute',
    {80}  'Fortify Health',
    {81}  'Fortify Magicka',
    {82}  'Fortify Fatigue',
    {83}  'Fortify Skill',
    {84}  'Fortify Maximum Magicka',
    {85}  'Absorb Attribute',
    {86}  'Absorb Health',
    {87}  'Absorb Magicka',
    {88}  'Absorb Fatigue',
    {89}  'Absorb Skill',
    {90}  'Resist Fire',
    {91}  'Resist Frost',
    {92}  'Resist Shock',
    {93}  'Resist Magicka',
    {94}  'Resist Common Disease',
    {95}  'Resist Blight Disease',
    {96}  'Resist Corprus Disease',
    {97}  'Resist Poison',
    {98}  'Resist Normal Weapons',
    {99}  'Resist Paralysis',
    {100} 'Remove Curse',
    {101} 'Turn Undead',
    {102} 'Summon Scamp',
    {103} 'Summon Clannfear',
    {104} 'Summon Daedroth',
    {105} 'Summon Dremora',
    {106} 'Summon Ancestral Ghost',
    {107} 'Summon Skeletal Minion',
    {108} 'Summon Bonewalker',
    {109} 'Summon Greater Bonewalker',
    {110} 'Summon Bonelord',
    {111} 'Summon Winged Twilight',
    {112} 'Summon Hunger',
    {113} 'Summon Golden Saint',
    {114} 'Summon Flame Atronach',
    {115} 'Summon Frost Atronach',
    {116} 'Summon Storm Atronach',
    {117} 'Fortify Attack',
    {118} 'Command Creature',
    {119} 'Command Humanoid',
    {120} 'Bound Dagger',
    {121} 'Bound Longsword',
    {122} 'Bound Mace',
    {123} 'Bound Battle Axe',
    {124} 'Bound Spear',
    {125} 'Bound Longbow',
    {126} 'EXTRA SPELL',
    {127} 'Bound Cuirass',
    {128} 'Bound Helm',
    {129} 'Bound Boots',
    {130} 'Bound Shield',
    {131} 'Bound Gloves',
    {132} 'Corpus',
    {133} 'Vampirism',
    {134} 'Summon Centurion Sphere',
    {135} 'Sun Damage',
    {136} 'Stunted Magicka',
    {137} 'Summon Fabricant',
    {138} 'sEffectSummonCreature01',
    {139} 'sEffectSummonCreature02',
    {140} 'sEffectSummonCreature03',
    {141} 'sEffectSummonCreature04',
    {142} 'sEffectSummonCreature05'
    ], [
    -1, 'None'
    ]);
end;

function wbSkillEnum: IwbEnumDef;
begin
  Result :=
    wbEnum([
    {0}  'Block',
    {1}  'Armorer',
    {2}  'Medium Armor',
    {3}  'Heavy Armor',
    {4}  'Blunt Weapon',
    {5}  'Long Blade',
    {6}  'Axe',
    {7}  'Spear',
    {8}  'Athletics',
    {9}  'Enchant',
    {10} 'Destruction',
    {11} 'Alteration',
    {12} 'Illusion',
    {13} 'Conjuration',
    {14} 'Mysticism',
    {15} 'Restoration',
    {16} 'Alchemy',
    {17} 'Unarmored',
    {18} 'Security',
    {19} 'Sneak',
    {20} 'Acrobatics',
    {21} 'Light Armor',
    {22} 'Short Blade',
    {23} 'Marksman',
    {24} 'Mercantile',
    {25} 'Speechcraft',
    {26} 'Hand-To-Hand'
    ], [
    -1, 'None'
    ]);
end;

function wbSpecializationEnum: IwbEnumDef;
begin
  Result :=
    wbEnum([
    {0} 'Combat',
    {1} 'Magic',
    {2} 'Stealth'
    ]);
end;


function wbLeveledFlags: IwbFlagsDef;
begin
  Result :=
    wbFlags([
    {0} 'Calculate from all levels <= player''s level',
    {1} 'Calculate for each item in count'
    ]);
end;


function wbAIData(const aGameDef: TwbGameDef): IwbRecordMemberDef;
begin
  Result :=
    wbStruct(AIDT, 'AI Data', [
      wbInteger('Hello', itU16).SetDefaultNativeValue(30),
      wbInteger('Fight', itU8).SetDefaultNativeValue(30),
      wbInteger('Flee', itU8).SetDefaultNativeValue(30),
      wbInteger('Alarm', itU8),
      wbUnused(3),
      wbInteger('Service Flags', itU32, wbServiceFlags(aGameDef)).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ]).SetRequired;
end;

function wbBipedObjects: IwbRecordMemberDef;
begin
  Result :=
    wbRArray('Biped Objects',
      wbRStruct('Biped Object', [
        wbInteger(INDX, 'Body Part', itU8,
          wbEnum ([
          {0}  'Head',
          {1}  'Hair',
          {2}  'Neck',
          {3}  'Chest',
          {4}  'Groin',
          {5}  'Skirt',
          {6}  'Right Hand',
          {7}  'Left Hand',
          {8}  'Right Wrist',
          {9}  'Left Wrist',
          {10} 'Shield',
          {11} 'Right Forearm',
          {12} 'Left Forearm',
          {13} 'Right Upper Arm',
          {14} 'Left Upper Arm',
          {15} 'Right Foot',
          {16} 'Left Foot',
          {17} 'Right Ankle',
          {18} 'Left Ankle',
          {19} 'Right Knee',
          {20} 'Left Knee',
          {21} 'Right Upper Leg',
          {22} 'Left Upper Leg',
          {23} 'Right Pauldron',
          {24} 'Left Pauldron',
          {25} 'Weapon',
          {26} 'Tail'
          ])),
        wbString(BNAM, 'Male'), //[BODY]
        wbString(CNAM, 'Female') //[BODY]
      ]).SetSummaryKey([0,1,2])
        .SetSummaryMemberPrefixSuffix(0, 'Part: ', ',')
        .SetSummaryMemberPrefixSuffix(1, 'Male: ', ',')
        .SetSummaryMemberPrefixSuffix(2, 'Female: ', ',')
        .IncludeFlag(dfSummaryMembersNoName)
        .IncludeFlag(dfSummaryNoSortKey)
        .IncludeFlag(dfCollapsed, wbCollapseBodyParts));
end;

function wbDeleted: IwbRecordMemberDef;
begin
  Result := wbInteger(DELE, 'Deleted', itU32, wbEnum(['True']));
end;

function wbDescription: IwbRecordMemberDef;
begin
  Result := wbString(DESC, 'Description');
end;

function wbEditorID: IwbRecordMemberDef;
begin
  Result :=
    wbString(NAME, 'Editor ID')
      .SetRequired
      .IncludeFlag(dfSummarySelfAsShortName);
end;

function wbEffects: IwbRecordMemberDef;
begin
  Result :=
    wbRArray('Effects',
      wbStructSK(ENAM, [0], 'Effect', [
        wbInteger('Magic Effect', itS16, wbMagicEffectEnum)
          .SetAfterSet(wbEffectRangeAfterSet)
          .SetDefaultNativeValue(-1),
        wbInteger('Skill', itS8, wbSkillEnum)
          .SetDefaultNativeValue(-1)
          .SetDontShow(wbEffectSkillDontShow),
        wbInteger('Attribute', itS8, wbAttributeEnum)
          .SetDefaultNativeValue(-1)
          .SetDontShow(wbEffectAttributeDontShow),
        wbUnion('Range', wbEffectRangeDecider, [
          wbInteger('Range', itU32,
            wbEnum([
            {0} 'Self',
            {1} 'Touch',
            {2} 'Target'
            ])),
          wbInteger('Range', itU32,
            wbEnum([], [
            1, 'Touch',
            2, 'Target'
            ])).SetDefaultNativeValue(1)
          ]).SetDontShow(wbEffectRangeDontShow),
        wbInteger('Area', itU32).SetDontShow(wbEffectAreaDontShow),
        wbInteger('Duration', itU32).SetDontShow(wbEffectDurationDontShow),
        wbInteger('Magnitude Minimum', itU32).SetDontShow(wbEffectMagnitudeDontShow),
        wbInteger('Magnitude Maximum', itU32).SetDontShow(wbEffectMagnitudeDontShow)
      ]).SetSummaryKeyOnValue([0,3,1,2])
        .SetSummaryPrefixSuffixOnValue(0, 'Effect: ', ',')
        .SetSummaryPrefixSuffixOnValue(3, 'Range: ', ',')
        .SetSummaryPrefixSuffixOnValue(1, 'Skill: ', ',')
        .SetSummaryPrefixSuffixOnValue(2, 'Attribute: ', '')
        .SetAfterLoad(wbEffectRangeAfterLoad)
        .IncludeFlag(dfSummaryMembersNoName)
        .IncludeFlag(dfSummaryNoSortKey));
end;

function wbEnchantment(const aGameDef: TwbGameDef): IwbRecordMemberDef;
begin
  Result := wbString(ENAM, 'Enchantment');
end;

function wbFullName: IwbRecordMemberDef;
begin
  Result := wbString(FNAM, 'Name');
end;

function wbIcon: IwbRecordMemberDef;
begin
  Result := wbString(ITEX, 'Icon Filename');
end;

function wbInventory: IwbRecordMemberDef;
begin
  Result :=
    wbRArray('Inventory',
      wbStruct(NPCO, 'Item Entry', [
        wbInteger('Count', itU32),
        wbString('Item', 32) //[ALCH, APPA, ARMO, BOOK, CLOT, INGR, LEVI, LIGH, LOCK, MISC, PROB, REPA, WEAP]
      ]).SetSummaryKeyOnValue([1,0])
        .SetSummaryPrefixSuffixOnValue(0, 'x', '}')
        .SetSummaryPrefixSuffixOnValue(1, '{', '')
        .IncludeFlag(dfCollapsed, wbCollapseItems));
end;

function wbModel: IwbRecordMemberDef;
begin
  Result := wbString(MODL, 'Model').SetDefaultEditValue('Add Art File');
end;

function wbPackages: IwbRecordMemberDef;
begin
  Result :=
    wbRArray('Packages',
      wbRUnion('Packages', [
        wbStruct(AI_W, 'Wander', [
          wbInteger('Distance', itU16).SetDefaultNativeValue(512),
          wbInteger('Duration In Hours', itU16).SetDefaultNativeValue(5),
          wbInteger('Time of Day', itU8),
          wbStruct('Idle Chances', [
            wbInteger('Idle 2', itU8).SetDefaultNativeValue(60),
            wbInteger('Idle 3', itU8).SetDefaultNativeValue(20),
            wbInteger('Idle 4', itU8).SetDefaultNativeValue(10),
            wbInteger('Idle 5', itU8),
            wbInteger('Idle 6', itU8),
            wbInteger('Idle 7', itU8),
            wbInteger('Idle 8', itU8),
            wbInteger('Idle 9', itU8)
          ]),
          wbInteger('Reset', itU8, wbBoolEnum).SetDefaultNativeValue(1)
        ]).SetRequired,
        wbStruct(AI_T, 'Travel', [
          wbVec3('Position'),
          wbInteger('Reset', itU8, wbBoolEnum).SetDefaultNativeValue(1),
          wbUnused(3)
        ]),
        wbRStruct('Follow', [
          wbStruct(AI_F, 'Follow', [
            wbVec3('Position'),
            wbInteger('Duration In Hours', itU16),
            wbStringForward('Target', 32).SetAfterLoad(wbForwardForReal), //[CREA, NPC_]
            wbInteger('Reset', itU16, wbBoolEnum).SetDefaultNativeValue(1)
          ]).SetRequired,
          wbString(CNDT, 'Follow To Cell') //[CELL]
        ]),
        wbRStruct('Escort', [
          wbStruct(AI_E, 'Escort', [
            wbVec3('Position'),
            wbInteger('Duration In Hours', itU16),
            wbStringForward('Target', 32).SetAfterLoad(wbForwardForReal), //[CREA, NPC_]
            wbInteger('Reset', itU16, wbBoolEnum).SetDefaultNativeValue(1)
          ]).SetRequired,
          wbString(CNDT, 'Escort To Cell') //[CELL]
        ]),
        wbStruct(AI_A, 'Activate', [
          wbStringForward('Target', 32).SetAfterLoad(wbForwardForReal), //[ACTI, ALCH, APPA, ARMO, BODY, BOOK, CLOT, CONT, CREA, DOOR, ENCH, INGR, LIGH, LEVC, LEVI, LOCK, MISC, NPC_, PROB, REPA, SPEL, STAT, WEAP]
          wbInteger('Reset', itU8, wbBoolEnum).SetDefaultNativeValue(1)
        ])
      ]));
end;

function wbScript: IwbRecordMemberDef;
begin
  Result := wbString(SCRI, 'Script');
end;

function wbSpells: IwbRecordMemberDef;
begin
  Result :=
    wbRArrayS('Spells',
      wbString(NPCS, 'Spell', 32) //[SPEL]
    );
end;

function wbTravelServices: IwbRecordMemberDef;
begin
  Result :=
    wbRArray('Travel Services',
      wbRStruct('Travel Service', [
        wbVec3PosRot(DODT, 'Destination').SetRequired,
        wbStringForward(DNAM, 'Cell', 64)
      ]));
end;


procedure TwbGameDefTES3.Define;
begin
  HeaderSignature := 'TES3';

  RecordFlags :=
    wbInteger('Record Flags', itU32,
      wbFlags([
      {0} 'ESM'
      ]));

  MainRecordHeader := wbStruct('Record Header', [
    wbString('Signature', 4, cpCritical),
    wbInteger('Data Size', itU32, nil, cpIgnore),
    wbByteArray('Version Control Info', 4, cpIgnore).SetToStr(wbVCI1ToStrBeforeFO4),
    RecordFlags
  ]);

  SizeOfMainRecordStruct := 16;

  KnownSubRecordSignatures[ksrEditorID] := 'NAME';
  KnownSubRecordSignatures[ksrFullName] := 'FNAM';
  KnownSubRecordSignatures[ksrBaseRecord] := '____';
  KnownSubRecordSignatures[ksrGridCell] := 'DATA';

  {>>> Records <<<}

  RegisterRecordDef(TES3, 'Main File Header', [
    wbStruct(HEDR, 'Header', [
      wbFloat('Version', cpNormal, False, 1, 2).IncludeFlag(dfInternalEditOnly, not wbAllowEditHEDRVersion),
      RecordFlags,
      wbString('Author', 32),
      wbString('Description', 256),
      wbInteger('Number of Records', itU32)
    ]).SetRequired,
    wbRArray('Master Files',
      wbRStruct('Master File', [
        wbStringForward(MAST, 'Filename').SetRequired,
        wbInteger(DATA, 'Master Size', itU64, nil, cpIgnore, True)
    ])).IncludeFlag(dfInternalEditOnly, not wbAllowMasterFilesEdit)
  ], cpNormal, True)
    .SetGetFormIDCallback(function(const aMainRecord: IwbMainRecord; out aFormID: TwbFormID): Boolean begin
       Result := True;
       aFormID := TwbFormID.Null;
     end)
     .SetAfterLoad(wbTES3AfterLoad);

  RegisterRecordDef(ACTI, 'Activator',
    wbFlags(wbFlagsList([
    10, 'References Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel.SetRequired,
    wbFullName.SetRequired,
    wbScript //[SCPT]
  ]).SetFormIDBase($40);

  RegisterRecordDef(ALCH, 'Alchemy',
    wbFlags(wbFlagsList([
    10, 'References Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel,
    wbString(TEXT, 'Icon Filename'),
    wbScript, //[SCPT]
    wbFullName,
    wbStruct(ALDT, 'Data', [
      wbFloat('Weight', cpNormal, False, 1, 2),
      wbInteger('Potion Value', itU32),
      wbInteger('Auto Calculate Value', itU32, wbBoolEnum).SetDefaultNativeValue(1)
    ]).SetRequired,
    wbEffects
  ]).SetFormIDBase($40);

  RegisterRecordDef(APPA, 'Apparatus',
    wbFlags(wbFlagsList([
    10, 'References Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel.SetRequired,
    wbFullName.SetRequired,
    wbScript, //[SCPT]
    wbStruct(AADT, 'Data', [
      wbInteger('Type', itU32,
        wbEnum([
        {0} 'Mortar & Pestle',
        {1} 'Alembic',
        {2} 'Calcinator',
        {3} 'Retort'
        ])).SetDefaultNativeValue(1),
      wbFloat('Quality', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbFloat('Weight', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbInteger('Value', itU32).SetDefaultNativeValue(1)
    ]).SetRequired,
    wbIcon
  ]).SetFormIDBase($40);

  RegisterRecordDef(ARMO, 'Armor',
    wbFlags(wbFlagsList([
    10, 'References Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel.SetRequired,
    wbFullName.SetRequired,
    wbScript, //[SCPT]
    wbStruct(AODT, 'Data', [
      wbInteger('Type', itU32,
        wbEnum([
        {0}  'Helmet',
        {1}  'Cuirass',
        {2}  'Left Pauldron',
        {3}  'Right Pauldron',
        {4}  'Greaves',
        {5}  'Boots',
        {6}  'Left Gauntlet',
        {7}  'Right Gauntlet',
        {8}  'Shield',
        {9}  'Left Bracer',
        {10} 'Right Bracer'
        ])).SetDefaultNativeValue(5),
      wbFloat('Weight', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbInteger('Value', itU32).SetDefaultNativeValue(1),
      wbInteger('Health', itU32).SetDefaultNativeValue(100),
      wbInteger('Enchanting Charge', itU32).SetDefaultNativeValue(100),
      wbInteger('Armor Rating', itU32).SetDefaultNativeValue(1)
    ]).SetRequired,
    wbIcon,
    wbBipedObjects,
    wbEnchantment(Self) //[ENCH]
  ]).SetFormIDBase($40);

  RegisterRecordDef(BODY, 'Body Part', @wbKnownSubRecordSignaturesNoFNAM,
    wbFlags(wbFlagsList([
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel.SetRequired,
    wbString(FNAM, 'Skin Race')  //[RACE]
      .SetDefaultNativeValue('Argonian')
      .SetRequired,
    wbStruct(BYDT, 'Data', [
      wbInteger('Body Part', itU8,
        wbEnum([
        {0}  'Head',
        {1}  'Hair',
        {2}  'Neck',
        {3}  'Chest',
        {4}  'Groin',
        {5}  'Hand',
        {6}  'Wrist',
        {7}  'Forearm',
        {8}  'Upperarm',
        {9}  'Foot',
        {10} 'Ankle',
        {11} 'Knee',
        {12} 'Upperleg',
        {13} 'Clavicle',
        {14} 'Tail'
        ])).SetDefaultNativeValue(10),
      wbInteger('Skin Type', itU8,
        wbEnum([
        {0} 'Normal',
        {1} 'Vampire'
        ])),
      wbInteger('Flags', itU8,
        wbFlags([
        {0} 'Female',
        {1} 'Not Playable'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Part Type', itU8,
        wbEnum([
        {0} 'Skin',
        {1} 'Clothing',
        {2} 'Armor'
        ]))
    ]).SetRequired
  ]).SetFormIDBase($20)
    .SetSummaryKey([2]);

  RegisterRecordDef(BOOK, 'Book',
    wbFlags(wbFlagsList([
    10, 'References Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel.SetRequired,
    wbFullName,
    wbStruct(BKDT, 'Book Data', [
      wbFloat('Weight', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbInteger('Value', itU32).SetDefaultNativeValue(1),
      wbInteger('Is Scroll', itU32, wbBoolEnum),
      wbInteger('Teaches', itS32, wbSkillEnum).SetDefaultNativeValue(-1), //[SKIL]
      wbInteger('Enchantment Charge', itU32).SetDefaultNativeValue(100)
    ]).SetRequired,
    wbScript, //[SCPT]
    wbIcon,
    wbLStringKC(TEXT, 'Book Text', 0, cpTranslate),
    wbEnchantment(Self) //[ENCH]
  ]).SetFormIDBase($40);

  RegisterRecordDef(BSGN, 'Birthsign', [
    wbDeleted,
    wbEditorID,
    wbFullName,
    wbString(TNAM, 'Constellation Filename'),
    wbDescription,
    wbSpells
  ]).SetFormIDBase($10);

  RegisterRecordDef(CELL, 'Cell', [
    wbString(NAME, 'Location').SetRequired,
    wbDeleted,
    wbStruct(DATA, 'Data', [
      wbInteger('Flags', itU32,
        wbFlags(wbSparseFlags([
        0, 'Is Interior Cell',
        1, 'Has Water',
        2, 'Illegal To Sleep Here',
        6, 'Has Map Color',
        7, 'Behave Like Exterior'
        ], False, 8))).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbStruct('Grid', [
        wbInteger('X', itS32),
        wbInteger('Y', itS32)
      ]).SetSummaryKey([0,1])
        .SetSummaryMemberPrefixSuffix(0, '(', ')')
        .SetSummaryMemberPrefixSuffix(1, '', ')')
        .SetSummaryDelimiter(', ')
        .SetDontShow(wbCellInteriorDontShow)
    ]).SetRequired,
    wbInteger(INTV, 'Water Height', itS32, nil, cpIgnore).SetDontShow(wbCellExteriorDontShow),
    wbString(RGNN, 'Region'),  //[REGN]
    wbByteColors(NAM5, 'Region Map Color').SetDontShow(wbCellInteriorDontShow),
    wbFloat(WHGT, 'Water Height').SetDontShow(wbCellExteriorDontShow),
    wbStruct(AMBI, 'Ambience', [
      wbByteColors('Ambient Color'),
      wbByteColors('Sunlight Color'),
      wbByteColors('Fog Color'),
      wbFloat('Fog Density', cpNormal, False, 1, 2).SetDefaultNativeValue(1)
    ]).SetDontShow(wbCellExteriorDontShow)
  ]).SetFormIDBase($B0)
    .SetGetGridCellCallback(function(const aSubRecord: IwbSubRecord; out aGridCell: TwbGridCell): Boolean begin
      with aGridCell, aSubRecord do begin
        Result := not (ElementNativeValues['Flags\Is Interior Cell'] = True);
        if Result then begin
          X := ElementNativeValues['Grid\X'];
          Y := ElementNativeValues['Grid\Y'];
        end;
      end;
    end)
    .SetGetFormIDCallback(function(const aMainRecord: IwbMainRecord; out aFormID: TwbFormID): Boolean begin
      var GridCell: TwbGridCell;
      Result := aMainRecord.GetGridCell(GridCell) and wbGridCellToFormID($A0, GridCell, aFormID);
    end)
    .SetIdentityCallback(function(const aMainRecord: IwbMainRecord): string begin
      var GridCell: TwbGridCell;
      if aMainRecord.GetGridCell(GridCell) then
        Result := '<Exterior>' + GridCell.SortKey
      else
        Result := aMainRecord.EditorID;
    end)
    .SetAfterLoad(wbCELLAfterLoad);

  RegisterRecordDef(CLAS, 'Class', [
    wbEditorID,
    wbDeleted,
    wbFullName.SetRequired,
    wbStruct(CLDT, 'Data', [
      wbArray('Primary Attributes',
        wbInteger('Attribute', itS32, wbAttributeEnum),
      2),
      wbInteger('Specialization', itU32, wbSpecializationEnum),
      wbArray('Major & Minor Skill Sets',
        wbStruct('Skill Set', [
          wbInteger('Minor Skill', itS32, wbSkillEnum), //[SKIL]
          wbInteger('Major Skill', itS32, wbSkillEnum) //[SKIL]
        ]),
      5),
      wbInteger('Playable', itU32, wbBoolEnum),
      wbInteger('Service Flags', itU32, wbServiceFlags(Self)).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ]).SetRequired,
    wbDescription
  ]).SetFormIDBase($18);

  RegisterRecordDef(CLOT, 'Clothing',
    wbFlags(wbFlagsList([
    10, 'References Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel.SetRequired,
    wbFullName,
    wbStruct(CTDT, 'Data', [
      wbInteger('Type', itU32, wbEnum([
      {0} 'Pants',
      {1} 'Shoes',
      {2} 'Shirt',
      {3} 'Belt',
      {4} 'Robe',
      {5} 'Right Glove',
      {6} 'Left Glove',
      {7} 'Skirt',
      {8} 'Ring',
      {9} 'Amulet'
      ])).SetDefaultNativeValue(9),
      wbFloat('Weight', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbInteger('Value', itU16).SetDefaultNativeValue(1),
      wbInteger('Enchantment Charge', itU16).SetDefaultNativeValue(100)
    ]).SetRequired,
    wbScript, //[SCPT]
    wbIcon,
    wbBipedObjects,
    wbEnchantment(Self) //[ENCH]
  ]).SetFormIDBase($40);

  RegisterRecordDef(CONT, 'Container',
    wbFlags(wbFlagsList([
    10, 'Corpses Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel.SetRequired,
    wbFullName,
    wbFloat(CNDT, 'Weight', cpNormal, False, 1, 2).SetRequired,
    wbInteger(FLAG, 'Flags', itU32,
      wbFlags(wbSparseFlags([
      0, 'Organic',
      1, 'Respawns',
      3, 'Can Hold Items'
      ], False, 4))
    ).SetDefaultNativeValue(4)
     .SetRequired
     .IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbScript, //[SCPT]
    wbInventory
  ]).SetFormIDBase($40);

  RegisterRecordDef(CREA, 'Creature',
    wbFlags(wbFlagsList([
    10, 'Corpses Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel.SetRequired,
    wbString(CNAM, 'Sound Generator Creature'), //[CREA]
    wbFullName,
    wbScript, //[SCPT]
    wbStruct(NPDT, 'Data', [
      wbInteger('Type', itU32,
        wbEnum([
        {0} 'Creature',
        {1} 'Daedra',
        {2} 'Undead',
        {3} 'Humanoid'
        ])),
      wbInteger('Level', itU32).SetDefaultNativeValue(1),
      wbStruct('Attributes', [
        wbInteger('Strength', itU32).SetDefaultNativeValue(50),
        wbInteger('Intelligence', itU32).SetDefaultNativeValue(50),
        wbInteger('Willpower', itU32).SetDefaultNativeValue(50),
        wbInteger('Agility', itU32).SetDefaultNativeValue(50),
        wbInteger('Speed', itU32).SetDefaultNativeValue(50),
        wbInteger('Endurance', itU32).SetDefaultNativeValue(50),
        wbInteger('Personality', itU32).SetDefaultNativeValue(50),
        wbInteger('Luck', itU32).SetDefaultNativeValue(50)
      ]),
      wbInteger('Health', itU32).SetDefaultNativeValue(50),
      wbInteger('Magicka', itU32).SetDefaultNativeValue(50),
      wbInteger('Fatigue', itU32).SetDefaultNativeValue(50),
      wbInteger('Soul', itU32).SetDefaultNativeValue(50),
      wbStruct('Skills', [
        wbInteger('Combat', itU32).SetDefaultNativeValue(50),
        wbInteger('Magic', itU32).SetDefaultNativeValue(50),
        wbInteger('Stealth', itU32).SetDefaultNativeValue(50)
      ]),
      wbArray('Attack Sets',
        wbStruct('Attack Set', [
          wbInteger('Minimum', itS32).SetDefaultNativeValue(1),
          wbInteger('Maximum', itS32).SetDefaultNativeValue(5)
        ]),
      3),
      wbInteger('Barter Gold', itU32)
    ]).SetRequired,
    wbInteger(FLAG, 'Flags', itU32,
      wbFlags(wbSparseFlags([
      0,  'Biped',
      1,  'Respawn',
      2,  'Weapon & Shield',
      3,  'Can Hold Items',
      4,  'Swims',
      5,  'Flies',
      6,  'Walks',
      7,  'Essential',
      10, 'Skeleton Blood',
      11, 'Metal Blood'
      ], False, 12))
    ).SetDefaultNativeValue(48)
     .SetRequired
     .IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbFloat(XSCL, 'Scale', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
    wbInventory,
    wbSpells,
    wbAIData(Self),
    wbTravelServices,
    wbPackages
  ]).SetFormIDBase($40);

  RegisterRecordDef(DIAL, 'Dialog Topic', [
    wbEditorID,
    wbStruct(DATA, 'Data', [
      wbInteger('Dialog Type', itU8, wbDialogTypeEnum),
      wbUnused(3)
    ]).SetRequired,
    wbDeleted
  ]).SetFormIDBase($80)
    .SetSummaryKey([1]);

  RegisterRecordDef(DOOR, 'Door',
    wbFlags(wbFlagsList([
    10, 'References Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel,
    wbFullName,
    wbScript, //[SCPT]
    wbString(SNAM, 'Open Sound'), //[SOUN]
    wbString(ANAM, 'Close Sound') //[SOUN]
  ]).SetFormIDBase($40);

  RegisterRecordDef(ENCH, 'Enchantment',
    wbFlags(wbFlagsList([
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbStruct(ENDT, 'Data', [
      wbInteger('Cast Type', itU32,
        wbEnum([
        {0} 'Cast Once',
        {1} 'Cast Strikes',
        {2} 'Cast When Used',
        {3} 'Constant Effect'
        ])),
      wbInteger('Enchantment Cost', itU32),
      wbInteger('Charge Amount', itU32),
      wbInteger('Flags', itU8,
        wbFlags([
        {0} 'Auto Calculate'
        ], True)).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbUnused(3)
    ]).SetRequired,
    wbEffects
  ]).SetFormIDBase($04)
    .SetSummaryKey([3]);

  RegisterRecordDef(FACT, 'Faction', [
    wbEditorID,
    wbDeleted,
    wbFullName.SetRequired,
    wbRArray('Ranks', wbStringForward(RNAM, 'Rank', 32)),
    wbStruct(FADT, 'Data', [
      wbArray('Favored Attributes', wbInteger('Attribute', itS32, wbAttributeEnum), 2),
      wbArray('Rank Requirements',
        wbStruct('Rank', [
          wbInteger('Attribute 1', itS32),
          wbInteger('Attribute 2', itS32),
          wbInteger('Primary Skills', itS32),
          wbInteger('Favored Skills', its32),
          wbInteger('Faction Reputation', itU32)
        ]).SetSummaryKey([0,1,2,3,4])
          .SetSummaryMemberPrefixSuffix(0, 'Attribute 1: ', ',')
          .SetSummaryMemberPrefixSuffix(1, 'Attribute 2: ', ',')
          .SetSummaryMemberPrefixSuffix(2, 'Primary Skills: ', ',')
          .SetSummaryMemberPrefixSuffix(3, 'Favored Skills: ', ',')
          .SetSummaryMemberPrefixSuffix(4, 'Faction Reputation: ', '')
          .IncludeFlag(dfCollapsed, wbCollapseFactionRanks)
          .IncludeFlag(dfSummaryMembersNoName),
      10),
      wbArray('Favored Skills', wbInteger('Skill', itS32, wbSkillEnum), 7),
      wbInteger('Hidden From Player', itU32, wbBoolEnum)
    ]).SetRequired,
    wbRArrayS('Relations',
      wbRStructSK([0], 'Relation', [
        wbString(ANAM, 'Faction'), //[FACT]
        wbInteger(INTV, 'Reaction', itS32)
      ]).SetToStr(wbFactionReactionToStr))
  ]).SetFormIDBase($1C);

  RegisterRecordDef(GLOB, 'Global', @wbKnownSubRecordSignaturesNoFNAM,  [
    wbEditorID,
    wbDeleted,
    wbInteger(FNAM, 'Variable Type', itU8,
      wbEnum([], [
      102, 'Float',
      108, 'Long',
      115, 'Short'
      ])).SetDefaultNativeValue(115),
    wbFloat(FLTV, 'Value', cpNormal, False, 1, 2)
  ]).SetFormIDBase($58)
    .SetSummaryKey([3])
    .SetAfterLoad(wbGlobalAfterLoad);

  RegisterRecordDef(GMST, 'Game Setting', [
    wbEditorID,
    wbRUnion('Value', [
      wbString(STRV, 'String Value'),
      wbInteger(INTV, 'Integer Value', itS32),
      wbFloat(FLTV, 'Float Value', cpNormal, False, 1, 4)
    ])
  ]).SetFormIDBase($50)
    .SetSummaryKey([1])
    .IncludeFlag(dfIndexEditorID);

  RegisterRecordDef(INFO, 'Dialog Response', @wbKnownSubRecordSignaturesINFO, [
    wbString(INAM, 'Response ID').SetRequired,
    wbString(PNAM, 'Previous Response ID').SetRequired,
    wbString(NNAM, 'Next Response ID').SetRequired,
    wbStruct(DATA, 'Data', [
      wbInteger('Dialog Type', itU32, wbDialogTypeEnum),
      wbInteger('Disposition/Index', itU32),
      wbInteger('Speaker Faction Rank', itS8).SetDefaultNativeValue(-1),
      wbInteger('Sex', itS8, wbSexEnum(Self)).SetDefaultNativeValue(-1),
      wbInteger('Player Faction Rank', itS8).SetDefaultNativeValue(-1),
      wbUnused(1)
    ]).SetRequired,
    wbString(ONAM, 'Speaker'), //[NPC_]
    wbString(RNAM, 'Speaker Race'), //[RACE]
    wbString(CNAM, 'Speaker Class'), //[CLAS]
    wbString(FNAM, 'Speaker Faction'), //[FACT]
    wbString(ANAM, 'Speaker Cell'), //[CELL]
    wbString(DNAM, 'Player Faction'), //[FACT]
    wbString(SNAM, 'Sound Filename'),
    wbString(NAME, 'Response'),
    wbDeleted,
    wbRArray('Conditions',
      wbRStruct('Condition', [
        wbStruct(SCVR, 'Condition', [
          wbInteger('Position', itU8,
            wbEnum([], [
            48, '1st',
            49, '2nd',
            50, '3rd',
            51, '4th',
            52, '5th',
            53, '6th'
            ])),
          wbInteger('Type', itU8,
            wbEnum([], [
            49, 'Function',
            50, 'Global',
            51, 'Local',
            52, 'Journal',
            53, 'Item',
            54, 'Dead',
            55, 'Not ID',
            56, 'Not Faction',
            57, 'Not Class',
            65, 'Not Race',
            66, 'Not Cell',
            67, 'Not Local'
            ])),
          wbUnion('Function', wbConditionFunctionDecider, [
            wbInteger('Function', itU16,
              wbEnum([], [
              12336, 'Reaction Low',
              12337, 'PC Strength',
              12338, 'PC Enchant',
              12339, 'PC Sneak',
              12340, 'PC Common Disease',
              12341, 'Choice',
              12342, 'PC Vampire',
              12343, 'Flee',
              12592, 'Reaction High',
              12593, 'PC Block',
              12594, 'PC Destruction',
              12595, 'PC Acrobatics',
              12596, 'PC Blight Disease',
              12597, 'PC Intelligence',
              12598, 'Level',
              12599, 'Should Attack',
              12848, 'Rank Requirement',
              12849, 'PC Armorer',
              12850, 'PC Alteration',
              12851, 'PC Light Armor',
              12852, 'PC Clothing Modifier',
              12853, 'PC Willpower',
              12854, 'Attacked',
              12855, 'Werewolf',
              13104, 'Reputation',
              13105, 'PC Medium Armor',
              13106, 'PC Illusion',
              13107, 'PC Short Blade',
              13108, 'PC Crime Level',
              13109, 'PC Agility',
              13110, 'Talked To PC',
              13111, 'PC Werewolf Kills',
              13360, 'Health Percent',
              13361, 'PC Heavy Armor',
              13362, 'PC Conjuration',
              13363, 'PC Marksman',
              13364, 'Same Sex',
              13365, 'PC Speed',
              13366, 'PC Health',
              13616, 'PC Reputation',
              13617, 'PC Blunt Weapon',
              13619, 'PC Mysticism',
              13619, 'PC Mercantile',
              13620, 'Same Race',
              13621, 'PC Endurance',
              13622, 'Creature Target',
              13872, 'PC Level',
              13873, 'PC Long Blade',
              13874, 'PC Restoration',
              13875, 'PC Speechcraft',
              13876, 'Same Faction',
              13877, 'PC Personality',
              13878, 'Friend Hit',
              14128, 'PC Health Percent',
              14129, 'PC Axe',
              14130, 'PC Alchemy',
              14131, 'PC Hand To Hand',
              14132, 'Faction Rank Difference',
              14133, 'PC Luck',
              14134, 'Fight',
              14384, 'PC Magicka',
              14385, 'PC Spear',
              14386, 'PC Unarmored',
              14387, 'PC Sex',
              14388, 'Detected',
              14389, 'PC Corpus',
              14390, 'Hello',
              14640, 'PC Fatigue',
              14641, 'PC Athletics',
              16462, 'PC Security',
              14643, 'PC Expelled',
              14644, 'Alarmed',
              14645, 'Weather',
              14646, 'Alarm'
              ])).SetDefaultNativeValue(14646),
            wbInteger('Function', itU16,
              wbEnum([], [
              22630, 'Float',
              22636, 'Long',
              22643, 'Short'
              ])).SetDefaultNativeValue(22630),
            wbInteger('Function', itU16,
              wbEnum([], [
              22602, 'Journal'
              ])).SetDefaultNativeValue(22602),
            wbInteger('Function', itU16,
              wbEnum([], [
              22601, 'Item'
              ])).SetDefaultNativeValue(22601),
            wbInteger('Function', itU16,
              wbEnum([], [
              22596, 'Dead'
              ])).SetDefaultNativeValue(22596),
            wbInteger('Function', itU16,
              wbEnum([], [
              22616, 'Not ID'
              ])).SetDefaultNativeValue(22616),
            wbInteger('Function', itU16,
              wbEnum([], [
              22598, 'Not Faction'
              ])).SetDefaultNativeValue(22598),
            wbInteger('Function', itU16,
              wbEnum([], [
              22595, 'Not Class'
              ])).SetDefaultNativeValue(22595),
            wbInteger('Function', itU16,
              wbEnum([], [
              22610, 'Not Race'
              ])).SetDefaultNativeValue(22610),
            wbInteger('Function', itU16,
              wbEnum([], [
              22604, 'Not Cell'
              ])).SetDefaultNativeValue(22604)
            ]),
          wbInteger('Operator', itU8,
            wbEnum([], [
            48, 'Equal To',
            49, 'Not Equal To',
            50, 'Greater Than',
            51, 'Greater Than Or Equal To',
            52, 'Less Than',
            53, 'Less Than Or Equal To'
            ])),
          wbString('Variable/Object')
        ]),
        wbRUnion('Value', [
          wbInteger(INTV, 'Value', itS32),
          wbFloat(FLTV, 'Value')
        ])
      ])),
    wbRStruct('Quest Data', [
      wbInteger(QSTN, 'Quest Named', itU8, wbBoolEnum).SetDefaultNativeValue(1),
      wbInteger(QSTF, 'Quest Finished', itU8, wbBoolEnum).SetDefaultNativeValue(1),
      wbInteger(QSTR, 'Quest Restarted', itU8, wbBoolEnum).SetDefaultNativeValue(1)
    ]).SetUnordered,
    wbString(BNAM, 'Result')
  ]).SetFormIDBase($90);

  RegisterRecordDef(INGR, 'Ingredient',
    wbFlags(wbFlagsList([
    10, 'References Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel.SetRequired,
    wbFullName,
    wbStruct(IRDT, 'Data', [
      wbFloat('Weight', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbInteger('Value', itU32).SetDefaultNativeValue(1),
      wbStruct('Effects', [
        wbArray('Magic Effects',
          wbInteger('Magic Effect', itS32, wbMagicEffectEnum).SetDefaultNativeValue(-1),
        4),
        wbArray('Skills',
          wbInteger('Skill', itS32, wbSkillEnum).SetDefaultNativeValue(-1),
        4),
        wbArray('Attributes',
          wbInteger('Attribute', itS32, wbAttributeEnum).SetDefaultNativeValue(-1),
        4)
      ])
    ]).SetRequired,
    wbScript, //[SCPT]
    wbIcon
  ]).SetFormIDBase($40)
    .SetAfterLoad(wbIngredientAfterLoad);

  RegisterRecordDef(LAND, 'Landscape', @wbKnownSubRecordSignaturesLAND, [
    wbStruct(INTV, 'Grid', [
      wbInteger('X', itS32),
      wbInteger('Y', itS32)
    ], cpCritical).SetSummaryKeyOnValue([0,1])
                  .SetSummaryPrefixSuffixOnValue(0, '(', '')
                  .SetSummaryPrefixSuffixOnValue(1, '', ')')
                  .SetRequired,
    wbInteger(DATA, 'Flags', itU32,
      wbFlags([
      {0} 'Has Vertex Normals/Height Map',
      {1} 'Has Vertex Colors',
      {2} 'Has Landscape Textures',
      {3} 'User Created/Edited'
      ])).SetDefaultNativeValue(8)
         .IncludeFlag(dfCollapsed, wbCollapseFlags),
    IfThen(wbSimpleRecords,
      wbByteArray(VNML, 'Vertex Normals'),
      wbArray(VNML, 'Vertex Normals',
        wbArray('Row',
          wbStruct('Column', [
            wbInteger('X', itS8, nil, cpBenign).SetGetCP(wbLandNormalsGetCP),
            wbInteger('Y', itS8, nil, cpBenign).SetGetCP(wbLandNormalsGetCP),
            wbInteger('Z', itS8, nil, cpBenign).SetGetCP(wbLandNormalsGetCP)
          ]).SetSummaryKey([0,1,2])
            .SetSummaryMemberPrefixSuffix(0, '(', '')
            .SetSummaryMemberPrefixSuffix(2, '', ')')
            .IncludeFlag(dfCollapsed, wbCollapseVec3)
            .IncludeFlag(dfSummaryMembersNoName),
        65).SetSummaryName('Columns')
           .IncludeFlag(dfCollapsed, wbCollapseVertices),
      65).SetSummaryName('Rows')
         .IncludeFlag(dfCollapsed, wbCollapseVertices)),
    IfThen(wbSimpleRecords,
      wbByteArray(VHGT, 'Vertex Height Map'),
      wbStruct(VHGT, 'Vertex Height Map', [
        wbFloat('Offset'),
        wbUnused(1),
        wbArray('Height Map',
          wbArray('Row',
            wbInteger('Column', itS8),
          65).SetSummaryName('Columns')
             .IncludeFlag(dfCollapsed, wbCollapseVertices),
        65).SetSummaryName('Rows')
           .IncludeFlag(dfCollapsed, wbCollapseVertices),
        wbUnused(2)
      ])),
    IfThen(wbSimpleRecords,
      wbByteArray(WNAM, 'World Map Colors'),
      wbArray(WNAM, 'World Map Colors',
        wbArray('Row',
          wbInteger('Column', itS8),
        9).SetSummaryName('Columns')
          .IncludeFlag(dfCollapsed, wbCollapseOther),
      9).SetSummaryName('Rows')
        .IncludeFlag(dfCollapsed, wbCollapseOther)),
    IfThen(wbSimpleRecords,
      wbByteArray(VCLR, 'Vertex Colors'),
      wbArray(VCLR, 'Vertex Colors',
        wbArray('Row',
          wbStruct('Column', [
            wbInteger('Red', itU8),
            wbInteger('Green', itU8),
            wbInteger('Blue', itU8)
          ]).SetToStr(wbRGBAToStr)
            .IncludeFlag(dfCollapsed, wbCollapseRGBA),
        65).SetSummaryName('Columns')
           .IncludeFlag(dfCollapsed, wbCollapseVertices),
      65).SetSummaryName('Rows')
         .IncludeFlag(dfCollapsed, wbCollapseVertices)),
    IfThen(wbSimpleRecords,
      wbByteArray(VTEX, 'Textures'),
      wbArray(VTEX, 'Textures',
        wbArray('Row',
          wbInteger('Column', itU16), //[LTEX]
        16).SetSummaryName('Columns')
           .IncludeFlag(dfCollapsed, wbCollapseOther),
      16).SetSummaryName('Rows')
         .IncludeFlag(dfCollapsed, wbCollapseOther))
  ]).SetFormIDBase($D0)
    .SetFormIDNameBase($B0)
    .SetGetFormIDCallback(function(const aMainRecord: IwbMainRecord; out aFormID: TwbFormID): Boolean begin
      var GridCell: TwbGridCell;
      Result := aMainRecord.GetGridCell(GridCell) and wbGridCellToFormID($C0, GridCell, aFormID);
    end)
    .SetIdentityCallback(function(const aMainRecord: IwbMainRecord): string begin
      Result := '';
      var GridCell: TwbGridCell;
      if aMainRecord.GetGridCell(GridCell) then
        Result := GridCell.SortKey;
    end);

  RegisterRecordDef(LEVC, 'Leveled Creature',
    wbFlags(wbFlagsList([
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbInteger(DATA, 'Leveled Flags', itU32, wbLeveledFlags)
      .SetRequired
      .IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(NNAM, 'Chance None', itU8).SetRequired,
    wbInteger(INDX, 'Entry Count', itU32).IncludeFlag(dfSkipImplicitEdit),
    wbRArrayS('Leveled Creature Entries',
      wbRStructSK([1], 'Leveled Creature Entry', [
        wbString(CNAM, 'Creature'), //[CREA]
        wbInteger(INTV, 'Level', itU16)
      ]).SetSummaryKey([1,0])
        .SetSummaryMemberPrefixSuffix(1, '[Level: ', ']')
        .SetSummaryMemberPrefixSuffix(0, '', ' x1')
        .IncludeFlag(dfSummaryMembersNoName)
        .IncludeFlag(dfSummaryNoSortKey)
        .IncludeFlag(dfCollapsed, wbCollapseLeveledItems)
    ).SetCountPath(INDX)
  ]).SetFormIDBase($40)
    .SetSummaryKey([5]);

  RegisterRecordDef(LEVI, 'Leveled Item',
    wbFlags(wbFlagsList([
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbInteger(DATA, 'Leveled Flags', itU32, wbLeveledFlags)
      .SetRequired
      .IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(NNAM, 'Chance None', itU8).SetRequired,
    wbInteger(INDX, 'Entry Count', itU32).IncludeFlag(dfSkipImplicitEdit),
    wbRArrayS('Leveled Item Entries',
      wbRStructSK([1], 'Leveled Item Entry', [
        wbString(INAM, 'Item'), //[ALCH, APPA, ARMO, BOOK, CLOT, INGR, LEVI, LIGH, LOCK, MISC, PROB, REPA, WEAP]
        wbInteger(INTV, 'Player Level', itU16)
      ]).SetSummaryKey([1,0])
        .SetSummaryMemberPrefixSuffix(1, '[Level: ', ']')
        .SetSummaryMemberPrefixSuffix(0, '', ' x1')
        .IncludeFlag(dfSummaryMembersNoName)
        .IncludeFlag(dfSummaryNoSortKey)
        .IncludeFlag(dfCollapsed, wbCollapseLeveledItems)
    ).SetCountPath(INDX)
  ]).SetFormIDBase($40)
    .SetSummaryKey([5]);

  RegisterRecordDef(LIGH, 'Light',
    wbFlags(wbFlagsList([
    10, 'References Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel.SetRequired,
    wbFullName,
    wbIcon,
    wbStruct(LHDT, 'Data', [
      wbFloat('Weight', cpNormal, False, 1, 2),
      wbInteger('Value', itU32),
      wbInteger('Time', itS32).SetDefaultNativeValue(-1),
      wbInteger('Radius', itU32).SetDefaultNativeValue(1000),
      wbByteColors,
      wbInteger('Flags', itU32,
        wbFlags([
        {0} 'Dynamic',
        {1} 'Can Carry',
        {2} 'Negative',
        {3} 'Flicker',
        {4} 'Fire',
        {5} 'Off By Default',
        {6} 'Flicker Slow',
        {7} 'Pulse',
        {8} 'Pulse Slow'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ]).SetRequired,
    wbScript, //[SCPT]
    wbString(SNAM, 'Looping Sound') //[SOUN]
  ]).SetFormIDBase($40);

  RegisterRecordDef(LOCK, 'Lockpick',
    wbFlags(wbFlagsList([
    10, 'References Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel.SetRequired,
    wbFullName,
    wbStruct(LKDT, 'Data', [
      wbFloat('Weight', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbInteger('Value', itU32).SetDefaultNativeValue(1),
      wbFloat('Quality', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbInteger('Uses', itU32).SetDefaultNativeValue(10)
    ]).SetRequired,
    wbScript, //[SCPT]
    wbIcon
  ]).SetFormIDBase($40);

  RegisterRecordDef(LTEX, 'Landscape Texture', [
    wbDeleted,
    wbEditorID,
    wbInteger(INTV, 'Texture ID', itU32).SetRequired,
    wbString(DATA, 'Texture Filename').SetRequired
  ]).SetFormIDBase($60)
    .SetSummaryKey([3]);

  RegisterRecordDef(MGEF, 'Magic Effect', @wbKnownSubRecordSignaturesINDX, [
    wbInteger(INDX, 'Effect', itU32, wbMagicEffectEnum),
    wbDeleted,
    wbStruct(MEDT, 'Data', [
      wbInteger('School', itU32,
        wbEnum([
        {0} 'Alteration',
        {1} 'Conjuration',
        {2} 'Destruction',
        {3} 'Illusion',
        {4} 'Mysticism',
        {5} 'Restoration'
        ])),
      wbFloat('Base Cost', cpNormal, False, 1, 2),
      wbInteger('Flags', itU32,
        wbFlags(wbSparseFlags([
        9,  'Spellmaking',
        10, 'Enchanting',
        11, 'Negative'
        ], False, 12))).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbStruct('Lighting Effect', [
        wbInteger('Red', itU32),
        wbInteger('Green', itU32),
        wbInteger('Blue', itU32)
      ]).SetToStr(wbRGBAToStr)
        .IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbFloat('Size Multiplier', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbFloat('Speed Multiplier', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbFloat('Size Cap', cpNormal, False, 1, 2)
    ]).SetRequired,
    wbString(ITEX, 'Effect Texture Filename'),
    wbString(PTEX, 'Particle Texture Filename'),
    wbString(BSND, 'Bolt Sound'), //[SOUN]
    wbString(CSND, 'Cast Sound'), //[SOUN]
    wbString(HSND, 'Hit Sound'), //[SOUN]
    wbString(ASND, 'Area Sound'), //[SOUN]
    wbString(CVFX, 'Casting Visual'), //[STAT]
    wbString(BVFX, 'Bolt Visual'), //[WEAP]
    wbString(HVFX, 'Hit Visual'), //[STAT]
    wbString(AVFX, 'Area Visual'), //[STAT]
    wbDescription
  ]).SetFormIDBase($02);

  RegisterRecordDef(MISC, 'Misc. Item',
    wbFlags(wbFlagsList([
    10, 'References Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel.SetRequired,
    wbFullName,
    wbStruct(MCDT,'Data', [
      wbFloat('Weight', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbInteger('Value', itU32).SetDefaultNativeValue(1),
      //This bool is only set true if the object is used in a KNAM on a REFR.
      wbInteger('Is Key', itU32, wbBoolEnum)
    ]).SetRequired,
    wbScript, //[SCPT]
    wbIcon
  ]).SetFormIDBase($40);

  RegisterRecordDef(NPC_, 'Non-Player Character',
    wbFlags(wbFlagsList([
    10, 'Corpses Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel,
    wbFullName,
    wbString(RNAM, 'Race') //[RACE]
      .SetDefaultEditValue('Argonian')
      .SetRequired,
    wbString(CNAM, 'Class') //[CLAS]
      .SetDefaultEditValue('Acrobat')
      .SetRequired,
    wbString(ANAM, 'Faction').SetRequired, //[FACT]
    wbString(BNAM, 'Head Body Part') //[BODY]
      .SetDefaultEditValue('b_n_argonian_m_head_02')
      .SetRequired,
    wbString(KNAM, 'Hair Body Part') //[BODY]
      .SetDefaultEditValue('b_n_argonian_m_hair01')
      .SetRequired,
    wbScript, //[SCPT]
    wbUnion(NPDT, 'Data', wbNPCDataDecider, [
        wbStruct('Non-Auto', [
          wbInteger('Level', itU16),
          wbStruct('Attributes', [
            wbInteger('Strength', itU8).SetDefaultNativeValue(50),
            wbInteger('Intelligence', itU8).SetDefaultNativeValue(50),
            wbInteger('Willpower', itU8).SetDefaultNativeValue(50),
            wbInteger('Agility', itU8).SetDefaultNativeValue(50),
            wbInteger('Speed', itU8).SetDefaultNativeValue(50),
            wbInteger('Endurance', itU8).SetDefaultNativeValue(50),
            wbInteger('Personality', itU8).SetDefaultNativeValue(50),
            wbInteger('Luck', itU8).SetDefaultNativeValue(50)
          ]),
          wbStruct('Skills', [
            wbInteger('Block', itU8).SetDefaultNativeValue(5),
            wbInteger('Armorer', itU8).SetDefaultNativeValue(5),
            wbInteger('Medium Armor', itU8).SetDefaultNativeValue(5),
            wbInteger('Heavy Armor', itU8).SetDefaultNativeValue(5),
            wbInteger('Blunt Weapon', itU8).SetDefaultNativeValue(5),
            wbInteger('Long Blade', itU8).SetDefaultNativeValue(5),
            wbInteger('Axe', itU8).SetDefaultNativeValue(5),
            wbInteger('Spear', itU8).SetDefaultNativeValue(5),
            wbInteger('Athletics', itU8).SetDefaultNativeValue(5),
            wbInteger('Enchant', itU8).SetDefaultNativeValue(5),
            wbInteger('Destruction', itU8).SetDefaultNativeValue(5),
            wbInteger('Alteration', itU8).SetDefaultNativeValue(5),
            wbInteger('Illusion', itU8).SetDefaultNativeValue(5),
            wbInteger('Conjuration', itU8).SetDefaultNativeValue(5),
            wbInteger('Mysticism', itU8).SetDefaultNativeValue(5),
            wbInteger('Restoration', itU8).SetDefaultNativeValue(5),
            wbInteger('Alchemy', itU8).SetDefaultNativeValue(5),
            wbInteger('Unarmored', itU8).SetDefaultNativeValue(5),
            wbInteger('Security', itU8).SetDefaultNativeValue(5),
            wbInteger('Sneak', itU8).SetDefaultNativeValue(5),
            wbInteger('Acrobatics', itU8).SetDefaultNativeValue(5),
            wbInteger('Light Armor', itU8).SetDefaultNativeValue(5),
            wbInteger('Short Blade', itU8).SetDefaultNativeValue(5),
            wbInteger('Marksman', itU8).SetDefaultNativeValue(5),
            wbInteger('Speechcraft', itU8).SetDefaultNativeValue(5),
            wbInteger('Mercantile', itU8).SetDefaultNativeValue(5),
            wbInteger('Hand-to-Hand', itU8).SetDefaultNativeValue(5)
          ]),
          wbUnused(1),
          wbInteger('Health', itU16).SetDefaultNativeValue(50),
          wbInteger('Magicka', itU16).SetDefaultNativeValue(100),
          wbInteger('Fatigue', itU16).SetDefaultNativeValue(200),
          wbInteger('Disposition', itU8).SetDefaultNativeValue(50),
          wbInteger('Reputation', itU8),
          wbInteger('Rank', itU8),
          wbUnused(1),
          wbInteger('Gold', itU32)
        ]),
        wbStruct('Auto', [
          wbInteger('Level', itU16).SetDefaultNativeValue(1),
          wbInteger('Disposition', itU8).SetDefaultNativeValue(50),
          wbInteger('Reputation', itU8),
          wbInteger('Rank', itU8),
          wbUnused(3),
          wbInteger('Gold', itU32)
        ])
    ]).SetRequired,
    wbInteger(FLAG, 'Flags', itU32,
      wbFlags(wbSparseFlags([
      0, 'Female',
      1, 'Essential',
      2, 'Respawn',
      3, 'Can Hold Items',
      4, 'Auto Calculate Stats',
      10, 'Skeleton Blood',
      11, 'Metal Blood'
      ], False, 12))
    ).SetDefaultNativeValue(18)
     .IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInventory,
    wbSpells,
    wbAIData(Self).SetRequired,
    wbTravelServices,
    wbPackages.SetRequired,
    wbFloat(XSCL, 'Scale', cpNormal, False, 1, 2).SetDefaultNativeValue(1)
  ]).SetFormIDBase($40);

  RegisterRecordDef(PGRD, 'Path Grid', [
    wbStruct(DATA, 'Data', [
      wbStruct('Grid', [
        wbInteger('X', itS32),
        wbInteger('Y', itS32)
      ], cpCritical).SetSummaryKey([0,1])
                    .SetSummaryMemberPrefixSuffix(0, '(', '')
                    .SetSummaryMemberPrefixSuffix(1, '', ')')
                    .SetSummaryDelimiter(', '),
      wbInteger('Granularity', itU16).SetDefaultNativeValue(1024),
      wbInteger('Point Count', itU16)
    ]).SetRequired,
    wbString(NAME, 'Location ID', 0, cpIgnore).SetRequired,
    IfThen(wbSimpleRecords,
      wbArray(PGRP, 'Points',
        wbByteArray('Point', 16)
      ).SetCountPathOnValue('DATA\Point Count', False),
      wbArray(PGRP, 'Points',
        wbStruct('Point', [
          wbStruct('Position', [
            wbInteger('X', itS32),
            wbInteger('Y', itS32),
            wbInteger('Z', itS32)
          ]).IncludeFlag(dfCollapsed, wbCollapseVec3),
          wbInteger('User Created', itU8, wbBoolEnum),
          wbInteger('Connection Count', itU8),
          wbUnused(2)
        ]).SetSummaryKey([0,2])
          .SetSummaryMemberPrefixSuffix(0, '', '')
          .SetSummaryMemberPrefixSuffix(2, 'Connections: ', '')
          .IncludeFlag(dfCollapsed, wbCollapseNavmesh)
      ).SetCountPathOnValue('DATA\Point Count', False)),
    IfThen(wbSimpleRecords,
      wbByteArray(PGRC, 'Point Connections'),
      wbArray(PGRC, 'Point Connections',
        wbArrayS('Point Connection',
          wbInteger('Point', itU32),
        wbCalcPGRCSize)).IncludeFlag(dfCollapsed, wbCollapseNavmesh))
  ]).SetFormIDBase($F0)
    .SetFormIDNameBase($B0)
    .SetGetGridCellCallback(function(const aSubRecord: IwbSubRecord; out aGridCell: TwbGridCell): Boolean begin
      with aGridCell, aSubRecord do begin
        X := ElementNativeValues['Grid\X'];
        Y := ElementNativeValues['Grid\Y'];
        Result := not ((X = 0) and (Y = 0));
      end;
    end)
    .SetGetFormIDCallback(function(const aMainRecord: IwbMainRecord; out aFormID: TwbFormID): Boolean begin
      var GridCell: TwbGridCell;
      Result := aMainRecord.GetGridCell(GridCell) and wbGridCellToFormID($E0, GridCell, aFormID);
    end)
    .SetIdentityCallback(function(const aMainRecord: IwbMainRecord): string begin
      var GridCell: TwbGridCell;
      if aMainRecord.GetGridCell(GridCell) then
        Result := '<Exterior>' + GridCell.SortKey
      else
        Result := aMainRecord.EditorID;
    end);

  RegisterRecordDef(PROB, 'Probe',
    wbFlags(wbFlagsList([
    10, 'References Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel.SetRequired,
    wbFullName,
    wbStruct(PBDT, 'Data', [
      wbFloat('Weight', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbInteger('Value', itU32).SetDefaultNativeValue(1),
      wbFloat('Quality', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbInteger('Uses', itU32).SetDefaultNativeValue(10)
    ]).SetRequired,
    wbScript, //[SCPT]
    wbIcon
  ]).SetFormIDBase($40);

  RegisterRecordDef(RACE, 'Race', [
    wbEditorID,
    wbDeleted,
    wbFullName.SetRequired,
    wbStruct(RADT, 'Data', [
      wbArrayS('Skill Bonuses',
        wbStructSK([0], 'Skill Bonus', [
          wbInteger('Skill', itS32, wbSkillEnum).SetDefaultNativeValue(-1),
          wbInteger('Bonus', itU32)
        ]).SetSummaryKey([1,0])
          .SetSummaryMemberPrefixSuffix(1, '+', '')
          .SetSummaryMemberPrefixSuffix(0, '', '')
          .IncludeFlag(dfSummaryMembersNoName)
          .IncludeFlag(dfSummaryNoSortKey)
          .IncludeFlag(dfCollapsed, wbCollapseOther),
      7),
      wbStruct('Base Attributes', [
        wbStruct('Strength', [
          wbInteger('Male', itU32).SetDefaultNativeValue(50),
          wbInteger('Female', itU32).SetDefaultNativeValue(50)
        ]),
        wbStruct('Intelligence', [
          wbInteger('Male', itU32).SetDefaultNativeValue(50),
          wbInteger('Female', itU32).SetDefaultNativeValue(50)
        ]),
        wbStruct('Willpower', [
          wbInteger('Male', itU32).SetDefaultNativeValue(50),
          wbInteger('Female', itU32).SetDefaultNativeValue(50)
        ]),
        wbStruct('Agility', [
          wbInteger('Male', itU32).SetDefaultNativeValue(50),
          wbInteger('Female', itU32).SetDefaultNativeValue(50)
        ]),
        wbStruct('Speed', [
          wbInteger('Male', itU32).SetDefaultNativeValue(50),
          wbInteger('Female', itU32).SetDefaultNativeValue(50)
        ]),
        wbStruct('Endurance', [
          wbInteger('Male', itU32).SetDefaultNativeValue(50),
          wbInteger('Female', itU32).SetDefaultNativeValue(50)
        ]),
        wbStruct('Personality', [
          wbInteger('Male', itU32).SetDefaultNativeValue(50),
          wbInteger('Female', itU32).SetDefaultNativeValue(50)
        ]),
        wbStruct('Luck', [
          wbInteger('Male', itU32).SetDefaultNativeValue(50),
          wbInteger('Female', itU32).SetDefaultNativeValue(50)
        ])
      ]),
      wbStruct('Height', [
        wbFloat('Male', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
        wbFloat('Female', cpNormal, False, 1, 2).SetDefaultNativeValue(1)
      ]),
      wbStruct('Weight', [
        wbFloat('Male', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
        wbFloat('Female', cpNormal, False, 1, 2).SetDefaultNativeValue(1)
      ]),
      wbInteger('Flags', itU32,
        wbFlags([
        {0} 'Playable',
        {1} 'Beast Race'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ]).SetRequired,
    wbSpells,
    wbDescription
  ]).SetFormIDBase($14);

  RegisterRecordDef(REFR, 'Placed Object', @wbKnownSubRecordSignaturesREFR, [
    wbStruct(CNDT, 'New Cell Cell', [
      wbInteger('X', itS32),
      wbInteger('Y', itS32)
    ]).SetSummaryKeyOnValue([0,1])
      .SetSummaryPrefixSuffixOnValue(0, '(', '')
      .SetSummaryPrefixSuffixOnValue(1, '', ')')
      .SetSummaryDelimiterOnValue(', '),
    wbInteger(FRMR, 'Object Index', itU32, wbFRMRToString, nil, cpIgnore, True)
      .SetRequired
      .IncludeFlag(dfInternalEditOnly),
    wbString(NAME, 'Base Object'), //[ACTI, ALCH, APPA, ARMO, BODY, BOOK, CLOT, CONT, CREA, DOOR, INGR, LEVC, LOCK, MISC, NPC_, PROB, REPA, STAT, WEAP]
    wbInteger(UNAM, 'Reference Blocked', itU8, wbEnum(['True'])),
    wbFloat(XSCL, 'Scale', cpNormal, False, 1, 2),
    wbRStructSK([], 'Owner Data', [
      wbString(ANAM, 'Owner'), //[NPC_]
      wbString(BNAM, 'Global Variable'), //[GLOB]
      wbString(CNAM, 'Faction Owner'), //[FACT]
      wbInteger(INDX, 'Faction Rank', itU32)
    ]).SetUnordered,
    wbFloat(XCHG, 'Enchantment Charge', cpNormal, False, 1, 0),
    wbString(XSOL, 'Soul'), //[CREA]
    wbInteger(INTV, 'Health', itU32),
    wbInteger(NAM9, 'Count', itU32),
    wbRStructSK([], 'Teleport Data', [
      wbVec3PosRot(DODT),
      wbString(DNAM, 'Cell') //[CELL]
    ]),
    wbRStructSK([], 'Lock Data', [
      wbInteger(FLTV, 'Lock Level', itU32).SetRequired,
      wbString(KNAM, 'Key'), //[MISC]
      wbString(TNAM, 'Trap') //[ENCH]
    ]).SetUnordered,
    wbDeleted,
    wbVec3PosRot(DATA, 'Reference Data')
  ]).SetGetFormIDCallback(function(const aMainRecord: IwbMainRecord; out aFormID: TwbFormID): Boolean begin
      var lFRMR := aMainRecord.RecordBySignature[FRMR];
      Result := Assigned(lFRMR);
      if Result then begin
        aFormID := TwbFormID.FromCardinal(lFRMR.NativeValue);
        var lLayout := aMainRecord.ContextObj.SlotLayout;
        if aFormID.FileID[lLayout].FullSlot = 0 then
          aFormID.FileID[lLayout] := TwbFileID.CreateFull($FF);
      end;
    end)
    .SetAfterLoad(wbDeletedAfterLoad);

  RegisterRecordDef(REGN, 'Region', [
    wbDeleted,
    wbEditorID,
    wbFullName.SetRequired,
    wbStruct(WEAT, 'Weather Chances', [
      wbInteger('Clear', itU8).SetDefaultNativeValue(5),
      wbInteger('Cloudy', itU8).SetDefaultNativeValue(25),
      wbInteger('Foggy', itU8).SetDefaultNativeValue(35),
      wbInteger('Overcast', itU8).SetDefaultNativeValue(20),
      wbInteger('Rain', itU8).SetDefaultNativeValue(10),
      wbInteger('Thunder', itU8).SetDefaultNativeValue(5),
      wbInteger('Ash', itU8),
      wbInteger('Blight', itU8),
      wbInteger('Snow', itU8),
      wbInteger('Blizzard', itU8)
    ]).SetOptionalFrom(8)
      .SetRequired,
    wbString(BNAM, 'Sleep Creature'), //[LEVC]
    wbByteColors(CNAM, 'Region Map Color').SetRequired,
    wbRArray('Region Sounds',
      wbStruct(SNAM, 'Region Sound', [
        wbStringForward('Sound', 32).SetAfterLoad(wbForwardForReal), //[SOUN]
        wbInteger('Chance', itU8).SetDefaultNativeValue(50)
      ]).SetSummaryKeyOnValue([0,1])
        .SetSummaryPrefixSuffixOnValue(0, 'Sound: ', ',')
        .SetSummaryPrefixSuffixOnValue(1, 'Chance: ', '')
        .IncludeFlag(dfCollapsed, wbCollapseSounds))
  ]).SetFormIDBase($70);

  RegisterRecordDef(REPA, 'Repair Item',
    wbFlags(wbFlagsList([
    10, 'References Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel.SetRequired,
    wbFullName,
    wbStruct(RIDT, 'Data', [
      wbFloat('Weight', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbInteger('Value', itU32).SetDefaultNativeValue(1),
      wbInteger('Uses', itU32).SetDefaultNativeValue(10),
      wbFloat('Quality', cpNormal, False, 1, 2).SetDefaultNativeValue(1)
    ]).SetRequired,
    wbScript, //[SCPT]
    wbIcon
  ]).SetFormIDBase($40);

  RegisterRecordDef(SCPT, 'Script', @wbKnownSubRecordSignaturesSCPT, [
    wbStruct(SCHD, 'Script Header', [
      //Name can be saved with 36 characters in the CS, but it collides with Number of Shorts.
      wbString('Name', 32),
      wbInteger('Number of Shorts', itU32),
      wbInteger('Number of Longs', itU32),
      wbInteger('Number of Floats', itU32),
      wbInteger('Compiled Size', itU32),
      wbInteger('Local Variable Size', itU32)
    ]).SetSummaryKeyOnValue([4,5,2,1,3])
      .SetSummaryPrefixSuffixOnValue(4, '{Compiled Size: ', ',')
      .SetSummaryPrefixSuffixOnValue(5, 'Local Var Size: ', ',')
      .SetSummaryPrefixSuffixOnValue(2, 'Shorts: ', ',')
      .SetSummaryPrefixSuffixOnValue(1, 'Longs: ', ',')
      .SetSummaryPrefixSuffixOnValue(3, 'Floats: ', '}')
      .SetRequired
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseScriptData),
    wbDeleted,
    wbArrayS(SCVR, 'Script Variables', wbString('Script Variable', 0, cpCritical)),
    wbByteArray(SCDT, 'Compiled Script'),
    wbStringScript(SCTX, 'Script Source').SetRequired
  ]).SetFormIDBase($30)
    .SetGetEditorIDCallback(function (const aSubRecord: IwbSubRecord): string begin
      Result := aSubRecord.ElementEditValues['Name'];
    end)
    .SetSetEditorIDCallback(procedure (const aSubRecord: IwbSubRecord; const aEditorID: string) begin
      aSubRecord.ElementEditValues['Name'] := aEditorID;
    end)
    .SetToStr(wbScriptToStr);

  RegisterRecordDef(SKIL, 'Skill', @wbKnownSubRecordSignaturesINDX, [
    wbInteger(INDX, 'Name', itU32, wbSkillEnum).SetRequired,
    wbDeleted,
    wbStruct(SKDT, 'Data', [
      wbInteger('Governing Attribute', itS32, wbAttributeEnum),
      wbInteger('Type', itU32, wbSpecializationEnum),
      wbUnion('Actions', wbSkillDecider, [
        wbStruct('Block', [
          wbFloat('Successful Block'),
          wbUnused(12)
        ]),
        wbStruct('Armorer', [
          wbFloat('Successful Repair'),
          wbUnused(12)
        ]),
        wbStruct('Armor', [
          wbFloat('Hit By Opponent'),
          wbUnused(12)
        ]),
        wbStruct('Weapon', [
          wbFloat('Successful Attack'),
          wbUnused(12)
        ]),
        wbStruct('Athletics', [
          wbFloat('Seconds of Running'),
          wbFloat('Seconds of Swimming'),
          wbUnused(8)
        ]),
        wbStruct('Enchant', [
          wbFloat('Recharge Item'),
          wbFloat('Use Magic Item'),
          wbFloat('Create Magic Item'),
          wbFloat('Cast When Strikes')
        ]),
        wbStruct('Magic School', [
          wbFloat('Successful Cast'),
          wbUnused(12)
        ]),
        wbStruct('Alchemy', [
          wbFloat('Potion Creation'),
          wbFloat('Ingredient Use'),
          wbUnused(8)
        ]),
        wbStruct('Security', [
          wbFloat('Defeat Trap'),
          wbFloat('Pick Lock'),
          wbUnused(8)
        ]),
        wbStruct('Sneak', [
          wbFloat('Avoid Notice'),
          wbFloat('Successful Pick-Pocket'),
          wbUnused(8)
        ]),
        wbStruct('Acrobatics', [
          wbFloat('Jump'),
          wbFloat('Fall'),
          wbUnused(8)
        ]),
        wbStruct('Mercantile', [
          wbFloat('Successful Bargain'),
          wbFloat('Successful Bribe'),
          wbUnused(8)
        ]),
        wbStruct('Speechcraft', [
          wbFloat('Successful Persuasion'),
          wbFloat('Failed Persuasion'),
          wbUnused(8)
        ])
      ])
    ]).SetRequired,
    wbDescription
  ]).SetFormIDBase($01);

  RegisterRecordDef(SNDG, 'Sound Generator', [
    wbEditorID,
    wbInteger(DATA, 'Type', itU32,
      wbEnum([
      {0} 'Left Foot',
      {1} 'Right Foot',
      {2} 'Swim Left',
      {3} 'Swim Right',
      {4} 'Moan',
      {5} 'Roar',
      {6} 'Scream',
      {7} 'Land'
      ])).SetDefaultNativeValue(7)
         .SetRequired,
    wbString(CNAM, 'Creature'), //[CREA]
    wbString(SNAM, 'Sound')
      .SetDefaultNativeValue('Body Fall Medium')
      .SetRequired, //[SOUN]
    wbDeleted
  ]).SetFormIDBase($28)
    .SetSummaryKey([3]);

  RegisterRecordDef(SOUN, 'Sound', @wbKnownSubRecordSignaturesNoFNAM, [
    wbEditorID,
    wbDeleted,
    wbString(FNAM, 'Sound Filename').SetRequired,
    wbStruct(DATA, 'Data', [
      wbInteger('Volume', itU8, wbDiv(255, 2)).SetDefaultNativeValue(1),
      wbInteger('Minimum Range', itU8),
      wbInteger('Maximum Range', itU8)
    ]).SetRequired
  ]).SetFormIDBase($40);

  RegisterRecordDef(SPEL, 'Spellmaking',
    wbFlags(wbFlagsList([
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbFullName,
    wbStruct(SPDT, 'Data', [
      wbInteger('Type', itU32,
        wbEnum([
        {0} 'Spell',
        {1} 'Ability',
        {2} 'Blight',
        {3} 'Disease',
        {4} 'Curse',
        {5} 'Power'
        ])),
      wbInteger('Spell Cost', itU32),
      wbInteger('Flags', itU32,
        wbFlags([
        {0} 'Auto Calculate Cost',
        {1} 'Player Start Spell',
        {2} 'Always Succeeds'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ]).SetRequired,
    wbEffects
  ]).SetFormIDBase($0A);

  RegisterRecordDef(SSCR, 'Start Script', @wbKnownSubRecordSignaturesSSCR, [
    wbDeleted,
    wbString(DATA, 'Numerical ID').SetRequired,
    wbString(NAME, 'Script').SetRequired //[SCPT]
  ]).SetFormIDBase($3F)
    .SetAfterLoad(wbDeletedAfterLoad);

  RegisterRecordDef(STAT, 'Static',
    wbFlags(wbFlagsList([
    10, 'References Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel.SetRequired
  ]).SetFormIDBase($40)
    .SetSummaryKey([2]);

  RegisterRecordDef(WEAP, 'Weapon',
    wbFlags(wbFlagsList([
    10, 'References Persist',
    13, 'Blocked'
    ])), [
    wbEditorID,
    wbDeleted,
    wbModel.SetRequired,
    wbFullName,
    wbStruct(WPDT, 'Data', [
      wbFloat('Weight', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbInteger('Value', itU32).SetDefaultNativeValue(1),
      wbInteger('Type', itU16,
        wbEnum([
        {0}  'Short Blade One Hand',
        {1}  'Long Blade One Hand',
        {2}  'Long Blade Two Close',
        {3}  'Blunt One Hand',
        {4}  'Blunt Two Close',
        {5}  'Blunt Two Wide',
        {6}  'Spear Two Wide',
        {7}  'Axe One Hand',
        {8}  'Axe Two Hand',
        {9}  'Marksman Bow',
        {10} 'Marksman Crossbow',
        {11} 'Marksman Thrown',
        {12} 'Arrow',
        {13} 'Bolt'
        ])).SetDefaultNativeValue(12),
      wbInteger('Health', itU16).SetDefaultNativeValue(100),
      wbFloat('Speed', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbFloat('Reach', cpNormal, False, 1, 2).SetDefaultNativeValue(1),
      wbInteger('Enchanting Charge', itU16).SetDefaultNativeValue(100),
      wbStruct('Damage Types', [
        wbStruct('Chop', [
          wbInteger('Minimum', itU8).SetDefaultNativeValue(1),
          wbInteger('Maximum', itU8).SetDefaultNativeValue(5)
        ]),
        wbStruct('Slash', [
          wbInteger('Minimum', itU8).SetDefaultNativeValue(1),
          wbInteger('Maximum', itU8).SetDefaultNativeValue(5)
        ]),
        wbStruct('Thrust', [
          wbInteger('Minimum', itU8).SetDefaultNativeValue(1),
          wbInteger('Maximum', itU8).SetDefaultNativeValue(5)
        ])
      ]),
      wbInteger('Flags', itU32,
        wbFlags([
        {0} 'Silver Weapon',
        {1} 'Ignore Normal Weapon Resistance'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ]).SetRequired,
    wbScript, //[SCPT]
    wbIcon,
    wbEnchantment(Self) //[ENCH]
  ]).SetFormIDBase($40);

  AddGroupOrder(GMST);
  AddGroupOrder(GLOB);
  AddGroupOrder(CLAS);
  AddGroupOrder(FACT);
  AddGroupOrder(RACE);
  AddGroupOrder(SOUN);
  AddGroupOrder(SKIL);
  AddGroupOrder(MGEF);
  AddGroupOrder(SCPT);
  AddGroupOrder(REGN);
  AddGroupOrder(SSCR);
  AddGroupOrder(BSGN);
  AddGroupOrder(LTEX);
  AddGroupOrder(STAT);
  AddGroupOrder(DOOR);
  AddGroupOrder(MISC);
  AddGroupOrder(WEAP);
  AddGroupOrder(CONT);
  AddGroupOrder(SPEL);
  AddGroupOrder(CREA);
  AddGroupOrder(BODY);
  AddGroupOrder(LIGH);
  AddGroupOrder(ENCH);
  AddGroupOrder(NPC_);
  AddGroupOrder(ARMO);
  AddGroupOrder(CLOT);
  AddGroupOrder(REPA);
  AddGroupOrder(ACTI);
  AddGroupOrder(APPA);
  AddGroupOrder(LOCK);
  AddGroupOrder(PROB);
  AddGroupOrder(INGR);
  AddGroupOrder(BOOK);
  AddGroupOrder(ALCH);
  AddGroupOrder(LEVI);
  AddGroupOrder(LEVC);
  AddGroupOrder(CELL);
  AddGroupOrder(LAND);
  AddGroupOrder(PGRD);
  AddGroupOrder(SNDG);
  AddGroupOrder(DIAL);
  AddGroupOrder(INFO);
  NexusModsUrl := 'https://www.nexusmods.com/morrowind/mods/54508';
  HEDRVersion := 1.30;
  HardcodedRangeAdmitted := True;
end;

initialization
  wbRegisterGameDef([gmTES3], tsPlugins, TwbGameDefTES3);
end.
