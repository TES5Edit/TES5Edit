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
//------------------------------------------------------------------------------
// Placeholder for future expansion
//------------------------------------------------------------------------------
unit wbDefinitionsTES3;

interface

procedure DefineTES3;

implementation

uses
  Types, Classes, SysUtils, Math, Variants,
  wbInterface;

const
  ACBS : TwbSignature = 'ACBS';
  ACHR : TwbSignature = 'ACHR';
  ACRE : TwbSignature = 'ACRE';
  TRGT : TwbSignature = 'TRGT';
  ACTI : TwbSignature = 'ACTI';
  AIDT : TwbSignature = 'AIDT';
  ALCH : TwbSignature = 'ALCH';
  AMMO : TwbSignature = 'AMMO';
  ANAM : TwbSignature = 'ANAM';
  ANIO : TwbSignature = 'ANIO';
  APPA : TwbSignature = 'APPA';
  ARMO : TwbSignature = 'ARMO';
  ATTR : TwbSignature = 'ATTR';
  ATXT : TwbSignature = 'ATXT';
  BMDT : TwbSignature = 'BMDT';
  BNAM : TwbSignature = 'BNAM';
  BOOK : TwbSignature = 'BOOK';
  BSGN : TwbSignature = 'BSGN';
  BTXT : TwbSignature = 'BTXT';
  CELL : TwbSignature = 'CELL';
  CLAS : TwbSignature = 'CLAS';
  CLMT : TwbSignature = 'CLMT';
  CLOT : TwbSignature = 'CLOT';
  CNAM : TwbSignature = 'CNAM';
  CNTO : TwbSignature = 'CNTO';
  CONT : TwbSignature = 'CONT';
  CREA : TwbSignature = 'CREA';
  CSAD : TwbSignature = 'CSAD';
  CSCR : TwbSignature = 'CSCR';
  CSDC : TwbSignature = 'CSDC';
  CSDI : TwbSignature = 'CSDI';
  CSDT : TwbSignature = 'CSDT';
  CSTD : TwbSignature = 'CSTD';
  CSTY : TwbSignature = 'CSTY';
  CTDA : TwbSignature = 'CTDA';
  CTDT : TwbSignature = 'CTDT';
  DATA : TwbSignature = 'DATA';
  DATX : TwbSignature = 'DATX';
  DELE : TwbSignature = 'DELE';
  DESC : TwbSignature = 'DESC';
  DIAL : TwbSignature = 'DIAL';
  DNAM : TwbSignature = 'DNAM';
  DOOR : TwbSignature = 'DOOR';
  EDID : TwbSignature = 'EDID';
  EDDX : TwbSignature = 'EDDX';
  EFID : TwbSignature = 'EFID';
  EFIT : TwbSignature = 'EFIT';
  ACVA : TwbSignature = 'ACVA';
  EFII : TwbSignature = 'EFII';
  EFXX : TwbSignature = 'EFXX';
  EFIX : TwbSignature = 'EFIX';
  EFME : TwbSignature = 'EFME';
  EFSH : TwbSignature = 'EFSH';
  ENAM : TwbSignature = 'ENAM';
  ENCH : TwbSignature = 'ENCH';
  ENIT : TwbSignature = 'ENIT';
  ESCE : TwbSignature = 'ESCE';
  EYES : TwbSignature = 'EYES';
  FACT : TwbSignature = 'FACT';
  FGGA : TwbSignature = 'FGGA';
  FGGS : TwbSignature = 'FGGS';
  FGTS : TwbSignature = 'FGTS';
  FLOR : TwbSignature = 'FLOR';
  FLTV : TwbSignature = 'FLTV';
  FNAM : TwbSignature = 'FNAM';
  FULL : TwbSignature = 'FULL';
  FURN : TwbSignature = 'FURN';
  GLOB : TwbSignature = 'GLOB';
  GMST : TwbSignature = 'GMST';
  GNAM : TwbSignature = 'GNAM';
  GRAS : TwbSignature = 'GRAS';
  HAIR : TwbSignature = 'HAIR';
  HCLR : TwbSignature = 'HCLR';
  HEDR : TwbSignature = 'HEDR';
  HNAM : TwbSignature = 'HNAM';
  ICO2 : TwbSignature = 'ICO2';
  ICON : TwbSignature = 'ICON';
  IDLE : TwbSignature = 'IDLE';
  NULL : TwbSignature = 'NULL';
  INAM : TwbSignature = 'INAM';
  INDX : TwbSignature = 'INDX';
  INFO : TwbSignature = 'INFO';
  INGR : TwbSignature = 'INGR';
  JNAM : TwbSignature = 'JNAM';
  KEYM : TwbSignature = 'KEYM';
  KFFZ : TwbSignature = 'KFFZ';
  LAND : TwbSignature = 'LAND';
  LIGH : TwbSignature = 'LIGH';
  LNAM : TwbSignature = 'LNAM';
  LSCR : TwbSignature = 'LSCR';
  LTEX : TwbSignature = 'LTEX';
  LVLC : TwbSignature = 'LVLC';
  LVLD : TwbSignature = 'LVLD';
  LVLF : TwbSignature = 'LVLF';
  LVLI : TwbSignature = 'LVLI';
  LVLO : TwbSignature = 'LVLO';
  LVSP : TwbSignature = 'LVSP';
  MAST : TwbSignature = 'MAST';
  MGEF : TwbSignature = 'MGEF';
  MISC : TwbSignature = 'MISC';
  MNAM : TwbSignature = 'MNAM';
  MO2B : TwbSignature = 'MO2B';
  MO2T : TwbSignature = 'MO2T';
  MO3B : TwbSignature = 'MO3B';
  MO3T : TwbSignature = 'MO3T';
  MO4B : TwbSignature = 'MO4B';
  MO4T : TwbSignature = 'MO4T';
  MOD2 : TwbSignature = 'MOD2';
  MOD3 : TwbSignature = 'MOD3';
  MOD4 : TwbSignature = 'MOD4';
  MODB : TwbSignature = 'MODB';
  MODL : TwbSignature = 'MODL';
  MODT : TwbSignature = 'MODT';
  NAM0 : TwbSignature = 'NAM0';
  NAM1 : TwbSignature = 'NAM1';
  NAM2 : TwbSignature = 'NAM2';
  NAM9 : TwbSignature = 'NAM9';
  NAME : TwbSignature = 'NAME';
  NIFT : TwbSignature = 'NIFT';
  NIFZ : TwbSignature = 'NIFZ';
  NPC_ : TwbSignature = 'NPC_';
  OFST : TwbSignature = 'OFST';
  OBME : TwbSignature = 'OBME';
  ONAM : TwbSignature = 'ONAM';
  PACK : TwbSignature = 'PACK';
  PFIG : TwbSignature = 'PFIG';
  PFPC : TwbSignature = 'PFPC';
  PGAG : TwbSignature = 'PGAG';
  PGRD : TwbSignature = 'PGRD';
  PGRI : TwbSignature = 'PGRI';
  PGRL : TwbSignature = 'PGRL';
  PGRP : TwbSignature = 'PGRP';
  PGRR : TwbSignature = 'PGRR';
  PKDT : TwbSignature = 'PKDT';
  PKID : TwbSignature = 'PKID';
  PLDT : TwbSignature = 'PLDT';
  PNAM : TwbSignature = 'PNAM';
  PSDT : TwbSignature = 'PSDT';
  PTDT : TwbSignature = 'PTDT';
  QNAM : TwbSignature = 'QNAM';
  QSDT : TwbSignature = 'QSDT';
  QSTA : TwbSignature = 'QSTA';
  QSTI : TwbSignature = 'QSTI';
  QSTR : TwbSignature = 'QSTR';
  TPIC : TwbSignature = 'TPIC';
  QUST : TwbSignature = 'QUST';
  RACE : TwbSignature = 'RACE';
  RCLR : TwbSignature = 'RCLR';
  RDAT : TwbSignature = 'RDAT';
  RDGS : TwbSignature = 'RDGS';
  RDMD : TwbSignature = 'RDMD';
  RDMP : TwbSignature = 'RDMP';
  RDOT : TwbSignature = 'RDOT';
  RDSD : TwbSignature = 'RDSD';
  RDWT : TwbSignature = 'RDWT';
  REFR : TwbSignature = 'REFR';
  PLYR : TwbSignature = 'PLYR';
  REGN : TwbSignature = 'REGN';
  RNAM : TwbSignature = 'RNAM';
  ROAD : TwbSignature = 'ROAD';
  RPLD : TwbSignature = 'RPLD';
  RPLI : TwbSignature = 'RPLI';
  SBSP : TwbSignature = 'SBSP';
  SCDA : TwbSignature = 'SCDA';
  SCHD : TwbSignature = 'SCHD';
  SCHR : TwbSignature = 'SCHR';
  SCIT : TwbSignature = 'SCIT';
  SCPT : TwbSignature = 'SCPT';
  SCRI : TwbSignature = 'SCRI';
  SCRO : TwbSignature = 'SCRO';
  SCRV : TwbSignature = 'SCRV';
  SCTX : TwbSignature = 'SCTX';
  SCVR : TwbSignature = 'SCVR';
  SGST : TwbSignature = 'SGST';
  SKIL : TwbSignature = 'SKIL';
  SLCP : TwbSignature = 'SLCP';
  SLGM : TwbSignature = 'SLGM';
  SLSD : TwbSignature = 'SLSD';
  SNAM : TwbSignature = 'SNAM';
  SNDD : TwbSignature = 'SNDD';
  SNDX : TwbSignature = 'SNDX';
  SOUL : TwbSignature = 'SOUL';
  SOUN : TwbSignature = 'SOUN';
  SPEL : TwbSignature = 'SPEL';
  SPIT : TwbSignature = 'SPIT';
  SPLO : TwbSignature = 'SPLO';
  STAT : TwbSignature = 'STAT';
  TCLF : TwbSignature = 'TCLF';
  TCLT : TwbSignature = 'TCLT';
  TES3 : TwbSignature = 'TES3';
  TNAM : TwbSignature = 'TNAM';
  TRDT : TwbSignature = 'TRDT';
  TREE : TwbSignature = 'TREE';
  UNAM : TwbSignature = 'UNAM';
  VCLR : TwbSignature = 'VCLR';
  VHGT : TwbSignature = 'VHGT';
  VNAM : TwbSignature = 'VNAM';
  VNML : TwbSignature = 'VNML';
  VTEX : TwbSignature = 'VTEX';
  VTXT : TwbSignature = 'VTXT';
  WATR : TwbSignature = 'WATR';
  WEAP : TwbSignature = 'WEAP';
  WLST : TwbSignature = 'WLST';
  WNAM : TwbSignature = 'WNAM';
  WRLD : TwbSignature = 'WRLD';
  WTHR : TwbSignature = 'WTHR';
  XACT : TwbSignature = 'XACT';
  XCCM : TwbSignature = 'XCCM';
  XCHG : TwbSignature = 'XCHG';
  XCLC : TwbSignature = 'XCLC';
  XCLL : TwbSignature = 'XCLL';
  XCLR : TwbSignature = 'XCLR';
  XCLW : TwbSignature = 'XCLW';
  XCMT : TwbSignature = 'XCMT';
  XCNT : TwbSignature = 'XCNT';
  XCWT : TwbSignature = 'XCWT';
  XESP : TwbSignature = 'XESP';
  XGLB : TwbSignature = 'XGLB';
  XHLT : TwbSignature = 'XHLT';
  XHRS : TwbSignature = 'XHRS';
  XLCM : TwbSignature = 'XLCM';
  XLOC : TwbSignature = 'XLOC';
  XLOD : TwbSignature = 'XLOD';
  XMRC : TwbSignature = 'XMRC';
  XMRK : TwbSignature = 'XMRK';
  XNAM : TwbSignature = 'XNAM';
  XOWN : TwbSignature = 'XOWN';
  XPCI : TwbSignature = 'XPCI';
  XRGD : TwbSignature = 'XRGD';
  XRNK : TwbSignature = 'XRNK';
  XRTM : TwbSignature = 'XRTM';
  XSCL : TwbSignature = 'XSCL';
  XSED : TwbSignature = 'XSED';
  XSOL : TwbSignature = 'XSOL';
  XTEL : TwbSignature = 'XTEL';
  XTRG : TwbSignature = 'XTRG';
  XXXX : TwbSignature = 'XXXX';
  ZNAM : TwbSignature = 'ZNAM';

var
  wbEDID: IwbSubRecordDef;
  wbXOWN: IwbSubRecordDef;
  wbXGLB: IwbSubRecordDef;
  wbXRGD: IwbSubRecordDef;
  wbSpecializationEnum: IwbEnumDef;
  wbOBMEResolutionInfo: IwbEnumDef;
  wbSoulGemEnum: IwbEnumDef;
  wbMusicEnum: IwbEnumDef;
  wbSLSD: IwbSubRecordDef;
  wbBodyDataIndex: IwbSubRecordDef;
  wbSPLO: IwbSubRecordDef;
  wbSPLOs: IwbSubRecordArrayDef;
  wbCNTO: IwbSubRecordDef;
  wbCNTOs: IwbSubRecordArrayDef;
  wbCSDT: IwbSubRecordStructDef;
  wbCSDTs: IwbSubRecordArrayDef;
  wbFULL: IwbSubRecordDef;
  wbFULLReq: IwbSubRecordDef;
  wbXNAM: IwbSubRecordDef;
  wbXNAMs: IwbSubRecordArrayDef;
  wbDESC: IwbSubRecordDef;
  wbXSCL: IwbSubRecordDef;
  wbDATAPosRot : IwbSubRecordDef;
  wbPosRot : IwbStructDef;
  wbMODL: IwbSubRecordStructDef;
  wbCTDA: IwbSubRecordUnionDef;
  wbSCHR: IwbSubRecordUnionDef;
  wbCTDAs: IwbSubRecordArrayDef;
  wbSCROs: IwbSubRecordArrayDef;
  wbPGRP: IwbSubRecordDef;
  wbResultScript: IwbSubRecordStructDef;
//  wbResultScriptOld: IwbSubRecordStructDef;
  wbSCRI: IwbSubRecordDef;
  wbFaceGen: IwbSubRecordStructDef;
  wbENAM: IwbSubRecordDef;
  wbFGGS: IwbSubRecordDef;
  wbXLOD: IwbSubRecordDef;
  wbXESP: IwbSubRecordDef;
  wbICON: IwbSubRecordDef;
  wbCrimeTypeEnum: IwbEnumDef;
  wbFormTypeEnum: IwbEnumDef;
  wbSexEnum: IwbEnumDef;
  wbAxisEnum: IwbEnumDef;
  wbServiceFlags: IwbFlagsDef;
  wbSkillEnum: IwbEnumDef;
  wbPKDTType: IwbEnumDef;
  wbPKDTFlags: IwbFlagsDef;
  wbQuadrantEnum: IwbEnumDef;
  wbBlendModeEnum: IwbEnumDef;
  wbBlendOpEnum: IwbEnumDef;
  wbZTestFuncEnum: IwbEnumDef;
  wbEFID: IwbSubRecordDef;
  wbEFIDOBME: IwbSubRecordDef;
  wbEFIT: IwbSubRecordDef;
  wbEFITOBME: IwbSubRecordDef;
  wbEFIX: IwbSubRecordDef;
  wbMagicSchoolEnum: IwbEnumDef;
  wbFunctionsEnum: IwbEnumDef;
  wbSCIT: IwbSubRecordStructDef;
  wbSCITOBME: IwbSubRecordStructDef;
  wbEffects: IwbSubRecordUnionDef;

