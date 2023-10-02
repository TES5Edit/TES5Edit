{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbDefinitionsTES3;

interface

uses
  wbInterface;

procedure DefineTES3;

implementation

uses
  Types,
  Classes,
  SysUtils,
  Math,
  Variants;

const
  AADT : TwbSignature = 'AADT';
  ACTI : TwbSignature = 'ACTI';
  AI_A : TwbSignature = 'AI'#$5F'A';
  AI_E : TwbSignature = 'AI'#$5F'E';
  AI_F : TwbSignature = 'AI'#$5F'F';
  AI_T : TwbSignature = 'AI'#$5F'T';
  AI_W : TwbSignature = 'AI'#$5F'W';
  AIDT : TwbSignature = 'AIDT';
  ALCH : TwbSignature = 'ALCH';
  ALDT : TwbSignature = 'ALDT';
  AMBI : TwbSignature = 'AMBI';
  ANAM : TwbSignature = 'ANAM';
  AODT : TwbSignature = 'AODT';
  APPA : TwbSignature = 'APPA';
  ARMO : TwbSignature = 'ARMO';
  ASND : TwbSignature = 'ASND';
  AVFX : TwbSignature = 'AVFX';
  BKDT : TwbSignature = 'BKDT';
  BNAM : TwbSignature = 'BNAM';
  BODY : TwbSignature = 'BODY';
  BOOK : TwbSignature = 'BOOK';
  BSGN : TwbSignature = 'BSGN';
  BSND : TwbSignature = 'BSND';
  BVFX : TwbSignature = 'BVFX';
  BYDT : TwbSignature = 'BYDT';
  CELL : TwbSignature = 'CELL';
  CLAS : TwbSignature = 'CLAS';
  CLDT : TwbSignature = 'CLDT';
  CLOT : TwbSignature = 'CLOT';
  CNAM : TwbSignature = 'CNAM';
  CNDT : TwbSignature = 'CNDT';
  CNTO : TwbSignature = 'CNTO';
  CONT : TwbSignature = 'CONT';
  CREA : TwbSignature = 'CREA';
  CSND : TwbSignature = 'CSND';
  CTDT : TwbSignature = 'CTDT';
  CVFX : TwbSignature = 'CVFX';
  DATA : TwbSignature = 'DATA';
  DELE : TwbSignature = 'DELE';
  DESC : TwbSignature = 'DESC';
  DIAL : TwbSignature = 'DIAL';
  DNAM : TwbSignature = 'DNAM';
  DODT : TwbSignature = 'DODT';
  DOOR : TwbSignature = 'DOOR';
  ENAM : TwbSignature = 'ENAM';
  ENCH : TwbSignature = 'ENCH';
  ENDT : TwbSignature = 'ENDT';
  ENIT : TwbSignature = 'ENIT';
  FACT : TwbSignature = 'FACT';
  FADT : TwbSignature = 'FADT';
  FLAG : TwbSignature = 'FLAG';
  FLTV : TwbSignature = 'FLTV';
  FNAM : TwbSignature = 'FNAM';
  FRMR : TwbSignature = 'FRMR';
  REFR : TwbSignature = 'REFR';
  GLOB : TwbSignature = 'GLOB';
  GMST : TwbSignature = 'GMST';
  HEDR : TwbSignature = 'HEDR';
  HSND : TwbSignature = 'HSND';
  HVFX : TwbSignature = 'HVFX';
  INAM : TwbSignature = 'INAM';
  INDX : TwbSignature = 'INDX';
  INFO : TwbSignature = 'INFO';
  INGR : TwbSignature = 'INGR';
  INTV : TwbSignature = 'INTV';
  IRDT : TwbSignature = 'IRDT';
  ITEX : TwbSignature = 'ITEX';
  KNAM : TwbSignature = 'KNAM';
  LAND : TwbSignature = 'LAND';
  LEVC : TwbSignature = 'LEVC';
  LEVI : TwbSignature = 'LEVI';
  LHDT : TwbSignature = 'LHDT';
  LIGH : TwbSignature = 'LIGH';
  LKDT : TwbSignature = 'LKDT';
  LOCK : TwbSignature = 'LOCK';
  LTEX : TwbSignature = 'LTEX';
  MAST : TwbSignature = 'MAST';
  MCDT : TwbSignature = 'MCDT';
  MEDT : TwbSignature = 'MEDT';
  MGEF : TwbSignature = 'MGEF';
  MISC : TwbSignature = 'MISC';
  MNAM : TwbSignature = 'MNAM';
  MODL : TwbSignature = 'MODL';
  NAM0 : TwbSignature = 'NAM0';
  NAM5 : TwbSignature = 'NAM5';
  NAM9 : TwbSignature = 'NAM9';
  NAME : TwbSignature = 'NAME';
  NNAM : TwbSignature = 'NNAM';
  NPC_ : TwbSignature = 'NPC_';
  NPCO : TwbSignature = 'NPCO';
  NPCS : TwbSignature = 'NPCS';
  NPDT : TwbSignature = 'NPDT';
  ONAM : TwbSignature = 'ONAM';
  PBDT : TwbSignature = 'PBDT';
  PGAG : TwbSignature = 'PGAG';
  PGRC : TwbSignature = 'PGRC';
  PGRD : TwbSignature = 'PGRD';
  PGRP : TwbSignature = 'PGRP';
  PNAM : TwbSignature = 'PNAM';
  PROB : TwbSignature = 'PROB';
  PTEX : TwbSignature = 'PTEX';
  QSTF : TwbSignature = 'QSTF';
  QSTN : TwbSignature = 'QSTN';
  QSTR : TwbSignature = 'QSTR';
  RACE : TwbSignature = 'RACE';
  RADT : TwbSignature = 'RADT';
  REGN : TwbSignature = 'REGN';
  REPA : TwbSignature = 'REPA';
  RGNN : TwbSignature = 'RGNN';
  RIDT : TwbSignature = 'RIDT';
  RNAM : TwbSignature = 'RNAM';
  SCDT : TwbSignature = 'SCDT';
  SCHD : TwbSignature = 'SCHD';
  SCIP : TwbSignature = 'SCIP';
  SCPT : TwbSignature = 'SCPT';
  SCRI : TwbSignature = 'SCRI';
  SCTX : TwbSignature = 'SCTX';
  SCVR : TwbSignature = 'SCVR';
  SKDT : TwbSignature = 'SKDT';
  SKIL : TwbSignature = 'SKIL';
  SNAM : TwbSignature = 'SNAM';
  SNDG : TwbSignature = 'SNDG';
  SOUN : TwbSignature = 'SOUN';
  SPDT : TwbSignature = 'SPDT';
  SPEL : TwbSignature = 'SPEL';
  SSCR : TwbSignature = 'SSCR';
  STAT : TwbSignature = 'STAT';
  STRV : TwbSignature = 'STRV';
  TES3 : TwbSignature = 'TES3';
  TEXT : TwbSignature = 'TEXT';
  TNAM : TwbSignature = 'TNAM';
  UNAM : TwbSignature = 'UNAM';
  VCLR : TwbSignature = 'VCLR';
  VHGT : TwbSignature = 'VHGT';
  VNML : TwbSignature = 'VNML';
  VTEX : TwbSignature = 'VTEX';
  VTXT : TwbSignature = 'VTXT';
  WEAP : TwbSignature = 'WEAP';
  WEAT : TwbSignature = 'WEAT';
  WHGT : TwbSignature = 'WHGT';
  WNAM : TwbSignature = 'WNAM';
  WPDT : TwbSignature = 'WPDT';
  XCHG : TwbSignature = 'XCHG';
  XSCL : TwbSignature = 'XSCL';
  XSOL : TwbSignature = 'XSOL';

var
  wbSkillEnum: IwbEnumDef;
  wbMagicSchoolEnum: IwbEnumDef;
  wbSpecializationEnum: IwbEnumDef;
  wbServiceFlags: IwbFlagsDef;
  wbAttributeEnum: IwbEnumDef;

function wbGLOBFNAM(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr, ctToSummary: begin
      case aInt of
        Ord('s'): Result := 'Short';
        Ord('l'): Result := 'Long';
        Ord('f'): Result := 'Float';
      else
        Result := '<Unknown: '+aInt.ToString+'>';
      end;
    end;
    ctToSortKey: Result := Chr(aInt);
    ctCheck: begin
      case aInt of
        Ord('s'), Ord('l'), Ord('f'): Result := '';
      else
        Result := '<Unknown: '+aInt.ToString+'>';
      end;
    end;
  end;
end;

function wbNPCDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  SubRecord: IwbSubRecord;
begin
  Result := 0;
  if Assigned(aElement) and Supports(aElement.Container, IwbSubRecord, SubRecord) then
    if SubRecord.SubRecordHeaderSize = 12 then
      Result := 1;
end;

function wbGLOBUnionDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  rValue: IwbRecord;
  s: string;
begin
  Result := 0;
  if not Assigned(aElement) then
    Exit;
  rValue := aElement.Container.RecordBySignature[FNAM];
  if Assigned(rValue) then begin
    s := rValue.Value;
    if Length(s) > 0 then
      case s[1] of
        's': Result := 0;
        'l': Result := 1;
        'f': Result := 2;
      end;
  end;
end;

const
  wbKnownSubRecordSignaturesMGEF : TwbKnownSubRecordSignatures = (
    'INDX',
    'DESC',
    '____',
    '____'
  );

  wbKnownSubRecordSignaturesSKIL : TwbKnownSubRecordSignatures = (
    'INDX',
    'DESC',
    '____',
    '____'
  );

  wbKnownSubRecordSignaturesSCPT : TwbKnownSubRecordSignatures = (
    'SCHD',
    '____',
    '____',
    '____'
  );

  wbKnownSubRecordSignaturesINFO : TwbKnownSubRecordSignatures = (
    'INAM',
    'NAME',
    '____',
    '____'
  );

  wbKnownSubRecordSignaturesCELL : TwbKnownSubRecordSignatures = (
    'NAME',
    'NAME',
    '____',
    'DATA'
  );

  wbKnownSubRecordSignaturesREFR : TwbKnownSubRecordSignatures = (
    '____',
    '____',
    'NAME',
    '____'
  );

  wbKnownSubRecordSignaturesLAND : TwbKnownSubRecordSignatures = (
    '____',
    '____',
    '____',
    'INTV'
  );

  wbKnownSubRecordSignaturesPGRD : TwbKnownSubRecordSignatures = (
    'NAME',
    'NAME',
    '____',
    'DATA'
  );


function GridCellToFormID(aFormIDBase: Byte; const aGridCell: TwbGridCell; out aFormID: TwbFormID): Boolean;
begin
  Result := False;
  with aGridCell do begin
    if (x < -512) or (x > 511) or (y < -512) or (y > 511) then
      Exit;
    aFormID := TwbFormID.FromCardinal((Cardinal(x + 512) shl 10) + Cardinal(y + 512) + (Cardinal(aFormIDBase) shl 16));
    Result := True;
  end;
end;

function wbFRMRToString(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  if aType in [ctToStr, ctToSummary, ctToSortKey, ctToEditValue] then begin
    Result := IntToHex(aInt, 8);
    if aType = ctToEditValue then
      Result := '$' + Result;
  end else
    Result := '';
end;


procedure DefineTES3;
var
  wbLAND: IwbMainRecordDef;
begin
  wbHeaderSignature := 'TES3';

  wbKnownSubRecordSignatures[ksrsEditorID] := 'NAME';
  wbKnownSubRecordSignatures[ksrsFullName] := 'FNAM';
  wbKnownSubRecordSignatures[ksrsBaseRecord] := '____';
  wbKnownSubRecordSignatures[ksrsGridCell] := '____';

  wbRecordFlags := wbInteger('Record Flags', itU32, wbFlags([
    {0x00000001}'ESM',
    {0x00000002}'Unknown 2',
    {0x00000004}'Unknown 3',
    {0x00000008}'Unknown 4',
    {0x00000010}'Unknown 5',
    {0x00000020}'Unknown 6',
    {0x00000040}'Unknown 7',
    {0x00000080}'Unknown 8',
    {0x00000100}'Unknown 9',
    {0x00000200}'Unknown 10',
    {Confirmed} {0x00000400}'PersistentReference', {TES3} {ACTI}
    {0x00000800}'Unknown 12',
    {0x00001000}'Unknown 13',
    {Confirmed} {0x00002000}'Blocked', {TES3} {ACTI}
    {0x00004000}'Unknown 15',
    {0x00008000}'Unknown 16',
    {0x00010000}'Unknown 17',
    {0x00020000}'Unknown 18',
    {0x00040000}'Unknown 19',
    {0x00080000}'Unknown 20',
    {0x00100000}'Unknown 21',
    {0x00200000}'Unknown 22',
    {0x00400000}'Unknown 23',
    {0x00800000}'Unknown 24',
    {0x01000000}'Unknown 25',
    {0x02000000}'Unknown 26',
    {0x04000000}'Unknown 27',
    {0x08000000}'Unknown 28',
    {0x10000000}'Unknown 29',
    {0x20000000}'Unknown 30',
    {0x40000000}'Unknown 31',
    {0x80000000}'Unknown 32'
  ]));

  wbMainRecordHeader := wbStruct('Record Header', [
    wbString('Signature', 4, cpCritical),
    wbInteger('Data Size', itU32, nil, cpIgnore),
    wbByteArray('Version Control Info', 4, cpIgnore),
    wbRecordFlags
  ]);

  wbSizeOfMainRecordStruct := 16;

  {Done}
  wbRecord(ACTI, 'Activator', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Name'),
    wbString(SCRI, 'ScriptID')
  ]).SetFormIDBase($40);

  wbActorValueEnum :=
    wbEnum([
      'Strength',
      'Intelligence',
      'Willpower',
      'Agility',
      'Speed',
      'Endurance',
      'Personality',
      'Luck',
      'Health',
      'Magicka',
      'Fatigue',
      'Encumbrance',
      'Armorer',
      'Athletics',
      'Blade',
      'Block',
      'Blunt',
      'Hand To Hand',
      'Heavy Armor',
      'Alchemy',
      'Alteration',
      'Conjuration',
      'Destruction',
      'Illusion',
      'Mysticism',
      'Restoration',
      'Acrobatics',
      'Light Armor',
      'Marksman',
      'Mercantile',
      'Security',
      'Sneak',
      'Speechcraft',
 {33} 'Aggression',
 {34} 'Confidence',
 {35} 'Energy',
 {36} 'Responsibility',
 {37} 'Bounty',
 {38} 'Fame',
 {39} 'Infamy',
 {40} 'Magicka Multiplier',
 {41} 'Night Eye Bonus',
 {42} 'Attack Bonus',
 {43} 'Defend Bonus',
 {44} 'Casting Penalty',
 {45} 'Blindness',
 {46} 'Chameleon',
 {47} 'Invisibility',
 {48} 'Paralysis',
 {49} 'Silence',
 {50} 'Confusion',
 {51} 'Detect Item Range',
 {52} 'Spell Absorb Chance',
 {53} 'Spell Reflect Chance',
 {54} 'Swim Speed Multiplier',
 {55} 'Water Breathing',
 {56} 'Water Walking',
 {57} 'Stunted Magicka',
 {58} 'Detect Life Range',
 {59} 'Reflect Damage',
 {60} 'Telekinesis',
 {61} 'Resist Fire',
 {62} 'Resist Frost',
 {63} 'Resist Disease',
 {64} 'Resist Magic',
 {65} 'Resist Normal Weapons',
 {66} 'Resist Paralysis',
 {67} 'Resist Poison',
 {68} 'Resist Shock',
 {69} 'Vampirism',
 {70} 'Darkness',
 {71} 'Resist Water Damage'
    ], [
      -1, 'None'
    ]);

  wbSkillEnum :=
    wbEnum([
      'Block',
      'Armorer',
      'Medium Armor',
      'Heavy Armor',
      'Blunt Weapon',
      'Long Blade',
      'Axe',
      'Spear',
      'Athletics',
      'Enchant',
      'Destruction',
      'Alteration',
      'Illusion',
      'Conjuration',
      'Mysticism',
      'Restoration',
      'Alchemy',
      'Unarmored',
      'Security',
      'Sneak',
      'Acrobatics',
      'Light Armor',
      'Short Blade',
      'Marksman',
      'Mercantile',
      'Speechcraft',
      'Hand-To-Hand'
    ], [
      -1, 'None'
    ]);

  wbMagicSchoolEnum :=
    wbEnum([
      'Alteration',
      'Conjuration',
      'Destruction',
      'Illusion',
      'Mysticism',
      'Restoration'
    ]);

  wbRecord(ALCH, 'Potion', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(TEXT, 'Inventory Icon'),
    wbString(FNAM, 'Potion Name'),
    wbStruct(ALDT, '', [
      wbFloat('Weight'),
      wbInteger('Value', itU32),
      wbInteger('AutoCalc', itU32)
    ]),
    wbRarray('Enchantments',
      wbStruct(ENAM, 'Enchantment', [
        wbInteger('short EffectID', itU16),
        wbInteger('byte  SkillID', itS8),
        wbInteger('byte  AttributeID', itS8),
        wbInteger('long  Unknown1', itU32),
        wbInteger('long  Unknown2', itU32),
        wbInteger('long  Duration', itU32),
        wbInteger('long  Magnitude', itU32),
        wbInteger('long  Unknown4', itU32)
      ])
    ),
    wbString(SCRI, 'ScriptID')
  ]).SetFormIDBase($40);

  {Done}
  wbRecord(APPA, 'Alchemical Apparatus', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Item Name'),
    wbString(SCRI, 'ScriptID'),
    wbStruct(AADT, 'Data', [
      wbInteger('Type', itU32, wbEnum([
        'Mortar and Pestle',
        'Alembic',
        'Calcinator',
        'Retort'
      ])),
      wbFloat('Quality'),
      wbFloat('Weight'),
      wbInteger('Value', itU32)
    ], cpNormal, True),
    wbString(ITEX, 'Icon Filename')
  ]).SetFormIDBase($40);

  {Done}
  wbRecord(ARMO, 'Armor', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Item Name'),
    wbString(SCRI, 'ScriptID'),
    wbStruct(AODT, 'Armour Data', [
      wbInteger('Armour', itU32, wbEnum([
        'Helmet',
        'Cuirass',
        'L. Pauldron',
        'R. Pauldron',
        'Greaves',
        'Boots',
        'L. Gauntlet',
        'R. Gauntlet',
        'Shield',
        'L. Bracer',
        'R. Bracer'
      ])),
      wbFloat('Weight'),
      wbInteger('Value', itU32),
      wbInteger('Health', itU32),
      wbInteger('EnchantPts', itU32),
      wbInteger('Armour', itU32)
    ]),
    wbString(ITEX, 'Icon Filename'),
    wbRArray('Armour Data',
      wbRStruct('Armour', [
        wbInteger(INDX, 'Body Part Index', itU8, wbEnum([
          'Head',
          'Hair',
          'Neck',
          'Cuirass',
          'Groin',
          'Skirt',
          'Right Hand',
          'Left Hand',
          'Right Wrist',
          'Left Wrist',
          'Shield',
          'Right Forearm',
          'Left Forearm',
          'Right Upper Arm',
          'Left Upper Arm',
          'Right Foot',
          'Left Foot',
          'Right Ankle',
          'Left Ankle',
          'Right Knee',
          'Left Knee',
          'Right Upper Leg',
          'Left Upper Leg',
          'Right Pauldron',
          'Left Pauldron',
          'Weapon',
          'Tail'
        ])),
        wbString(BNAM, 'Male Part Name'),
        wbString(CNAM, 'Female Body Part Name')
      ], [])
    ),
    wbString(ENAM, 'EnchantID')
  ]).SetFormIDBase($40);

  {Done}
  wbRecord(BOOK, 'Book', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Book Name'),
    wbStruct(BKDT, 'Book Data', [
      wbFloat('Weight'),
      wbInteger('Value', itU32),
      { Not sure this might be a Flag, it's 0 when it's not a scroll
      and 01 when it is a scroll }
      wbInteger('Scroll', itU32, wbEnum([
        'Not A Scroll',
        'Scroll'
      ])),
      wbInteger('SkillID', itS32, wbSkillEnum),
      wbInteger('EnchantPts', itU32)
    ]),
    wbString(SCRI, 'ScriptID'),
    wbString(ITEX, 'Icon Filename'),
    {quotes don't work with wbString in the book text}
    {x93Such as?x94 asked Bianki, smiling.<BR>}
    wbString(TEXT, 'Book Text'),
    wbString(ENAM, 'EnchantID')
  ]).SetFormIDBase($40);

  {Done}
  wbRecord(BSGN, 'Birthsign', [
    wbString(NAME, 'ID'),
    wbString(FNAM, 'Name'),
    wbString(TNAM, 'Texture filename'),
    wbString(DESC, 'Description'),
    wbRArray('Spells',
      wbStringForward(NPCS, 'SpellID', 32)
    )
  ]).SetFormIDBase($10);

  wbRecord(CELL, 'Cell', @wbKnownSubRecordSignaturesCELL, [
    wbString(NAME, 'ID'),
    wbStruct(DATA, 'Data', [
      wbInteger('Flags', itU32, wbFlags([
        {0x01} 'Is Interior Cell',
        {0x02} 'Has water',
        {0x04} 'Illegal to Sleep here',
        {0x08} 'Unknown4',
        {0x10} 'Unknown5',
        {0x20} 'Unknown6',
        {0x40} 'Unknown7',
        {0x80} 'Behave like exterior'
      ])),
      wbInteger('X', itS32),
      wbInteger('Y', itS32)
    ]),
    wbInteger(INTV, 'Number of uses', itU32),
    wbString(RGNN, 'Region Name'),

    {Exterior Cell Sub-Records}
    wbStruct(NAM5, 'Map Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
    ]),

    {Exterior Cell Sub-Records}
    wbFloat(WHGT, 'Water Height'),
    wbStruct(AMBI, 'Map Color', [
        wbInteger('AmbientColor', itU32),
        wbInteger('SunlightColor', itU32),
        wbInteger('FogColor', itU32),
        wbFloat('FogDensity')
    ])
  ], True)
  .SetFormIDBase($B0)
  .SetGetGridCellCallback(function(const aSubRecord: IwbSubRecord; out aGridCell: TwbGridCell): Boolean begin
    with aGridCell, aSubRecord do begin
      Result := not (ElementNativeValues['Flags\Is Interior Cell'] = True);
      if Result then begin
        X := ElementNativeValues['X'];
        Y := ElementNativeValues['Y'];
      end;
    end;
  end).SetGetFormIDCallback(function(const aMainRecord: IwbMainRecord; out aFormID: TwbFormID): Boolean begin
    var GridCell: TwbGridCell;
    Result := aMainRecord.GetGridCell(GridCell) and GridCellToFormID($A0, GridCell, aFormID);
  end).SetIdentityCallback(function(const aMainRecord: IwbMainRecord): string begin
    var GridCell: TwbGridCell;
    if aMainRecord.GetGridCell(GridCell) then
      Result := '<Exterior>' + GridCell.SortKey
    else
      Result := aMainRecord.EditorID;
  end);

  wbRecord(REFR, 'Reference', @wbKnownSubRecordSignaturesREFR, [
    wbInteger(FRMR, 'Object Index', itU32, wbFRMRToString, nil, cpIgnore, True).IncludeFlag(dfInternalEditOnly),
    wbString(NAME, 'ID'),
    wbEmpty(DELE, 'Deleted'),
    wbFloat(XSCL, 'Scale'),
    wbString(ANAM, 'Owner'),
    wbString(BNAM, 'Global variable'),
    wbString(XSOL, 'Soul Extra Data'),
    wbString(CNAM, 'Faction'),
    wbInteger(INDX, 'Faction Rank', itS32),
    wbFloat(XCHG, 'Enchantment Charge'),
    wbInteger(INTV, 'Charge', itS32),
    wbInteger(NAM9, 'Gold Value', itS32),
    wbStruct(DODT, 'Cell Travel Destination', [
      wbFloat('XPos'),
      wbFloat('YPos'),
      wbFloat('ZPos'),
      wbFloat('XRot'),
      wbFloat('YRot'),
      wbFloat('ZRot')
    ]),
    wbString(DNAM, 'Door CellID'),
    wbInteger(FLTV, 'Lock Level', itS32),
    wbString(KNAM, 'Door key'),
    wbString(TNAM, 'Trap name'),
    wbInteger(UNAM, 'Reference Blocked', itS8),
    wbStruct(DATA, 'Reference Position Data', [
      wbFloat('XRefPos'),
      wbFloat('YRefPos'),
      wbFloat('ZRefPos'),
      wbFloat('XRefRot'),
      wbFloat('YRefRot'),
      wbFloat('ZRefRot')
    ])
  ]).SetGetFormIDCallback(function(const aMainRecord: IwbMainRecord; out aFormID: TwbFormID): Boolean begin
    var lFRMR := aMainRecord.RecordBySignature[FRMR];
    Result := Assigned(lFRMR);
    if Result then begin
      aFormID := TwbFormID.FromCardinal(lFRMR.NativeValue);
      if aFormID.FileID.FullSlot = 0 then
        aFormID.FileID := TwbFileID.Create($FF);
    end;
  end);

  wbServiceFlags :=
    wbFlags([
      {0x00000001} 'Weapons',
      {0x00000002} 'Armor',
      {0x00000004} 'Clothing',
      {0x00000008} 'Books',
      {0x00000010} 'Ingredients',
      {0x00000020} 'Picks',
      {0x00000040} 'Probes',
      {0x00000080} 'Lights',
      {0x00000100} 'Apparatus',
      {0x00000200} 'Repair',
      {0x00000400} 'Miscellaneous',
      {0x00000800} 'Spells',
      {0x00001000} 'Magic Items',
      {0x00002000} 'Potions',
      {0x00004000} 'Training',
      {0x00008000} 'Spellmaking',
      {0x00010000} 'Enchanting',
      {0x00020000} 'Repair Item'
    ]);

  wbSpecializationEnum := wbEnum(['Combat', 'Magic', 'Stealth']);

  wbRecord(CLAS, 'Class', [
    wbString(NAME, 'ID'),
    wbString(FNAM, 'Class name string'),
    wbStruct(CLDT, '', [
      wbInteger('AttributeID1', itS32),
      wbInteger('AttributeID2', its32),
      wbInteger('Specialization', its32, wbSpecializationEnum),
      wbInteger('MinorID1', its32),
      wbInteger('MajorID1', its32),
      wbInteger('MinorID2', its32),
      wbInteger('MajorID2', its32),
      wbInteger('MinorID3', its32),
      wbInteger('MajorID3', its32),
      wbInteger('MinorID4', its32),
      wbInteger('MajorID4', its32),
      wbInteger('MinorID5', its32),
      wbInteger('MajorID5', its32),
      wbInteger('Flags', its32, wbFlags(['Playable'])),
      wbInteger('AutoCalcFlags', its32, wbServiceFlags)
    ]),
    wbString(DESC, 'Description')
  ]).SetFormIDBase($18);

  wbRecord(CLOT, 'Clothing', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Clothing Name'),
    wbStruct(CTDT, '', [
      wbInteger('Biped Flags', itU32, wbEnum([
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
      ])),
      wbFloat('Weight'),
      wbInteger('Value', itU16),
      wbInteger('EnchantPts', itU16)
    ], cpNormal, True),
    wbString(ITEX, 'Inventory Icon'),
    wbRArray('Clothing Worn',
      wbRStruct('Clothes', [
        wbInteger(INDX, 'Body Part Index', itU8),
        wbString(BNAM, 'Male Body Part Name'),
        wbString(CNAM, 'Female Body Part Name')
      ], [])
    ),
    wbString(ENAM, 'EnchantID'),
    wbString(SCRI, 'ScriptID')
  ]).SetFormIDBase($40);

  wbRecord(CONT, 'Container', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Container Name'),
    wbStruct(CNDT, 'Container Data', [
      wbFloat('Weight')
    ]),
    wbStruct(FLAG, 'Container Flags', [
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Organic',
        {0x00000002} 'Respawns, organic only',
        {0x00000004} 'Unknown3',
        {0x00000008} 'Default, unknown',
        {0x00000010} 'Unknown5',
        {0x00000020} 'Unknown6',
        {0x00000040} 'Unknown7',
        {0x00000080} 'Unknown8'
      ]))
    ]),
    wbRArray('Referenced Items',
      wbStruct(NPCO, 'Item', [
        wbInteger('Count', itU32),
        wbString('Item Name', 32)
      ])
    )
  ]).SetFormIDBase($40);

  wbRecord(CREA, 'Creature', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(CNAM, 'Creatures Naming'),
    wbString(FNAM, 'Creature Name'),
    wbString(SCRI, 'ScriptID'),
    wbStruct(NPDT, 'Creature Data', [
      wbInteger('Type', itU32, wbEnum([
        {0} 'Creature',
        {1} 'Daedra',
        {2} 'Undead',
        {3} 'Humanoid'
      ])),
      wbInteger('Level', itU32),
      wbInteger('Strength', itU32),
      wbInteger('Intelligence', itU32),
      wbInteger('Willpower', itU32),
      wbInteger('Agility', itU32),
      wbInteger('Speed', itU32),
      wbInteger('Endurance', itU32),
      wbInteger('Personality', itU32),
      wbInteger('Luck', itU32),
      wbInteger('Health', itU32),
      wbInteger('SpellPts', itU32),
      wbInteger('Fatigue', itU32),
      wbInteger('Soul', itU32),
      wbInteger('Combat', itU32),
      wbInteger('Magic', itU32),
      wbInteger('Stealth', itU32),
      wbInteger('AttackMin1', itU32),
      wbInteger('AttackMax1', itU32),
      wbInteger('AttackMin2', itU32),
      wbInteger('AttackMax2', itU32),
      wbInteger('AttackMin3', itU32),
      wbInteger('AttackMax3', itU32),
      wbInteger('Gold', itU32)
    ]),
    wbStruct(FLAG, 'Creature Flags', [
      {All these flage need verified}
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Biped',
        {0x00000002} 'Respawn',
        {0x00000004} 'Weapon and shield',
        {0x00000008} 'None',
        {0x00000010} 'Swims',
        {0x00000020} 'Flies',
        {0x00000040} 'Walks',
        {0x00000080} 'Default',
        {0x00000100} 'Unknown9',
        {0x00000200} 'Essential',
        {0x00000400} 'Skeleton Blood',
        {0x00000800} 'Metal Blood',
        {0x00001000} 'Unknown13',
        {0x00002000} 'Unknown14',
        {0x00004000} 'Unknown15',
        {0x00008000} 'Unknown16'
      ]))
    ]),
    wbByteArray(XSCL, 'Unknown'),
    wbRArray('Creature Items',
      wbStruct(NPCO, 'Item', [
        wbInteger('Count', itU32),
        wbString('Name', 32)
      ])
    ),
    wbRArray('Creature Spell',
      wbStruct(NPCS, 'Spell', [
        wbString('Name', 32)
      ])
    ),
    wbStruct(AIDT, 'AI data', [
      wbInteger('Hello', itU8),
      wbInteger('Unknown1', itU8),
      wbInteger('Fight', itU8),
      wbInteger('Flee', itU8),
      wbInteger('Alarm', itU8),
      wbInteger('Unknown2', itU8),
      wbInteger('Unknown3', itU8),
      wbInteger('Unknown4', itU8),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Weapon',
        {0x00000002} 'Armor',
        {0x00000004} 'Clothing',
        {0x00000008} 'Books',
        {0x00000010} 'Ingrediant',
        {0x00000020} 'Picks',
        {0x00000040} 'Probes',
        {0x00000080} 'Lights',
        {0x00000100} 'Apparatus',
        {0x00000200} 'Repair',
        {0x00000400} 'Misc',
        {0x00000800} 'Spells',
        {0x00001000} 'Magic Items',
        {0x00002000} 'Potions',
        {0x00004000} 'Training',
        {0x00008000} 'Spellmaking',
        {0x00010000} 'Enchanting',
        {0x00020000} 'Repair Item',
        {0x00040000} 'Unknown 19',
        {0x00080000} 'Unknown 20'
      ]))
    ]),
    wbStruct(AI_W, 'AI Wander', [
      wbInteger('Distance', itU16),
      wbInteger('Duration', itU8),
      wbInteger('TimeOfDay', itU8),
      wbInteger('Idle', itU8),
      wbByteArray('Unknown' , 1),
      wbByteArray('Unknown' , 4),
      wbByteArray('Unknown' , 4),
      wbByteArray('Unknown')
    ], cpNormal, False, nil, 3),
    wbStruct(AI_T, 'AI Travel', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z'),
      wbInteger('Unknown', itU32)
    ]),
    wbStruct(AI_F, 'AI Follow', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z'),
      wbInteger('Duration', itU16),
      wbString('ID', 32),
      wbInteger('Unknown', itU16)
    ]),
    wbStruct(AI_E, 'AI Escort', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z'),
      wbInteger('Duration', itU16),
      wbString('ID', 32),
      wbInteger('Unknown', itU16)
    ]),
    wbStruct(AI_A, 'AI Activate', [
      wbString('ID', 32),
      wbInteger('Unknown', itU8)
    ]),
    wbFloat(XSCL, 'Scale')
  ]).SetFormIDBase($40);

{ What follows in the ESP/ESM are all the INFO records that belong to the
  DIAL record.  One of the few cases where order is important
}

  wbRecord(DIAL, 'Dialog Topic', [
    wbString(NAME, 'ID'),
    wbInteger(DATA, 'Type', itU8, wbEnum([
      {0} 'Regular Topic',
      {1} 'Voice?',
      {2} 'Greeting?',
      {3} 'Persuasion?',
      {4} 'Journal'
    ]))
  ]).SetFormIDBase($80);

  wbRecord(INFO, 'Dialog response', @wbKnownSubRecordSignaturesINFO, [
    wbString(INAM, 'Info name string'),
    wbString(PNAM, 'Previous info ID'),
    wbString(NNAM, 'Next info ID'),
    wbStruct(DATA, 'Info data', [
      wbInteger('Unknown', itU8),
      wbInteger('Disposition', itU8),
      wbInteger('Rank', itU8),
      wbInteger('Gender', itU8, wbEnum([], [
       $00, 'Male',
       $01, 'Female',
       $FF, 'None'
      ])),
      wbInteger('PCRank', itU8),
      wbInteger('Unknown', itU8)
    ]),
    wbString(ONAM, 'Actor string'),
    wbString(RNAM, 'Race string'),
    wbString(CNAM, 'Class string'),
    wbString(FNAM, 'Faction string'),
    wbString(ANAM, 'Cell string'),
    wbString(DNAM, 'PC Faction string'),
    wbString(NAME, 'ID'),
    wbString(SNAM, 'Sound filename'),
    wbInteger(QSTN, 'Journal Name', itU8, wbEnum([], [1, 'Yes'])).SetDefaultNativeValue(1),
    wbInteger(QSTF, 'Journal Finished', itU8, wbEnum([], [1, 'Yes'])).SetDefaultNativeValue(1),
    wbInteger(QSTR, 'Journal Restart', itU8, wbEnum([], [1, 'Yes'])).SetDefaultNativeValue(1),
    wbRArray('Conditions', wbRStruct('Conditions', [
      wbString(SCVR, 'String for the function/variable'),
      wbRUnion('Result', [
        wbInteger(INTV, 'Result - Integer', itS32),
        wbFloat(FLTV, 'Result - Float')
      ], [])
    ], [])),
    wbString(BNAM, 'Result text (not compiled)')
  ]).SetFormIDBase($90);

  wbRecord(DOOR, 'Door', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Door Name'),
    wbString(SCRI, 'ScriptID'),
    {Needs verification, may not have an SCIP record}
    wbStringScript(SCIP, 'Script Source', 0),
    wbString(SNAM, 'Sound name open'),
    wbString(ANAM, 'Sound name close')
  ]).SetFormIDBase($40);

  wbRecord(ENCH, 'Enchantment', [
    wbString(NAME, 'ID'),
    wbStruct(ENDT, 'Enchant Data', [
      wbInteger('Type', itU32, wbEnum([
        {0} 'Cast Once',
        {1} 'Cast Strikes',
        {2} 'Cast when Used',
        {3} 'Constant Effect'
      ])),
      wbInteger('Enchant Cost', itU32),
      wbInteger('Charge Amount', itU32),
      wbInteger('Auto Calc', itU32)
    ]),
    wbStruct(ENAM, 'Enchant Data', [
      wbInteger('EffectID', itU16),
      wbInteger('SkillID', itU8),
      wbInteger('AttributeID', itU8),
      wbInteger('RangeType', itU32, wbEnum([
        {0} 'Scroll',
        {1} 'Staff',
        {2} 'Weapon',
        {3} 'Apparel'
      ])),
      wbInteger('Area', itU32),
      wbInteger('Duration', itU32),
      wbInteger('MagMin', itU32),
      wbInteger('MagMax', itU32)
    ])
  ]).SetFormIDBase($04);

  wbRecord(FACT, 'Faction', [
    wbString(NAME, 'ID'),
    wbString(FNAM, 'Name'),
    wbRArray('Ranks', wbStringForward(RNAM, 'Rank', 32)),
    wbStruct(FADT, 'Data', [
      wbArray('Attributes', wbInteger('Attribute', itS32, wbAttributeEnum), 2),
      wbArray('Rank Requirements', wbStruct('Rank', [
        wbArray('Attributes', wbInteger('Attribute', itS32), 2),
        wbArray('Skills', wbInteger('Skill', itS32), 2),
        wbInteger('Reaction', itS32)
      ]), 10),
      wbInteger('Flags', its32, wbFlags(['Hidden from Player']))
    ]),
    wbRStructs('Relations','Relation', [
      wbString(ANAM, 'FactionID'),
      wbInteger(INTV, 'Reaction', its32)
    ], [])
  ]).SetFormIDBase($1C);

  wbRecord(GLOB, 'Global', [
    wbString(NAME, 'ID'),
    wbString(FNAM, 'Type', 1),
    wbUnion(FLTV, 'Value', wbGLOBUnionDecider, [
      wbFloat('Comparison Value - Short'),
      wbByteArray('Comparison Value - Long'),
      wbFloat('Comparison Value - Float')
    ])
  ]).SetFormIDBase($58);

  wbRecord(GMST, 'Game Setting', [
    wbString(NAME, 'ID'),
    wbRUnion('Value', [
      wbString(STRV, 'String Value'),
      wbInteger(INTV, 'Interer Value', its32),
      wbFloat(FLTV, 'Float Value')
    ], [])
  ])
  .SetFormIDBase($50)
  .IncludeFlag(dfIndexEditorID);

  wbRecord(INGR, 'Ingredient', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Activator Name'),
    wbStruct(IRDT, 'Ingrediant Data', [
      wbFloat('Weight'),
      wbInteger('Value', itS32),
      wbInteger('EffectID', itS32),
      wbInteger('SkillID', itS32),
      wbInteger('AttributeID', itS32)
    ]),
    wbString(ITEX, 'Inventory icon'),
    wbString(SCRI, 'ScriptID')
  ]).SetFormIDBase($40);

  if wbSimpleRecords then begin

    wbLAND := wbRecord(LAND, 'Landscape', @wbKnownSubRecordSignaturesLAND, [
      wbStruct(INTV, 'Grid', [
        wbInteger('X', itS32),
        wbInteger('Y', itS32)
      ]),
      wbByteArray(DATA, 'Flags', 4),
      wbByteArray(VNML, 'Vertex Normals'),
      wbByteArray(VHGT, 'Vertext Height Map'),
      wbByteArray(WNAM, 'Unknown'),
      wbByteArray(VCLR, 'Vertex Colours'),
      wbByteArray(VTXT, 'Vertex Colours')
    ]);

  end else begin

    wbLAND := wbRecord(LAND, 'Landscape', @wbKnownSubRecordSignaturesLAND, [
      wbStruct(INTV, 'Grid', [
        wbInteger('X', itS32),
        wbInteger('Y', itS32)
      ]),
      wbByteArray(DATA, 'Flags', 4),
      wbArray(VNML, 'Vertex Normals', wbStruct('Row', [
        wbArray('Columns', wbStruct('Column', [
          wbInteger('X', itU8),
          wbInteger('Y', itU8),
          wbInteger('Z', itU8)
        ]), 66)
      ]), 66),
      wbStruct(VHGT, 'Vertext Height Map', [
        wbFloat('Offset'),
        wbByteArray('Unknown', 1),
        wbArray('Rows', wbStruct('Row', [
          wbArray('Columns', wbInteger('Column', itS8), 66)
        ]), 66),
        wbByteArray('Unknown', 2)
      ]),
      wbArray(WNAM, 'Unknown', wbStruct('Row', [
        wbArray('Columns', wbStruct('Column', [
          wbInteger('Unknown', itS8)
        ]), 9)
      ]), 9),
      wbArray(VCLR, 'Vertex Colours', wbStruct('Row', [
        wbArray('Columns', wbStruct('Column', [
          wbInteger('R', itU8),
          wbInteger('G', itU8),
          wbInteger('B', itU8)
        ]), 66)
      ]), 66),
      wbArray(VTEX, 'Textures', wbStruct('Row', [
        wbArray('Columns', wbStruct('Column', [
          wbInteger('Texture', itU16)
        ]), 16)
      ]), 16)
    ]);

  end;

  wbLAND
    .SetFormIDBase($D0)
    .SetFormIDNameBase($B0)
    .SetGetFormIDCallback(function(const aMainRecord: IwbMainRecord; out aFormID: TwbFormID): Boolean begin
      var GridCell: TwbGridCell;
      Result := aMainRecord.GetGridCell(GridCell) and GridCellToFormID($C0, GridCell, aFormID);
    end).SetIdentityCallback(function(const aMainRecord: IwbMainRecord): string begin
      var GridCell: TwbGridCell;
      if aMainRecord.GetGridCell(GridCell) then
        Result := GridCell.SortKey
      else
        Result := '';
    end);

  wbRecord(LIGH, 'Light', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Light Name'),
    wbString(ITEX, 'Inventory icon'),
    wbStruct(LHDT, 'Light Data', [
      wbFloat('Weight'),
      wbInteger('Value', itU32),
      wbInteger('Time', itS32),
      wbInteger('Radius', itU32),
      wbStruct('Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbInteger('Unused', itU8)
      ]),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Dynamic',
        {0x00000002} 'Can be Carried',
        {0x00000004} 'Negative',
        {0x00000008} 'Flicker',
        {0x00000010} 'Fire',
        {0x00000020} 'Off By Default',
        {0x00000040} 'Flicker Slow',
        {0x00000080} 'Pulse',
        {0x00000100} 'Pulse Slow'
      ]))
    ]),
    wbString(SCRI, 'ScriptID'),
    {Need to verify if it has an SCPT record}
    wbStringScript(SCPT, 'Script Source', 0),
    wbString(SNAM, 'Sound name')
  ]).SetFormIDBase($40);

  wbRecord(LTEX, 'Landscape Texture', [
    wbString(NAME, 'ID'),
    wbInteger(INTV, 'Landscape ID Number', itU32),
    wbString(DATA, 'FileName')
  ]).SetFormIDBase($60);

  wbRecord(LEVC, 'Leveled Creature', [
    wbString(NAME, 'ID'),
    wbInteger(DATA, 'Flags', itU32, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count'
    ])),
    wbInteger(NNAM, 'Chance none', itU8),
    wbInteger(INDX, 'Count', itS32),
    wbRArray('Leveled Creature Entries',
      wbRStruct('Leveled Creature', [
        wbString(CNAM, 'Creature Name'),
        wbInteger(INTV, 'Creature Level', itS16)
      ], [])
    )
  ]).SetFormIDBase($40);

  wbRecord(LEVI, 'Leveled Item', [
    wbString(NAME, 'ID'),
    wbInteger(DATA, 'Flags', itU32, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count'
    ])),
    wbInteger(NNAM, 'Chance none', itU8),
    wbInteger(INDX, 'Count', itS32),
    wbRArray('Leveled List Entries',
      wbRStruct('Leveled Item', [
        wbString(INAM, 'Item Name'),
        wbInteger(INTV, 'Item Level', itS16)
      ], [])
    )
  ]).SetFormIDBase($40);

  wbRecord(MGEF, 'Magic Effect', @wbKnownSubRecordSignaturesMGEF, [
    wbInteger(INDX, 'Magic Effect ID', itU32),
    wbStruct(MEDT, 'Effect Data', [
      wbInteger('SpellSchool', itU32, wbMagicSchoolEnum),
      wbFloat('Base cost'),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Unknown1',
        {0x00000002} 'Unknown2',
        {0x00000004} 'Unknown3',
        {0x00000008} 'Unknown4',
        {0x00000010} 'Unknown5',
        {0x00000020} 'Unknown6',
        {0x00000040} 'Unknown7',
        {0x00000080} 'Unknown8',
        {0x00000100} 'Unknown9',
        {0x00000200} 'Spellmaking',
        {0x00000400} 'Enchanting',
        {0x00000800} 'Negative'
      ])),
      wbStruct('Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Uknown', 1)
      ]),
      wbFloat('Speed Multiplier'),
      wbFloat('Size Multiplier'),
      wbFloat('SizeCap'),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4)
    ]),
    wbString(ITEX, 'Effect Icon string'),
    wbString(PTEX, 'Particle texture string'),
    wbString(BSND, 'Bolt sound'),
    wbString(CSND, 'Cast sound'),
    wbString(HSND, 'Hit sound'),
    wbString(ASND, 'Area sound'),
    wbString(CVFX, 'Casting visual string'),
    wbString(BVFX, 'Bolt visual string'),
    wbString(HVFX, 'Hit visual string'),
    wbString(AVFX, 'Area visual string'),
    wbString(DESC, 'Description')
  ]).SetFormIDBase($02);

  wbRecord(MISC, 'Misc. Item', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Item Name'),
    wbStruct(MCDT, '', [
      wbFloat('Weight'),
      wbInteger('Value', itU32),
      wbInteger('Unknown', itS32)
    ]),
    wbString(SCRI, 'Script ID'),
    wbString(ITEX, 'Iventory Icon Filename'),
    wbString(ENAM, 'EnchantID')
  ]).SetFormIDBase($40);

  wbRecord(NPC_, 'Non-Player Character', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'NPC Name'),
    wbString(RNAM, 'Race Name', 0, cpNormal, True),
    wbString(CNAM, 'Class name'),
    wbString(ANAM, 'Faction name', 0, cpNormal, True),
    wbString(BNAM, 'Head model', 0, cpNormal, True),
    wbString(KNAM, 'Hair model', 0, cpNormal, True),
    wbString(SCRI, 'ScriptID'),
    wbStruct(NPDT, 'NPC Data', [
      wbUnion('Data', wbNPCDataDecider, [
        wbStruct('Data 52', [
          wbInteger('Level', itU16),
          wbInteger('Strength', itU8),
          wbInteger('Intelligence', itU8),
          wbInteger('Willpower', itU8),
          wbInteger('Agility', itU8),
          wbInteger('Speed', itU8),
          wbInteger('Endurance', itU8),
          wbInteger('Personality', itU8),
          wbInteger('Luck', itU8),
          wbArray('Skills', wbInteger('Value', itU8), 27),
          wbInteger('Reputation', itU8),
          wbInteger('Health', itU16),
          wbInteger('SpellPts', itU16),
          wbInteger('Fatigue', itU16),
          wbInteger('Disposition', itU8),
          wbInteger('FactionID', itU8),
          wbInteger('Rank', itU8),
          wbInteger('Unknown1', itU8),
          wbInteger('Gold', itU32)
        ]),
        wbStruct('Data 12', [
          wbInteger('Level', itU16),
          wbInteger('Disposition', itU8),
          wbInteger('FactionID', itU8),
          wbInteger('Rank', itU8),
          wbInteger('Unknown1', itU8),
          wbInteger('Unknown2', itU8),
          wbInteger('Unknown3', itU8),
          wbInteger('Gold', itU32)
        ])
      ])
    ]),
    wbStruct(FLAG, 'NPC Flags', [
      wbInteger('Flags', itU32, wbFlags([
        {0x000001} 'Female',
        {0x000002} 'Essential',
        {0x000004} 'Respawn',
        {0x000008} '',
        {0x000010} 'Autocalc',
        {0x000020} 'Blood Skel',
        {0x000040} 'Blood Metal'
      ]))
    ]),
    wbRArray('NPC Items',
      wbStruct(NPCO, 'Item', [
        wbInteger('Count', itU32),
        wbString('Name', 32)
      ])
    ),
    wbRArray('NPC Spell',
      wbStruct(NPCS, 'Spell', [
        wbString('Name', 32)
      ])
    ),
    wbStruct(AIDT, 'AI data', [
      wbInteger('Hello', itU8),
      wbInteger('Unknown1', itU8),
      wbInteger('Fight', itU8),
      wbInteger('Flee)', itU8),
      wbInteger('Alarm', itU8),
      wbInteger('Unknown2', itU8),
      wbInteger('Unknown3', itU8),
      wbInteger('Unknown4', itU8),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Weapon',
        {0x00000002} 'Armor',
        {0x00000004} 'Clothing',
        {0x00000008} 'Books',
        {0x00000010} 'Ingrediant',
        {0x00000020} 'Picks',
        {0x00000040} 'Probes',
        {0x00000080} 'Lights',
        {0x00000100} 'Apparatus',
        {0x00000200} 'Repair',
        {0x00000400} 'Misc',
        {0x00000800} 'Spells',
        {0x00001000} 'Magic Items',
        {0x00002000} 'Potions',
        {0x00004000} 'Training',
        {0x00008000} 'Spellmaking',
        {0x00010000} 'Enchanting',
        {0x00020000} 'Repair Item',
        {0x00040000} 'Unknown 19',
        {0x00080000} 'Unknown 20'
      ]))
    ]),
    wbStruct(DODT, 'Cell Travel Destination', [
      wbFloat('XPos'),
      wbFloat('YPos'),
      wbFloat('ZPos'),
      wbFloat('XRot'),
      wbFloat('YRot'),
      wbFloat('ZRot')
    ]),
    wbString(DNAM, 'Cell escort/follow to'),
    wbStruct(AI_W, 'AI Wander', [
      wbInteger('Distance', itU16),
      wbInteger('Duration', itU16),
      wbInteger('TimeOfDay', itU8),
      wbInteger('Idle', itU8),
      wbInteger('Unknown', itU8)
    ]),
    wbStruct(AI_T, 'AI Travel', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z'),
      wbInteger('Unknown', itU32)
    ]),
    wbStruct(AI_F, 'AI Follow', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z'),
      wbInteger('Duration', itU16),
      wbString('ID', 32),
      wbInteger('Unknown', itU16)
    ]),
    wbStruct(AI_E, 'AI Escort', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z'),
      wbInteger('Duration', itU16),
      wbString('ID', 32),
      wbInteger('Unknown', itU16)
    ]),
    wbString(CNDT, 'Cell escort/follow to'),
    wbStruct(AI_A, 'AI Activate', [
      wbString('ID', 32),
      wbInteger('Unknown', itU8)
    ]),
    wbFloat(XSCL, 'Scale')
  ]).SetFormIDBase($40);

  wbRecord(PGRD, 'Path Grid', @wbKnownSubRecordSignaturesPGRD, [
    wbStruct(DATA, 'Path Grid Data', [
      wbInteger('X', itS32),
      wbInteger('Y', itS32),
      wbInteger('Unknown', itU16),
      wbInteger('Unknown', itU16)
    ], cpNormal, True),
    wbString(NAME, 'ID'),
    wbByteArray(PGAG, 'Unknown'),
    wbByteArray(PGRP, 'Points', 0),
    wbByteArray(PGRC, 'Grids', 0)
  ])
  .SetFormIDBase($F0)
  .SetFormIDNameBase($B0).SetGetGridCellCallback(function(const aSubRecord: IwbSubRecord; out aGridCell: TwbGridCell): Boolean begin
    with aGridCell, aSubRecord do begin
      X := ElementNativeValues['X'];
      Y := ElementNativeValues['Y'];
      Result := not ((X = 0) and (Y = 0));
    end;
  end).SetGetFormIDCallback(function(const aMainRecord: IwbMainRecord; out aFormID: TwbFormID): Boolean begin
    var GridCell: TwbGridCell;
    Result := aMainRecord.GetGridCell(GridCell) and GridCellToFormID($E0, GridCell, aFormID);
  end).SetIdentityCallback(function(const aMainRecord: IwbMainRecord): string begin
    var GridCell: TwbGridCell;
    if aMainRecord.GetGridCell(GridCell) then
      Result := '<Exterior>' + GridCell.SortKey
    else
      Result := aMainRecord.EditorID;
  end);

  {Done}
  wbRecord(BODY, 'Body Parts', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Racial Skin Type'),
    wbStruct(BYDT, 'Body Part Data', [
      wbInteger('Part', itU8, wbEnum([
        'Head',
        'Hair',
        'Neck',
        'Chest',
        'Groin',
        'Hand',
        'Wrist',
        'Forearm',
        'Upperarm',
        'Foot',
        'Ankle',
        'Knee',
        'Upperleg',
        'Clavicle',
        'Tail'
      ])),
      wbInteger('Skin Type', itU8, wbEnum([
        'None',
        'Vampire'
      ])),
      wbInteger('Flags', itU8, wbFlags([
        'Female',
        'Not Playable'
      ])),
      wbInteger('Body Part Type', itU8, wbEnum([
        'Skin',
        'Clothing',
        'Armor'
      ]))
    ])
  ]).SetFormIDBase($20);

  wbRecord(RACE, 'Race', [
    wbString(NAME, 'ID'),
    wbString(FNAM, 'Name'),
    wbStruct(RADT, 'Data', [
      wbArray('Skill Bonuses', wbStruct('Skill Bonus', [
        wbInteger('Skill', itS32, wbSkillEnum),
        wbInteger('Bonus', itS32)
      ]), 7),
      wbArray('Attributes',
        wbArray('Attribute',
          wbInteger('Attribute', itS32),
        ['Male', 'Female']),
      ['Strength', 'Intelligence', 'Willpower', 'Agility', 'Speed', 'Endurance', 'Personality', 'Luck']),
      wbArray('Height',
        wbFloat('Height'),
      ['Male', 'Female']),
      wbArray('Weight',
        wbFloat('Weight'),
      ['Male', 'Female']),
      wbInteger('Flags', itU32, wbFlags(['Playable', 'Beast Race']))
    ]),
    wbRArray('Spells',
      wbStringForward(NPCS, 'SpellID', 32)
    ),
    wbString(DESC, 'Description')
  ], True).SetFormIDBase($14);

  wbRecord(REGN, 'Region', [
    wbString(NAME, 'ID'),
    wbString(FNAM, 'Sound Filename'),
    wbStruct(WEAT, 'Weather Type', [
      wbInteger('Clear', itU8),
      wbInteger('Cloudy', itU8),
      wbInteger('Foggy', itU8),
      wbInteger('Overcast', itU8),
      wbInteger('Rain', itU8),
      wbInteger('Thunder', itU8),
      wbInteger('Ash', itU8),
      wbInteger('Blight', itU8),
      wbByteArray('Unknown', 1),
      wbByteArray('Unknown', 1)
    ]),
    wbString(BNAM, 'Sleep creature string'),
    wbStruct(CNAM, 'Map Color', [
      wbInteger('Red', itU8),
      wbInteger('Green', itU8),
      wbInteger('Blue', itU8),
      wbByteArray('Unused', 1)
    ]),
    wbRArray('Sound Records',
      wbStruct(SNAM, 'Sound Record', [
        wbstring('SoundName', 16),
        wbStruct('Sound Info 1', [
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8)
        ]),
        wbStruct('Sound Info 2', [
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8)
        ]),
        wbStruct('Sound Info 3', [
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8)
        ]),
        wbStruct('Sound Info 4', [
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8)
        ]),
        wbInteger('Chance', itU8)
      ])
    )
  ]).SetFormIDBase($70);

  wbRecord(REPA, 'Repair Items', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Item Name'),
    wbStruct(RIDT, 'Data', [
      wbFloat('Weight'),
      wbInteger('Value', itU32),
      wbInteger('Uses', itU32),
      wbFloat('Quality')
    ]),
    wbString(ITEX, 'Inventory Icon'),
    wbString(SCRI, 'ScriptID')
  ]).SetFormIDBase($40);

  wbRecord(LOCK, 'Lockpicking Items', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Item Name'),
    wbStruct(LKDT, 'Data', [
      wbFloat('Weight'),
      wbInteger('Value', itU32),
      wbFloat('Quality'),
      wbInteger('Uses', itU32)
    ]),
    wbString(ITEX, 'Inventory Icon'),
    wbString(SCRI, 'ScriptID')
  ]).SetFormIDBase($40);

  wbRecord(PROB, 'Probe Items', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Item Name'),
    wbStruct(PBDT, 'Data', [
      wbFloat('Weight'),
      wbInteger('Value', itU32),
      wbFloat('Quality'),
      wbInteger('Uses', itU32)
    ]),
    wbString(ITEX, 'Inventory Icon'),
    wbString(SCRI, 'ScriptID')
  ]).SetFormIDBase($40);

  wbRecord(SCPT, 'Script', @wbKnownSubRecordSignaturesSCPT, [
    wbStruct(SCHD, 'Script Header', [
      wbString('Name', 32),
      wbInteger('NumShorts', itS32),
      wbInteger('NumLongs', itS32),
      wbInteger('NumFloats', itS32),
      wbInteger('ScriptDataSize', itS32),
      wbInteger('LocalVarSize', itS32)
    ]),
    wbArray(SCVR, 'Script Variables', wbString('Script Variables')),
    wbByteArray(SCDT, 'Compiled Script'),
    wbStringScript(SCTX, 'Script Source', 0, cpNormal, True)
  ])
  .SetFormIDBase($30)
  .SetGetEditorIDCallback(function (const aSubRecord: IwbSubRecord): string begin
    Result := aSubRecord.ElementEditValues['Name'];
  end).SetSetEditorIDCallback(procedure (const aSubRecord: IwbSubRecord; const aEditorID: string) begin
    aSubRecord.ElementEditValues['Name'] := aEditorID;
  end);

  wbAttributeEnum :=
    wbEnum([
      'Strength',
      'Intelligence',
      'Willpower',
      'Agility',
      'Speed',
      'Endurance',
      'Personality',
      'Luck'
      ]);

  {Done}
  wbRecord(SKIL, 'Skill', @wbKnownSubRecordSignaturesSKIL, [
    wbInteger(INDX, 'Skill', itS32, wbSkillEnum),
    wbStruct(SKDT, 'Skill Data', [
      wbInteger('Attribute', itS32, wbAttributeEnum),
      wbInteger('Type', itU32, wbEnum([
       {0}'Combat',
       {1}'Magic',
       {2}'Stealth'
      ])),
      wbFloat('Action One'),
      wbFloat('Action Two'),
      wbFloat('Action Three'),
      wbFloat('Action Four')
    ]),
    wbString(DESC, 'Description')
  ]).SetFormIDBase($01);

  wbRecord(SNDG, 'Sound Generator', [
    wbString(NAME, 'ID'),
    wbStruct(DATA, 'Sound Data', [
      wbInteger('Type', itU32, wbEnum([
       {0}'Left Foot',
       {0}'Right Foot',
       {0}'Swim Left',
       {0}'Swim Right',
       {0}'Moan',
       {0}'Roar',
       {0}'Scream',
       {0}'Land'
      ]))
    ]),
    wbString(SNAM, 'Sound ID string'),
    wbString(CNAM, 'Creature name')
  ]).SetFormIDBase($28);

  wbRecord(SOUN, 'Sound', [
    wbString(NAME, 'ID'),
    wbString(FNAM, 'Sound Filename'),
    wbStruct(DATA, 'Sound Data', [
      wbInteger('Volume', itU8),
      wbInteger('MinRange', itS8),
      wbInteger('MaxRange', itS8)
    ])
  ]).SetFormIDBase($40);

  wbRecord(SPEL, 'Spell', [
    wbString(NAME, 'ID'),
    wbString(FNAM, 'Spell Name'),
    wbStruct(SPDT, 'Spell Data', [
      wbInteger('Type', itU32, wbEnum([
        {0} 'Spell',
        {1} 'Ability',
        {2} 'Blight',
        {3} 'Disease',
        {4} 'Curse',
        {5} 'Power'
      ])),
      wbInteger('SpellCost', itU32),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'AutoCalc',
        {0x00000002} 'PC Start',
        {0x00000004} 'Always Succeeds'
      ]))
    ]),
    wbRArray('Enchantment Data',
      wbByteArray(ENAM, 'Unknown', 0)
    )
  ]).SetFormIDBase($0A);

  wbRecord(SSCR, 'Start Script', [
    wbString(DATA, 'Digits'),
    wbString(NAME, 'ID')
  ]).SetFormIDBase($3F);

  {Done}
  wbRecord(STAT, 'Static', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename')
  ]).SetFormIDBase($40);

  wbRecord(TES3, 'Main File Header', [
    wbStruct(HEDR, 'Header', [
      wbFloat('Version'),
      wbRecordFlags,
      wbString('Author', 32),
      wbString('Description', 256),
      wbInteger('Number of Records', itU32)
    ], cpNormal, True),
    wbRArray('Master Files', wbRStruct('Master File', [
      wbStringForward(MAST, 'Filename', 0, cpNormal, True),
      wbInteger(DATA, 'Master Size', itU64, nil, cpNormal, True)
    ], [])).IncludeFlag(dfInternalEditOnly, not wbAllowMasterFilesEdit)
  ], False, nil, cpNormal, True).SetGetFormIDCallback(function(const aMainRecord: IwbMainRecord; out aFormID: TwbFormID): Boolean begin
    Result := True;
    aFormID := TwbFormID.Null;
  end);

  wbRecord(WEAP, 'Weapon', [
    wbString(NAME, 'ID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Item Name'),
    wbStruct(WPDT, 'Weapon Data', [
      wbFloat('Weight'),
      wbInteger('Value', itU32),
      wbInteger('Type', itU16, wbEnum([
        {0} 'ShortBladeOneHand',
        {1} 'LongBladeOneHand',
        {2} 'LongBladeTwoClose',
        {3} 'BluntOneHand',
        {4} 'BluntTwoClose',
        {5} 'BluntTwoWide',
        {6} 'SpearTwoWide',
        {7} 'AxeOneHand',
        {8} 'AxeTwoHand',
        {9} 'MarksmanBow',
        {10} 'MarksmanCrossbow',
        {11} 'MarksmanThrown',
        {12} 'Arrow',
        {13} 'Bolt'
      ])),
      wbInteger('Health', itU16),
      wbFloat('Speed'),
      wbFloat('Reach'),
      wbInteger('EnchantPts', itU16),
      wbInteger('ChopMin', itU8),
      wbInteger('ChopMax', itU8),
      wbInteger('SlashMin', itU8),
      wbInteger('SlashMax', itU8),
      wbInteger('ThrustMin', itU8),
      wbInteger('ThrustMax', itU8),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Unknown1',
        {0x00000002} 'Ignore Normal Weapon Resistance'
      ]))
    ]),
    wbString(ITEX, 'Iventory Icon Filename'),
    wbString(ENAM, 'Enchantment ID string'),
    wbString(SCRI, 'ScriptID')
  ]).SetFormIDBase($40);

  wbAddGroupOrder(GMST);
  wbAddGroupOrder(GLOB);
  wbAddGroupOrder(CLAS);
  wbAddGroupOrder(FACT);
  wbAddGroupOrder(RACE);
  wbAddGroupOrder(SOUN);
  wbAddGroupOrder(SKIL);
  wbAddGroupOrder(MGEF);
  wbAddGroupOrder(SCPT);
  wbAddGroupOrder(REGN);
  wbAddGroupOrder(SSCR);  // To be confirmed
  wbAddGroupOrder(BSGN);
  wbAddGroupOrder(LTEX);
  wbAddGroupOrder(STAT);
  wbAddGroupOrder(DOOR);
  wbAddGroupOrder(MISC);
  wbAddGroupOrder(WEAP);
  wbAddGroupOrder(CONT);
  wbAddGroupOrder(SPEL);
  wbAddGroupOrder(CREA);
  wbAddGroupOrder(BODY);
  wbAddGroupOrder(LIGH);
  wbAddGroupOrder(ENCH);
  wbAddGroupOrder(NPC_);
  wbAddGroupOrder(ARMO);
  wbAddGroupOrder(CLOT);
  wbAddGroupOrder(REPA);
  wbAddGroupOrder(ACTI);
  wbAddGroupOrder(APPA);
  wbAddGroupOrder(LOCK);
  wbAddGroupOrder(PROB);
  wbAddGroupOrder(INGR);
  wbAddGroupOrder(BOOK);
  wbAddGroupOrder(ALCH);
  wbAddGroupOrder(LEVI);
  wbAddGroupOrder(LEVC);
  wbAddGroupOrder(CELL);
  wbAddGroupOrder(LAND);
  wbAddGroupOrder(PGRD);
  wbAddGroupOrder(SNDG);
  wbAddGroupOrder(DIAL);
  wbAddGroupOrder(INFO);

  wbHEDRVersion := 1.30;
end;

initialization
end.