function wbClmtMoonsPhaseLength(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  PhaseLength : Byte;
  Masser      : Boolean;
  Secunda     : Boolean;
begin
  Result := '';
  if aType = ctToSortKey then begin
    Result := IntToHex64(aInt, 2);
  end else if aType = ctToStr then begin
    PhaseLength := aInt mod 64;
    Masser := (aInt and 64) <> 0;
    Secunda := (aInt and 128) <> 0;
    if Masser then
      if Secunda then
        Result := 'Masser, Secunda / '
      else
        Result := 'Masser / '
    else
      if Secunda then
        Result := 'Secunda / '
      else
        Result := 'No Moon / ';
    Result := Result + IntToStr(PhaseLength);
  end;
end;

function wbClmtTime(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 4)
  else if aType = ctToStr then
    Result := TimeToStr( EncodeTime(aInt div 6, (aInt mod 6) * 10, 0, 0) );
end;

var
  wbCtdaTypeFlags : IwbFlagsDef;

function wbCtdaType(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  s: string;
begin
  Result := '';
  case aType of
    ctToStr: begin
      case aInt and $F0 of
        $00 : Result := '等于';
        $20 : Result := '不等于';
        $40 : Result := '大于';
        $60 : Result := '大于或等于';
        $80 : Result := '小于';
        $A0 : Result := '小于或等于';
      else
        Result := '<未知的比较操作符>'
      end;

      if not Assigned(wbCtdaTypeFlags) then
        wbCtdaTypeFlags := wbFlags([
          {0x01} '或',
          {0x02} 'Run on target',
          {0x04} '使用全局'
        ]);

      s := wbCtdaTypeFlags.ToString(aInt and $0F, aElement);

      if s <> '' then
        Result := Result + ' / ' + s;
    end;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2);
      Exit;
    end;
    ctCheck: begin
      case aInt and $F0 of
        $00, $20, $40, $60, $80, $A0 : Result := '';
      else
        Result := '<未知的比较操作符>'
      end;

      if not Assigned(wbCtdaTypeFlags) then
        wbCtdaTypeFlags := wbFlags([
          {0x01} '或',
          {0x02} 'Run on target',
          {0x04} '使用全局'
        ]);

      s := wbCtdaTypeFlags.Check(aInt and $0F, aElement);

      if s <> '' then
        Result := Result + ' / ' + s;
    end;
  end;
end;

function wbIdleAnam(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr: begin
      case aInt and not $80 of
        0: Result := 'Lower Body';
        1: Result := 'Left Arm';
        2: Result := '左手';
        3: Result := 'Right Arm';
        4: Result := 'Special Idle';
        5: Result := 'Whole Body';
        6: Result := 'Upper Body';
      else
        Result := '<未知: '+IntToStr(aInt and not $80)+'>';
      end;

      if (aInt and $80) = 0 then
        Result := Result + ', Must return a file';
    end;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2);
    end;
    ctCheck: begin
      case aInt and not $80 of
        0..6: Result := '';
      else
        Result := '<未知: '+IntToStr(aInt and not $80)+'>';
      end;
    end;
  end;
end;

function wbScaledInt4ToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
const
  PlusMinus : array[Boolean] of string = ('+', '-');
begin
  Result := '';
  case aType of
    ctToStr, ctToEditValue: Result := FloatToStrF(aInt / 10000, ffFixed, 99, 4);
    ctToSortKey: begin
      Result := FloatToStrF(aInt / 10000, ffFixed, 99, 4);
      if Length(Result) < 22 then
        Result := StringOfChar('0', 22 - Length(Result)) + Result;
      Result := PlusMinus[aInt < 0] + Result;
    end;
    ctCheck: Result := '';
  end;
end;

function wbScaledInt4ToInt(const aString: string; const aElement: IwbElement): Int64;
var
  f: Extended;
begin
  f := StrToFloat(aString);
  f := f * 10000;
  Result := Round(f);
end;

function wbHideFFFF(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 4)
  else if aType = ctToStr then
    if aInt = $FFFF then
      Result := '无'
    else
      Result := IntToStr(aInt);
end;

function wbAtxtPosition(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  if aType = ctToSortKey then
    Result := IntToHex64(aInt div 17, 2) + IntToHex64(aInt mod 17, 2)
  else if aType = ctCheck then begin
    if (aInt < 0) or (aInt > 288) then
      Result := '<超出范围：'+IntToStr(aInt)+'>'
    else
      Result := '';
  end else if aType = ctToStr then
    Result := IntToStr(aInt) + ' -> ' + IntToStr(aInt div 17) + ':' + IntToStr(aInt mod 17);
end;

function wbWthrDataClassification(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr: begin
      case aInt and not 192 of
        0: Result := '无';
        1: Result := '晴朗';
        2: Result := '多云';
        3: Result := '下雨';
        4: Result := '下雪';
      else
        Result := '<未知: '+IntToStr(aInt and not 192)+'>';
      end;
    end;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2)
    end;
    ctCheck: begin
      case aInt and not 192 of
        0..4: Result := '';
      else
        Result := '<未知: '+IntToStr(aInt and not 192)+'>';
      end;
    end;
  end;
end;

function wbGLOBFNAM(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr: begin
      case aInt of
        Ord('s'): Result := '短整数';
        Ord('l'): Result := '长整数';
        Ord('f'): Result := '浮点数';
      else
        Result := '<未知: '+IntToStr(aInt)+'>';
      end;
    end;
    ctToSortKey: Result := Chr(aInt);
    ctCheck: begin
      case aInt of
        Ord('s'), Ord('l'), Ord('f'): Result := '';
      else
        Result := '<未知: '+IntToStr(aInt)+'>';
      end;
    end;
  end;
end;

function wbPlacedAddInfo(const aMainRecord: IwbMainRecord): string;
var
  Rec: IwbRecord;
  Container: IwbContainer;
  s: string;
begin
  Result := '';

  Rec := aMainRecord.RecordBySignature['NAME'];
  if Assigned(Rec) then begin
    s := Trim(Rec.Value);
    if s <> '' then
      Result := '放置 ' + s;
  end;

  Container := aMainRecord.Container;
  while Assigned(Container) and (Container.ElementType <> etGroupRecord) do
    Container := Container.Container;

  if Assigned(Container) then begin
    s := Trim(Container.Name);
    if s <> '' then begin
      if Result <> '' then
        Result := Result + ' ';
      Result := Result + '到 ' + s;
    end;
  end;
end;

function wbCellAddInfo(const aMainRecord: IwbMainRecord): string;
var
  Rec: IwbRecord;
  Container: IwbContainer;
  GroupRecord : IwbGroupRecord;
  s: string;
begin
  Result := '';

  Rec := aMainRecord.RecordBySignature['XCLC'];
  if Assigned(Rec) then
      Result := '在 ' + Rec.Elements[0].Value + ',' + Rec.Elements[1].Value;

  Container := aMainRecord.Container;
  while Assigned(Container) and not
    (Supports(Container, IwbGroupRecord, GroupRecord) and (GroupRecord.GroupType = 1))  do
    Container := Container.Container;

  if Assigned(Container) then begin
    s := wbFormID.ToString(GroupRecord.GroupLabel, aMainRecord);
    if s <> '' then begin
      if Result <> '' then
        s := s + ' ';
      Result := '位于 ' + s + Result;
    end;
  end;
end;

function wbGMSTUnionDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  rEDID: IwbRecord;
  s: string;
begin
  Result := 1;
  rEDID := aElement.Container.RecordBySignature[EDID];
  if Assigned(rEDID) then begin
    s := rEDID.Value;
    if Length(s) > 0 then
      case s[1] of
        's': Result := 0;
        'f': Result := 2;
      end;
  end;
end;

function wbMISCActorValueDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  MainRecord : IwbMainRecord;
begin
  Result := 0;

  if not Assigned(aElement) then
    Exit;

  MainRecord := aElement.ContainingMainRecord;
  if not Assigned(MainRecord) then
    Exit;

  if (MainRecord.Flags._Flags and $000000C0) = $000000C0 then
    Result := 1;
end;

function wbXLOCFillerDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  if Container.DataSize = 16 then
    Result := 1;
end;

function wbPACKPKDTDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 1;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  if Container.DataSize = 4 then
    Result := 0;
end;

function wbREFRXSEDDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  if Container.DataSize = 4 then
    Result := 1;
end;


type
  TCTDAFunctionParamType = (
    ptNone,
    ptInteger,
    ptVariableName,  //Integer
    ptSex,           //Enum: Male, Female
    ptActorValue,    //Enum: wbActorValue
    ptCrimeType,     //?? Enum
    ptAxis,          //?? Char
    ptFormType,      //?? Enum
    ptQuestStage,

    ptObjectReference,    //REFR, ACHR, ACRE, PGRE
    ptInventoryObject,    //ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, NOTE, ARMA
    ptActor,              //ACHR, ACRE
    ptQuest,              //QUST
    ptFaction,            //FACT
    ptCell,               //CELL
    ptClass,              //CLAS
    ptRace,               //RACE
    ptActorBase,          //NPC_, CREA
    ptGlobal,             //GLOB
    ptWeather,            //WTHR
    ptPackage,            //PACK
    ptOwnerOpt,           //FACT, NPC_
    ptBirthsign,          //BSGN
    ptFurniture,          //FURN
    ptMagicItem,          //SPEL
    ptMagicEffect,        //MGEF
    ptWorldspace,         //WRLD
    ptReferencableObject
  );

  PCTDAFunction = ^TCTDAFunction;
  TCTDAFunction = record
    Index: Integer;
    Name: string;
    ParamType1: TCTDAFunctionParamType;
    ParamType2: TCTDAFunctionParamType;
  end;

const
  wbCTDAFunctions : array[0..168] of TCTDAFunction = (
    (Index:   1; Name: 'GetDistance'; ParamType1: ptObjectReference),
    (Index:   5; Name: 'GetLocked'),
    (Index:   6; Name: 'GetPos'; ParamType1: ptAxis),
    (Index:   8; Name: 'GetAngle'; ParamType1: ptAxis),
    (Index:  10; Name: 'GetStartingPos'; ParamType1: ptAxis),
    (Index:  11; Name: 'GetStartingAngle'; ParamType1: ptAxis),
    (Index:  12; Name: 'GetSecondsPassed'),
    (Index:  14; Name: 'GetActorValue'; ParamType1: ptActorValue),
    (Index:  18; Name: 'GetCurrentTime'),
    (Index:  24; Name: 'GetScale'),
    (Index:  27; Name: 'GetLineOfSight'; ParamType1: ptObjectReference),
    (Index:  32; Name: 'GetInSameCell'; ParamType1: ptObjectReference),
    (Index:  35; Name: 'GetDisabled'),
    (Index:  36; Name: 'MenuMode'; ParamType1: ptInteger),
    (Index:  39; Name: 'GetDisease'),
    (Index:  40; Name: 'GetVampire'),
    (Index:  41; Name: 'GetClothingValue'),
    (Index:  42; Name: 'SameFaction'; ParamType1: ptActor),
    (Index:  43; Name: 'SameRace'; ParamType1: ptActor),
    (Index:  44; Name: 'SameSex'; ParamType1: ptActor),
    (Index:  45; Name: 'GetDetected'; ParamType1: ptActor),
    (Index:  46; Name: 'GetDead'),
    (Index:  47; Name: 'GetItemCount'; ParamType1: ptInventoryObject),
    (Index:  48; Name: 'GetGold'),
    (Index:  49; Name: 'GetSleeping'),
    (Index:  50; Name: 'GetTalkedToPC'),
    (Index:  53; Name: 'GetScriptVariable'; ParamType1: ptObjectReference; ParamType2: ptVariableName),
    (Index:  56; Name: 'GetQuestRunning'; ParamType1: ptQuest),
    (Index:  58; Name: 'GetStage'; ParamType1: ptQuest),
    (Index:  59; Name: 'GetStageDone'; ParamType1: ptQuest; ParamType2: ptQuestStage),
    (Index:  60; Name: 'GetFactionRankDifference'; ParamType1: ptFaction; ParamType2: ptActor),
    (Index:  61; Name: 'GetAlarmed'),
    (Index:  62; Name: 'IsRaining'),
    (Index:  63; Name: 'GetAttacked'),
    (Index:  64; Name: 'GetIsCreature'),
    (Index:  65; Name: 'GetLockLevel'),
    (Index:  66; Name: 'GetShouldAttack'; ParamType1: ptActor),
    (Index:  67; Name: 'GetInCell'; ParamType1: ptCell),
    (Index:  68; Name: 'GetIsClass'; ParamType1: ptClass),
    (Index:  69; Name: 'GetIsRace'; ParamType1: ptRace),
    (Index:  70; Name: 'GetIsSex'; ParamType1: ptSex),
    (Index:  71; Name: 'GetInFaction'; ParamType1: ptFaction),
    (Index:  72; Name: 'GetIsID'; ParamType1: ptReferencableObject),
    (Index:  73; Name: 'GetFactionRank'; ParamType1: ptFaction),
    (Index:  74; Name: 'GetGlobalValue'; ParamType1: ptGlobal),
    (Index:  75; Name: 'IsSnowing'),
    (Index:  76; Name: 'GetDisposition'; ParamType1: ptActor),
    (Index:  77; Name: 'GetRandomPercent'),
    (Index:  79; Name: 'GetQuestVariable'; ParamType1: ptQuest; ParamType2: ptVariableName),
    (Index:  80; Name: 'GetLevel'),
    (Index:  81; Name: 'GetArmorRating'),
    (Index:  84; Name: 'GetDeadCount'; ParamType1: ptActorBase),
    (Index:  91; Name: 'GetIsAlerted'),
    (Index:  98; Name: 'GetPlayerControlsDisabled'),
    (Index:  99; Name: 'GetHeadingAngle'; ParamType1: ptObjectReference),
    (Index: 101; Name: 'IsWeaponOut'),
    (Index: 102; Name: 'IsTorchOut'),
    (Index: 103; Name: 'IsShieldOut'),
    (Index: 104; Name: 'IsYielding'),
    (Index: 106; Name: 'IsFacingUp'),
    (Index: 107; Name: 'GetKnockedState'),
    (Index: 108; Name: 'GetWeaponAnimType'),
    (Index: 109; Name: 'GetWeaponSkillType'),
    (Index: 110; Name: 'GetCurrentAIPackage'),
    (Index: 111; Name: 'IsWaiting'),
    (Index: 112; Name: 'IsIdlePlaying'),
    (Index: 116; Name: 'GetCrimeGold'),
    (Index: 122; Name: 'GetCrime'; ParamType1: ptActor; ParamType2: ptCrimeType),
    (Index: 125; Name: 'IsGuard'),
    (Index: 127; Name: 'CanPayCrimeGold'),
    (Index: 128; Name: 'GetFatiguePercentage'),
    (Index: 129; Name: 'GetPCIsClass'; ParamType1: ptClass),
    (Index: 130; Name: 'GetPCIsRace'; ParamType1: ptRace),
    (Index: 131; Name: 'GetPCIsSex'; ParamType1: ptSex),
    (Index: 132; Name: 'GetPCInFaction'; ParamType1: ptFaction),
    (Index: 133; Name: 'SameFactionAsPC'),
    (Index: 134; Name: 'SameRaceAsPC'),
    (Index: 135; Name: 'SameSexAsPC'),
    (Index: 136; Name: 'GetIsReference'; ParamType1: ptObjectReference),
    (Index: 141; Name: 'IsTalking'),
    (Index: 142; Name: 'GetWalkSpeed'),
    (Index: 143; Name: 'GetCurrentAIProcedure'),
    (Index: 144; Name: 'GetTrespassWarningLevel'),
    (Index: 145; Name: 'IsTrespassing'),
    (Index: 146; Name: 'IsInMyOwnedCell'),
    (Index: 147; Name: 'GetWindSpeed'),
    (Index: 148; Name: 'GetCurrentWeatherPercent'),
    (Index: 149; Name: 'GetIsCurrentWeather'; ParamType1: ptWeather),
    (Index: 150; Name: 'IsContinuingPackagePCNear'),
    (Index: 153; Name: 'CanHaveFlames'),
    (Index: 154; Name: 'HasFlames'),
    (Index: 157; Name: 'GetOpenState'),
    (Index: 159; Name: 'GetSitting'),
    (Index: 160; Name: 'GetFurnitureMarkerID'),
    (Index: 161; Name: 'GetIsCurrentPackage'; ParamType1: ptPackage),
    (Index: 162; Name: 'IsCurrentFurnitureRef'; ParamType1: ptObjectReference),
    (Index: 163; Name: 'IsCurrentFurnitureObj'; ParamType1: ptFurniture),
    (Index: 170; Name: 'GetDayOfWeek'),
    (Index: 171; Name: 'IsPlayerInJail'),
    (Index: 172; Name: 'GetTalkedToPCParam'; ParamType1: ptActor),
    (Index: 175; Name: 'IsPCSleeping'),
    (Index: 176; Name: 'IsPCAMurderer'),
    (Index: 180; Name: 'GetDetectionLevel'; ParamType1: ptActor),
    (Index: 182; Name: 'GetEquipped'; ParamType1: ptInventoryObject),
    (Index: 185; Name: 'IsSwimming'),
    (Index: 190; Name: 'GetAmountSoldStolen'),
    (Index: 193; Name: 'GetPCExpelled'; ParamType1: ptFaction),
    (Index: 195; Name: 'GetPCFactionMurder'; ParamType1: ptFaction),
    (Index: 197; Name: 'GetPCFactionSteal'; ParamType1: ptFaction),
    (Index: 199; Name: 'GetPCFactionAttack'; ParamType1: ptFaction),
    (Index: 201; Name: 'GetPCFactionSubmitAuthority'; ParamType1: ptFaction),
    (Index: 203; Name: 'GetDestroyed'),
    (Index: 214; Name: 'HasMagicEffect'; ParamType1: ptMagicEffect),
    (Index: 215; Name: 'GetDoorDefaultOpen'),
    (Index: 223; Name: 'IsSpellTarget'; ParamType1: ptMagicItem),
    (Index: 224; Name: 'GetIsPlayerBirthsign'; ParamType1: ptBirthsign),
    (Index: 225; Name: 'GetPersuasionNumber'),
    (Index: 227; Name: 'HasVampireFed'),
    (Index: 228; Name: 'GetIsClassDefault'; ParamType1: ptClass),
    (Index: 229; Name: 'GetClassDefaultMatch'),
    (Index: 230; Name: 'GetInCellParam'; ParamType1: ptCell; ParamType2: ptObjectReference),
    (Index: 237; Name: 'GetIsGhost'),
    (Index: 242; Name: 'GetUnconscious'),
    (Index: 244; Name: 'GetRestrained'),
    (Index: 246; Name: 'GetIsUsedItem'; ParamType1: ptReferencableObject),
    (Index: 247; Name: 'GetIsUsedItemType'; ParamType1: ptFormType),
    (Index: 249; Name: 'GetPCFame'),
    (Index: 251; Name: 'GetPCInfamy'),
    (Index: 254; Name: 'GetIsPlayableRace'),
    (Index: 255; Name: 'GetOffersServicesNow'),
    (Index: 258; Name: 'GetUsedItemLevel'),
    (Index: 259; Name: 'GetUsedItemActivate'),
    (Index: 264; Name: 'GetBarterGold'),
    (Index: 265; Name: 'IsTimePassing'),
    (Index: 266; Name: 'IsPleasant'),
    (Index: 267; Name: 'IsCloudy'),
    (Index: 274; Name: 'GetArmorRatingUpperBody'),
    (Index: 277; Name: 'GetBaseActorValue'; ParamType1: ptActorValue),
    (Index: 278; Name: 'IsOwner'; ParamType1: ptOwnerOpt),
    (Index: 280; Name: 'IsCellOwner'; ParamType1: ptCell; ParamType2: ptOwnerOpt),
    (Index: 282; Name: 'IsHorseStolen'),
    (Index: 285; Name: 'IsLeftUp'),
    (Index: 286; Name: 'IsSneaking'),
    (Index: 287; Name: 'IsRunning'),
    (Index: 288; Name: 'GetFriendHit'; ParamType1: ptActor),
    (Index: 289; Name: 'IsInCombat'),
    (Index: 300; Name: 'IsInInterior'),
    (Index: 305; Name: 'GetInvestmentGold'),
    (Index: 306; Name: 'IsActorUsingATorch'),
    (Index: 309; Name: 'IsXBox'),
    (Index: 310; Name: 'GetInWorldspace'; ParamType1: ptWorldSpace),
    (Index: 312; Name: 'GetPCMiscStat'; ParamType1: ptInteger),
    (Index: 313; Name: 'IsActorEvil'),
    (Index: 314; Name: 'IsActorAVictim'),
    (Index: 315; Name: 'GetTotalPersuasionNumber'),
    (Index: 318; Name: 'GetIdleDoneOnce'),
    (Index: 320; Name: 'GetNoRumors'),
    (Index: 323; Name: 'WhichServiceMenu'),
    (Index: 327; Name: 'IsRidingHorse'),
    (Index: 329; Name: 'IsTurnArrest'),
    (Index: 332; Name: 'IsInDangerousWater'),
    (Index: 338; Name: 'GetIgnoreFriendlyHits'),
    (Index: 339; Name: 'IsPlayersLastRiddenHorse'),
    (Index: 353; Name: 'IsActor'),
    (Index: 354; Name: 'IsEssential'),
    (Index: 358; Name: 'IsPlayerMovingIntoNewSpace'),
    (Index: 361; Name: 'GetTimeDead'),
    (Index: 362; Name: 'GetPlayerHasLastRiddenHorse'),
    (Index: 365; Name: 'GetPlayerInSEWorld')
  );

var
  wbCTDAFunctionEditInfo : string;

function CmpU32(a, b : Cardinal) : Integer;
asm
  xor ecx, ecx
  cmp eax, edx
  ja @@GT
  je @@EQ
@@LT:
  dec ecx
  dec ecx
@@GT:
  inc ecx
@@EQ:
  mov eax, ecx
end;

function wbCTDAParamDescFromIndex(aIndex: Integer): PCTDAFunction;
var
  L, H, I, C: Integer;
begin
  Result := nil;

  L := Low(wbCTDAFunctions);
  H := High(wbCTDAFunctions);
  while L <= H do begin
    I := (L + H) shr 1;
    C := CmpU32(wbCTDAFunctions[I].Index, aIndex);
    if C < 0 then
      L := I + 1
    else begin
      H := I - 1;
      if C = 0 then begin
        L := I;
        Result := @wbCTDAFunctions[L];
      end;
    end;
  end;
end;

function wbCTDACompValueDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  if Integer(Container.ElementByName['类型'].NativeValue) and $04 <> 0 then
    Result := 1;
end;

function wbEFITOBMEParamDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  ParamInfo: Variant;
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  ParamInfo := Container.ElementNativeValues['..\EFME\EFIT Param Info'];
  if VarIsNull(ParamInfo) or VarIsEmpty(ParamInfo) then
  else
    Result := ParamInfo;
end;

function wbEFIXParamDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  ParamInfo: Variant;
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  ParamInfo := Container.ElementNativeValues['..\EFME\EFIX Param Info'];
  if VarIsNull(ParamInfo) or VarIsEmpty(ParamInfo) then
  else
    Result := ParamInfo;
end;

function wbCTDAParam1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Desc: PCTDAFunction;
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  Desc := wbCTDAParamDescFromIndex(Container.ElementByName['函数'].NativeValue);
  if Assigned(Desc) then
    Result := Succ(Integer(Desc.ParamType1));
end;

function wbCTDAParam2Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Desc: PCTDAFunction;
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  Desc := wbCTDAParamDescFromIndex(Container.ElementByName['函数'].NativeValue);
  if Assigned(Desc) then
    Result := Succ(Integer(Desc.ParamType2));
end;
{
function wbCTDAFunction(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Desc: PCTDAFunction;
begin
  Result := '';
  case aType of
    ctToStr: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := Desc.Name
      else
        Result := '<未知: '+IntToStr(aInt)+'>';
    end;
    ctToSortKey: Result := IntToHex(aInt, 8);
    ctCheck: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := ''
      else
        Result := '<未知: '+IntToStr(aInt)+'>';
    end;
  end;
end;
}
function wbCTDAFunctionToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Desc : PCTDAFunction;
  i    : Integer;
begin
  Result := '';
  case aType of
    ctToStr, ctToEditValue: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := Desc.Name
      else if aType = ctToEditValue then
        Result := IntToStr(aInt)
      else
        Result := '<未知: '+IntToStr(aInt)+'>';
    end;
    ctToSortKey: Result := IntToHex(aInt, 8);
    ctCheck: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := ''
      else
        Result := '<未知: '+IntToStr(aInt)+'>';
    end;
    ctEditType:
      Result := 'ComboBox';
    ctEditInfo: begin
      Result := wbCTDAFunctionEditInfo;
      if Result = '' then begin
        with TStringList.Create do try
          for i := Low(wbCTDAFunctions) to High(wbCTDAFunctions) do
            Add(wbCTDAFunctions[i].Name);
          Sort;
          Result := CommaText;
        finally
          Free;
        end;
        wbCTDAFunctionEditInfo := Result;
      end;
    end;
  end;
end;

function wbCTDAFunctionToInt(const aString: string; const aElement: IwbElement): Int64;
var
  i: Integer;
begin
  for i := Low(wbCTDAFunctions) to High(wbCTDAFunctions) do
    with wbCTDAFunctions[i] do
      if SameText(Name, aString) then begin
        Result := Index;
        Exit;
      end;
  Result := StrToInt64(aString);
end;

function wbCTDAParam2VariableNameToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainerElementRef;
  Param1     : IwbElement;
  MainRecord : IwbMainRecord;
  BaseRecord : IwbMainRecord;
  ScriptRef  : IwbElement;
  Script     : IwbMainRecord;
  Variables  : TStringList;
  LocalVars  : IwbContainerElementRef;
  LocalVar   : IwbContainerElementRef;
  i, j       : Integer;
  s          : string;
begin
  case aType of
    ctToStr: Result := IntToStr(aInt) + ' <警告：无法解析参数 1>';
    ctToEditValue: Result := IntToStr(aInt);
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<警告：无法解析参数 1>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not Assigned(aElement) then Exit;
  Container := GetContainerRefFromUnionOrValue(aElement);
  if not Assigned(Container) then Exit;

  Param1 := Container.ElementByName['参数 #1'];

  if not Assigned(Param1) then
    Exit;

  MainRecord := nil;
  if not Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
    Exit;
{    if Param1.NativeValue = 0 then
      if Supports(Container.Container, IwbContainerElementRef, Container) then
        for i := 0 to Pred(Container.ElementCount) do
          if Supports(Container.Elements[i], IwbContainerElementRef, Container2) then
            if SameText(Container2.ElementValues['函数'], 'GetIsID') then begin
              Param1 := Container2.ElementByName['参数 #1'];
              if Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
                Break;
            end;}

  if not Assigned(MainRecord) then
    Exit;

  BaseRecord := MainRecord.BaseRecord;
  if Assigned(BaseRecord) then
    MainRecord := BaseRecord;

  ScriptRef := MainRecord.RecordBySignature['SCRI'];

  if not Assigned(ScriptRef) then begin
    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: "'+MainRecord.ShortName+'" does not contain a SCRI subrecord>';
      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" does not contain a SCRI subrecord>';
    end;
    Exit;
  end;

  if not Supports(ScriptRef.LinksTo, IwbMainRecord, Script) then begin
    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: "'+MainRecord.ShortName+'" does not have a valid script>';
      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" does not have a valid script>';
    end;
    Exit;
  end;

  case aType of
    ctEditType: begin
      Result := 'ComboBox';
      Exit;
    end;
    ctEditInfo:
      Variables := TStringList.Create;
  else
    Variables := nil;
  end;
  try
    if Supports(Script.ElementByName['Local Variables'], IwbContainerElementRef, LocalVars) then begin
      for i := 0 to Pred(LocalVars.ElementCount) do
        if Supports(LocalVars.Elements[i], IwbContainerElementRef, LocalVar) then begin
          j := LocalVar.ElementNativeValues['SLSD\索引'];
          s := LocalVar.ElementNativeValues['SCVR'];
          if Assigned(Variables) then
            Variables.AddObject(s, TObject(j))
          else if j = aInt then begin
            case aType of
              ctToStr, ctToEditValue: Result := s;
              ctCheck: Result := '';
            end;
            Exit;
          end;
        end;
    end;

    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: Variable Index not found in "' + Script.Name + '">';
      ctCheck: Result := '<Warning: Variable Index not found in "' + Script.Name + '">';
      ctEditInfo: begin
        Variables.Sort;
        Result := Variables.CommaText;
      end;
    end;
  finally
    FreeAndNil(Variables);
  end;
end;

function wbCTDAParam2VariableNameToInt(const aString: string; const aElement: IwbElement): Int64;
var
  Container  : IwbContainerElementRef;
  Param1     : IwbElement;
  MainRecord : IwbMainRecord;
  BaseRecord : IwbMainRecord;
  ScriptRef  : IwbElement;
  Script     : IwbMainRecord;
  LocalVars  : IwbContainerElementRef;
  LocalVar   : IwbContainerElementRef;
  i, j       : Integer;
  s          : string;
begin
  Result := StrToInt64Def(aString, Low(Cardinal));
  if Result <> Low(Cardinal) then
    Exit;

  if not Assigned(aElement) then
    raise Exception.Create('aElement not specified');

  Container := GetContainerRefFromUnionOrValue(aElement);

  if not Assigned(Container) then
    raise Exception.Create('Container not assigned');

  Param1 := Container.ElementByName['参数 #1'];

  if not Assigned(Param1) then
    raise Exception.Create('Could not find "Parameter #1"');

  if not Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
    raise Exception.Create('"Parameter #1" does not reference a valid main record');

  BaseRecord := MainRecord.BaseRecord;
  if Assigned(BaseRecord) then
    MainRecord := BaseRecord;

  ScriptRef := MainRecord.RecordBySignature['SCRI'];

  if not Assigned(ScriptRef) then
    raise Exception.Create('"'+MainRecord.ShortName+'" does not contain a SCRI subrecord');

  if not Supports(ScriptRef.LinksTo, IwbMainRecord, Script) then
    raise Exception.Create('"'+MainRecord.ShortName+'" does not have a valid script');

  if Supports(Script.ElementByName['Local Variables'], IwbContainerElementRef, LocalVars) then begin
    for i := 0 to Pred(LocalVars.ElementCount) do
      if Supports(LocalVars.Elements[i], IwbContainerElementRef, LocalVar) then begin
        j := LocalVar.ElementNativeValues['SLSD\索引'];
        s := LocalVar.ElementNativeValues['SCVR'];
        if SameText(s, Trim(aString)) then begin
          Result := j;
          Exit;
        end;
      end;
  end;

  raise Exception.Create('Variable "'+aString+'" was not found in "'+MainRecord.ShortName+'"');
end;

function wbCTDAParam2QuestStageToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainerElementRef;
  Param1     : IwbElement;
  MainRecord : IwbMainRecord;
  EditInfos  : TStringList;
  Stages     : IwbContainerElementRef;
  Stage      : IwbContainerElementRef;
  i, j       : Integer;
  s, t       : string;
begin
  case aType of
    ctToStr: Result := IntToStr(aInt) + ' <警告：无法解析参数 1>';
    ctToEditValue: Result := IntToStr(aInt);
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<警告：无法解析参数 1>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not Assigned(aElement) then Exit;
  Container := GetContainerRefFromUnionOrValue(aElement);
  if not Assigned(Container) then Exit;

  Param1 := Container.ElementByName['参数 #1'];

  if not Assigned(Param1) then
    Exit;

  if not Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
    Exit;

  if MainRecord.Signature <> QUST then begin
    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: "'+MainRecord.ShortName+'" is not a Quest record>';
      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" is not a Quest record>';
    end;
    Exit;
  end;

  case aType of
    ctEditType: begin
      Result := 'ComboBox';
      Exit;
    end;
    ctEditInfo:
      EditInfos := TStringList.Create;
  else
    EditInfos := nil;
  end;
  try
    if Supports(MainRecord.ElementByName['阶段'], IwbContainerElementRef, Stages) then begin
      for i := 0 to Pred(Stages.ElementCount) do
        if Supports(Stages.Elements[i], IwbContainerElementRef, Stage) then begin
          j := Stage.ElementNativeValues['INDX'];
          s := Trim(Stage.ElementValues['日志记录\日志记录\CNAM']);
          t := IntToStr(j);
          while Length(t) < 3 do
            t := '0' + t;
          if s <> '' then
            t := t + ' ' + s;
          if Assigned(EditInfos) then
            EditInfos.AddObject(t, TObject(j))
          else if j = aInt then begin
            case aType of
              ctToStr, ctToEditValue: Result := t;
              ctCheck: Result := '';
            end;
            Exit;
          end;
        end;
    end;

    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: Quest Stage not found in "' + MainRecord.Name + '">';
      ctCheck: Result := '<Warning: Quest Stage not found in "' + MainRecord.Name + '">';
      ctEditInfo: begin
        EditInfos.Sort;
        Result := EditInfos.CommaText;
      end;
    end;
  finally
    FreeAndNil(EditInfos);
  end;
end;

function wbCTDAParam2QuestStageToInt(const aString: string; const aElement: IwbElement): Int64;
var
  i    : Integer;
  s    : string;
begin
  i := 1;
  s := Trim(aString);
  while (i <= Length(s)) and (s[i] in ['0'..'9']) do
    Inc(i);
  s := Copy(s, 1, Pred(i));

  Result := StrToInt(s);
end;

procedure wbRemoveOFST(const aElement: IwbElement);
var
  Container: IwbContainer;
  rOFST: IwbRecord;
begin
  if Supports(aElement, IwbContainer, Container) then begin
    rOFST := Container.RecordBySignature[OFST];
    if Assigned(rOFST) then
      Container.RemoveElement(rOFST);
  end;
end;

procedure wbCELLAfterLoad(const aElement: IwbElement);
var
  Container    : IwbContainerElementRef;
  Container2   : IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
  i            : Integer;
  IsInterior   : Boolean;
  GroupRecord  : IwbGroupRecord;
  Removed      : Boolean;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    if not Container.ElementExists['DATA'] then
      Exit;

    IsInterior := (Container.ElementNativeValues['DATA'] and 1) <> 0;

    if IsInterior then
      Container.Add('XCLL')
    else begin
      Container.Add('XCLC');
      if (Container.ElementNativeValues['DATA'] and 2) = 0 then
        if Supports(MainRecord.Container, IwbGroupRecord, GroupRecord) then
          if GroupRecord.GroupType = 1 then
            Container.ElementNativeValues['DATA'] :=
              Container.ElementNativeValues['DATA'] or 2;
    end;

    Removed := False;
    if Supports(Container.ElementBySignature[XCLR], IwbContainerElementRef, Container2) then begin
      for i:= Pred(Container2.ElementCount) downto 0 do
        if not Supports(Container2.Elements[i].LinksTo, IwbMainRecord, MainRecord) or (MainRecord.Signature <> 'REGN') then begin
          if not Removed then begin
            Removed := True;
            Container2.MarkModifiedRecursive;
          end;
          Container2.RemoveElement(i);
        end;
      if Container2.ElementCount < 1 then
        Container2.Remove;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbMGEFAfterLoad(const aElement: IwbElement);
var
  Container    : IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
  _File        : IwbFile;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    _File := MainRecord._File;

    if not Assigned(_File) then
      Exit;

    if not SameText(_File.FileName, 'Oblivion.esm') then
      Exit;

    if SameText(MainRecord.EditorID, 'RSFI') or
       SameText(MainRecord.EditorID, 'RSFR') or
       SameText(MainRecord.EditorID, 'RSPA') or
       SameText(MainRecord.EditorID, 'RSSH') then begin

         Container.ElementNativeValues['DATA - 数据\标志'] :=
           Cardinal(Container.ElementNativeValues['DATA - 数据\标志']) or $8;

       end;

    if SameText(MainRecord.EditorID, 'REAN') then begin

         Container.ElementNativeValues['DATA - 数据\标志'] :=
           Cardinal(Container.ElementNativeValues['DATA - 数据\标志']) and not $20000;

       end;

  finally
    wbEndInternalEdit;
  end;
end;


procedure wbEFITAfterLoad(const aElement: IwbElement);
var
  Container : IwbContainerElementRef;
  Element   : IwbElement;
  ActorValue: Variant;
  MainRecord: IwbMainRecord;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;
    if Container.ElementCount < 1 then
      Exit;

    Element := Container.ElementByName['Magic effect name'];
    if not Assigned(Element) then
      Exit;
    if not Supports(Element.LinksTo, IwbMainRecord, MainRecord) then
      Exit;
    if MainRecord.Signature <> 'MGEF' then
      Exit;

    if (MainRecord.ElementNativeValues['DATA - 数据\标志'] and $01000000) = 0 then
      Exit;

    ActorValue := MainRecord.ElementNativeValues['DATA - 数据\关联道具'];
    if VarIsNull(ActorValue) or VarIsClear(ActorValue) then
      Exit;
    if VarCompareValue(ActorValue, Container.ElementNativeValues['角色数值']) <> vrEqual then
      Container.ElementNativeValues['角色数值'] := ActorValue;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbREFRAfterLoad(const aElement: IwbElement);
var
  Container: IwbContainerElementRef;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;
    if Container.ElementCount < 1 then
      Exit;

    Container.RemoveElement('XPCI');
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbLIGHAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    if Container.ElementExists['DATA'] then begin
      if SameValue(Container.ElementNativeValues['DATA\衰减指数'], 0.0) then
        Container.ElementNativeValues['DATA\衰减指数'] := 1.0;
      if SameValue(Container.ElementNativeValues['DATA\视场'], 0.0) then
        Container.ElementNativeValues['DATA\视场'] := 90.0;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbLVLAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
  Chance     : Integer;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    Container.RemoveElement('DATA');

    Chance := Container.ElementNativeValues['LVLD'];
    if (Chance and $80) <> 0 then begin
      Chance := Chance and not $80;
      Container.ElementNativeValues['LVLD'] := Chance;
      Container.ElementNativeValues['LVLF'] := Container.ElementNativeValues['LVLF'] or $01;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbRPLDAfterLoad(const aElement: IwbElement);
var
  Container : IwbContainer;
  a, b      : Single;
  NeedsFlip : Boolean;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainer, Container) then
      Exit;

    NeedsFlip := False;
    if Container.ElementCount > 1 then begin
      a := (Container.Elements[0] as IwbContainer).Elements[0].NativeValue;
      b := (Container.Elements[Pred(Container.ElementCount)] as IwbContainer).Elements[0].NativeValue;
      case CompareValue(a, b) of
        EqualsValue: begin
          a := (Container.Elements[0] as IwbContainer).Elements[1].NativeValue;
          b := (Container.Elements[Pred(Container.ElementCount)] as IwbContainer).Elements[1].NativeValue;
          NeedsFlip := CompareValue(a, b) = GreaterThanValue;
        end;
        GreaterThanValue:
          NeedsFlip := True;
      end;
    end;
    if NeedsFlip then
      Container.ReverseElements;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbPGRDAfterLoad(const aElement: IwbElement);
var
  Container   : IwbContainerElementRef;
  MainRecord  : IwbMainRecord;
  Points      : IwbContainerElementRef;
  Connections : IwbContainerElementRef;
  i, j        : Integer;
  Point       : IwbContainerElementRef;
  Connection  : IwbContainerElementRef;
  Removed     : Boolean;
  FirstRemoved: Boolean;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    if not Supports(Container.ElementBySignature['PGRP'], IwbContainerElementRef, Points) then
      Exit;

    if not Container.ElementExists['PGAG'] then
      Container.Add('PGAG').DataSize := (Points.ElementCount + 7) div 8;

    MainRecord.IsCompressed := True;

    if not Supports(Container.ElementBySignature['PGRR'], IwbContainerElementRef, Connections) then
      Exit;

    if Points.ElementCount < Connections.ElementCount then
      Exit;

    FirstRemoved := False;
    for i := Pred(Connections.ElementCount) downto 0 do begin
      Connection := Connections.Elements[i] as IwbContainerElementRef;

      Removed := False;
      j := Connection.ElementCount;
      while j > 0 do begin
        Dec(j);
        if Connection.Elements[j].NativeValue = 65535 then begin
          if not FirstRemoved then begin
            FirstRemoved := True;
            Connections.MarkModifiedRecursive;
          end;
          Connection.Elements[j].Remove;
          Removed := True;
        end else
          Break;
      end;

      if Removed then begin
        Point := Points.Elements[i] as IwbContainerElementRef;
        Point.ElementNativeValues['连接'] := Connection.ElementCount;
      end;

    end;

  finally
    wbEndInternalEdit;
  end;
end;

procedure wbPGRRPointAfterLoad(const aElement: IwbElement);
var
  Connections : IwbContainerElementRef;
  i           : Integer;
//  Index       : Integer;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Connections) then
      Exit;
    for i := Pred(Connections.ElementCount) downto 0 do
      if Connections.Elements[i].NativeValue = 65535 then begin
        Connections.RemoveElement(i);
      end;
{    if Removed then begin
      Index := aElement.Container.ElementCount;
      (aElement.ContainingMainRecord.RecordBySignature['PGRP'].Elements[Index] as IwbContainer).Elements[3].NativeValue := Connections.ElementCount;
    end;}
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbPGRIPointerAfterLoad(const aElement: IwbElement);
var
  Connections : IwbContainerElementRef;
  i, j        : Integer;
  s           : string;
  Keys        : TStringList;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Connections) then
      Exit;

    Keys := TStringList.Create;
    try
      Keys.Sorted := True;
      Keys.Duplicates := dupError;
      for i := Pred(Connections.ElementCount) downto 0 do begin
        s := Connections.Elements[i].SortKey[True];
        if Keys.Find(s, j) then
          Connections.RemoveElement(i, True)
        else
          Keys.Add(s);
      end;
    finally
      Keys.Free;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

{
function wbPGRPConnectionsCallback(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Point : IwbContainerElementRef;
  s     : string;
  i     : Integer;
  PGRP  : IwbContainerElementRef;
  PGRD  : IwbMainRecord;
  PGRR  : IwbContainerElementRef;
  Cons  : IwbContainerElementRef;
begin
  Result := '';
  if aType = ctCheck then
    Exit;

  if wbFixupPGRD and (aInt > 0) and Assigned(aElement) and (aElement.ElementStates * [esModified] = []) then begin
    Point := aElement.Container as IwbContainerElementRef;
    if Assigned(Point) then begin
      s := Trim(Point.Name);
      i := Pos('#', s);
      if i > 0 then begin
        i := StrToIntDef(Copy(s, i+1, High(Integer)), -1);
        if i >= 0 then begin
          PGRP := Point.Container as IwbContainerElementRef;
          if Assigned(PGRP) then begin
            if Supports(PGRP.Container, IwbMainRecord, PGRD) then begin
              if (csInitDone in PGRD.ContainerStates) and (PGRD.Signature = 'PGRD') then begin
                PGRR := PGRD.RecordBySignature['PGRR'] as IwbContainerElementRef;
                if Assigned(PGRR) and (PGRR.ElementCount > 0) and (csInitDone in PGRR.ContainerStates) then begin
                  if (i < PGRR.ElementCount) then begin
                    if Supports(PGRR.Elements[i], IwbContainer, Cons) then begin
                      aInt := Cons.ElementCount;
                    end;
                  end;
                end;
                PGRR := nil;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 2)
  else if aType = ctToStr then
    Result := IntToStr(aInt);
end;
}

function wbPxDTLocationDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  Result := Container.ElementByName['类型'].NativeValue;
end;

function wbCalcPGRRSize(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Index: Integer;
begin
  Index := aElement.Container.ElementCount;
  Result := ((aElement.Container.Container as IwbMainRecord).RecordBySignature['PGRP'].Elements[Pred(Index)] as IwbContainer).Elements[3].NativeValue;
end;

function wbMGEFFAssocItemDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  s: string;
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  s := Container.ElementByName['标志'].SortKey[False];
  if s[17] = '1' then
    Result := 1
  else if s[18] = '1' then
    Result := 2
  else if s[19] = '1' then
    Result := 3
  else if s[25] = '1' then
    Result := 4;
end;

function wbEDDXDontShow(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := True;

  if Supports(aElement.Container, IwbMainRecord, MainRecord) then
    Result := not Assigned(MainRecord.ElementBySignature[OBME]);
end;

function wbOBMEDontShow(const aElement: IwbElement): Boolean;
var
  _File: IwbFile;
begin
  if not Assigned(aElement) then begin
    Result := True;
    Exit;
  end;

  Result := False;

  _File := aElement._File;
  if Assigned(_File) and SameText(_File.FileName, 'Oblivion.esm') then
    Result := True;
end;

procedure DefineTES3;
begin
  HeaderSignature := 'TES3';
  
  wbRecordFlags := wbInteger('记录标志', itU32, wbFlags([
    {0x00000001}'ESM',
    {0x00000002}'',
    {0x00000004}'',
    {0x00000008}'',
    {0x00000010}'',
    {0x00000020}'已删除',
    {0x00000040}'边界地区 / 角色数值',
    {0x00000080}'关闭火 / 角色数值',
    {0x00000100}'',
    {0x00000200}'投射阴影',
    {0x00000400}'任务物品 / 固定衍生 / 菜单显示',
    {0x00000800}'初始禁用',
    {0x00001000}'已忽略',
    {0x00002000}'',
    {0x00004000}'',
    {0x00008000}'远景可见',
    {0x00010000}'',
    {0x00020000}'危险 / 禁止进入 (室内场景)',
    {0x00040000}'已压缩 ',
    {0x00080000}'无法等待'
  ]));

  wbMainRecordHeader := wbStruct('记录头', [
    wbString('签名', 4, cpCritical),
    wbInteger('数据体积', itU32, nil, cpIgnore),
    wbRecordFlags,
    wbFormID('表单序号', cpFormID),
    wbByteArray('未知', 4, cpIgnore)
  ]);

  wbSizeOfMainRecordStruct := 20;

  wbIgnoreRecords.Add(XXXX);

  wbXRGD := wbByteArray(XRGD, '布娃娃数据');

  wbMusicEnum := wbEnum(['默认', '公众场所', '地牢']);

  wbEDID := wbString(EDID, '编辑器标识', 0, cpBenign);
  wbFULL := wbString(FULL, '名称', 0, cpTranslate);
  wbFULLReq := wbString(FULL, '名称', 0, cpNormal, True);
  wbDESC := wbString(DESC, '描述', 0, cpTranslate);
  wbXSCL := wbFloat(XSCL, '范围');

  wbPosRot :=
    wbStruct('方位/角度', [
      wbStruct('方位', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]),
      wbStruct('角度', [
        wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
      ])
    ]);

  wbDATAPosRot :=
    wbStruct(DATA, '方位/角度', [
      wbStruct('方位', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]),
      wbStruct('角度', [
        wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
      ])
    ], cpNormal, True);

  wbMODL :=
    wbRStructSK([0], '模型', [
      wbString(MODL, '模型'),
      wbFloat(MODB, 'Bound Radius', cpBenign),
      wbByteArray(MODT, '材质文件哈希值', 0, cpIgnore)
//      wbArray(MODT, '未知',
//        wbByteArray('未知', 24, cpBenign),
//      0, nil, cpBenign)
    ], []);

  wbSCRI := wbFormIDCk(SCRI, '脚本', [SCPT]);
  wbENAM := wbFormIDCk(ENAM, 'Enchantment', [ENCH]);

  wbXLOD := wbArray(XLOD, '远景细节数据', wbFloat('未知'), 3);
  wbXESP := wbStruct(XESP, '启用根源', [
    wbFormIDCk('衍生', [PLYR, REFR, ACRE, ACHR]),
    wbInteger('标志', itU8, wbFlags([
      '设置父系为相反状态'
    ])),
    wbByteArray('未使用', 3)
  ]);

  wbRecord(ACHR, 'Placed NPC', [
    wbEDID,
    wbFormIDCk(NAME, '基础', [NPC_], False, cpNormal, True),
    wbRStruct('未使用', [
      wbFormIDCk(XPCI, '未使用', [CELL]),
      wbString(FULL, '未使用')
    ], []),
    wbXLOD,
    wbXESP,
    wbFormIDCk(XMRC, 'Merchant container', [REFR], True),
    wbFormIDCk(XHRS, '马', [ACRE], True),
    wbXRGD,
    wbXSCL,
    wbDATAPosRot
  ], True, wbPlacedAddInfo, cpNormal, False, wbREFRAfterLoad);

  wbXOWN := wbFormIDCk(XOWN, '所有者', [FACT, NPC_]);
  wbXGLB := wbFormIDCk(XGLB, '全局变量', [GLOB]);

  wbRecord(ACRE, 'Placed Creature', [
    wbEDID,
    wbFormIDCk(NAME, '基础', [CREA], False, cpNormal, True),
    wbRStruct('所有权', [
      wbXOWN,
      wbInteger(XRNK, '派系等级', itS32),
      wbXGLB
    ], []),
    wbXESP,
    wbXRGD,
    wbXSCL,
    wbDATAPosRot
  ], True, wbPlacedAddInfo);

  wbRecord(ACTI, 'Activator', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbSCRI,
    wbFormIDCk(SNAM, '音效', [SOUN])
  ]);

  wbICON := wbString(ICON, '图标');

  wbActorValueEnum :=
    wbEnum([
      '力量',
      '智力',
      '意志力',
      '敏捷',
      '速度',
      '耐力',
      '魅力',
      '运气',
      '生命',
      '法力',
      '体力',
      '耐力',
      'Armorer',
      'Athletics',
      'Blade',
      '格挡',
      'Blunt',
      '徒手格斗',
      '重甲',
      '炼金',
      '改变系',
      '召唤系',
      '毁灭系',
      '幻术系',
      'Mysticism',
      '恢复系',
      'Acrobatics',
      '轻甲',
      '箭术',
      'Mercantile',
      'Security',
      '潜行',
      '口才',
 {33} '好战',
 {34} '信心',
 {35} '活力',
 {36} '品德',
 {37} 'Bounty',
 {38} '名望',
 {39} '恶名',
 {40} 'Magicka Multiplier',
 {41} '夜视 Bonus',
 {42} 'Attack Bonus',
 {43} 'Defend Bonus',
 {44} 'Casting Penalty',
 {45} '失明',
 {46} 'Chameleon',
 {47} '隐形',
 {48} '麻痹',
 {49} 'Silence',
 {50} 'Confusion',
 {51} 'Detect Item Range',
 {52} '魔法吸收概率',
 {53} 'Spell Reflect Chance',
 {54} '游泳速度加成',
 {55} '水下呼吸',
 {56} '水下行走',
 {57} 'Stunted Magicka',
 {58} '生命检测范围',
 {59} 'Reflect Damage',
 {60} '隔空取物',
 {61} '火焰抵抗',
 {62} '冰冻抵抗',
 {63} '疾病抵抗',
 {64} '魔法抵抗',
 {65} 'Resist Normal Weapons',
 {66} 'Resist Paralysis',
 {67} 'Resist Poison',
 {68} '闪电抵抗',
 {69} 'Vampirism',
 {70} 'Darkness',
 {71} 'Resist Water Damage'
    ], [
      -1, '无'
    ]);

  wbSkillEnum :=
    wbEnum([
      'Armorer',
      'Athletics',
      'Blade',
      '格挡',
      'Blunt',
      '徒手格斗',
      '重甲',
      '炼金',
      '改变系',
      '召唤系',
      '毁灭系',
      '幻术系',
      'Mysticism',
      '恢复系',
      'Acrobatics',
      '轻甲',
      '箭术',
      'Mercantile',
      'Security',
      '潜行',
      '口才'
    ], [
      -1, '无'
    ]);


  wbEFID := wbInteger(EFID, 'Magic effect name', itU32, wbChar4, cpNormal, True);

  wbEFIDOBME := wbStringMgefCode(EFID, 'Magic Effect Code', 4, cpNormal, True);

  wbEFIT :=
    wbStructSK(EFIT, [4, 5], '', [
      wbInteger('Magic effect name', itU32, wbChar4),
      wbInteger('量级', itU32),
      wbInteger('范围', itU32),
      wbInteger('持续时间', itU32),
      wbInteger('类型', itU32, wbEnum(['自身', '接触', '目标'])),
      wbInteger('角色数值', itS32, wbActorValueEnum)
    ], cpNormal, True, nil, -1, wbEFITAfterLoad);

  wbEFITOBME :=
    wbStructSK(EFIT, [4, 5], '', [
      wbStringMgefCode('Magic Effect Code', 4),
      wbInteger('量级', itU32),
      wbInteger('范围', itU32),
      wbInteger('持续时间', itU32),
      wbInteger('类型', itU32, wbEnum(['自身', '接触', '目标'])),
      wbUnion('Param #1', wbEFITOBMEParamDecider, [
        wbByteArray('Param #1 - Unknown Type', 4),
        wbFormID('Param #1 - FormID'),
        wbStringMgefCode('Param #1 - Magic Effect Code', 4),
        wbFormIDCk('Param #1 - Actor Value', [ACVA])
      ])
    ], cpNormal, True, nil, -1{, wbEFITAfterLoad});

  wbEFIX :=
    wbStructSK(EFIX, [3], '', [
      wbInteger('Override Mask', itU32, wbFlags([])),
      wbInteger('标志', itU32, wbFlags([])),
      wbFloat('基本消耗'),
      wbUnion('Param #2', wbEFIXParamDecider, [
        wbByteArray('Param #2 - Unknown Type', 4),
        wbFormID('Param #2 - FormID'),
        wbStringMgefCode('Param #2 - Magic Effect Code', 4),
        wbFormIDCk('Param #2 - Actor Value', [ACVA])
      ])
    ], cpNormal, True, nil, -1, wbEFITAfterLoad);

  wbMagicSchoolEnum :=
    wbEnum([
      '改变系',
      '召唤系',
      '毁灭系',
      '幻术系',
      'Mysticism',
      '恢复系'
    ]);

  wbSCIT :=
    wbRStructSK([0], 'Script effect', [
      wbStructSK(SCIT, [0], 'Script effect data', [
        wbFormIDCk('Script effect', [NULL, SCPT]),
        wbInteger('Magic school', itU32, wbMagicSchoolEnum),
        wbInteger('Visual effect name', itU32, wbChar4),
        wbInteger('标志', itU8, wbFlags(['敌对的'])),
        wbByteArray('未使用', 3)
      ], cpNormal, True, nil, 1),
      wbFULLReq
    ], []);

  wbSCITOBME :=
    wbRStructSK([0], 'Script effect', [
      wbStructSK(SCIT, [0], 'Script effect data', [
        wbFormIDCk('Script effect', [NULL, SCPT]),
        wbInteger('Magic school', itU32, wbMagicSchoolEnum),
        wbStringMgefCode('视觉效果代码', 4),
        wbInteger('标志', itU8, wbFlags(['敌对的'])),
        wbByteArray('未使用', 3)
      ], cpNormal, True, nil, 1),
      wbFULLReq
    ], []);


  wbOBMEResolutionInfo := wbEnum(['无', '表单序号', 'Magic Effect Code', '角色数值']);

  wbEffects :=
    wbRUnion('效果', [
      wbRStruct('效果', [
        wbRStructs('效果','效果', [
          wbEFID,
          wbEFIT,
          wbSCIT
        ], [])
      ], []),
      wbRStruct('效果', [
        wbRStructs('效果','效果', [
          wbStruct(EFME, 'Oblivion Magic Extender', [
            wbInteger('Record Version', itU8),
            wbStruct('OBME Version', [
              wbInteger('Beta', itU8),
              wbInteger('Minor', itU8),
              wbInteger('Major', itU8)
            ]),
            wbInteger('EFIT Param Info', itU8, wbOBMEResolutionInfo),
            wbInteger('EFIX Param Info', itU8, wbOBMEResolutionInfo),
            wbByteArray('未使用', $0A)
          ]),
          wbEFIDOBME,
          wbEFITOBME,
          wbSCITOBME,
          wbString(EFII, '图标'),
          wbEFIX
        ], []),
        wbEmpty(EFXX, 'Effects End Marker', cpNormal, True),
        wbFULLReq
      ], [])
    ], []);

  wbRecord(ALCH, 'Potion', [
    wbEDID,
    wbStruct(OBME, 'Oblivion Magic Extender', [
      wbInteger('Record Version', itU8),
      wbStruct('OBME Version', [
        wbInteger('Beta', itU8),
        wbInteger('Minor', itU8),
        wbInteger('Major', itU8)
      ]),
      wbByteArray('未使用', $1C)
    ], cpNormal, False, wbOBMEDontShow),
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbFloat(DATA, '重量', cpNormal, True),
    wbStruct(ENIT, '', [
      wbInteger('价值', itS32),
      wbInteger('标志', itU8, wbFlags(['不自动计算', '食物'])),
      wbByteArray('未使用', 3)
    ], cpNormal, True),
    wbEffects
  ]);

  wbRecord(AMMO, 'Ammunition', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbICON,
    wbFormIDCk(ENAM, 'Enchantment', [ENCH]),
    wbInteger(ANAM, 'Enchantment Points', itU16),
    wbStruct(DATA, '', [
      wbFloat('速度'),
      wbInteger('标志', itU8, wbFlags(['无视普通武器抗性'])),
      wbByteArray('未使用', 3),
      wbInteger('价值', itU32),
      wbFloat('重量'),
      wbInteger('伤害', itU16)
    ], cpNormal, True)
  ]);

  wbRecord(ANIO, 'Animated Object', [
    wbEDID,
    wbMODL,
    wbFormIDCk(DATA, 'IDLE animation', [IDLE], False, cpNormal, True)
  ]);

  wbRecord(APPA, 'Alchemical Apparatus', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbStruct(DATA, '', [
      wbInteger('类型', itU8, wbEnum(['Mortar and Pestle', 'Alembic', 'Calcinator', 'Retort'])),
      wbInteger('价值', itU32),
      wbFloat('重量'),
      wbFloat('质量')
    ], cpNormal, True)
  ]);

  wbRecord(ARMO, 'Armor', [
    wbEDID,
    wbFULL,
    wbSCRI,
    wbENAM,
    wbInteger(ANAM, 'Enchantment Points', itU16),
    wbStruct(BMDT, '', [
      wbInteger('Biped Flags', itU16, wbFlags([
        {0x00000001} '头部',
        {0x00000002} '发型',
        {0x00000004} 'Upper Body',
        {0x00000008} 'Lower Body',
        {0x00000010} 'Hand',
        {0x00000020} 'Foot',
        {0x00000040} 'Right Ring',
        {0x00000080} 'Left Ring',
        {0x00000100} '项链',
        {0x00000200} '武器',
        {0x00000400} 'Back Weapon',
        {0x00000800} 'Side Weapon',
        {0x00001000} 'Quiver',
        {0x00002000} '盾牌',
        {0x00004000} '火把',
        {0x00008000} '尾巴'
      ])),
      wbInteger('一般标志', itU8, wbFlags([
        {0x0001} 'Hide Rings',
        {0x0002} 'Hide Amulets',
        {0x0004} '',
        {0x0008} '',
        {0x0010} '',
        {0x0020} '',
        {0x0040} '玩家不可用',
        {0x0080} 'Heavy armor'
      ])),
      wbByteArray('未使用', 1)
    ], cpNormal, True),
    wbRStruct('Male biped model', [
      wbString(MODL, '模型'),
      wbFloat(MODB, 'Bound Radius', cpBenign),
      wbByteArray(MODT, '材质文件哈希值', 0, cpIgnore)
    ], []),
    wbRStruct('男性世界模型', [
      wbString(MOD2, '模型'),
      wbFloat(MO2B, 'Bound Radius', cpBenign),
      wbByteArray(MO2T, '材质文件哈希值', 0, cpIgnore)
    ], []),
    wbString(ICON, 'Male icon filename'),
    wbRStruct('Female biped model', [
      wbString(MOD3, '模型'),
      wbFloat(MO3B, 'Bound Radius', cpBenign),
      wbByteArray(MO3T, '材质文件哈希值', 0, cpIgnore)
    ], []),
    wbRStruct('女性世界模型', [
      wbString(MOD4, '模型'),
      wbFloat(MO4B, 'Bound Radius', cpBenign),
      wbByteArray(MO4T, '材质文件哈希值', 0, cpIgnore)
    ], []),
    wbString(ICO2, 'Female icon filename'),
    wbStruct(DATA, '', [
      wbInteger('Armor', itU16, wbDiv(100)),
      wbInteger('价值', itU32),
      wbInteger('生命', itU32),
      wbFloat('重量')
    ], cpNormal, True)
  ]);

  wbRecord(BOOK, 'Book', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbENAM,
    wbInteger(ANAM, 'Enchantment Points', itU16),
    wbDESC,
    wbStruct(DATA, '', [
      wbInteger('标志', itU8, wbFlags(['卷轴', '无法带走'])),
      wbInteger('传授', itS8, wbSkillEnum),
      wbInteger('价值', itU32),
      wbFloat('重量')
    ], cpNormal, True)
  ], True);

  wbSPLO := wbFormIDCk(SPLO, '法术', [SPEL, LVSP]);
  wbSPLOs := wbRArrayS('Spells', wbSPLO);

  wbRecord(BSGN, 'Birthsign', [
    wbEDID,
    wbFULL,
    wbICON,
    wbDESC,
    wbSPLOs
  ]);

  wbRecord(CELL, 'Cell', [
    wbEDID,
    wbFULL,
    wbInteger(DATA, '标志', itU8, wbFlags([
      {0x01} '室内场景',
      {0x02} '存在水源',
      {0x04} '无法快速旅行到这边',
      {0x08} '强制隐藏景观 (室外场景) / 湮没室内 (室内场景)',
      {0x10} '',
      {0x20} '公共场所',
      {0x40} '已手动修改',
      {0x80} '表现为室外'
    ]), cpNormal, True),
    wbStruct(XCLC, '网格', [
      wbInteger('X', itS32),
      wbInteger('Y', itS32)
    ]),
    wbStruct(XCLL, '光照', [
      wbStruct('环境颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbStruct('指向颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbStruct('雾颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbFloat('雾近距离'),
      wbFloat('雾远距离'),
      wbInteger('指向角度 XY', itS32),
      wbInteger('指向角度 Z', itS32),
      wbFloat('指向淡出', cpNormal, False, 1, -1, nil, nil, 1.0),
      wbFloat('雾裁剪距离')
    ]),
    wbArrayS(XCLR, '地区', wbFormIDCk('地区', [REGN])),
    wbInteger(XCMT, '音乐', itU8, wbMusicEnum),
    wbFloat(XCLW, '水面高度', cpBenign),
    wbFormIDCk(XCCM, '气候', [CLMT]),
    wbFormIDCk(XCWT, '水源', [WATR]),
    wbRStruct('所有权', [
      wbXOWN,
      wbInteger(XRNK, '派系等级', itS32),
      wbXGLB
    ], [XCLW, XCMT])
  ], True, wbCellAddInfo, cpNormal, False, wbCELLAfterLoad);

  wbServiceFlags :=
    wbFlags([
      {0x00000001} 'Weapons',
      {0x00000002} 'Armor',
      {0x00000004} '服装',
      {0x00000008} 'Books',
      {0x00000010} 'Ingredients',
      {0x00000020} '',
      {0x00000040} '',
      {0x00000080} 'Lights',
      {0x00000100} 'Apparatus',
      {0x00000200} '',
      {0x00000400} '杂项',
      {0x00000800} 'Spells',
      {0x00001000} 'Magic Items',
      {0x00002000} 'Potions',
      {0x00004000} 'Training',
      {0x00008000} '',
      {0x00010000} 'Recharge',
      {0x00020000} 'Repair'
    ]);

  wbSpecializationEnum := wbEnum(['战斗', 'Magic', 'Stealth']);

  wbRecord(CLAS, 'Class', [
    wbEDID,
    wbFULL,
    wbDESC,
    wbICON,
    wbStruct(DATA, '', [
      wbArrayS('Primary Attributes', wbInteger('Primary Attribute', itS32, wbActorValueEnum), 2),
      wbInteger('Specialization', itU32, wbSpecializationEnum),
      wbArrayS('Major Skills', wbInteger('Major Skill', itS32, wbActorValueEnum), 7),
      wbInteger('标志', itU32, wbFlags(['玩家可用', 'Guard'])),
      wbInteger('Buys/Sells and Services', itU32, wbServiceFlags),
      wbInteger('传授', itS8, wbSkillEnum),
      wbInteger('最大训练等级', itU8),
      wbInteger('未使用', itU16)
    ], cpNormal, True, nil, 5)
  ]);

  wbRecord(CLMT, 'Climate', [
    wbEDID,
    wbArrayS(WLST, '天气类型', wbStructSK([0], '天气类型', [
      wbFormIDCk('天气', [WTHR]),
      wbInteger('概率', itS32)
    ])),
    wbString(FNAM, '太阳材质'),
    wbString(GNAM, '太阳光晕材质'),
    wbMODL,
    wbStruct(TNAM, '时间', [
      wbStruct('日出', [
        wbInteger('开始', itU8, wbClmtTime),
        wbInteger('结束', itU8, wbClmtTime)
      ]),
      wbStruct('日落', [
        wbInteger('开始', itU8, wbClmtTime),
        wbInteger('结束', itU8, wbClmtTime)
      ]),
      wbInteger('波动', itU8),
      wbInteger('月亮 / 位相长度', itU8, wbClmtMoonsPhaseLength)
    ], cpNormal, True)
  ]);

  wbRecord(CLOT, 'Clothing', [
    wbEDID,
    wbFULL,
    wbSCRI,
    wbENAM,
    wbInteger(ANAM, 'Enchantment Points', itU16),
    wbStruct(BMDT, '', [
      wbInteger('Biped Flags', itU16, wbFlags([
        {0x00000001} '头部',
        {0x00000002} '发型',
        {0x00000004} 'Upper Body',
        {0x00000008} 'Lower Body',
        {0x00000010} 'Hand',
        {0x00000020} 'Foot',
        {0x00000040} 'Right Ring',
        {0x00000080} 'Left Ring',
        {0x00000100} '项链',
        {0x00000200} '武器',
        {0x00000400} 'Back Weapon',
        {0x00000800} 'Side Weapon',
        {0x00001000} 'Quiver',
        {0x00002000} '盾牌',
        {0x00004000} '火把',
        {0x00008000} '尾巴'
      ])),
      wbInteger('一般标志', itU8, wbFlags([
        {0x0001} 'Hide Rings',
        {0x0002} 'Hide Amulets',
        {0x0004} '',
        {0x0008} '',
        {0x0010} '',
        {0x0020} '',
        {0x0040} '玩家不可用',
        {0x0080} '' {Heavy armor}
      ])),
      wbByteArray('未使用', 1)
    ], cpNormal, True),
    wbRStruct('Male biped model', [
      wbString(MODL, '模型'),
      wbFloat(MODB, 'Bound Radius', cpBenign),
      wbByteArray(MODT, '材质文件哈希值', 0, cpIgnore)
    ], []),
    wbRStruct('男性世界模型', [
      wbString(MOD2, '模型'),
      wbFloat(MO2B, 'Bound Radius', cpBenign),
      wbByteArray(MO2T, '材质文件哈希值', 0, cpIgnore)
    ], []),
    wbString(ICON, 'Male icon filename'),
    wbRStruct('Female biped model', [
      wbString(MOD3, '模型'),
      wbFloat(MO3B, 'Bound Radius', cpBenign),
      wbByteArray(MO3T, '材质文件哈希值', 0, cpIgnore)
    ], []),
    wbRStruct('女性世界模型', [
      wbString(MOD4, '模型'),
      wbFloat(MO4B, 'Bound Radius', cpBenign),
      wbByteArray(MO4T, '材质文件哈希值', 0, cpIgnore)
    ], []),
    wbString(ICO2, 'Female icon filename'),
    wbStruct(DATA, '', [
      wbInteger('价值', itU32),
      wbFloat('重量')
    ], cpNormal, True)
  ]);

  wbCNTO :=
    wbStructSK(CNTO, [0], '物品', [
      wbFormIDCk('物品', [ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, LVLI, KEYM, CLOT, ALCH, APPA, LIGH]),
      wbInteger('数量', itS32)
    ]);

  wbCNTOs := wbRArrayS('物品', wbCNTO);

  wbRecord(CONT, 'Container', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbSCRI,
    wbCNTOs,
    wbStruct(DATA, '', [
      wbInteger('标志', itU8, wbFlags(['', '重生'])),
      wbFloat('重量')
    ], cpNormal, True),
    wbFormIDCk(SNAM, '开启音效', [SOUN]),
    wbFormIDCk(QNAM, '关闭音效', [SOUN])
  ]);

  wbCSDT := wbRStructSK([0], '声音类型', [
    wbInteger(CSDT, '类型', itU32,wbEnum([
      {0x00} '左脚',
      {0x01} '右脚',
      {0x02} '左脚后退',
      {0x03} '右脚后退',
      {0x04} '待机',
      {0x05} '清醒',
      {0x06} '攻击',
      {0x07} '打击',
      {0x08} '死亡',
      {0x09} '武器'
    ])),
    wbRArrayS('音效', wbRStructSK([0], '音效', [
      wbFormIDCk(CSDI, '音效', [SOUN], False, cpNormal, True),
      wbInteger(CSDC, '声音概率', itU8, nil, cpNormal, True)
    ], []), cpNormal, True)
  ], []);

  wbCSDTs := wbRArrayS('声音类型', wbCSDT);

  wbSoulGemEnum := wbEnum([
    {0} '无',
    {1} '微小',
    {2} '较小',
    {3} '普通',
    {4} '较大',
    {5} '巨大'
  ]);

  wbRecord(CREA, 'Creature', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbCNTOs,
    wbSPLOs,
    wbArrayS(NIFZ, '模型', wbStringLC('模型')),
    wbByteArray(NIFT, '材质文件哈希值', 0, cpIgnore),
    wbStruct(ACBS, '构造', [
      wbInteger('标志', itU32, wbFlags([
        {0x000001} 'Biped',
        {0x000002} '不死',
        {0x000004} 'Weapon & Shield',
        {0x000008} '重生',
        {0x000010} '游泳',
        {0x000020} '飞行',
        {0x000040} '步行',
        {0x000080} 'PC Level Offset',
        {0x000100} '未使用', //??
        {0x000200} 'No Low Level Processing',
        {0x000400} '未使用', //??
        {0x000800} 'No Blood Spray',
        {0x001000} 'No Blood Decal',
        {0x002000} '',
        {0x004000} '',
        {0x008000} 'No Head',
        {0x010000} 'No Right Arm',
        {0x020000} 'No Left Arm',
        {0x040000} 'No Combat in Water',
        {0x080000} '没有影子',
        {0x100000} 'No Corpse Check'
      ])),
      wbInteger('Base spell points', itU16),
      wbInteger('体力', itU16),
      wbInteger('Barter gold', itU16),
      wbInteger('Level (offset)', itS16),
      wbInteger('Calc min', itU16),
      wbInteger('Calc max', itU16)
    ], cpNormal, True),
    wbRArrayS('派系',
      wbStructSK(SNAM, [0], '派系', [
        wbFormIDCk('派系', [FACT]),
        wbInteger('等级', itU8),
        wbByteArray('未使用', 3)
      ])
    ),
    wbFormIDCk(INAM, '死亡物品', [LVLI]),
    wbSCRI,
    wbStruct(AIDT, 'AI数据', [
      wbInteger('好战', itU8),
      wbInteger('信心', itU8),
      wbInteger('活力', itU8),
      wbInteger('品德', itU8),
      wbInteger('Buys/Sells and Services', itU32, wbServiceFlags),
      wbInteger('传授', itS8, wbSkillEnum),
      wbInteger('最大训练等级', itU8),
      wbByteArray('未使用', 2)
    ], cpNormal, True),
    wbRArray('AI Packages', wbFormIDCk(PKID, 'AI Package', [PACK])),
    wbArrayS(KFFZ, '动作', wbStringLC('动作')),
    wbStruct(DATA, 'Creature Data', [
      wbInteger('类型', itU8, wbEnum([
        'Creature',
        'Daedra',
        'Undead',
        'Humanoid',
        '马',
        'Giant'
      ])),
      wbInteger('Combat Skill', itU8),
      wbInteger('魔法技能', itU8),
      wbInteger('Stealth Skill', itU8),
      wbInteger('Soul', itU8, wbSoulGemEnum),
      wbByteArray('未使用', 1),
      wbInteger('生命', itU16),
      wbByteArray('未使用', 2),
      wbInteger('Attack Damage', itU16),
      wbInteger('力量', itU8),
      wbInteger('智力', itU8),
      wbInteger('意志力', itU8),
      wbInteger('敏捷', itU8),
      wbInteger('速度', itU8),
      wbInteger('耐力', itU8),
      wbInteger('魅力', itU8),
      wbInteger('运气', itU8)
    ], cpNormal, True),
    wbInteger(RNAM, 'Attack reach', itU8, nil, cpNormal, True),
    wbFormIDCk(ZNAM, '战斗风格', [CSTY]),
    wbFloat(TNAM, 'Turning Speed', cpNormal, True),
    wbFloat(BNAM, 'Base Scale', cpNormal, True),
    wbFloat(WNAM, 'Foot Weight', cpNormal, True),
    wbString(NAM0, 'Blood Spray'),
    wbString(NAM1, 'Blood Decal'),
    wbFormIDCk(CSCR, 'Inherits Sounds from', [CREA]),
    wbCSDTs
  ], True);

  wbRecord(CSTY, 'Combat Style', [
    wbEDID,
    wbStruct(CSTD, 'Standard', [
      {000}wbInteger('Dodge % Chance', itU8),
      {001}wbInteger('Left/Right % Chance', itU8),
      {002}wbByteArray('未使用', 2),
      {004}wbFloat('Dodge L/R Timer (min)'),
      {008}wbFloat('Dodge L/R Timer (max)'),
      {012}wbFloat('Dodge Forward Timer (min)'),
      {016}wbFloat('Dodge Forward Timer (max)'),
      {020}wbFloat('Dodge Back Timer Min'),
      {024}wbFloat('Dodge Back Timer Max'),
      {028}wbFloat('Idle Timer min'),
      {032}wbFloat('Idle Timer max'),
      {036}wbInteger('Block % Chance', itU8),
      {037}wbInteger('Attack % Chance', itU8),
      {038}wbByteArray('未使用', 2),
      {040}wbFloat('Recoil/Stagger Bonus to Attack'),
      {044}wbFloat('Unconscious Bonus to Attack'),
      {048}wbFloat('Hand-To-Hand Bonus to Attack'),
      {052}wbInteger('Power Attack % Chance', itU8),
      {053}wbByteArray('未使用', 3),
      {056}wbFloat('Recoil/Stagger Bonus to Power'),
      {060}wbFloat('Unconscious Bonus to Power Attack'),
      {064}wbInteger('Power Attack - Normal', itU8),
      {065}wbInteger('Power Attack - Forward', itU8),
      {066}wbInteger('Power Attack - Back', itU8),
      {067}wbInteger('Power Attack - Left', itU8),
      {068}wbInteger('Power Attack - Right', itU8),
      {069}wbByteArray('未使用', 3),
      {072}wbFloat('Hold Timer (min)'),
      {076}wbFloat('Hold Timer (max)'),
      {080}wbInteger('标志 1', itU8, wbFlags([
             'Advanced',
             'Choose Attack using % Chance',
             'Ignore Allies in Area',
             'Will Yield',
             'Rejects Yields',
             'Fleeing Disabled',
             'Prefers Ranged',
             'Melee Alert OK'
           ])),
      {081}wbInteger('Acrobatic Dodge % Chance', itU8),
      {082}wbByteArray('未使用', 2),
      {084}wbFloat('Range Mult (Optimal)'),
      {088}wbFloat('Range Mult (Max)'),
      {092}wbFloat('Switch Distance (Melee)'),
      {096}wbFloat('Switch Distance (Ranged)'),
      {100}wbFloat('Buff standoff Distance'),
      {104}wbFloat('Ranged standoff Distance'),
      {108}wbFloat('Group standoff Distance'),
      {112}wbInteger('Rushing Attack % Chance', itU8),
      {113}wbByteArray('未使用', 3),
      {116}wbFloat('Rushing Attack Distance Mult'),
      {120}wbInteger('标志 2', itU32, wbFlags([
             'Do Not Acquire'
           ]))
    ], cpNormal, True, nil, 31),
    wbStruct(CSAD, 'Advanced', [
      wbFloat('Dodge Fatigue Mod Mult'),
      wbFloat('Dodge Fatigue Mod Base'),
      wbFloat('Encumb. Speed Mod Base'),
      wbFloat('Encumb. Speed Mod Mult'),
      wbFloat('Dodge While Under Attack Mult'),
      wbFloat('Dodge Not Under Attack Mult'),
      wbFloat('Dodge Back While Under Attack Mult'),
      wbFloat('Dodge Back Not Under Attack Mult'),
      wbFloat('Dodge Forward While Attacking Mult'),
      wbFloat('Dodge Forward Not Attacking Mult'),
      wbFloat('Block Skill Modifier Mult'),
      wbFloat('Block Skill Modifier Base'),
      wbFloat('Block While Under Attack Mult'),
      wbFloat('Block Not Under Attack Mult'),
      wbFloat('Attack Skill Modifier Mult'),
      wbFloat('Attack Skill Modifier Base'),
      wbFloat('Attack While Under Attack Mult'),
      wbFloat('Attack Not Under Attack Mult'),
      wbFloat('Attack During Block Mult'),
      wbFloat('Power Att. Fatigue Mod Base'),
      wbFloat('Power Att. Fatigue Mod Mult')
    ])
  ]);

  wbRecord(DIAL, 'Dialog Topic', [
    wbEDID,
    wbRArrayS('任务', wbFormIDCk(QSTI, '任务', [QUST], False, cpBenign)),
    wbRArrayS('任务?', wbFormIDCk(QSTR, '任务?', [QUST], False, cpBenign)),
    wbFULL,
    wbInteger(DATA, '类型', itU8, wbEnum([
      {0} '话题',
      {1} '交谈',
      {2} '战斗',
      {3} '说服',
      {4} '侦察',
      {5} '服务',
      {6} '杂项'
    ]), cpNormal, True)
  ], True);

  wbRecord(DOOR, 'Door', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbSCRI,
    wbFormIDCk(SNAM, '开启音效', [SOUN]),
    wbFormIDCk(ANAM, '关闭音效', [SOUN]),
    wbFormIDCk(BNAM, '循环音效', [SOUN]),
    wbInteger(FNAM, '标志', itU8, wbFlags([
      {0x01} 'Oblivion gate',
      {0x02} '自动门',
      {0x04} '隐藏',
      {0x08} '最小使用'
    ]), cpNormal, True),
    wbRArrayS('Random teleport destinations', wbFormIDCk(TNAM, 'Destination', [CELL, WRLD]))
  ]);

  wbBlendModeEnum := wbEnum([
    '',
    'Zero',
    'One',
    'Source Color',
    'Source Inverse Color',
    'Source Alpha',
    'Source Inverted Alpha',
    'Dest Alpha',
    'Dest Inverted Alpha',
    'Dest Color',
    'Dest Inverse Color',
    'Source Alpha SAT'
  ]);

  wbBlendOpEnum := wbEnum([
    '',
    '增加',
    '减少',
    '反减',
    '最小',
    '最大'
  ]);
  wbZTestFuncEnum := wbEnum([
    '',
    '',
    '',
    '等于',
    '正常',
    '大于',
    '',
    '大于或等于',
    '始终显示'
  ]);

  wbRecord(EFSH, 'Effect Shader', [
    wbEDID,
    wbString(ICON, '填充材质'),
    wbString(ICO2, '粒子着色器材质'),
    wbStruct(DATA, '', [
      wbInteger('标志', itU8, wbFlags([
        {0} '无表面着色器',
        {1} '',
        {2} '',
        {3} '无粒子着色器',
        {4} '边缘效果 - 反转',
        {5} '表面着色器 - 仅影响表面'
      ])),
      wbByteArray('未使用', 3),
      wbInteger('表面着色器 - 源混合模式', itU32, wbBlendModeEnum),
      wbInteger('表面着色器 - 混合操作', itU32, wbBlendOpEnum),
      wbInteger('表面着色器 - Z测试函数', itU32, wbZTestFuncEnum),
      wbStruct('填充/材质效果 - 颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbFloat('填充/材质效果 - Alpha 淡入时间'),
      wbFloat('填充/材质效果 - 完整 Alpha 时间'),
      wbFloat('填充/材质效果 - Alpha 淡出时间'),
      wbFloat('填充/材质效果 - 固定 Alpha 比率'),
      wbFloat('填充/材质效果 - Alpha 脉冲幅度'),
      wbFloat('填充/材质效果 - Alpha 脉冲频率'),
      wbFloat('填充/材质效果 - 材质动画速度 (U)'),
      wbFloat('填充/材质效果 - 材质动画速度 (V)'),
      wbFloat('边缘效果 - 衰减'),
      wbStruct('边缘效果 - 颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbFloat('边缘效果 - Alpha 淡入时间'),
      wbFloat('边缘效果 - 完整 Alpha 时间'),
      wbFloat('边缘效果 - Alpha 淡出时间'),
      wbFloat('边缘效果 - 固定 Alpha 比率'),
      wbFloat('边缘效果 - Alpha 脉冲幅度'),
      wbFloat('边缘效果 - Alpha 脉冲频率'),
      wbFloat('填充/材质效果 - 完整 Alpha 比率'),
      wbFloat('边缘效果 - 完整 Alpha 比率'),
      wbInteger('表面着色器 - 目标混合模式', itU32, wbBlendModeEnum),
      wbInteger('粒子着色器 - 源混合模式', itU32, wbBlendModeEnum),
      wbInteger('粒子着色器 - 混合操作', itU32, wbBlendOpEnum),
      wbInteger('粒子着色器 - Z测试函数', itU32, wbZTestFuncEnum),
      wbInteger('粒子着色器 - 目标混合模式', itU32, wbBlendModeEnum),
      wbFloat('粒子着色器 - 粒子产生提升时间'),
      wbFloat('粒子着色器 - 完整粒子产生时间'),
      wbFloat('粒子着色器 - 粒子产生缓减时间'),
      wbFloat('粒子着色器 - 完整粒子产生比率'),
      wbFloat('粒子着色器 - 固定粒子产生比率'),
      wbFloat('粒子着色器 - 粒子寿命'),
      wbFloat('粒子着色器 - 粒子寿命 +/-'),
      wbFloat('粒子着色器 - 沿法线初始速度'),
      wbFloat('粒子着色器 - 沿法线加速度'),
      wbFloat('粒子着色器 - 初始速度 #1'),
      wbFloat('粒子着色器 - 初始速度 #2'),
      wbFloat('粒子着色器 - 初始速度 #3'),
      wbFloat('粒子着色器 - 加速度 #1'),
      wbFloat('粒子着色器 - 加速度 #2'),
      wbFloat('粒子着色器 - 加速度 #3'),
      wbFloat('粒子着色器 - 规模检索 1'),
      wbFloat('粒子着色器 - 规模检索 2'),
      wbFloat('粒子着色器 - 规模检索 1 时间'),
      wbFloat('粒子着色器 - 规模检索 2 时间'),
      wbStruct('颜色检索1 - 颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbStruct('颜色检索2 - 颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbStruct('颜色检索3 - 颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbFloat('颜色检索1 - 颜色 Alpha'),
      wbFloat('颜色检索2 - 颜色 Alpha'),
      wbFloat('颜色检索3 - 颜色 Alpha'),
      wbFloat('颜色检索1 - 颜色检索时间'),
      wbFloat('颜色检索2 - 颜色检索时间'),
      wbFloat('颜色检索3 - 颜色检索时间')
    ], cpNormal, True, nil, 25)
  ]);

  wbRecord(ENCH, 'Enchantment', [
    wbEDID,
    wbStruct(OBME, 'Oblivion Magic Extender', [
      wbInteger('Record Version', itU8),
      wbStruct('OBME Version', [
        wbInteger('Beta', itU8),
        wbInteger('Minor', itU8),
        wbInteger('Major', itU8)
      ]),
      wbByteArray('未使用', $1C)
    ], cpNormal, False, wbOBMEDontShow),
    wbFULL,
    wbStruct(ENIT, '', [
      wbInteger('类型', itU32, wbEnum([
        {0} '卷轴',
        {1} '法杖',
        {2} '武器',
        {3} 'Apparel'
      ])),
      wbInteger('Charge Amount', itU32),
      wbInteger('Enchant Cost', itU32),
      wbInteger('标志', itU8, wbFlags(['Manual Enchant Cost (Autocalc Off)'])),
      wbByteArray('未使用', 3)
    ], cpNormal, True),
    wbEffects
  ]);

  wbRecord(EYES, 'Eyes', [
    wbEDID,
    wbFULL,
    wbString(ICON, '材质', 0, cpNormal, True),
    wbInteger(DATA, '标志', itU8, wbFlags(['玩家可用']), cpNormal, True)
  ]);

  wbXNAM :=
    wbStructSK(XNAM, [0], '关系', [
      wbFormIDCk('派系', [FACT, RACE]),
      wbInteger('修正', itS32)
    ]);

  wbXNAMs := wbRArrayS('关系', wbXNAM);

  wbRecord(FACT, 'Faction', [
    wbEDID,
    wbFULL,
    wbXNAMs,
    wbInteger(DATA, '标志', itU8, wbFlags(['从玩家隐藏', '有害', '特殊战斗']), cpNormal, True),
    wbFloat(CNAM, '犯罪罚金加成', cpNormal, True, 1, -1, nil, nil, 1.0),
    wbRStructsSK('等级', '等级', [0], [
      wbInteger(RNAM, '等级#', itS32),
      wbString(MNAM, '男性', 0, cpTranslate),
      wbString(FNAM, '女性', 0, cpTranslate),
      wbString(INAM, '记号')
    ], [])
  ]);

  wbRecord(FLOR, 'Flora', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbSCRI,
    wbFormIDCk(PFIG, '原料', [INGR]),
    wbStruct(PFPC, '季节性原料生产率', [
      wbInteger('春季', itU8),
      wbInteger('夏季 ', itU8),
      wbInteger('秋季', itU8),
      wbInteger('冬季', itU8)
    ], cpNormal, True)
  ]);

  wbRecord(FURN, 'Furniture', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbSCRI,
    wbByteArray(MNAM, 'Marker Flags', 0, cpNormal, True)
  ]);

  wbRecord(GLOB, 'Global', [
    wbEDID,
    wbInteger(FNAM, '类型', itU8, wbGLOBFNAM, nil, cpNormal, True),
    wbFloat(FLTV, '数值', cpNormal, True)
  ]);

  wbRecord(GMST, 'Game Setting', [
    wbEDID,
    wbUnion(DATA, '数值', wbGMSTUnionDecider, [
      wbString('', 0, cpTranslate),
      wbInteger('', itS32),
      wbFloat('')
    ], cpNormal, True)
  ]);

  wbRecord(GRAS, 'Grass', [
    wbEDID,
    wbMODL,
    wbStruct(DATA, '', [
      wbInteger('密度', itU8),
      wbInteger('最小坡度', itU8),
      wbInteger('最大坡度', itU8),
      wbByteArray('未使用', 1),
      wbInteger('距离水面的单位', itU16),
      wbByteArray('未使用', 2),
      wbInteger('距离水面类型的单位', itU32, wbEnum([
        '向上 - 至少',
        '向上 - 最多',
        '向下 - 至少',
        '向下 - 最多',
        '任意 - 至少',
        '任意 - 最多',
        '任意 - 最多高于',
        '任意 - 最多低于'
      ])),
      wbFloat('位置范围'),
      wbFloat('高度范围'),
      wbFloat('颜色范围'),
      wbFloat('波形周期'),
      wbInteger('标志', itU8, wbFlags([
        '顶点发光',
        '统一大小',
        '适应坡度'
      ])),
      wbByteArray('未使用', 3)
    ], cpNormal, True)
  ]);

  wbRecord(HAIR, 'Hair', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbString(ICON, '材质', 0, cpNormal, True),
    wbInteger(DATA, '标志', itU8, wbFlags([
      '玩家可用',
      '非男性',
      '非女性',
      '固定'
    ]), cpNormal, True)
  ]);

  wbCrimeTypeEnum :=
    wbEnum([
      '偷窃',
      '扒窃',
      '非法入侵',
      '攻击',
      '谋杀',
      '盗马'
    ], [
      -1, '无'
    ]);

  wbFormTypeEnum :=
    wbEnum([], [
      $03, 'Game Setting',
      $04, 'Global',
      $05, 'Class',
      $06, 'Faction',
      $07, 'Hair',
      $08, 'Eyes',
      $09, 'Race',
      $0A, 'Sound',
      $0B, 'Skill',
      $0C, 'Magic Effect',
      $0D, 'Script',
      $0E, 'Land Texture',
      $0F, 'Enchantment',
      $10, 'Spell',
      $11, 'BirthSign',
      $12, 'Activator',
      $13, 'Apparatus',
      $14, 'Armor',
      $15, 'Book',
      $16, 'Clothing',
      $17, 'Container',
      $18, 'Door',
      $19, 'Ingredient',
      $1A, 'Light',
      $1B, 'Misc',
      $1C, 'Static',
      $1D, 'Grass',
      $1E, 'Tree',
      $1F, 'Flora',
      $20, 'Furniture',
      $21, 'Weapon',
      $22, 'Ammi',
      $23, 'NPC',
      $24, 'Creature',
      $25, 'Leveled Creature',
      $26, 'Soul Gem',
      $27, 'Key',
      $28, 'Alchemy',
      $29, 'SubSpace',
      $2A, 'Sigil Stone',
      $2B, 'Leveled Item',
      $2D, 'Weather',
      $2E, 'Climate',
      $2F, 'Region',
      $30, 'Cell',
      $31, 'Placed Object',
      $32, 'Placed NPC',
      $33, 'Placed Creature',
      $34, 'Path Grid',
      $35, 'Worldspace',
      $36, 'Landscape',
      $38, 'Road',
      $39, 'Dialog Topic',
      $3A, 'Dialog Response',
      $3B, 'Quest',
      $3C, 'Idle Animation',
      $3D, 'Package',
      $3E, 'Combat Style',
      $3F, 'Load Screen',
      $40, 'Leveled Spell',
      $41, 'Animated Object',
      $42, 'Water',
      $43, 'Effect Shader'
  ]);

  wbSexEnum :=
    wbEnum(['男性','女性']);

  wbAxisEnum :=
    wbEnum([], [
      88, 'X',
      89, 'Y',
      90, 'Z'
    ]);

  wbCTDA :=
    wbRUnion('条件', [
      wbStruct(CTDA, '条件', [
        wbInteger('类型', itU8, wbCtdaType),
        wbByteArray('未使用', 3),
        wbUnion('比较值', wbCTDACompValueDecider, [
          wbFloat('比较值 - 浮点值'),
          wbFormIDCk('比较值 - 全局变量', [GLOB])
        ]),
        wbInteger('函数', itU32, wbCTDAFunctionToStr, wbCTDAFunctionToInt),
        wbUnion('参数 #1', wbCTDAParam1Decider, [
          {00} wbByteArray('未知', 4),
          {01} wbByteArray('无', 4, cpIgnore),
          {02} wbInteger('整数', itS32),
          {03} wbInteger('Variable Name (INVALID)', itS32),
          {04} wbInteger('性别', itU32, wbSexEnum),
          {05} wbFormIDCk('角色数值', [ACVA]),
//          {05} wbInteger('角色数值', itS32, wbActorValueEnum),
          {06} wbInteger('犯罪类型', itU32, wbCrimeTypeEnum),
          {07} wbInteger('坐标', itU32, wbAxisEnum),
          {08} wbInteger('表单类型', itU32, wbFormTypeEnum),
          {09} wbInteger('任务阶段 (不可用)', itS32),
          {10} wbFormIDCk('衍生对象', [PLYR, REFR, ACHR, ACRE, TRGT]),
          {12} wbFormIDCk('装备栏对象', [ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH]),
          {13} wbFormIDCk('角色', [PLYR, ACHR, ACRE, TRGT]),
          {14} wbFormIDCk('任务', [QUST]),
          {15} wbFormIDCk('派系', [FACT]),
          {16} wbFormIDCk('场景', [CELL]),
          {17} wbFormIDCk('职业', [CLAS]),
          {18} wbFormIDCk('种族', [RACE]),
          {19} wbFormIDCk('角色基础', [NPC_, CREA, ACTI]),
          {20} wbFormIDCk('全局', [GLOB]),
          {21} wbFormIDCk('天气', [WTHR]),
          {22} wbFormIDCk('AI包', [PACK]),
          {23} wbFormIDCk('所有者', [FACT, NPC_]),
          {24} wbFormIDCk('Birthsign', [BSGN]),
          {25} wbFormIDCk('家具', [FURN]),
          {26} wbFormIDCk('Magic Item', [SPEL]),
          {27} wbFormIDCk('Magic Effect', [MGEF]),
          {28} wbFormIDCk('世界空间', [WRLD]),
          {29} wbFormIDCk('衍生对象', [CREA, NPC_, TREE, SBSP, LVLC, SOUN, ACTI, DOOR, FLOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, GRAS])
        ]),
        wbUnion('参数 #2', wbCTDAParam2Decider, [
          {00} wbByteArray('未知', 4),
          {01} wbByteArray('无', 4, cpIgnore),
          {02} wbInteger('整数', itS32),
          {03} wbInteger('Variable Name', itS32, wbCTDAParam2VariableNameToStr, wbCTDAParam2VariableNameToInt),
          {04} wbInteger('性别', itU32, wbSexEnum),
          {05} wbFormIDCk('角色数值', [ACVA]),
//          {05} wbInteger('角色数值', itS32, wbActorValueEnum),
          {06} wbInteger('犯罪类型', itU32, wbCrimeTypeEnum),
          {07} wbInteger('坐标', itU32, wbAxisEnum),
          {08} wbInteger('表单类型', itU32, wbFormTypeEnum),
          {09} wbInteger('任务阶段', itS32, wbCTDAParam2QuestStageToStr, wbCTDAParam2QuestStageToInt),
          {10} wbFormIDCk('衍生对象', [PLYR, REFR, ACHR, ACRE, TRGT]),
          {12} wbFormIDCk('装备栏对象', [ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH]),
          {13} wbFormIDCk('角色', [PLYR, ACHR, ACRE, TRGT]),
          {14} wbFormIDCk('任务', [QUST]),
          {15} wbFormIDCk('派系', [FACT]),
          {16} wbFormIDCk('场景', [CELL]),
          {17} wbFormIDCk('职业', [CLAS]),
          {18} wbFormIDCk('种族', [RACE]),
          {19} wbFormIDCk('角色基础', [NPC_, CREA, ACTI]),
          {20} wbFormIDCk('全局', [GLOB]),
          {21} wbFormIDCk('天气', [WTHR]),
          {22} wbFormIDCk('AI包', [PACK]),
          {23} wbFormIDCk('所有者', [FACT, NPC_]),
          {24} wbFormIDCk('Birthsign', [BSGN]),
          {25} wbFormIDCk('家具', [FURN]),
          {26} wbFormIDCk('Magic Item', [SPEL]),
          {27} wbFormIDCk('Magic Effect', [MGEF]),
          {28} wbFormIDCk('世界空间', [WRLD]),
          {29} wbFormIDCk('衍生对象', [CREA, NPC_, TREE, SBSP, LVLC, SOUN, ACTI, DOOR, FLOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, GRAS])
        ]),
        wbInteger('未使用', itU32, nil, cpIgnore)
      ], cpNormal, False, nil, 6),
      wbStruct(CTDT, 'Condition (old format)', [
        wbInteger('类型', itU8, wbCtdaType),
        wbByteArray('未使用', 3),
        wbUnion('比较值', wbCTDACompValueDecider, [
          wbFloat('比较值 - 浮点值'),
          wbFormIDCk('比较值 - 全局变量', [GLOB])
        ]),
        wbInteger('函数', itU32, wbCTDAFunctionToStr, wbCTDAFunctionToInt),
        wbUnion('参数 #1', wbCTDAParam1Decider, [
          {00} wbByteArray('未知', 4),
          {01} wbByteArray('无', 4, cpIgnore),
          {02} wbInteger('整数', itS32),
          {03} wbInteger('Variable Name (INVALID)', itS32),
          {04} wbInteger('性别', itU32, wbSexEnum),
          {05} wbFormIDCk('角色数值', [ACVA]),
//          {05} wbInteger('角色数值', itS32, wbActorValueEnum),
          {06} wbInteger('犯罪类型', itU32, wbCrimeTypeEnum),
          {07} wbInteger('坐标', itU32, wbAxisEnum),
          {08} wbInteger('表单类型', itU32, wbFormTypeEnum),
          {09} wbInteger('任务阶段 (不可用)', itS32),
          {10} wbFormIDCk('衍生对象', [PLYR, REFR, ACHR, ACRE, TRGT]),
          {12} wbFormIDCk('装备栏对象', [ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH]),
          {13} wbFormIDCk('角色', [PLYR, ACHR, ACRE, TRGT]),
          {14} wbFormIDCk('任务', [QUST]),
          {15} wbFormIDCk('派系', [FACT]),
          {16} wbFormIDCk('场景', [CELL]),
          {17} wbFormIDCk('职业', [CLAS]),
          {18} wbFormIDCk('种族', [RACE]),
          {19} wbFormIDCk('角色基础', [NPC_, CREA, ACTI]),
          {20} wbFormIDCk('全局', [GLOB]),
          {21} wbFormIDCk('天气', [WTHR]),
          {22} wbFormIDCk('AI包', [PACK]),
          {23} wbFormIDCk('所有者', [FACT, NPC_]),
          {24} wbFormIDCk('Birthsign', [BSGN]),
          {25} wbFormIDCk('家具', [FURN]),
          {26} wbFormIDCk('Magic Item', [SPEL]),
          {27} wbFormIDCk('Magic Effect', [MGEF]),
          {28} wbFormIDCk('世界空间', [WRLD]),
          {29} wbFormIDCk('衍生对象', [CREA, NPC_, TREE, SBSP, LVLC, SOUN, ACTI, DOOR, FLOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, GRAS])
        ]),
        wbUnion('参数 #2', wbCTDAParam2Decider, [
          {00} wbByteArray('未知', 4),
          {01} wbByteArray('无', 4, cpIgnore),
          {02} wbInteger('整数', itS32),
          {03} wbInteger('Variable Name', itS32, wbCTDAParam2VariableNameToStr, wbCTDAParam2VariableNameToInt),
          {04} wbInteger('性别', itU32, wbSexEnum),
          {05} wbFormIDCk('角色数值', [ACVA]),
//          {05} wbInteger('角色数值', itS32, wbActorValueEnum),
          {06} wbInteger('犯罪类型', itU32, wbCrimeTypeEnum),
          {07} wbInteger('坐标', itU32, wbAxisEnum),
          {08} wbInteger('表单类型', itU32, wbFormTypeEnum),
          {09} wbInteger('任务阶段', itS32, wbCTDAParam2QuestStageToStr, wbCTDAParam2QuestStageToInt),
          {10} wbFormIDCk('衍生对象', [PLYR, REFR, ACHR, ACRE, TRGT]),
          {12} wbFormIDCk('装备栏对象', [ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH]),
          {13} wbFormIDCk('角色', [PLYR, ACHR, ACRE, TRGT]),
          {14} wbFormIDCk('任务', [QUST]),
          {15} wbFormIDCk('派系', [FACT]),
          {16} wbFormIDCk('场景', [CELL]),
          {17} wbFormIDCk('职业', [CLAS]),
          {18} wbFormIDCk('种族', [RACE]),
          {19} wbFormIDCk('角色基础', [NPC_, CREA, ACTI]),
          {20} wbFormIDCk('全局', [GLOB]),
          {21} wbFormIDCk('天气', [WTHR]),
          {22} wbFormIDCk('AI包', [PACK]),
          {23} wbFormIDCk('所有者', [FACT, NPC_]),
          {24} wbFormIDCk('Birthsign', [BSGN]),
          {25} wbFormIDCk('家具', [FURN]),
          {26} wbFormIDCk('Magic Item', [SPEL]),
          {27} wbFormIDCk('Magic Effect', [MGEF]),
          {28} wbFormIDCk('世界空间', [WRLD]),
          {29} wbFormIDCk('衍生对象', [CREA, NPC_, TREE, SBSP, LVLC, SOUN, ACTI, DOOR, FLOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, GRAS])
        ]),
        wbEmpty('未使用', cpIgnore)
      ])
    ], []);

  wbCTDAs := wbRArray('条件', wbCTDA);

  wbSCHR :=
    wbRUnion('Basic Script Data', [
      wbStruct(SCHR, 'Basic Script Data', [
        wbByteArray('未使用', 4),
        wbInteger('RefCount', itU32),
        wbInteger('CompiledSize', itU32),
        wbInteger('VariableCount', itU32),
        wbInteger('类型', itU32, wbEnum([
          '对象',
          '任务'
        ], [
          $100, 'Magic Effect'
        ]))
      ]),
      wbStruct(SCHD, 'Basic Script Data', [
        wbByteArray('未使用', 4),
        wbInteger('RefCount', itU32),
        wbInteger('CompiledSize', itU32),
        wbInteger('VariableCount', itU32),
        wbInteger('类型', itU32, wbEnum([
          '对象',
          '任务'
        ], [
          $100, 'Magic Effect'
        ]))
      ])
    ], []);

  wbSCROs :=
    wbRArray('衍生',
      wbRUnion('', [
        wbFormIDCk(SCRO, 'Global Reference',
          [ACTI, DOOR, FLOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP,
           INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, QUST, PLYR, PACK, LVLI,
           FACT, ACHR, REFR, ACRE, GLOB, DIAL, CELL, SOUN, MGEF, WTHR, CLAS, EFSH, RACE,
           LVLC, CSTY, WRLD, SCPT, BSGN, TREE, NULL]),
        wbInteger(SCRV, 'Local Variable', itU32)
      ], [])
    );

  wbResultScript := wbRStruct('Result Script', [
    wbSCHR,
    wbByteArray(SCDA, 'Compiled result script'),
    wbStringScript(SCTX, 'Result script source'),
    wbSCROs
  ], []);
{
  wbResultScriptOld := wbRStruct('Result Script (Old Format?)', [
    wbByteArray(SCHD, 'Unknown (Script Header?)'),
    wbByteArray(SCDA, 'Compiled result script'),
    wbStringScript(SCTX, 'Result script source'),
    wbSCROs
  ], []);
}
  wbRecord(IDLE, 'Idle Animation', [
    wbEDID,
    wbMODL,
    wbCTDAs,
    wbInteger(ANAM, '动作群组分组', itU8, wbIdleAnam, nil, cpNormal, True),
    wbArray(DATA, '相关待机动作', wbFormIDCk('相关待机动作', [IDLE, NULL]), ['上一级', '上一个同级对象'], cpNormal, True)
  ]);

  wbRecord(INFO, 'Dialog response', [
    wbStruct(DATA, '', [
      wbInteger('类型', itU8, wbEnum([
        {0} '话题',
        {1} '交谈',
        {2} '战斗',
        {3} '说服',
        {4} '侦察',
        {5} '服务',
        {6} '杂项'
      ])),
      wbInteger('标志', itU8, wbFlags([
        {0x0001} '再见',
        {0x0002} '随机',
        {0x0004} '说一次',
        {0x0008} '',
        {0x0010} '信息驳回',
        {0x0020} '随机结束',
        {0x0040} '传播流言'
      ])),
      wbByteArray('未使用', 1)
    ], cpNormal, True),
    wbFormIDCk(QSTI, '任务', [QUST], False, cpNormal, True),
    wbFormIDCk(TPIC, '话题', [DIAL]),
    wbFormIDCk(PNAM, '前一个情报', [INFO, NULL]),
    wbRArray('Add topics', wbFormIDCk(NAME, '话题', [DIAL])),
    wbRArray('回复',
      wbRStruct('回复', [
        wbStruct(TRDT, '回复数据', [
          wbInteger('表情类型', itU32, wbEnum([
            {0} '无表情',
            {1} '生气',
            {2} '厌恶',
            {3} '恐惧',
            {4} '伤心',
            {5} '高兴',
            {6} '惊讶'
          ])),
          wbInteger('表情数值', itS32),
          wbByteArray('未使用', 4),
          wbInteger('回复数', itU8),
          wbByteArray('未使用', 3)
        ]),
        wbString(NAM1, '回复文本', 0, cpTranslate),
        wbString(NAM2, 'Actor notes', 0, cpTranslate)
      ], [])
    ),
    wbCTDAs,
    wbRArray('Choices', wbFormIDCk(TCLT, 'Choice', [DIAL])),
    wbRArray('Link From', wbFormIDCk(TCLF, '话题', [DIAL])),
    wbResultScript
  ]);

  wbRecord(INGR, 'Ingredient', [
    wbEDID,
    wbStruct(OBME, 'Oblivion Magic Extender', [
      wbInteger('Record Version', itU8),
      wbStruct('OBME Version', [
        wbInteger('Beta', itU8),
        wbInteger('Minor', itU8),
        wbInteger('Major', itU8)
      ]),
      wbByteArray('未使用', $1C)
    ], cpNormal, False, wbOBMEDontShow),
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbFloat(DATA, '重量', cpNormal, True),
    wbStruct(ENIT, '', [
      wbInteger('价值', itS32),
      wbInteger('标志', itU8, wbFlags(['不自动计算', '食物'])),
      wbByteArray('未使用', 3)
    ], cpNormal, True),
    wbEffects
  ]);

  wbRecord(KEYM, 'Key', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbStruct(DATA, '', [
      wbInteger('价值', itS32),
      wbFloat('重量')
    ], cpNormal, True)
  ]);

  wbQuadrantEnum := wbEnum([
    {0} '左下',
    {1} '右下',
    {2} '左上',
    {3} '右上'
  ]);

  if wbSimpleRecords then begin

    wbRecord(LAND, 'Landscape', [
      wbByteArray(DATA, '未知'),
      wbByteArray(VNML, '顶点法线'),
      wbByteArray(VHGT, '顶点高度贴图'),
      wbByteArray(VCLR, '顶点颜色'),

      wbRArrayS('图层', wbRUnion('图层', [
        wbRStructSK([0],'基础图层', [
          wbStructSK(BTXT, [1, 3], '基础图层头部', [
            wbFormIDCk('材质', [LTEX, NULL]),
            wbInteger('象限', itU8, wbQuadrantEnum),
            wbByteArray('未使用', 1),
            wbInteger('图层', itS16)
          ])
        ], []),
        wbRStructSK([0],'Alpha 图层', [
          wbStructSK(ATXT, [1, 3], 'Alpha 图层头部', [
            wbFormIDCk('材质', [LTEX, NULL]),
            wbInteger('象限', itU8, wbQuadrantEnum),
            wbByteArray('未使用', 1),
            wbInteger('图层', itS16)
          ]),
          wbByteArray(VTXT, 'Alpha 图层数据')
        ], [])
      ], [])),

      wbArray(VTEX, '材质', wbFormIDCk('材质', [LTEX, NULL]))
    ]);

  end else begin

    wbRecord(LAND, 'Landscape', [
      wbByteArray(DATA, '未知'),
//      wbStruct(DATA, '', [
//        wbInteger('标志', itU8, wbFlags([])),
//        wbByteArray('未知')
//      ]),
      wbArray(VNML, '顶点法线', wbStruct('行', [
        wbArray('列', wbStruct('列', [
          wbInteger('X', itU8),
          wbInteger('Y', itU8),
          wbInteger('Z', itU8)
        ]), 33)
      ]), 33),
      wbStruct(VHGT, '顶点高度贴图', [
        wbFloat('偏移'),
        wbArray('行', wbStruct('行', [
          wbArray('列', wbInteger('列', itU8), 33)
        ]), 33),
        wbByteArray('未使用', 3)
      ]),
      wbArray(VCLR, '顶点颜色', wbStruct('行', [
        wbArray('列', wbStruct('列', [
          wbInteger('X', itU8),
          wbInteger('Y', itU8),
          wbInteger('Z', itU8)
        ]), 33)
      ]), 33),

      wbRArrayS('图层', wbRUnion('图层', [
        wbRStructSK([0],'基础图层', [
          wbStructSK(BTXT, [1, 3], '基础图层头部', [
            wbFormIDCk('材质', [LTEX, NULL]),
            wbInteger('象限', itU8, wbQuadrantEnum),
            wbByteArray('未使用', 1),
            wbInteger('图层', itS16)
          ])
        ], []),
        wbRStructSK([0],'Alpha 图层', [
          wbStructSK(ATXT, [1, 3], 'Alpha 图层头部', [
            wbFormIDCk('材质', [LTEX, NULL]),
            wbInteger('象限', itU8, wbQuadrantEnum),
            wbByteArray('未使用', 1),
            wbInteger('图层', itS16)
          ]),
          wbArrayS(VTXT, 'Alpha 图层数据', wbStructSK([0], '场景', [
            wbInteger('方位', itU16, wbAtxtPosition),
            wbByteArray('未使用', 2),
            wbFloat('透明度')
          ]))
        ], [])
      ], [])),

      wbArray(VTEX, '材质', wbFormIDCk('材质', [LTEX, NULL]))
    ]);

  end;

  wbRecord(LIGH, 'Light', [
    wbEDID,
    wbMODL,
    wbSCRI,
    wbFULL,
    wbICON,
    wbStruct(DATA, '', [
      wbInteger('时间', itS32),
      wbInteger('半径', itU32),
      wbStruct('颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbInteger('未使用', itU8)
      ]),
      wbInteger('标志', itU32, wbFlags([
        {0x00000001} '动态的',
        {0x00000002} '可以携带',
        {0x00000004} '背光',
        {0x00000008} '闪烁',
        {0x00000010} '未使用',
        {0x00000020} '默认熄灭',
        {0x00000040} '微弱闪烁',
        {0x00000080} '跳动',
        {0x00000100} '微弱跳动',
        {0x00000200} '点光源',
        {0x00000400} '点阴影'
      ])),
      wbFloat('衰减指数'),
      wbFloat('视场'),
      wbInteger('数值', itU32),
      wbFloat('重量')
    ], cpNormal, True, nil, 6),
    wbFloat(FNAM, '淡化数值', cpNormal, True, 1, -1, nil, nil, 1.0),
    wbFormIDCk(SNAM, '音效', [SOUN])
  ], False, nil, cpNormal, False, wbLIGHAfterLoad);

  wbRecord(LSCR, 'Load Screen', [
    wbEDID,
    wbICON,
    wbDESC,
    wbRArrayS('Locations', wbStructSK(LNAM, [0, 1], '位置', [
      wbFormIDCk('Direct', [CELL, WRLD, NULL]),
      wbStructSK([0, 1], 'Indirect', [
        wbFormIDCk('World', [NULL, WRLD]),
        wbStructSK([0,1], '网格', [
          wbInteger('Y', itS16),
          wbInteger('X', itS16)
        ])
      ])
    ]))
  ]);

  wbRecord(LTEX, 'Landscape Texture', [
    wbEDID,
    wbICON,
    wbStruct(HNAM, 'Havok 数据', [
      wbInteger('材料类型', itU8, wbEnum([
        {00} 'STONE',
        {01} 'CLOTH',
        {02} 'DIRT',
        {03} 'GLASS',
        {04} '草地',
        {05} 'METAL',
        {06} 'ORGANIC',
        {07} 'SKIN',
        {08} '水源',
        {09} 'WOOD',
        {10} 'HEAVY STONE',
        {11} 'HEAVY METAL',
        {12} 'HEAVY WOOD',
        {13} 'CHAIN',
        {14} 'SNOW'
      ]), cpNormal, True, nil, nil, 2),
      wbInteger('摩擦', itU8, nil, cpNormal, True, nil, nil, 30),
      wbInteger('弹力', itU8, nil, cpNormal, True, nil, nil, 30)
    ], cpNormal, True),
    wbInteger(SNAM, '纹理高光指数', itU8, nil, cpNormal, True, False, nil, nil, 30),
    wbRArrayS('草地', wbFormIDCk(GNAM, '草地', [GRAS]))
  ]);

  wbRecord(LVLC, 'Leveled Creature', [
    wbEDID,
    wbInteger(LVLD, 'Chance none', itU8, nil, cpNormal, True),
    wbInteger(LVLF, '标志', itU8, wbFlags([
      {0x01} '计算自所有低于玩家等级的',
      {0x02} '计算每一个物品的数量'
    ]), cpNormal, True),
    wbRArrayS('等级列表记录',
      wbStructExSK(LVLO , [0, 2], [3], '等级列表记录', [
        wbInteger('等级', itS16),
        wbByteArray('未使用', 2),
        wbFormIDCk('衍生', [NPC_, CREA, LVLC]),
        wbInteger('数量', itS16),
        wbByteArray('未使用', 2)
      ], cpNormal, False, nil, 3),
    cpNormal, True),
    wbSCRI,
    wbFormIDCk(TNAM, 'Creature template', [NPC_, CREA])
  ], True, nil, cpNormal, False, wbLVLAfterLoad);

  wbRecord(LVLI, 'Leveled Item', [
    wbEDID,
    wbInteger(LVLD, 'Chance none', itU8, nil, cpNormal, True),
    wbInteger(LVLF, '标志', itU8, wbFlags([
      {0x01} '计算自所有低于玩家等级的',
      {0x02} '计算每一个物品的数量'
    ]), cpNormal, True),
    wbRArrayS('等级列表记录',
      wbStructExSK(LVLO , [0, 2], [3], '等级列表记录', [
        wbInteger('等级', itS16),
        wbByteArray('未使用', 2),
        wbFormIDCk('衍生', [ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, LVLI, KEYM, CLOT, ALCH, APPA, LIGH]),
        wbInteger('数量', itS16),
        wbByteArray('未使用', 2)
      ], cpNormal, False, nil, 3),
    cpNormal, True),
    wbByteArray(DATA, '未使用', 1)
  ], False, nil, cpNormal, False, wbLVLAfterLoad);

  wbRecord(LVSP, 'Leveled Spell', [
    wbEDID,
    wbInteger(LVLD, 'Chance none', itU8, nil, cpNormal, True),
    wbInteger(LVLF, '标志', itU8, wbFlags([
      {0x01} '计算自所有低于玩家等级的',
      {0x02} '计算每一个物品的数量',
      {0x04} '使用所有魔法'
    ]), cpNormal, True),
    wbRArrayS('等级列表记录',
      wbStructExSK(LVLO , [0, 2], [3], '等级列表记录', [
        wbInteger('等级', itS16),
        wbByteArray('未使用', 2),
        wbFormIDCk('衍生', [SPEL, LVSP]),
        wbInteger('数量', itS16),
        wbByteArray('未使用', 2)
      ], cpNormal, False, nil, 3),
    cpNormal, True)
  ], False, nil, cpNormal, False, wbLVLAfterLoad);

  wbRecord(MGEF, 'Magic Effect', [
    wbStringMgefCode(EDID, 'Magic Effect Code'),
    wbStruct(OBME, 'Oblivion Magic Extender', [
      wbInteger('Record Version', itU8),
      wbStruct('OBME Version', [
        wbInteger('Beta', itU8),
        wbInteger('Minor', itU8),
        wbInteger('Major', itU8)
      ]),
      wbInteger('Param A Info', itU8, wbOBMEResolutionInfo),
      wbInteger('Param B Info', itU8, wbOBMEResolutionInfo),
      wbByteArray('未使用', 2),
      wbString('Handler', 4),
      wbInteger('Flag Overrides', itU32, wbFlags([
        { 0} '',
        { 1} '',
        { 2} 'ParamFlagA',
        { 3} 'Beneficial',
        { 4} '',
        { 5} '',
        { 6} '',
        { 7} '',
        { 8} '',
        { 9} '',
        {10} '',
        {11} '',
        {12} '',
        {13} '',
        {14} '',
        {15} '',
        {16} 'ParamFlagB',
        {17} 'Magnitude Is Range',
        {18} 'Atomic Resistance',
        {19} 'ParamFlagC',
        {20} 'ParamFlagD',
        {21} '',
        {22} '',
        {23} '',
        {24} '',
        {25} '',
        {26} '',
        {27} '',
        {28} '',
        {29} '',
        {30} '隐藏'
      ])),
      wbByteArray('ParamB', 4),
      wbByteArray('未使用', $1C)
    ], cpNormal, False, wbOBMEDontShow),
    wbString(EDDX, '编辑器标识', 0, cpNormal, False, wbEDDXDontShow),
    wbFULL,
    wbDESC,
    wbICON,
    wbMODL,
    wbStruct(DATA, '数据', [
      wbInteger('标志', itU32, wbFlags([
        {0x00000001} '敌对的',
        {0x00000002} '恢复',
        {0x00000004} '有害的',
        {0x00000008} 'Magnitude %',
        {0x00000010} '自身',
        {0x00000020} '接触',
        {0x00000040} '目标',
        {0x00000080} 'No duration',
        {0x00000100} 'No magnitude',
        {0x00000200} 'No area',
        {0x00000400} 'FX persist',
        {0x00000800} 'Spellmaking',
        {0x00001000} '附魔',
        {0x00002000} 'No Ingredient',
        {0x00004000} '',
        {0x00008000} '',
        {0x00010000} 'Use weapon',
        {0x00020000} 'Use armor',
        {0x00040000} 'Use creature',
        {0x00080000} 'Use skill',
        {0x00100000} 'Use attribute',
        {0x00200000} '',
        {0x00400000} '',
        {0x00800000} '',
        {0x01000000} 'Use actor value',
        {0x02000000} 'Spray projectile type (or Fog if Bolt is specified as well)',
        {0x04000000} 'Bolt projectile type',
        {0x08000000} 'No hit effect'
      ])),
      wbFloat('Base cost'),
      wbUnion('关联道具', wbMGEFFAssocItemDecider, [
        wbFormIDCk('未使用', [NULL]),
        wbFormIDCk('Assoc. Weapon', [WEAP]),
        wbFormIDCk('Assoc. Armor', [ARMO, NULL{?}]),
        wbFormIDCk('Assoc. Creature', [CREA, LVLC, NPC_]),
        wbInteger('Assoc. Actor Value', itS32, wbActorValueEnum)
      ]),
      wbInteger('Magic School', itS32, wbMagicSchoolEnum),
      wbInteger('Resist value', itS32, wbActorValueEnum),
      wbInteger('Counter Effect Count', itU16), //!!! must be updated automatically when ESCE length changes!
      wbByteArray('未使用', 2),
      wbFormIDCk('光效', [LIGH, NULL]),
      wbFloat('Projectile speed'),
      wbFormIDCk('效果渲染', [EFSH, NULL]),
      wbFormIDCk('Enchant effect', [EFSH, NULL]),
      wbFormIDCk('Casting sound', [NULL, SOUN]),
      wbFormIDCk('Bolt sound', [NULL, SOUN]),
      wbFormIDCk('Hit sound', [NULL, SOUN]),
      wbFormIDCk('Area sound', [NULL, SOUN]),
      wbFloat('Constant Effect enchantment factor'),
      wbFloat('Constant Effect barter factor')
    ], cpNormal, True, nil, 10),
    wbArrayS(ESCE, '消除效果', wbStringMgefCode('Counter Effect Code', 4){wbInteger('Counter Effect', itU32, wbChar4)})
  ], False, nil, cpNormal, False, wbMGEFAfterLoad);

  wbRecord(MISC, 'Misc. Item', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbStruct(DATA, '', [
      wbUnion('', wbMISCActorValueDecider, [
        wbInteger('价值', itS32),
        wbFormIDCk('角色数值', [ACVA])
      ]),
      wbUnion('', wbMISCActorValueDecider, [
        wbFloat('重量'),
        wbInteger('Group', itU32, wbEnum([], [
          $40E00000, ' [NONE]',
          $40400000, 'AI',
          $00000000, 'Attribute',
          $40C00000, '战斗',
          $40A00000, '杂项',
          $40000000, '技能',
          $40800000, 'Social',
          $3F800000, 'Stat'
        ]))
      ])
    ], cpNormal, True)
  ]);

  wbFaceGen := wbRStruct('脸部生成数据', [
    wbByteArray(FGGS, '脸部生成几何-对称', 0, cpNormal, True),
    wbByteArray(FGGA, '脸部生成几何-不对称', 0, cpNormal, True),
    wbByteArray(FGTS, '脸部生成材质-对称', 0, cpNormal, True)
  ], [], cpNormal, True);

  wbRecord(NPC_, 'Non-Player Character', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbStruct(ACBS, '构造', [
      wbInteger('标志', itU32, wbFlags([
        {0x000001} '女性',
        {0x000002} '不死',
        {0x000004} '',
        {0x000008} '重生',
        {0x000010} '自动计算属性',
        {0x000020} '',
        {0x000040} '',
        {0x000080} 'PC Level Offset',
        {0x000100} '',
        {0x000200} 'No Low Level Processing',
        {0x000400} '',
        {0x000800} '',
        {0x001000} '',
        {0x002000} 'No Rumors',
        {0x004000} '可召唤',
        {0x008000} 'No Persuasion',
        {0x010000} '',
        {0x020000} '',
        {0x040000} '',
        {0x080000} '',
        {0x100000} 'Can Corpse Check'
      ])),
      wbInteger('Base spell points', itU16),
      wbInteger('体力', itU16),
      wbInteger('Barter gold', itU16),
      wbInteger('Level (offset)', itS16),
      wbInteger('Calc min', itU16),
      wbInteger('Calc max', itU16)
    ], cpNormal, True),
    wbRArrayS('派系',
      wbStructSK(SNAM, [0], '派系', [
        wbFormIDCk('派系', [FACT]),
        wbInteger('等级', itU8),
        wbByteArray('未使用', 3)
      ])
    ),
    wbFormIDCk(INAM, '死亡物品', [LVLI]),
    wbFormIDCk(RNAM, '种族', [RACE], False, cpNormal, True),
    wbCNTOs,
    wbSPLOs,
    wbSCRI,
    wbStruct(AIDT, 'AI数据', [
      wbInteger('好战', itU8),
      wbInteger('信心', itU8),
      wbInteger('活力', itU8),
      wbInteger('品德', itU8),
      wbInteger('Buys/Sells and Services', itU32, wbServiceFlags),
      wbInteger('传授', itS8, wbSkillEnum),
      wbInteger('最大训练等级', itU8),
      wbByteArray('未使用', 2)
    ], cpNormal, True),
    wbRArray('AI Packages', wbFormIDCk(PKID, 'AI Package', [PACK])),
    wbArrayS(KFFZ, '动作', wbString('动作')),
    wbFormIDCk(CNAM, '职业', [CLAS], False, cpNormal, True),
    wbStruct(DATA, 'Stats', [
      wbInteger('Armorer', itU8),
      wbInteger('Athletics', itU8),
      wbInteger('Blade', itU8),
      wbInteger('格挡', itU8),
      wbInteger('Blunt', itU8),
      wbInteger('徒手格斗', itU8),
      wbInteger('重甲', itU8),
      wbInteger('炼金', itU8),
      wbInteger('改变系', itU8),
      wbInteger('召唤系', itU8),
      wbInteger('毁灭系', itU8),
      wbInteger('幻术系', itU8),
      wbInteger('Mysticism', itU8),
      wbInteger('恢复系', itU8),
      wbInteger('Acrobatics', itU8),
      wbInteger('轻甲', itU8),
      wbInteger('箭术', itU8),
      wbInteger('Mercantile', itU8),
      wbInteger('Security', itU8),
      wbInteger('潜行', itU8),
      wbInteger('口才', itU8),
      wbInteger('生命', itU16),
      wbByteArray('未使用', 2),
      wbInteger('力量', itU8),
      wbInteger('智力', itU8),
      wbInteger('意志力', itU8),
      wbInteger('敏捷', itU8),
      wbInteger('速度', itU8),
      wbInteger('耐力', itU8),
      wbInteger('魅力', itU8),
      wbInteger('运气', itU8)
    ], cpNormal, True),
    wbFormIDCk(HNAM, '发型', [HAIR]),
    wbFloat(LNAM, 'Hair length'),
    wbArray(ENAM, '眼睛', wbFormIDCk('眼睛', [EYES])),
    wbStruct(HCLR, 'Hair color', [
      wbInteger('红', itU8),
      wbInteger('绿', itU8),
      wbInteger('蓝', itU8),
      wbByteArray('未使用', 1)
    ], cpNormal, True),
    wbFormIDCk(ZNAM, '战斗风格', [CSTY]),
    wbFaceGen,
    wbByteArray(FNAM, '未知', 0, cpBenign)
  ], True);

  wbPKDTFlags := wbFlags([
          {0x00000001} '提供服务',
          {0x00000002} 'Must reach location',
          {0x00000004} '必须完成',
          {0x00000008} 'Lock doors at package start',
          {0x00000010} 'Lock doors at package end',
          {0x00000020} 'Lock doors at location',
          {0x00000040} '开始时开门',
          {0x00000080} '结束时开门',
          {0x00000100} 'Unlock doors at location',
          {0x00000200} 'Continue if PC near',
          {0x00000400} '每天一次',
          {0x00000800} '未使用',
          {0x00001000} 'Skip fallout behavior',
          {0x00002000} 'Always run',
          {0x00004000} '',
          {0x00008000} '',
          {0x00010000} '',
          {0x00020000} 'Always sneak',
          {0x00040000} 'Allow swimming',
          {0x00080000} 'Allow falls',
          {0x00100000} 'Armor unequipped',
          {0x00200000} 'Weapons unequipped',
          {0x00400000} 'Defensive combat',
          {0x00800000} 'Use horse',
          {0x01000000} 'No idle anims',
          {0x02000000} '',
          {0x04000000} '',
          {0x08000000} '',
          {0x10000000} '',
          {0x20000000} '',
          {0x40000000} '',
          {0x80000000} ''
        ]);

  wbPKDTType := wbEnum([
           {0} 'Find',
           {1} 'Follow',
           {2} 'Escort',
           {3} 'Eat',
           {4} 'Sleep',
           {5} 'Wander',
           {6} 'Travel',
           {7} 'Accompany',
           {8} 'Use item at',
           {9} 'Ambush',
          {10} 'Flee not combat',
          {11} 'Cast magic'
        ]);

  wbRecord(PACK, 'AI Package', [
    wbEDID,
    wbUnion(PKDT, '常规', wbPACKPKDTDecider, [
      wbStruct('常规', [
        wbInteger('标志', itU16, wbPKDTFlags),
        wbInteger('类型', itU8, wbPKDTType),
        wbByteArray('未使用', 1)
      ]),
      wbStruct('常规', [
        wbInteger('标志', itU32, wbPKDTFlags),
        wbInteger('类型', itU8, wbPKDTType),
        wbByteArray('未使用', 3)
      ])
    ]),
    wbStruct(PLDT, '位置', [
      wbInteger('类型', itS32, wbEnum([
        {0} '接近衍生',
        {1} '在场景内',
        {2} '接近当前位置',
        {3} '接近编辑器位置',
        {4} '对象编号',
        {5} 'Object type'
      ])),
      wbUnion('位置', wbPxDTLocationDecider, [
        wbFormIDCk('衍生', [REFR, ACHR, ACRE, PLYR], True),
        wbFormIDCk('场景', [CELL]),
        wbFormIDCk('未使用', [NULL]),
        wbFormIDCk('未使用', [NULL]),
        wbFormIDCk('对象编号', [ACTI, DOOR, FLOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH]),
        wbInteger('Object type', itU32)
      ]),
      wbInteger('半径', itS32)
    ]),
    wbStruct(PSDT, '时间表', [
      wbInteger('月份', itS8),
      wbInteger('星期', itS8, wbEnum([
        'Sundas',
        'Morndas',
        'Tirdas',
        'Middas',
        'Turdas',
        'Fredas',
        'Loredas',
        'Morndas to Fredas',
        'Loredas, Sundas',
        'Morndas, Middas, Fredas',
        'Tirdas, Turdas'
      ], [
        -1, '任意'
      ])),
      wbInteger('日', itU8),
      wbInteger('时间', itS8),
      wbInteger('持续时间', itS32)
    ]),
    wbStruct(PTDT, '目标', [
      wbInteger('类型', itS32, wbEnum([
        {0} 'Specific reference',
        {1} '对象编号',
        {2} 'Object type'
      ])),
      wbUnion('目标', wbPxDTLocationDecider, [
        wbFormIDCk('衍生', [ACHR, ACRE, REFR, PLYR], True),
        wbFormIDCk('对象编号', [ACTI, DOOR, FLOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH]),
        wbInteger('Object type', itU32)
      ]),
      wbInteger('数量', itS32)
    ]),
    wbCTDAs
  ]);

  wbPGRP :=
    wbArray(PGRP, 'Points', wbStruct('Point', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z (Even = Red/Orange, Odd = Blue)'),
      wbInteger('连接', itU8{, wbPGRPConnectionsCallback}),
      wbByteArray('未使用', 3)
    ]), 0, nil, nil, cpNormal, True);

      {The Connection Count in the PGRP record specifies how many entries in this
       array belong to each point. If the first 4 points in the PGRP array have
       Connection Counts 2, 5, 2, 4 then the first 2 entries are the connections
       of point 0, then next 5 are the connections of point 1, the next 2 of point 2,
       the next 4 of point 3 and so on..., this can currently not be represented
       declaratively }

  wbRecord(PGRD, 'Path Grid', [
    wbInteger(DATA, 'Point Count', itU16, nil, cpNormal, True),
    wbPGRP,
    wbByteArray(PGAG, '未知'),
    wbArray(PGRR, 'Point-to-Point Connections',
      wbArrayS('Point', wbInteger('Point', itU16), wbCalcPGRRSize{, cpNormal, False, wbPGRRPointAfterLoad})
    ),
    wbArrayS(PGRI, 'Inter-Cell Connections', wbStructSK([0,2,3,4], 'Inter-Cell Connection', [
      wbInteger('Point', itU16),
      wbByteArray('未使用', 2),
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ]), 0, cpNormal, False, wbPGRIPointerAfterLoad),
    wbRArrayS('Point-to-Reference Mappings',
      wbStructSK(PGRL, [0], 'Point-to-Reference Mapping', [
        wbFormIDCk('衍生', [REFR]),
        wbArrayS('Points', wbInteger('Point', itU32))
      ])
    )
  ], False, nil, cpNormal, False, wbPGRDAfterLoad);

  wbRecord(QUST, 'Quest', [
    wbEDID,
    wbSCRI,
    wbFULL,
    wbICON,
    wbStruct(DATA, '常规', [
      wbInteger('标志', itU8, wbFlags([
        {0x01} 'Start game enabled',
        {0x02} '',
        {0x04} 'Allow repeated conversation topics',
        {0x08} '允许重复的阶段'
      ])),
      wbInteger('优先级', itU8)
    ], cpNormal, True),
    wbCTDAs,
    wbRArrayS('阶段', wbRStructSK([0], '阶段', [
      wbInteger(INDX, 'Stage index', itS16),
      wbRArray('日志记录', wbRStruct('日志记录', [
        wbInteger(QSDT, '阶段标志', itU8, wbFlags([
          {0x01} 'Complete quest'
        ])),
        wbCTDAs,
        wbString(CNAM, '日志记录', 0, cpTranslate),
        wbResultScript
      ], []))
    ], [])),
    wbRArray('目标', wbRStruct('目标', [
      wbStruct(QSTA, '目标', [
        wbFormIDCk('目标', [REFR, ACRE, ACHR], True),
        wbInteger('标志', itU8, wbFlags([
          {0x01} 'Compass marker ignores locks'
        ])),
        wbByteArray('未使用', 3)
      ]),
      wbCTDAs
    ], []))
  ]);

  wbBodyDataIndex :=
    wbInteger(INDX, '索引', itU32, wbEnum([
      'Upper Body',
      'Lower Body',
      'Hand',
      'Foot',
      '尾巴'
    ]));

  wbRecord(RACE, 'Race', [
    wbEDID,
    wbFULL,
    wbDESC,
    wbSPLOs,
    wbXNAMs,
    wbStruct(DATA, '', [
      wbArrayS('技能加强', wbStructSK([0], '技能加强', [
        wbInteger('技能', itS8, wbActorValueEnum),
        wbInteger('加强', itS8)
      ]), 7),
      wbByteArray('未使用', 2),
      wbFloat('男性身高'),
      wbFloat('女性身高'),
      wbFloat('男性体重'),
      wbFloat('女性体重'),
      wbInteger('标志', itU32, wbFlags([
        '玩家可用'
      ]))
    ], cpNormal, True),
    wbStruct(VNAM, '语音', [
      wbFormIDCk('男性', [RACE, NULL]),
      wbFormIDCk('女性', [RACE, NULL])
    ]),
    wbStruct(DNAM, 'Default Hair', [
      wbFormIDCk('男性', [HAIR]),
      wbFormIDCk('女性', [HAIR])
    ]),
    wbInteger(CNAM, '默认头发颜色', itU8, nil, cpNormal, True),
    wbFloat(PNAM, '脸部生成 - 主要钳位', cpNormal, True),
    wbFloat(UNAM, '脸部生成 - 脸部钳位', cpNormal, True),
    wbStruct(ATTR, 'Base Attributes', [
      wbStruct('男性', [
        wbInteger('力量', itU8),
        wbInteger('智力', itU8),
        wbInteger('意志力', itU8),
        wbInteger('敏捷', itU8),
        wbInteger('速度', itU8),
        wbInteger('耐力', itU8),
        wbInteger('魅力', itU8),
        wbInteger('运气', itU8)
      ]),
      wbStruct('女性', [
        wbInteger('力量', itU8),
        wbInteger('智力', itU8),
        wbInteger('意志力', itU8),
        wbInteger('敏捷', itU8),
        wbInteger('速度', itU8),
        wbInteger('耐力', itU8),
        wbInteger('魅力', itU8),
        wbInteger('运气', itU8)
      ])
    ]),
    wbRStruct('Face Data', [
      wbEmpty(NAM0, 'Face Data Marker'),
      wbRArrayS('部分', wbRStructSK([0], '部分', [
        wbInteger(INDX, '索引', itU32, wbEnum([
          '头部',
          'Ear (Male)',
          'Ear (Female)',
          '嘴巴',
          'Teeth (Lower)',
          'Teeth (Upper)',
          'Tongue',
          'Eye (Left)',
          'Eye (Right)'
        ])),
        wbMODL,
        wbICON
      ], []))
    ], [], cpNormal, True),
    wbEmpty(NAM1, '身体数据标记', cpNormal, True),
    wbRStruct('男性身体数据', [
      wbEmpty(MNAM, 'Male Body Data Marker'),
      wbMODL,
      wbRArrayS('部分', wbRStructSK([0], '部分', [
        wbBodyDataIndex,
        wbICON
      ], []))
    ], [], cpNormal, True),
    wbRStruct('女性身体数据', [
      wbEmpty(FNAM, 'Female Body Data Marker'),
      wbMODL,
      wbRArrayS('部分', wbRStructSK([0], '部分', [
        wbBodyDataIndex,
        wbICON
      ], []))
    ], [], cpNormal, True),
    wbArrayS(HNAM, '发型', wbFormIDCk('发型', [HAIR]), 0, cpNormal, True),
    wbArrayS(ENAM, '眼睛', wbFormIDCk('眼睛', [EYES]),  0,  cpNormal, True),
    wbFaceGen,
    wbByteArray(SNAM, '未知', 2, cpNormal, True)
  ], True);

  wbRecord(REFR, 'Placed Object', [
    wbEDID,
    wbFormIDCk(NAME, '基础', [TREE, SBSP, LVLC, SOUN, ACTI, DOOR, FLOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, GRAS], False, cpNormal, True),
    wbStruct(XTEL, '传送目的地', [
      wbFormIDCk('门', [REFR], True),
      wbPosRot
    ]),
    wbStruct(XLOC, 'Lock information', [
      wbInteger('Lock Level', itU8),
      wbByteArray('未使用', 3),
      wbFormIDCk('钥匙', [KEYM, NULL]),
      wbUnion('未使用', wbXLOCFillerDecider, [
        wbEmpty('未使用'),
        wbByteArray('未使用', 4)
      ]),
      wbInteger('标志', itU8, wbFlags(['', '', '等级锁'])),
      wbByteArray('未使用', 3)
    ]),
    wbRStruct('所有权', [
      wbXOWN,
      wbInteger(XRNK, '派系等级', itS32),
      wbXGLB
    ], [XLOC]),
    wbXESP,
    wbFormIDCk(XTRG, '目标', [REFR, ACHR, ACRE], True),
    wbUnion(XSED, '', wbREFRXSEDDecider, [
      wbInteger('SpeedTree Seed', itU8),
      wbInteger('SpeedTree Seed (old format)', itU8{itU32 CS just cuts it off...})
    ]),
    wbXLOD,
    wbFloat(XCHG, '费用'),
    wbInteger(XHLT, '生命', itS32),
    wbRStruct('未使用', [
      wbFormIDCk(XPCI, '未使用', [CELL]),
      wbString(FULL, '未使用')
    ], []),
    wbInteger(XLCM, '等级调整', itS32),
    wbFormIDCk(XRTM, '未知', [REFR]),
    wbInteger(XACT, '动作标记', itU32, wbFlags([
      '使用默认',
      '激活',
      '打开',
      '默认打开'
    ])),
    wbInteger(XCNT, '数量', itS32),
    wbRStruct('地图标记', [
      wbEmpty(XMRK, '地图标记起始标记'),
      wbInteger(FNAM, '地图标志', itU8, wbFlags([
        {0x01} '可见',
        {0x02} '可以旅行到'
      ]), cpNormal, True),
      wbFULLReq,
      wbStruct(TNAM, '', [
        wbInteger('类型', itU8, wbEnum([
          {0x00} '无?',
          {0x01} '营地',
          {0x02} '洞穴',
          {0x03} '城市',
          {0x04} '精灵废墟',
          {0x05} '堡垒废墟',
          {0x06} '矿山',
          {0x07} '地标',
          {0x08} '酒馆',
          {0x09} '村落',
          {0x0A} '达德拉神殿',
          {0x0B} '地狱门',
          {0x0C} '未知? (门图标)'
        ])),
        wbByteArray('未使用', 1)
      ], cpNormal, True)
    ], []),
    wbEmpty(ONAM, '默认打开'),
    wbXSCL,
    wbInteger(XSOL, '所含灵魂', itU8, wbSoulGemEnum),
    wbDATAPosRot
  ], True, wbPlacedAddInfo, cpNormal, False, wbREFRAfterLoad);

  wbRecord(REGN, 'Region', [
    wbEDID,
    wbICON,
    wbStruct(RCLR, '地图颜色', [
      wbInteger('红', itU8),
      wbInteger('绿', itU8),
      wbInteger('蓝', itU8),
      wbByteArray('未使用', 1)
    ], cpNormal, True),
    wbFormIDCk(WNAM, '世界空间', [WRLD]),

    wbRArray('区域范围', wbRStruct('区域范围', [
      wbInteger(RPLI, '边缘衰减', itU32),
      wbArray(RPLD, '区域点数据', wbStruct('点', [
        wbFloat('X'),
        wbFloat('Y')
      ]), 0, wbRPLDAfterLoad)
    ], []), cpNormal, True),

    wbRArrayS('边缘数据记录', wbRStructSK([0], '边缘数据记录', [
      {always starts with an RDAT}
      wbStructSK(RDAT, [0], '数据头', [
        wbInteger('类型', itU32, wbEnum([
          {0}'',
          {1}'',
          {2}'对象',
          {3}'天气',
          {4}'地图',
          {5}'',
          {6}'草地',
          {7}'音效',
          {8}'',
          {9}''
        ])),
        wbInteger('标志', itU8, wbFlags([
          '覆盖'
        ])),
        wbInteger('优先级', itU8),
        wbByteArray('未使用', 2)
      ], cpNormal, True, nil, 3),

      {followed by one of these: }

      {--- Objects ---}
      wbArray(RDOT, '对象', wbStruct('对象', [
        wbFormIDCk('对象', [TREE, FLOR, STAT, LTEX]),
        wbInteger('父系索引', itU16, wbHideFFFF),
        wbByteArray('未使用', 2),
        wbFloat('密度'),
        wbInteger('聚集', itU8),
        wbInteger('最小坡度', itU8),
        wbInteger('最大坡度', itU8),
        wbInteger('标志', itU8, wbFlags([
          {0}'与斜坡一致',
          {1}'绘制顶点',
          {2}'尺寸变化范围 +/-',
          {3}'X +/-',
          {4}'Y +/-',
          {5}'Z +/-',
          {6}'树木',
          {7}'超大石块'
        ])),
        wbInteger('半径关于父系', itU16),
        wbInteger('半径', itU16),
        wbByteArray('未知', 4),
        wbFloat('最大高度'),
        wbFloat('下沉'),
        wbFloat('下沉变化范围'),
        wbFloat('尺寸变化范围'),
        wbStruct('角度变化范围', [
          wbInteger('X', itU16),
          wbInteger('Y', itU16),
          wbInteger('Z', itU16)
        ]),
        wbByteArray('未使用', 2),
        wbByteArray('未知', 4)
      ])),

      {--- Map ---}
      wbString(RDMP, '地图名称', 0, cpTranslate),

      {--- Grass ---}
      wbArrayS(RDGS, '草地', wbStructSK([0], '草地', [
        wbFormIDCk('草地', [GRAS]),
        wbByteArray('未使用', 4)
      ])),

      {--- Sound ---}
      wbInteger(RDMD, '音乐类型', itU32, wbMusicEnum),
      wbArrayS(RDSD, '音效', wbStructSK([0], '音效', [
        wbFormIDCk('音效', [SOUN]),
        wbInteger('标志', itU32, wbFlags([
          '晴朗',
          '多云',
          '下雨',
          '下雪'
        ])),
        wbInteger('概率', itU32, wbScaledInt4ToStr, wbScaledInt4ToInt)
      ])),

      {--- Weather ---}
      wbArrayS(RDWT, '天气类型', wbStructSK([0], '天气类型', [
        wbFormIDCk('天气', [WTHR]),
        wbInteger('概率', itU32)
      ]))
    ], []))
  ], True);

  wbRecord(ROAD, 'Road', [
    wbPGRP,
    wbArray(PGRR, 'Point-to-Point Connections (complex structure can''t be represented, see source)',
      {The Connection Count in the PGRP record specifies how many entries in this
       array belong to each point. If the first 4 points in the PGRP array have
       Connection Counts 2, 5, 2, 4 then the first 2 entries are the connections
       of point 0, then next 5 are the connections of point 1, the next 2 of point 2,
       the next 4 of point 3 and so on..., this can currently not be represented
       declaratively }
      wbStruct('Point', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]), 0, nil, nil, cpNormal, True)
  ]);

  wbRecord(SBSP, 'Subspace', [
    wbEDID,
    wbStruct(DNAM, '', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ], cpNormal, True)
  ]);

  wbSLSD := wbStructSK(SLSD, [0], 'Local Variable Data', [
    wbInteger('索引', itU32),
    wbByteArray('未使用', 12),
    wbInteger('标志', itU8, wbFlags(['IsLongOrShort']), cpCritical),
    wbByteArray('未使用')
  ]);

  wbRecord(SCPT, 'Script', [
    wbEDID,
    wbByteArray(SCHD, 'Unknown (Script Header?)'),
    wbSCHR,
    wbByteArray(SCDA, 'Compiled Script'),
    wbStringScript(SCTX, 'Script Source', 0, cpNormal, True),
    wbRArrayS('Local Variables', wbRStructSK([0], 'Local Variable', [
      wbSLSD,
      wbString(SCVR, '名称', 0, cpCritical)
    ], [])),
    wbSCROs
  ]);

  wbRecord(SGST, 'Sigil Stone', [
    wbEDID,
    wbStruct(OBME, 'Oblivion Magic Extender', [
      wbInteger('Record Version', itU8),
      wbStruct('OBME Version', [
        wbInteger('Beta', itU8),
        wbInteger('Minor', itU8),
        wbInteger('Major', itU8)
      ]),
      wbByteArray('未使用', $1C)
    ], cpNormal, False, wbOBMEDontShow),
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbEffects,
    wbStruct(DATA, '', [
      wbInteger('Uses ', itU8),
      wbInteger('价值', itU32),
      wbFloat('重量')
    ], cpNormal, True)
  ]);

  wbRecord(SKIL, 'Skill', [
    wbEDID,
    wbInteger(INDX, '技能', itS32, wbActorValueEnum, cpNormal, True),
    wbDESC,
    wbICON,
    wbStruct(DATA, 'Skill Data', [
      wbInteger('操作', itS32, wbActorValueEnum),
      wbInteger('Attribute', itS32, wbActorValueEnum),
      wbInteger('Specialization', itU32, wbSpecializationEnum),
      wbArray('Use Values', wbFloat('Use Value'), 2)
    ], cpNormal, True),
    wbString(ANAM, 'Apprentice Text', 0, cpTranslate, True),
    wbString(JNAM, 'Journeyman Text', 0, cpTranslate, True),
    wbString(ENAM, 'Expert Text', 0, cpTranslate, True),
    wbString(MNAM, 'Master Text', 0, cpTranslate, True)
  ]);

  wbRecord(SLGM, 'Soul Gem', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbStruct(DATA, '', [
      wbInteger('价值', itU32),
      wbFloat('重量')
    ], cpNormal, True),
    wbInteger(SOUL, '所含灵魂', itU8, wbSoulGemEnum, cpNormal, True),
    wbInteger(SLCP, '最大容量', itU8, wbSoulGemEnum, cpNormal, True)
  ]);

  wbRecord(SOUN, 'Sound', [
    wbEDID,
    wbString(FNAM, 'Sound Filename'),
    wbRUnion('Sound Data', [
      wbStruct(SNDX, 'Sound Data', [
        wbInteger('Minimum attentuation distance', itU8, wbMul(5)),
        wbInteger('Maximum attentuation distance', itU8, wbMul(100)),
        wbInteger('频率调整 %', itS8),
        wbByteArray('未使用', 1),
        wbInteger('标志', itU16, wbFlags([
          {0x0001} '随机频移',
          {0x0002} 'Play At Random',
          {0x0004} 'Environment Ignored',
          {0x0008} 'Random Location',
          {0x0010} '循环',
          {0x0020} 'Menu Sound',
          {0x0040} '2D',
          {0x0080} '360 LFE'
        ])),
        wbByteArray('未使用', 2),
        wbInteger('Static attentuation cdB', itS16),
        wbInteger('Stop time ', itU8),
        wbInteger('起始时间 ', itU8)
      ], cpNormal, True),
      wbStruct(SNDD, 'Sound Data', [
        wbInteger('Minimum attentuation distance', itU8, wbMul(5)),
        wbInteger('Maximum attentuation distance', itU8, wbMul(100)),
        wbInteger('频率调整 %', itS8),
        wbByteArray('未使用', 1),
        wbInteger('标志', itU16, wbFlags([
          {0x0001} '随机频移',
          {0x0002} 'Play At Random',
          {0x0004} 'Environment Ignored',
          {0x0008} 'Random Location',
          {0x0010} '循环',
          {0x0020} 'Menu Sound',
          {0x0040} '2D',
          {0x0080} '360 LFE'
        ])),
        wbByteArray('未使用', 2),
        wbEmpty('未使用'),
        wbEmpty('未使用'),
        wbEmpty('未使用')
      ], cpNormal, True)
    ], [], cpNormal, True)
  ]);

  wbRecord(SPEL, 'Spell', [
    wbEDID,
    wbStruct(OBME, 'Oblivion Magic Extender', [
      wbInteger('Record Version', itU8),
      wbStruct('OBME Version', [
        wbInteger('Beta', itU8),
        wbInteger('Minor', itU8),
        wbInteger('Major', itU8)
      ]),
      wbByteArray('未使用', $1C)
    ], cpNormal, False, wbOBMEDontShow),
    wbFULL,
    wbStruct(SPIT, '', [
      wbInteger('类型', itU32, wbEnum([
        {0} '法术',
        {1} '疾病',
        {2} '威能',
        {3} '次级威能',
        {4} '能力',
        {5} '毒药'
      ])),
      wbInteger('Cost', itU32),
      wbInteger('等级', itU32, wbEnum([
        {0} '新手',
        {1} '学徒',
        {2} '熟手',
        {3} '专家',
        {4} '大师'
      ])),
      wbInteger('标志', itU8, wbFlags([
        {0x00000001} 'Manual Spell Cost',
        {0x00000002} 'Immune to Silence 1',
        {0x00000004} 'Player Start Spell',
        {0x00000008} 'Immune to Silence 2',
        {0x00000010} '影响范围不受视角限制',
        {0x00000020} 'Script Effect Always Applies',
        {0x00000040} 'Disallow Spell Absorb/Reflect',
        {0x00000080} 'Touch Spell Explodes w/ no Target'
      ])),
      wbByteArray('未使用', 3)
    ], cpNormal, True),
    wbEffects
  ]);

  wbRecord(STAT, 'Static', [
    wbEDID,
    wbMODL
  ]);

  wbRecord(TES3, 'Main File Header', [
    wbStruct(HEDR, '文件头', [
      wbFloat('版本'),
      wbInteger('记录总数', itU32),
      wbInteger('下个物体序号', itU32)
    ], cpNormal, True),
    wbByteArray(OFST, '未知', 0, cpIgnore),
    wbByteArray(DELE, '未知', 0, cpIgnore),
    wbString(CNAM, '作者', 0, cpTranslate, True),
    wbString(SNAM, '描述', 0, cpTranslate),
    wbRArray('Master 文件', wbRStruct('Master 文件', [
      wbString(MAST, '文件', 0, cpNormal, True),
      wbByteArray(DATA, '未使用', 8, cpIgnore, True)
    ], []))
  ], False, nil, cpNormal, True, wbRemoveOFST);

  wbRecord(TREE, 'Tree', [
    wbEDID,
    wbMODL,
    wbICON,
    wbArrayS(SNAM, 'SpeedTree Seeds', wbInteger('SpeedTree Seed', itU32)),
    wbStruct(CNAM, '树木数据', [
      wbFloat('Leaf Curvature'),
      wbFloat('Minimum Leaf Angle'),
      wbFloat('Maximum Leaf Angle'),
      wbFloat('Branch Dimming Value'),
      wbFloat('Leaf Dimming Value'),
      wbInteger('Shadow Radius', itS32),
      wbFloat('Rock Speed'),
      wbFloat('Rustle Speed')
    ], cpNormal, True),
    wbStruct(BNAM, 'Billboard Dimensions', [
      wbFloat('宽度'),
      wbFloat('高度')
    ], cpNormal, True)
  ]);

  wbRecord(WATR, 'Water', [
    wbEDID,
    wbString(TNAM, '材质', 0, cpNormal, True),
    wbInteger(ANAM, '透明度', itU8, nil, cpNormal, True),
    wbInteger(FNAM, '标志', itU8, wbFlags([
      {0}'造成伤害',
      {1}'Reflective'
    ]), cpNormal, True),
    wbString(MNAM, 'Material ID'),
    wbFormIDCk(SNAM, '音效', [SOUN]),
    wbStruct(DATA, '', [
      wbFloat('Wind Velocity'),
      wbFloat('风向'),
      wbFloat('Wave Amplitude'),
      wbFloat('波动频率'),
      wbFloat('阳光强度'),
      wbFloat('反射指数'),
      wbFloat('菲涅耳指数'),
      wbFloat('X 滚动速度'),
      wbFloat('Y 滚动速度'),
      wbFloat('水雾距离 - 接近地面'),
      wbFloat('水雾距离 - 远离地面'),
      wbStruct('潜水颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbStruct('深水颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbStruct('反射颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbInteger('Texture Blend', itU8),
      wbByteArray('未使用', 3),
      wbFloat('雨滴模拟器 - 推力'),
      wbFloat('雨滴模拟器 - 速度'),
      wbFloat('雨滴模拟器 - 衰减'),
      wbFloat('雨滴模拟器 - 阻尼'),
      wbFloat('雨滴模拟器 - 起始尺寸'),
      wbFloat('水纹模拟器 - 推力'),
      wbFloat('水纹模拟器 - 速度'),
      wbFloat('水纹模拟器 - 衰减'),
      wbFloat('水纹模拟器 - 阻尼'),
      wbFloat('水纹模拟器 - 起始尺寸'),
      wbInteger('伤害', itU16)
    ], cpNormal, True, nil, 0),
    wbStruct(GNAM, 'Related Waters', [
      wbFormIDCk('Daytime', [WATR, NULL]),
      wbFormIDCk('Nighttime', [WATR, NULL]),
      wbFormIDCk('Underwater', [WATR, NULL])
    ], cpNormal, True)
  ]);

  wbRecord(WEAP, 'Weapon', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbENAM,
    wbInteger(ANAM, 'Enchantment Points', itU16),
    wbStruct(DATA, '', [
      wbInteger('类型', itU32, wbEnum([
        {0} 'Blade One Hand',
        {1} 'Blade Two Hand',
        {2} 'Blunt One Hand',
        {3} 'Blunt Two Hand',
        {4} '法杖',
        {5} '弓'
      ])),
      wbFloat('速度'),
      wbFloat('范围'),
      wbInteger('标志', itU32, wbFlags(['无视普通武器抗性'])),
      wbInteger('价值', itU32),
      wbInteger('生命', itU32),
      wbFloat('重量'),
      wbInteger('伤害', itU16)
    ], cpNormal, True)
  ]);

  wbRecord(WRLD, 'Worldspace', [
    wbEDID,
    wbFULL,
    wbFormIDCk(WNAM, '父系空间', [WRLD]),
    wbFormIDCk(CNAM, '气候', [CLMT]),
    wbFormIDCk(NAM2, '水源', [WATR]),
    wbICON,
    wbStruct(MNAM, '地图数据', [
      wbStruct('Uable Dimensions', [
        wbInteger('X', itS32),
        wbInteger('Y', itS32)
      ]),
      wbStruct('场景坐标', [
        wbStruct('北西场景', [
          wbInteger('X', itS16),
          wbInteger('Y', itS16)
        ]),
        wbStruct('南东场景', [
          wbInteger('X', itS16),
          wbInteger('Y', itS16)
        ])
      ])
    ]),
    wbInteger(DATA, '标志', itU8, wbFlags([
      {0x01} 'Small world',
      {0x02} '无法快速旅行',
      {0x04} 'Oblivion worldspace',
      {0x08} '',
      {0x10} '无LOD水'
    ]), cpNormal, True),
    wbArray(NAM0, '未知', wbFloat(''), 0, nil, nil, cpNormal, True),
    wbArray(NAM9, '未知', wbFloat(''), 0, nil, nil, cpNormal, True),
    wbInteger(SNAM, '音乐', itU32, wbMusicEnum),
    wbByteArray(OFST, '未知')
  ], False, nil, cpNormal, False, wbRemoveOFST);

  wbRecord(WTHR, 'Weather', [
    wbEDID,
    wbString(CNAM, 'Texture Lower Layer'),
    wbString(DNAM, 'Texture Upper Layer'),
    wbMODL,
    wbArray(NAM0, 'Colors by Types/Times',
      wbArray('类型',
        wbStruct('时间', [
          wbInteger('红', itU8),
          wbInteger('绿', itU8),
          wbInteger('蓝', itU8),
          wbByteArray('未使用', 1)
        ]),
        ['日出', '白天', '日落', '夜晚']
      ),
      ['天空高层','Fog','Clouds-Lower','环境','日光','太阳','星星','天空低层','地平线','Clouds-Upper']
    , cpNormal, True),
    wbStruct(FNAM, '水雾距离', [
      wbFloat('Day Near'),
      wbFloat('Day Far'),
      wbFloat('Night Near'),
      wbFloat('Night Far')
    ], cpNormal, True),
    wbStruct(HNAM, 'HDR Data', [
      wbFloat('眼睛适应速度'),
      wbFloat('模糊半径'),
      wbFloat('Blur Passes'),
      wbFloat('Emissive Mult'),
      wbFloat('Target LUM'),
      wbFloat('Upper LUM Clamp'),
      wbFloat('Bright Scale'),
      wbFloat('Bright Clamp'),
      wbFloat('LUM Ramp No Tex'),
      wbFloat('LUM Ramp Min'),
      wbFloat('LUM Ramp Max'),
      wbFloat('Sunlight Dimmer'),
      wbFloat('Grass Dimmer'),
      wbFloat('Tree Dimmer')
    ], cpNormal, True),
    wbStruct(DATA, '', [
      wbInteger('风速', itU8),
      wbInteger('云层速度 (Lower)', itU8),
      wbInteger('云层速度 (Upper)', itU8),
      wbInteger('过渡时长', itU8),
      wbInteger('太阳眩光', itU8),
      wbInteger('太阳伤害', itU8),
      wbInteger('颗粒 - 开始淡入', itU8),
      wbInteger('颗粒 - 结束淡出', itU8),
      wbInteger('雷电 - 开始淡入', itU8),
      wbInteger('雷电 - 结束淡出', itU8),
      wbInteger('雷电 - 频率', itU8),
      wbInteger('Weather Classification', itU8, wbWthrDataClassification),
      wbStruct('闪电颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8)
      ])
    ], cpNormal, True),
    wbRArray('音效', wbStruct(SNAM, '音效', [
      wbFormIDCk('音效', [SOUN]),
      wbInteger('类型', itU32, wbEnum([
       {0}'默认',
       {1}'颗粒',
       {2}'风',
       {3}'闪电'
      ]))
    ]))
  ]);

  wbAddGroupOrder(GMST);
  wbAddGroupOrder(GLOB);
  wbAddGroupOrder(CLAS);
  wbAddGroupOrder(FACT);
  wbAddGroupOrder(HAIR);
  wbAddGroupOrder(EYES);
  wbAddGroupOrder(RACE);
  wbAddGroupOrder(SOUN);
  wbAddGroupOrder(SKIL);
  wbAddGroupOrder(MGEF);
  wbAddGroupOrder(SCPT);
  wbAddGroupOrder(LTEX);
  wbAddGroupOrder(ENCH);
  wbAddGroupOrder(SPEL);
  wbAddGroupOrder(BSGN);
  wbAddGroupOrder(ACTI);
  wbAddGroupOrder(APPA);
  wbAddGroupOrder(ARMO);
  wbAddGroupOrder(BOOK);
  wbAddGroupOrder(CLOT);
  wbAddGroupOrder(CONT);
  wbAddGroupOrder(DOOR);
  wbAddGroupOrder(INGR);
  wbAddGroupOrder(LIGH);
  wbAddGroupOrder(MISC);
  wbAddGroupOrder(STAT);
  wbAddGroupOrder(GRAS);
  wbAddGroupOrder(TREE);
  wbAddGroupOrder(FLOR);
  wbAddGroupOrder(FURN);
  wbAddGroupOrder(WEAP);
  wbAddGroupOrder(AMMO);
  wbAddGroupOrder(NPC_);
  wbAddGroupOrder(CREA);
  wbAddGroupOrder(LVLC);
  wbAddGroupOrder(SLGM);
  wbAddGroupOrder(KEYM);
  wbAddGroupOrder(ALCH);
  wbAddGroupOrder(SBSP);
  wbAddGroupOrder(SGST);
  wbAddGroupOrder(LVLI);
  wbAddGroupOrder(WTHR);
  wbAddGroupOrder(CLMT);
  wbAddGroupOrder(REGN);
  wbAddGroupOrder(CELL);
  wbAddGroupOrder(WRLD);
  wbAddGroupOrder(DIAL);
  wbAddGroupOrder(QUST);
  wbAddGroupOrder(IDLE);
  wbAddGroupOrder(PACK);
  wbAddGroupOrder(CSTY);
  wbAddGroupOrder(LSCR);
  wbAddGroupOrder(LVSP);
  wbAddGroupOrder(ANIO);
  wbAddGroupOrder(WATR);
  wbAddGroupOrder(EFSH);
end;

initialization
end.
