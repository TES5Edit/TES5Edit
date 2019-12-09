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

unit wbDefinitionsFO3;

{$I wbDefines.inc}

interface

uses
  wbInterface;

var
	wbAggroRadiusFlags: IwbFlagsDef;
  wbPKDTFlags: IwbFlagsDef;
	wbRecordFlagsFlags: IwbFlagsDef;
	wbServiceFlags: IwbFlagsDef;
	wbTemplateFlags: IwbFlagsDef;

	wbAgressionEnum: IwbEnumDef;
	wbAlignmentEnum: IwbEnumDef;
	wbArchtypeEnum: IwbEnumDef;
	wbAssistanceEnum: IwbEnumDef;
	wbAttackAnimationEnum: IwbEnumDef;
	wbBlendModeEnum: IwbEnumDef;
	wbBlendOpEnum: IwbEnumDef;
	wbBodyLocationEnum: IwbEnumDef;
	wbBodyPartIndexEnum: IwbEnumDef;
	wbConfidenceEnum: IwbEnumDef;
	wbCreatureTypeEnum: IwbEnumDef;
	wbCrimeTypeEnum: IwbEnumDef;
	wbCriticalStageEnum: IwbEnumDef;
	wbEquipTypeEnum: IwbEnumDef;
	wbFormTypeEnum: IwbEnumDef;
	wbFunctionsEnum: IwbEnumDef;
	wbHeadPartIndexEnum: IwbEnumDef;
	wbImpactMaterialTypeEnum: IwbEnumDef;
	wbMenuModeEnum: IwbEnumDef;
	wbMiscStatEnum: IwbEnumDef;
	wbModEffectEnum: IwbEnumDef;
	wbMoodEnum: IwbEnumDef;
	wbMusicEnum: IwbEnumDef;
	wbObjectTypeEnum: IwbEnumDef;
	wbPKDTType: IwbEnumDef;
	wbPlayerActionEnum: IwbEnumDef;
	wbReloadAnimEnum: IwbEnumDef;
	wbSkillEnum: IwbEnumDef;
	wbSoundLevelEnum: IwbEnumDef;
	wbSpecializationEnum: IwbEnumDef;
	wbVatsValueFunctionEnum: IwbEnumDef;
	wbWeaponAnimTypeEnum: IwbEnumDef;
	wbZTestFuncEnum: IwbEnumDef;

procedure DefineFO3;

implementation

uses
  Types,
  Classes,
  SysUtils,
  Math,
  Variants,
  wbHelpers,
  wbDefinitionsCommon;

const
  _00_IAD: TwbSignature = #$00'IAD';
  _40_IAD: TwbSignature = #$40'IAD';
  _01_IAD: TwbSignature = #$01'IAD';
  _41_IAD: TwbSignature = #$41'IAD';
  _02_IAD: TwbSignature = #$02'IAD';
  _42_IAD: TwbSignature = #$42'IAD';
  _03_IAD: TwbSignature = #$03'IAD';
  _43_IAD: TwbSignature = #$43'IAD';
  _04_IAD: TwbSignature = #$04'IAD';
  _44_IAD: TwbSignature = #$44'IAD';
  _05_IAD: TwbSignature = #$05'IAD';
  _45_IAD: TwbSignature = #$45'IAD';
  _06_IAD: TwbSignature = #$06'IAD';
  _46_IAD: TwbSignature = #$46'IAD';
  _07_IAD: TwbSignature = #$07'IAD';
  _47_IAD: TwbSignature = #$47'IAD';
  _08_IAD: TwbSignature = #$08'IAD';
  _48_IAD: TwbSignature = #$48'IAD';
  _09_IAD: TwbSignature = #$09'IAD';
  _49_IAD: TwbSignature = #$49'IAD';
  _0A_IAD: TwbSignature = #$0A'IAD';
  _4A_IAD: TwbSignature = #$4A'IAD';
  _0B_IAD: TwbSignature = #$0B'IAD';
  _4B_IAD: TwbSignature = #$4B'IAD';
  _0C_IAD: TwbSignature = #$0C'IAD';
  _4C_IAD: TwbSignature = #$4C'IAD';
  _0D_IAD: TwbSignature = #$0D'IAD';
  _4D_IAD: TwbSignature = #$4D'IAD';
  _0E_IAD: TwbSignature = #$0E'IAD';
  _4E_IAD: TwbSignature = #$4E'IAD';
  _0F_IAD: TwbSignature = #$0F'IAD';
  _4F_IAD: TwbSignature = #$4F'IAD';
  _10_IAD: TwbSignature = #$10'IAD';
  _50_IAD: TwbSignature = #$50'IAD';
  _11_IAD: TwbSignature = #$11'IAD';
  _51_IAD: TwbSignature = #$51'IAD';
  _12_IAD: TwbSignature = #$12'IAD';
  _52_IAD: TwbSignature = #$52'IAD';
  _13_IAD: TwbSignature = #$13'IAD';
  _53_IAD: TwbSignature = #$53'IAD';
  _14_IAD: TwbSignature = #$14'IAD';
  _54_IAD: TwbSignature = #$54'IAD';

  _0_IAD : TwbSignature = #0'IAD';
  _1_IAD : TwbSignature = #1'IAD';
  _2_IAD : TwbSignature = #2'IAD';
  _3_IAD : TwbSignature = #3'IAD';
  ACBS : TwbSignature = 'ACBS';
  ACHR : TwbSignature = 'ACHR';
  ACRE : TwbSignature = 'ACRE';
  ACTI : TwbSignature = 'ACTI';
  ADDN : TwbSignature = 'ADDN';
  AIDT : TwbSignature = 'AIDT';
  ALCH : TwbSignature = 'ALCH';
  AMMO : TwbSignature = 'AMMO';
  ANAM : TwbSignature = 'ANAM';
  ANIO : TwbSignature = 'ANIO';
  ARMA : TwbSignature = 'ARMA';
  ARMO : TwbSignature = 'ARMO';
  ASPC : TwbSignature = 'ASPC';
  ATTR : TwbSignature = 'ATTR';
  ATXT : TwbSignature = 'ATXT';
  AVIF : TwbSignature = 'AVIF';
  BIPL : TwbSignature = 'BIPL';
  BMCT : TwbSignature = 'BMCT';
  BMDT : TwbSignature = 'BMDT';
  BNAM : TwbSignature = 'BNAM';
  BOOK : TwbSignature = 'BOOK';
  BPND : TwbSignature = 'BPND';
  BPNI : TwbSignature = 'BPNI';
  BPNN : TwbSignature = 'BPNN';
  BPNT : TwbSignature = 'BPNT';
  BPTD : TwbSignature = 'BPTD';
  BPTN : TwbSignature = 'BPTN';
  BTXT : TwbSignature = 'BTXT';
  CAMS : TwbSignature = 'CAMS';
  CELL : TwbSignature = 'CELL';
  CLAS : TwbSignature = 'CLAS';
  CLMT : TwbSignature = 'CLMT';
  CNAM : TwbSignature = 'CNAM';
  CNTO : TwbSignature = 'CNTO';
  COBJ : TwbSignature = 'COBJ';
  COED : TwbSignature = 'COED';
  CONT : TwbSignature = 'CONT';
  CPTH : TwbSignature = 'CPTH';
  CRDT : TwbSignature = 'CRDT';
  CREA : TwbSignature = 'CREA';
  CSAD : TwbSignature = 'CSAD';
  CSCR : TwbSignature = 'CSCR';
  CSDC : TwbSignature = 'CSDC';
  CSDI : TwbSignature = 'CSDI';
  CSDT : TwbSignature = 'CSDT';
  CSSD : TwbSignature = 'CSSD';
  CSTD : TwbSignature = 'CSTD';
  CSTY : TwbSignature = 'CSTY';
  CTDA : TwbSignature = 'CTDA';
  DATA : TwbSignature = 'DATA';
  DEBR : TwbSignature = 'DEBR';
  DELE : TwbSignature = 'DELE';
  DESC : TwbSignature = 'DESC';
  DEST : TwbSignature = 'DEST';
  DIAL : TwbSignature = 'DIAL';
  DMDL : TwbSignature = 'DMDL';
  DMDT : TwbSignature = 'DMDT';
  DNAM : TwbSignature = 'DNAM';
  DOBJ : TwbSignature = 'DOBJ';
  DODT : TwbSignature = 'DODT';
  DOOR : TwbSignature = 'DOOR';
  DSTD : TwbSignature = 'DSTD';
  DSTF : TwbSignature = 'DSTF';
  EAMT : TwbSignature = 'EAMT';
  ECZN : TwbSignature = 'ECZN';
  EDID : TwbSignature = 'EDID';
  EFID : TwbSignature = 'EFID';
  EFIT : TwbSignature = 'EFIT';
  EFSD : TwbSignature = 'EFSD';
  EFSH : TwbSignature = 'EFSH';
  EITM : TwbSignature = 'EITM';
  ENAM : TwbSignature = 'ENAM';
  ENCH : TwbSignature = 'ENCH';
  ENIT : TwbSignature = 'ENIT';
  EPF2 : TwbSignature = 'EPF2';
  EPF3 : TwbSignature = 'EPF3';
  EPFD : TwbSignature = 'EPFD';
  EPFT : TwbSignature = 'EPFT';
  ESCE : TwbSignature = 'ESCE';
  ETYP : TwbSignature = 'ETYP';
  EXPL : TwbSignature = 'EXPL';
  EYES : TwbSignature = 'EYES';
  FACT : TwbSignature = 'FACT';
  FGGA : TwbSignature = 'FGGA';
  FGGS : TwbSignature = 'FGGS';
  FGTS : TwbSignature = 'FGTS';
  FLST : TwbSignature = 'FLST';
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
  HDPT : TwbSignature = 'HDPT';
  HEDR : TwbSignature = 'HEDR';
  HNAM : TwbSignature = 'HNAM';
  ICO2 : TwbSignature = 'ICO2';
  ICON : TwbSignature = 'ICON';
  IDLA : TwbSignature = 'IDLA';
  IDLB : TwbSignature = 'IDLB';
  IDLC : TwbSignature = 'IDLC';
  IDLE : TwbSignature = 'IDLE';
  IDLF : TwbSignature = 'IDLF';
  IDLM : TwbSignature = 'IDLM';
  IDLT : TwbSignature = 'IDLT';
  IMAD : TwbSignature = 'IMAD';
  IMGS : TwbSignature = 'IMGS';
  INAM : TwbSignature = 'INAM';
  INDX : TwbSignature = 'INDX';
  INFO : TwbSignature = 'INFO';
  INGR : TwbSignature = 'INGR';
  IPCT : TwbSignature = 'IPCT';
  IPDS : TwbSignature = 'IPDS';
  ITXT : TwbSignature = 'ITXT';
  JNAM : TwbSignature = 'JNAM';
  KEYM : TwbSignature = 'KEYM';
  KFFZ : TwbSignature = 'KFFZ';
  KNAM : TwbSignature = 'KNAM';
  LAND : TwbSignature = 'LAND';
  LGTM : TwbSignature = 'LGTM';
  LIGH : TwbSignature = 'LIGH';
  LNAM : TwbSignature = 'LNAM';
  LSCR : TwbSignature = 'LSCR';
  LTEX : TwbSignature = 'LTEX';
  LTMP : TwbSignature = 'LTMP';
  LVLC : TwbSignature = 'LVLC';
  LVLD : TwbSignature = 'LVLD';
  LVLF : TwbSignature = 'LVLF';
  LVLG : TwbSignature = 'LVLG';
  LVLI : TwbSignature = 'LVLI';
  LVLN : TwbSignature = 'LVLN';
  LVLO : TwbSignature = 'LVLO';
  MAST : TwbSignature = 'MAST';
  MESG : TwbSignature = 'MESG';
  MGEF : TwbSignature = 'MGEF';
  MICN : TwbSignature = 'MICN';
  MICO : TwbSignature = 'MICO';
  MIC2 : TwbSignature = 'MIC2';
  MISC : TwbSignature = 'MISC';
  MNAM : TwbSignature = 'MNAM';
  MO2B : TwbSignature = 'MO2B';
  MO2S : TwbSignature = 'MO2S';
  MO2T : TwbSignature = 'MO2T';
  MO3B : TwbSignature = 'MO3B';
  MO3S : TwbSignature = 'MO3S';
  MO3T : TwbSignature = 'MO3T';
  MO4B : TwbSignature = 'MO4B';
  MO4S : TwbSignature = 'MO4S';
  MO4T : TwbSignature = 'MO4T';
  MOD2 : TwbSignature = 'MOD2';
  MOD3 : TwbSignature = 'MOD3';
  MOD4 : TwbSignature = 'MOD4';
  MODB : TwbSignature = 'MODB';
  MODD : TwbSignature = 'MODD';
  MODL : TwbSignature = 'MODL';
  MODS : TwbSignature = 'MODS';
  MOSD : TwbSignature = 'MOSD';
  MSTT : TwbSignature = 'MSTT';
  MUSC : TwbSignature = 'MUSC';
  IMPS : TwbSignature = 'IMPS';
  IMPF : TwbSignature = 'IMPF';
  NAM0 : TwbSignature = 'NAM0';
  NAM1 : TwbSignature = 'NAM1';
  NAM2 : TwbSignature = 'NAM2';
  NAM3 : TwbSignature = 'NAM3';
  NAM4 : TwbSignature = 'NAM4';
  NAM5 : TwbSignature = 'NAM5';
  NAM6 : TwbSignature = 'NAM6';
  NAM7 : TwbSignature = 'NAM7';
  NAM8 : TwbSignature = 'NAM8';
  NAM9 : TwbSignature = 'NAM9';
  NAME : TwbSignature = 'NAME';
  NAVI : TwbSignature = 'NAVI';
  NAVM : TwbSignature = 'NAVM';
  NEXT : TwbSignature = 'NEXT';
  NIFT : TwbSignature = 'NIFT';
  NIFZ : TwbSignature = 'NIFZ';
  NNAM : TwbSignature = 'NNAM';
  NOTE : TwbSignature = 'NOTE';
  NPC_ : TwbSignature = 'NPC_';
  NULL : TwbSignature = 'NULL';
  NVCA : TwbSignature = 'NVCA';
  NVCI : TwbSignature = 'NVCI';
  NVDP : TwbSignature = 'NVDP';
  NVER : TwbSignature = 'NVER';
  NVEX : TwbSignature = 'NVEX';
  NVGD : TwbSignature = 'NVGD';
  NVMI : TwbSignature = 'NVMI';
  NVTR : TwbSignature = 'NVTR';
  NVVX : TwbSignature = 'NVVX';
  OBND : TwbSignature = 'OBND';
  ONAM : TwbSignature = 'ONAM';
  PACK : TwbSignature = 'PACK';
  PBEA : TwbSignature = 'PBEA';
  PERK : TwbSignature = 'PERK';
  PFIG : TwbSignature = 'PFIG';
  PFPC : TwbSignature = 'PFPC';
  PGAG : TwbSignature = 'PGAG';
  PGRE : TwbSignature = 'PGRE';
  PMIS : TwbSignature = 'PMIS';
  TRGT : TwbSignature = 'TRGT';
  PGRI : TwbSignature = 'PGRI';
  PGRL : TwbSignature = 'PGRL';
  PGRP : TwbSignature = 'PGRP';
  PGRR : TwbSignature = 'PGRR';
  PKAM : TwbSignature = 'PKAM';
  PKDD : TwbSignature = 'PKDD';
  PKDT : TwbSignature = 'PKDT';
  PKE2 : TwbSignature = 'PKE2';
  PKED : TwbSignature = 'PKED';
  PKFD : TwbSignature = 'PKFD';
  PKID : TwbSignature = 'PKID';
  PKPT : TwbSignature = 'PKPT';
  PKW3 : TwbSignature = 'PKW3';
  PLD2 : TwbSignature = 'PLD2';
  PLDT : TwbSignature = 'PLDT';
  PLYR : TwbSignature = 'PLYR';
  PNAM : TwbSignature = 'PNAM';
  POBA : TwbSignature = 'POBA';
  POCA : TwbSignature = 'POCA';
  POEA : TwbSignature = 'POEA';
  PRKC : TwbSignature = 'PRKC';
  PRKE : TwbSignature = 'PRKE';
  PRKF : TwbSignature = 'PRKF';
  PROJ : TwbSignature = 'PROJ';
  PSDT : TwbSignature = 'PSDT';
  PTD2 : TwbSignature = 'PTD2';
  PTDT : TwbSignature = 'PTDT';
  PUID : TwbSignature = 'PUID';
  PWAT : TwbSignature = 'PWAT';
  QNAM : TwbSignature = 'QNAM';
  QOBJ : TwbSignature = 'QOBJ';
  QSDT : TwbSignature = 'QSDT';
  QSTA : TwbSignature = 'QSTA';
  QSTI : TwbSignature = 'QSTI';
  TPIC : TwbSignature = 'TPIC';
  QSTR : TwbSignature = 'QSTR';
  QUST : TwbSignature = 'QUST';
  RACE : TwbSignature = 'RACE';
  RADS : TwbSignature = 'RADS';
  RAFB : TwbSignature = 'RAFB';
  RAFD : TwbSignature = 'RAFD';
  RAGA : TwbSignature = 'RAGA';
  RAPS : TwbSignature = 'RAPS';
  RCLR : TwbSignature = 'RCLR';
  RDAT : TwbSignature = 'RDAT';
  RDMD : TwbSignature = 'RDMD';
  RDMO : TwbSignature = 'RDMO';
  RDMP : TwbSignature = 'RDMP';
  RDGS : TwbSignature = 'RDGS';
  RDOT : TwbSignature = 'RDOT';
  RDSD : TwbSignature = 'RDSD';
  RDWT : TwbSignature = 'RDWT';
  REFR : TwbSignature = 'REFR';
  REGN : TwbSignature = 'REGN';
  REPL : TwbSignature = 'REPL';
  RGDL : TwbSignature = 'RGDL';
  RNAM : TwbSignature = 'RNAM';
  RPLD : TwbSignature = 'RPLD';
  RPLI : TwbSignature = 'RPLI';
  SCHR : TwbSignature = 'SCHR';
  SCOL : TwbSignature = 'SCOL';
  SCPT : TwbSignature = 'SCPT';
  SCRI : TwbSignature = 'SCRI';
  SCRN : TwbSignature = 'SCRN';
  SCRO : TwbSignature = 'SCRO';
  SCRV : TwbSignature = 'SCRV';
  SCVR : TwbSignature = 'SCVR';
  SLCP : TwbSignature = 'SLCP';
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
  TACT : TwbSignature = 'TACT';
  TCLF : TwbSignature = 'TCLF';
  TCLT : TwbSignature = 'TCLT';
  TERM : TwbSignature = 'TERM';
  TES4 : TwbSignature = 'TES4';
  TNAM : TwbSignature = 'TNAM';
  TPLT : TwbSignature = 'TPLT';
  TRDT : TwbSignature = 'TRDT';
  TREE : TwbSignature = 'TREE';
  TX00 : TwbSignature = 'TX00';
  TX01 : TwbSignature = 'TX01';
  TX02 : TwbSignature = 'TX02';
  TX03 : TwbSignature = 'TX03';
  TX04 : TwbSignature = 'TX04';
  TX05 : TwbSignature = 'TX05';
  TXST : TwbSignature = 'TXST';
  UNAM : TwbSignature = 'UNAM';
  VCLR : TwbSignature = 'VCLR';
  VHGT : TwbSignature = 'VHGT';
  VNAM : TwbSignature = 'VNAM';
  VNML : TwbSignature = 'VNML';
  VTCK : TwbSignature = 'VTCK';
  VTEX : TwbSignature = 'VTEX';
  VTXT : TwbSignature = 'VTXT';
  VTYP : TwbSignature = 'VTYP';
  WATR : TwbSignature = 'WATR';
  WEAP : TwbSignature = 'WEAP';
  WLST : TwbSignature = 'WLST';
  WNAM : TwbSignature = 'WNAM';
  WRLD : TwbSignature = 'WRLD';
  WTHR : TwbSignature = 'WTHR';
  XACT : TwbSignature = 'XACT';
  XAMC : TwbSignature = 'XAMC';
  XAMT : TwbSignature = 'XAMT';
  XAPD : TwbSignature = 'XAPD';
  XAPR : TwbSignature = 'XAPR';
  XCAS : TwbSignature = 'XCAS';
  XCCM : TwbSignature = 'XCCM';
  XCET : TwbSignature = 'XCET';
  XCHG : TwbSignature = 'XCHG';
  XCIM : TwbSignature = 'XCIM';
  XCLC : TwbSignature = 'XCLC';
  XCLL : TwbSignature = 'XCLL';
  XCLP : TwbSignature = 'XCLP';
  XCLR : TwbSignature = 'XCLR';
  XCLW : TwbSignature = 'XCLW';
  XCMO : TwbSignature = 'XCMO';
  XCMT : TwbSignature = 'XCMT';
  XCNT : TwbSignature = 'XCNT';
  XCWT : TwbSignature = 'XCWT';
  XEMI : TwbSignature = 'XEMI';
  XESP : TwbSignature = 'XESP';
  XEZN : TwbSignature = 'XEZN';
  XGLB : TwbSignature = 'XGLB';
  XHLP : TwbSignature = 'XHLP';
  XDCR : TwbSignature = 'XDCR';
  XHLT : TwbSignature = 'XHLT';
  XIBS : TwbSignature = 'XIBS';
  XLCM : TwbSignature = 'XLCM';
  XLKR : TwbSignature = 'XLKR';
  XLOC : TwbSignature = 'XLOC';
  XLOD : TwbSignature = 'XLOD';
  XLRM : TwbSignature = 'XLRM';
  XLTW : TwbSignature = 'XLTW';
  XMBO : TwbSignature = 'XMBO';
  XMBP : TwbSignature = 'XMBP';
  XMBR : TwbSignature = 'XMBR';
  XMRC : TwbSignature = 'XMRC';
  XMRK : TwbSignature = 'XMRK';
  XNAM : TwbSignature = 'XNAM';
  XNDP : TwbSignature = 'XNDP';
  XOCP : TwbSignature = 'XOCP';
  XORD : TwbSignature = 'XORD';
  XOWN : TwbSignature = 'XOWN';
  XPOD : TwbSignature = 'XPOD';
  XPTL : TwbSignature = 'XPTL';
  XPPA : TwbSignature = 'XPPA';
  XPRD : TwbSignature = 'XPRD';
  XPRM : TwbSignature = 'XPRM';
  XPWR : TwbSignature = 'XPWR';
  XRAD : TwbSignature = 'XRAD';
  XRDO : TwbSignature = 'XRDO';
  XRDS : TwbSignature = 'XRDS';
  XRGB : TwbSignature = 'XRGB';
  XRGD : TwbSignature = 'XRGD';
  XRMR : TwbSignature = 'XRMR';
  XRNK : TwbSignature = 'XRNK';
  XRTM : TwbSignature = 'XRTM';
  XSCL : TwbSignature = 'XSCL';
  XSED : TwbSignature = 'XSED';
  XSRF : TwbSignature = 'XSRF';
  XSRD : TwbSignature = 'XSRD';
  XTEL : TwbSignature = 'XTEL';
  XTRG : TwbSignature = 'XTRG';
  XTRI : TwbSignature = 'XTRI';
  XXXX : TwbSignature = 'XXXX';
  YNAM : TwbSignature = 'YNAM';
  ZNAM : TwbSignature = 'ZNAM';

var
  wbPKDTSpecificFlagsUnused : Boolean;
  wbEDID: IwbSubRecordDef;
  wbEDIDReq: IwbSubRecordDef;
  wbEDIDReqKC: IwbSubRecordDef;
  wbBMDT: IwbSubRecordDef;
  wbYNAM: IwbSubRecordDef;
  wbZNAM: IwbSubRecordDef;
  wbCOED: IwbSubRecordDef;
  wbXLCM: IwbSubRecordDef;
  wbEITM: IwbSubRecordDef;
  wbREPL: IwbSubRecordDef;
  wbBIPL: IwbSubRecordDef;
  wbDEST: IwbSubRecordStructDef;
  wbDESTActor: IwbSubRecordStructDef;
  wbDODT: IwbSubRecordDef;
  wbXOWN: IwbSubRecordDef;
  wbXRGD: IwbSubRecordDef;
  wbXRGB: IwbSubRecordDef;
  wbSLSD: IwbSubRecordDef;
  wbSPLO: IwbSubRecordDef;
  wbSPLOs: IwbSubRecordArrayDef;
  wbCNTO: IwbRecordMemberDef;
  wbCNTOs: IwbSubRecordArrayDef;
  wbAIDT: IwbSubRecordDef;
  wbCSDT: IwbSubRecordStructDef;
  wbCSDTs: IwbSubRecordArrayDef;
  wbFULL: IwbSubRecordDef;
  wbFULLActor: IwbSubRecordDef;
  wbFULLReq: IwbSubRecordDef;
  wbDESC: IwbSubRecordDef;
  wbDESCReq: IwbSubRecordDef;
  wbXSCL: IwbSubRecordDef;
  wbMODD: IwbSubRecordDef;
  wbMOSD: IwbSubRecordDef;
  wbMODS: IwbSubRecordDef;
  wbMO2S: IwbSubRecordDef;
  wbMO3S: IwbSubRecordDef;
  wbMO4S: IwbSubRecordDef;
  wbCTDA: IwbRecordMemberDef;
  wbSCHRReq: IwbSubRecordDef;
  wbCTDAs: IwbSubRecordArrayDef;
  wbCTDAsReq: IwbSubRecordArrayDef;
  wbSCROs: IwbRecordMemberDef;
//  wbPGRP: IwbSubRecordDef;
  wbEmbeddedScript: IwbRecordMemberDef;
  wbEmbeddedScriptPerk: IwbRecordMemberDef;
  wbEmbeddedScriptReq: IwbRecordMemberDef;
  wbSCRI: IwbSubRecordDef;
  wbSCRIActor: IwbSubRecordDef;
  wbFaceGen: IwbSubRecordStructDef;
  wbFaceGenNPC: IwbSubRecordStructDef;
  wbENAM: IwbSubRecordDef;
//  wbFGGS: IwbSubRecordDef;
  wbXESP: IwbSubRecordDef;
  wbICON: IwbSubRecordStructDef;
  wbICONReq: IwbSubRecordStructDef;
  wbActorValue: IwbIntegerDef;
  wbETYP: IwbSubRecordDef;
  wbETYPReq: IwbSubRecordDef;
  wbEFID: IwbSubRecordDef;
  wbEFIT: IwbSubRecordDef;
  wbEffects: IwbSubRecordArrayDef;
  wbEffectsReq: IwbSubRecordArrayDef;
  wbBPNDStruct: IwbSubRecordDef;
  wbLeveledListEntryCreature: IwbRecordMemberDef;
  wbLeveledListEntryNPC: IwbRecordMemberDef;
  wbLeveledListEntryItem: IwbRecordMemberDef;

function wbGenericModel(aRequired: Boolean = False; aDontShow: TwbDontShowCallback = nil): IwbRecordMemberDef;
begin
  Result :=
    wbRStructSK([0], 'Model', [
      wbString(MODL, 'Model FileName', 0, cpNormal, True),
      wbByteArray(MODB, 'Unknown', 4, cpIgnore),
      wbMODT,
      wbMODS,
      wbMODD
    ], [], cpNormal, aRequired, aDontShow, True)
    .SetSummaryKey([0])
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfSummaryNoSortKey)
    .IncludeFlag(dfCollapsed, wbCollapseModels);
end;

function wbTexturedModel(aSubRecordName: string; aSignatures: TwbSignatures; aTextureSubRecords: array of IwbSubRecordDef): IwbRecordMemberDef;
begin
  Result :=
    wbRStruct(aSubRecordName, [
      wbString(aSignatures[0], 'Model FileName', 0, cpNormal, True),
      wbModelInfo(aSignatures[1]),
      aTextureSubRecords[0],
      aTextureSubRecords[1]
    ], [], cpNormal, False, nil, True)
    .SetSummaryKey([0, 2])
    .SetSummaryMemberPrefixSuffix(2, '', '')
    .SetSummaryDelimiter(' ')
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfSummaryNoSortKey)
    .IncludeFlag(dfCollapsed, wbCollapseModels);
end;

function wbNVTREdgeToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Index      : Integer;
  Flags      : Cardinal;
  IsExternal : Boolean;
  Container  : IwbContainerElementRef;
begin
  Result := '';
  IsExternal := False;
  if Supports(aElement, IwbContainerElementRef, Container) then begin
    Index := StrToIntDef(Copy(Container.Name, 11, 1), -1);
    if (Index >= 0) and (Index <= 2) then begin
      Flags := Container.ElementNativeValues['..\..\Flags'];
      IsExternal := Flags and (Cardinal(1) shl Index) <> 0;
    end;
  end;

  if IsExternal then begin
    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if Container.ElementExists['..\..\..\..\NVEX\Connection #' + aInt.ToString] then
          Result := Result + ' (Triangle #' +
            Container.ElementValues['..\..\..\..\NVEX\Connection #' + aInt.ToString + '\Triangle'] + ' in ' +
            Container.ElementValues['..\..\..\..\NVEX\Connection #' + aInt.ToString + '\Navigation Mesh'] + ')'
        else
          if aType = ctToStr then
            Result := Result + ' <Error: NVEX\Connection #' + aInt.ToString + ' is missing>';
      end;
      ctToSortKey:
        if Container.ElementExists['..\..\..\..\NVEX\Connection #' + aInt.ToString] then
          Result :=
            Container.ElementSortKeys['..\..\..\..\NVEX\Connection #' + aInt.ToString + '\Navigation Mesh', True] + '|' +
            Container.ElementSortKeys['..\..\..\..\NVEX\Connection #' + aInt.ToString + '\Triangle', True];
      ctCheck:
        if Container.ElementExists['..\..\..\..\NVEX\Connection #' + aInt.ToString] then
          Result := ''
        else
          Result := 'NVEX\Connection #' + aInt.ToString + ' is missing';
    end
  end else
    case aType of
      ctToStr, ctToSummary: Result := aInt.ToString;
    end;
end;

function wbNVTREdgeToInt(const aString: string; const aElement: IwbElement): Int64;
begin
  Result := StrToInt64(aString);
end;


function wbEPFDActorValueToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  AsCardinal : Cardinal;
  AsFloat    : Single;
begin
  AsCardinal := aInt;
  AsFloat := PSingle(@AsCardinal)^;
  aInt := Round(AsFloat);
  case aType of
    ctToStr, ctToSummary: Result := wbActorValueEnum.ToString(aInt, aElement, aType = ctToSummary);
    ctToSortKey: Result := wbActorValueEnum.ToSortKey(aInt, aElement);
    ctCheck: Result := wbActorValueEnum.Check(aInt, aElement);
    ctToEditValue: Result := wbActorValueEnum.ToEditValue(aInt, aElement);
    ctEditType: Result := 'ComboBox';
    ctEditInfo: Result := wbActorValueEnum.EditInfo[aInt, aElement].ToCommaText;
  end;
end;

function wbEPFDActorValueToInt(const aString: string; const aElement: IwbElement): Int64;
var
  AsCardinal : Cardinal;
  AsFloat    : Single;
begin
  AsFloat := wbActorValueEnum.FromEditValue(aString, aElement);
  PSingle(@AsCardinal)^ := AsFloat;
  Result := AsCardinal;
end;

function wbCTDAParam2VariableNameToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainerElementRef;
  //Container2 : IwbContainerElementRef;
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
    ctToStr, ctToSummary: begin
      Result := aInt.ToString;
      if aType = ctToStr then
        Result := Result + ' <Warning: Could not resolve Parameter 1>';
    end;
    ctToEditValue: Result := aInt.ToString;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Parameter 1>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not wbTryGetContainerRefFromUnionOrValue(aElement, Container) then
    Exit;

  Param1 := Container.ElementByName['Parameter #1'];
  if not wbTryGetMainRecord(Param1, MainRecord) then
    Exit;

{    if Param1.NativeValue = 0 then
      if Supports(Container.Container, IwbContainerElementRef, Container) then
        for i := 0 to Pred(Container.ElementCount) do
          if Supports(Container.Elements[i], IwbContainerElementRef, Container2) then
            if SameText(Container2.ElementValues['Function'], 'GetIsID') then begin
              Param1 := Container2.ElementByName['Parameter #1'];
              if Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
                Break;
            end;}

  BaseRecord := MainRecord.BaseRecord;
  if Assigned(BaseRecord) then
    MainRecord := BaseRecord;

  MainRecord := MainRecord.WinningOverride;

  ScriptRef := MainRecord.RecordBySignature['SCRI'];

  if not Assigned(ScriptRef) then begin
    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: "'+MainRecord.ShortName+'" does not contain a SCRI subrecord>';
      end;
      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" does not contain a SCRI subrecord>';
    end;
    Exit;
  end;

  if not Supports(ScriptRef.LinksTo, IwbMainRecord, Script) then begin
    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: "'+MainRecord.ShortName+'" does not have a valid script>';
      end;
      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" does not have a valid script>';
    end;
    Exit;
  end;

  Script := Script.HighestOverrideOrSelf[aElement._File.LoadOrder];

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
          j := LocalVar.ElementNativeValues['SLSD\Index'];
          s := LocalVar.ElementNativeValues['SCVR'];
          if Assigned(Variables) then
            Variables.AddObject(s, TObject(j))
          else if j = aInt then begin
            case aType of
              ctToStr, ctToSummary, ctToEditValue: Result := s;
              ctCheck: Result := '';
            end;
            Exit;
          end;
        end;
    end;

    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: Variable Index not found in "' + Script.Name + '">';
      end;
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

  Param1 := Container.ElementByName['Parameter #1'];

  if not Assigned(Param1) then
    raise Exception.Create('Could not find "Parameter #1"');

  if not Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
    raise Exception.Create('"Parameter #1" does not reference a valid main record');

  BaseRecord := MainRecord.BaseRecord;
  if Assigned(BaseRecord) then
    MainRecord := BaseRecord;

  MainRecord := MainRecord.WinningOverride;

  ScriptRef := MainRecord.RecordBySignature['SCRI'];

  if not Assigned(ScriptRef) then
    raise Exception.Create('"'+MainRecord.ShortName+'" does not contain a SCRI subrecord');

  if not Supports(ScriptRef.LinksTo, IwbMainRecord, Script) then
    raise Exception.Create('"'+MainRecord.ShortName+'" does not have a valid script');

  Script := Script.HighestOverrideOrSelf[aElement._File.LoadOrder];

  if Supports(Script.ElementByName['Local Variables'], IwbContainerElementRef, LocalVars) then begin
    for i := 0 to Pred(LocalVars.ElementCount) do
      if Supports(LocalVars.Elements[i], IwbContainerElementRef, LocalVar) then begin
        j := LocalVar.ElementNativeValues['SLSD\Index'];
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
    ctToStr, ctToSummary: begin
      Result := aInt.ToString;
      if aType = ctToStr then
        Result := Result + ' <Warning: Could not resolve Parameter 1>';
    end;
    ctToEditValue: Result := aInt.ToString;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Parameter 1>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not wbTryGetContainerRefFromUnionOrValue(aElement, Container) then
    Exit;

  Param1 := Container.ElementByName['Parameter #1'];
  if not wbTryGetMainRecord(Param1, MainRecord) then
    Exit;

  MainRecord := MainRecord.WinningOverride;

  if MainRecord.Signature <> QUST then begin
    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: "'+MainRecord.ShortName+'" is not a Quest record>';
      end;
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
    if Supports(MainRecord.ElementByName['Stages'], IwbContainerElementRef, Stages) then begin
      for i := 0 to Pred(Stages.ElementCount) do
        if Supports(Stages.Elements[i], IwbContainerElementRef, Stage) then begin
          j := Stage.ElementNativeValues['INDX'];
          s := Trim(Stage.ElementValues['Log Entries\Log Entry\CNAM']);
          t := IntToStr(j);
          while Length(t) < 3 do
            t := '0' + t;
          if s <> '' then
            t := t + ' ' + s;
          if Assigned(EditInfos) then
            EditInfos.AddObject(t, TObject(j))
          else if j = aInt then begin
            case aType of
              ctToStr, ctToSummary, ctToEditValue: Result := t;
              ctCheck: Result := '';
            end;
            Exit;
          end;
        end;
    end;

    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: Quest Stage not found in "' + MainRecord.Name + '">';
      end;
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

function wbPerkDATAQuestStageToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
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
    ctToStr, ctToSummary: begin
      Result := aInt.ToString;
      if aType = ctToStr then
        Result := Result + ' <Warning: Could not resolve Quest>';
    end;
    ctToEditValue: Result := aInt.ToString;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Quest>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not wbTryGetContainerRefFromUnionOrValue(aElement, Container) then
    Exit;

  Param1 := Container.ElementByName['Quest'];
  if not wbTryGetMainRecord(Param1, MainRecord) then
    Exit;

  MainRecord := MainRecord.WinningOverride;

  if MainRecord.Signature <> QUST then begin
    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: "'+MainRecord.ShortName+'" is not a Quest record>';
      end;
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
    if Supports(MainRecord.ElementByName['Stages'], IwbContainerElementRef, Stages) then begin
      for i := 0 to Pred(Stages.ElementCount) do
        if Supports(Stages.Elements[i], IwbContainerElementRef, Stage) then begin
          j := Stage.ElementNativeValues['INDX'];
          s := Trim(Stage.ElementValues['Log Entries\Log Entry\CNAM']);
          t := IntToStr(j);
          while Length(t) < 3 do
            t := '0' + t;
          if s <> '' then
            t := t + ' ' + s;
          if Assigned(EditInfos) then
            EditInfos.AddObject(t, TObject(j))
          else if j = aInt then begin
            case aType of
              ctToStr, ctToSummary, ctToEditValue: Result := t;
              ctCheck: Result := '';
            end;
            Exit;
          end;
        end;
    end;

    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: Quest Stage not found in "' + MainRecord.Name + '">';
      end;
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

function wbCTDAParam2QuestObjectiveToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainerElementRef;
  Param1     : IwbElement;
  MainRecord : IwbMainRecord;
  EditInfos  : TStringList;
  Objectives     : IwbContainerElementRef;
  Objective      : IwbContainerElementRef;
  i, j       : Integer;
  s, t       : string;
begin
  case aType of
    ctToStr, ctToSummary: begin
      Result := aInt.ToString;
      if aType = ctToStr then
        Result := Result + ' <Warning: Could not resolve Parameter 1>';
    end;
    ctToEditValue: Result := aInt.ToString;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Parameter 1>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not wbTryGetContainerRefFromUnionOrValue(aElement, Container) then
    Exit;

  Param1 := Container.ElementByName['Parameter #1'];
  if not wbTryGetMainRecord(Param1, MainRecord) then
    Exit;

  MainRecord := MainRecord.WinningOverride;

  if MainRecord.Signature <> QUST then begin
    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: "'+MainRecord.ShortName+'" is not a Quest record>';
      end;
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
    if Supports(MainRecord.ElementByName['Objectives'], IwbContainerElementRef, Objectives) then begin
      for i := 0 to Pred(Objectives.ElementCount) do
        if Supports(Objectives.Elements[i], IwbContainerElementRef, Objective) then begin
          j := Objective.ElementNativeValues['QOBJ'];
          s := Trim(Objective.ElementValues['NNAM']);
          t := IntToStr(j);
          while Length(t) < 3 do
            t := '0' + t;
          if s <> '' then
            t := t + ' ' + s;
          if Assigned(EditInfos) then
            EditInfos.AddObject(t, TObject(j))
          else if j = aInt then begin
            case aType of
              ctToStr, ctToSummary, ctToEditValue: Result := t;
              ctCheck: Result := '';
            end;
            Exit;
          end;
        end;
    end;

    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: Quest Objective not found in "' + MainRecord.Name + '">';
      end;
      ctCheck: Result := '<Warning: Quest Objective not found in "' + MainRecord.Name + '">';
      ctEditInfo: begin
        EditInfos.Sort;
        Result := EditInfos.CommaText;
      end;
    end;
  finally
    FreeAndNil(EditInfos);
  end;
end;

function wbClmtMoonsPhaseLength(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  PhaseLength : Byte;
  Masser      : Boolean;
  Secunda     : Boolean;
begin
  Result := '';
  if aType = ctToSortKey then begin
    Result := IntToHex64(aInt, 2);
    Exit;
  end;

  if aType in [ctToStr, ctToSummary] then begin
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
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 4)
  else if aType in [ctToStr, ctToSummary] then
    Result := TimeToStr( EncodeTime(aInt div 6, (aInt mod 6) * 10, 0, 0) )
  else
    Result := '';
end;

function wbREFRNavmeshTriangleToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainerElementRef;
  Navmesh    : IwbElement;
  MainRecord : IwbMainRecord;
  Triangles  : IwbContainerElementRef;
begin
  case aType of
    ctToStr, ctToSummary: Result := aInt.ToString;
    ctToEditValue: Result := aInt.ToString;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not wbTryGetContainerRefFromUnionOrValue(aElement, Container) then
    Exit;

  Navmesh := Container.Elements[0];
  if not wbTryGetMainRecord(Navmesh, MainRecord) then
    Exit;

  MainRecord := MainRecord.WinningOverride;

  if MainRecord.Signature <> NAVM then begin
    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: "'+MainRecord.ShortName+'" is not a Navmesh record>';
      end;
      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" is not a Navmesh record>';
    end;
    Exit;
  end;

  if not wbSimpleRecords and (aType = ctCheck) and Supports(MainRecord.ElementByPath['NVTR'], IwbContainerElementRef, Triangles) then
    if aInt >= Triangles.ElementCount then
      Result := '<Warning: Navmesh triangle not found in "' + MainRecord.Name + '">';
end;

function wbStringToInt(const aString: string; const aElement: IwbElement): Int64;
begin
  Result := StrToIntDef(aString, 0);
end;


var
  wbCtdaTypeFlags : IwbFlagsDef;

function wbCtdaTypeToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  s: string;
begin
  Result := '';
  case aType of
    ctEditType:
      Result := 'CheckComboBox';
    ctEditInfo:
      Result := 'Equal,Greater,Lesser,Or,"Use Global","Run on Target"';
    ctToEditValue: begin
      Result := '000000';
      case aInt and $F0 of
        $00 : Result[1] := '1';
        $40 : Result[2] := '1';
        $60 : begin
                Result[1] := '1';
                Result[2] := '1';
              end;
        $80 : Result[3] := '1';
        $A0 : begin
                Result[1] := '1';
                Result[3] := '1';
              end;
      end;
      if (aInt and $01) <> 0 then
        Result[4] := '1';
      if (aInt and $02) <> 0 then
        Result[6] := '1';
      if (aInt and $04) <> 0 then
        Result[5] := '1';
    end;
    ctToStr, ctToSummary: begin
      case aInt and $F0 of
        $00 : Result := 'Equal to';
        $20 : Result := 'Not equal to';
        $40 : Result := 'Greater than';
        $60 : Result := 'Greater than or equal to';
        $80 : Result := 'Less than';
        $A0 : Result := 'Less than or equal to';
      else
        Result := '<Unknown Compare operator>'
      end;

      if not Assigned(wbCtdaTypeFlags) then
        wbCtdaTypeFlags := wbFlags([
          {0x01} 'Or',
          {0x02} 'Run on target',
          {0x04} 'Use global'
        ]);

      s := wbCtdaTypeFlags.ToString(aInt and $0F, aElement, aType = ctToSummary);

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
        Result := '<Unknown Compare operator>'
      end;

      if not Assigned(wbCtdaTypeFlags) then
        wbCtdaTypeFlags := wbFlags([
          {0x01} 'Or',
          {0x02} 'Run on target',
          {0x04} 'Use global'
        ]);

      s := wbCtdaTypeFlags.Check(aInt and $0F, aElement);

      if s <> '' then
        Result := Result + ' / ' + s;
    end;
  end;
end;

function wbCtdaTypeToInt(const aString: string; const aElement: IwbElement): Int64;
var
  s: string;
begin
  s := aString + '00000000';
  if s[1] = '1' then begin
    if s[2] = '1' then begin
      if s[3] = '1' then begin
        Result := $00;
      end else begin
        Result := $60;
      end;
    end else begin
      if s[3] = '1' then begin
        Result := $A0;
      end else begin
        Result := $00;
      end;
    end;
  end else begin
    if s[2] = '1' then begin
      if s[3] = '1' then begin
        Result := $20;
      end else begin
        Result := $40;
      end;
    end else begin
      if s[3] = '1' then begin
        Result := $80;
      end else begin
        Result := $20;
      end;
    end;
  end;
  // Or
  if s[4] = '1' then
    Result := Result or $01;
  // Use aliases
  if s[6] = '1' then
    Result := Result or $02;
  // Use global
  if s[5] = '1' then
    Result := Result or $04;
end;

procedure wbHeadPartsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container : IwbContainerElementRef;
begin
  if wbBeginInternalEdit then try
    if Supports(aElement, IwbContainerElementRef, Container) then
      if (Container.Elements[0].NativeValue = 1) and (Container.ElementCount > 2) then
        Container.RemoveElement(1);
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbMESGDNAMAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  OldValue, NewValue : Integer;
  Container          : IwbContainerElementRef;
begin
  if VarSameValue(aOldValue, aNewValue) then
    Exit;

  if not Supports(aElement.Container, IwbContainerElementRef, Container) then
    Exit;

  OldValue := Integer(aOldValue) and 1;
  NewValue := Integer(aNewValue) and 1;

  if NewValue = OldValue then
    Exit;

  if NewValue = 1 then
    Container.RemoveElement('TNAM')
  else
    Container.Add('TNAM', True);
end;

procedure wbGMSTEDIDAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  OldValue, NewValue : string;
  Container          : IwbContainerElementRef;
begin
  if VarSameValue(aOldValue, aNewValue) then
    Exit;

  if not Supports(aElement.Container, IwbContainerElementRef, Container) then
    Exit;

  OldValue := aOldValue;
  NewValue := aNewValue;

  if (Length(OldValue) < 1) or (Length(OldValue) < 1) or (OldValue[1] <> NewValue[1]) then begin
    Container.RemoveElement('DATA');
    Container.Add('DATA', True);
  end;
end;

procedure wbFLSTEDIDAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  OldValue, NewValue     : string;
  OldOrdered, NewOrdered : Boolean;
  Container              : IwbContainerElementRef;
const
  OrderedList = 'OrderedList';
begin
  if VarSameValue(aOldValue, aNewValue) then
    Exit;

  if not Supports(aElement.Container, IwbContainerElementRef, Container) then
    Exit;

  OldValue := aOldValue;
  NewValue := aNewValue;

  if Length(OldValue) > Length(OrderedList) then
    Delete(OldValue, 1, Length(OldValue)-Length(OrderedList));

  if Length(NewValue) > Length(OrderedList) then
    Delete(NewValue, 1, Length(NewValue)-Length(OrderedList));

  OldOrdered := SameText(OldValue, OrderedList);
  NewOrdered := SameText(NewValue, OrderedList);

  if OldOrdered <> NewOrdered then
    Container.RemoveElement('FormIDs');
end;

procedure wbCtdaTypeAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  OldValue, NewValue: Integer;
  Container: IwbContainerElementRef;
begin
  if VarSameValue(aOldValue, aNewValue) then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  // reset value if "use global" has changed
  OldValue := aOldValue and $04;
  NewValue := aNewValue and $04;

  if OldValue <> NewValue then
    Container.ElementNativeValues['..\Comparison Value'] := 0;

  if aNewValue and $02 then begin
    Container.ElementNativeValues['..\Run On'] := 1;
    if Integer(Container.ElementNativeValues['..\Run On']) = 1 then
      aElement.NativeValue := Byte(aNewValue) and not $02;
  end;
end;

function wbIdleAnam(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr, ctToSummary: begin
      case aInt and not $C0 of
        0: Result := 'Idle';
        1: Result := 'Movement';
        2: Result := 'Left Arm';
        3: Result := 'Left Hand';
        4: Result := 'Weapon';
        5: Result := 'Weapon Up';
        6: Result := 'Weapon Down';
        7: Result := 'Special Idle';
       20: Result := 'Whole Body';
       21: Result := 'Upper Body';
      else
        Result := '<Unknown: '+IntToStr(aInt and not $C0)+'>';
      end;

      if (aInt and $80) = 0 then
        Result := Result + ', Must return a file';
      if (aInt and $40) = 1 then
        Result := Result + ', Unknown Flag';
    end;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2);
    end;
    ctCheck: begin
      case aInt and not $C0 of
        0..7, 20, 21: Result := '';
      else
        Result := '<Unknown: '+IntToStr(aInt and not $C0)+'>';
      end;
    end;
  end;
end;

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

function wbPlacedAddInfo(const aMainRecord: IwbMainRecord): string;
var
  Rec: IwbRecord;
  Container: IwbContainer;
  s: string;
  Cell: IwbMainRecord;
  Position: TwbVector;
  Grid: TwbGridCell;
begin
  Result := '';

  Rec := aMainRecord.RecordBySignature['NAME'];
  if Assigned(Rec) then begin
    s := Trim(Rec.Value);
    if s <> '' then
      Result := 'places ' + s;
  end;

  Container := aMainRecord.Container;
  while Assigned(Container) and (Container.ElementType <> etGroupRecord) do
    Container := Container.Container;

  if not Assigned(Container) then
    Exit;

  s := Trim(Container.Name);
  if s <> '' then begin
    if Result <> '' then
      Result := Result + ' ';

    Result := Result + 'in ' + s;

    // grid position of persistent reference in exterior persistent cell (interior cells are not persistent)
    if Supports(aMainRecord.Container, IwbGroupRecord, Container) then
      Cell := IwbGroupRecord(Container).ChildrenOf;

    if Assigned(Cell) and Cell.IsPersistent and (Cell.Signature = 'CELL') then
      if aMainRecord.GetPosition(Position) then begin
        Grid := wbPositionToGridCell(Position);
        Result := Result + ' at ' + IntToStr(Grid.x) + ',' + IntToStr(Grid.y);
      end;
  end;
end;

function wbINFOAddInfo(const aMainRecord: IwbMainRecord): string;
var
  Container: IwbContainer;
  s: string;
begin
  Result := Trim(aMainRecord.ElementValues['Responses\Response\NAM1']);
  if Result <> '' then
    Result := '''' + Result + '''';

  Container := aMainRecord.Container;
  while Assigned(Container) and (Container.ElementType <> etGroupRecord) do
    Container := Container.Container;

  if Assigned(Container) then begin
    s := Trim(Container.Name);
    if s <> '' then begin
      if Result <> '' then
        Result := Result + ' ';
      Result := Result + 'in ' + s;
    end;
  end;

  s := Trim(aMainRecord.ElementValues['QSTI']);
  if s <> '' then begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + 'for ' + s;
  end;
end;

function wbNAVMAddInfo(const aMainRecord: IwbMainRecord): string;
var
  Rec        : IwbRecord;
  Element    : IwbElement;
  s          : string;
begin
  Result := '';

  Rec := aMainRecord.RecordBySignature['DATA'];
  if not Assigned(Rec) then
    Exit;

  Element := Rec.ElementByName['Cell'];
  if Assigned(Element) then
    Element := Element.LinksTo;
  if Assigned(Element) then
    s := Trim(Element.Name);
  if s <> '' then
    Result := 'for ' + s;
end;

function wbWthrDataClassification(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr, ctToSummary: begin
      case aInt and not 192 of
        0: Result := 'None';
        1: Result := 'Pleasant';
        2: Result := 'Cloudy';
        4: Result := 'Rainy';
        8: Result := 'Snow';
      else
        Result := '<Unknown: '+IntToStr(aInt and not 192)+'>';
      end;
    end;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2)
    end;
    ctCheck: begin
      case aInt and not 192 of
        0, 1, 2, 4, 8: Result := '';
      else
        Result := '<Unknown: '+IntToStr(aInt and not 192)+'>';
      end;
    end;
  end;
end;

function wbNOTETNAMDecide(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  rDATA: IwbRecord;
begin
  Result := 0;
  rDATA := aElement.Container.RecordBySignature[DATA];
  if Assigned(rDATA) then
    if rDATA.NativeValue = 3 then //Voice
      Result := 1;
end;

function wbNOTESNAMDecide(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  rDATA: IwbRecord;
begin
  Result := 0;
  rDATA := aElement.Container.RecordBySignature[DATA];
  if Assigned(rDATA) then
    if rDATA.NativeValue = 3 then //Voice
      Result := 1;
end;

function wbIPDSDATACount(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  if Assigned(aBasePtr) and Assigned(aEndPtr) then
    Result := (NativeUInt(aBasePtr) - NativeUInt(aBasePtr)) div 4
  else
    Result := 12;
end;

function wbNAVINAVMGetCount1(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  DataContainer : IwbDataContainer;
begin
  Result := 0;

  if Supports(aElement, IwbDataContainer, DataContainer) then begin
    if DataContainer.ElementType = etArray then
      if not Supports(DataContainer.Container, IwbDataContainer, DataContainer) then
        Exit;
    Assert(DataContainer.Name = 'Data');
    Result := PWord(NativeUInt(DataContainer.DataBasePtr) + 3*3*4)^;
  end;
end;

function wbNAVINAVMGetCount2(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  DataContainer : IwbDataContainer;
begin
  Result := 0;

  if Supports(aElement, IwbDataContainer, DataContainer) then begin
    if DataContainer.ElementType = etArray then
      if not Supports(DataContainer.Container, IwbDataContainer, DataContainer) then
        Exit;
    Assert(DataContainer.Name = 'Data');
    Result := PWord(NativeUInt(DataContainer.DataBasePtr) + 3*3*4 + 2)^;
  end;
end;

function wbMGEFFAssocItemDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
  Archtype      : Variant;
  DataContainer : IwbDataContainer;
  Element       : IwbElement;
const
  OffsetArchtype = 56;

begin
  Result := 1;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  VarClear(ArchType);
  Element := Container.ElementByName['Archtype'];

  if Assigned(Element) then
    ArchType := Element.NativeValue
  else if Supports(Container, IwbDataContainer, DataContainer) and
          DataContainer.IsValidOffset(aBasePtr, aEndPtr, OffsetArchtype) then begin // we are part a proper structure
      aBasePtr := PByte(aBasePtr) + OffsetArchtype;
      ArchType := PCardinal(aBasePtr)^;
    end;

  if VarIsEmpty(ArchType) then
    Exit;

  case Integer(ArchType) of
    01: Result := 2;//Script
    18: Result := 3;//Bound Item
    19: Result := 4;//Summon Creature
  else
    Result := 0;
  end;
end;

procedure wbMGEFAssocItemAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container : IwbContainer;
  Element   : IwbElement;
begin
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  if not (aNewValue <> 0) then
    Exit;

  Element := Container.ElementByName['Archtype'];
  if Assigned(Element) and Element.NativeValue = 0 then
      Element.NativeValue := $FF; // Signals ArchType that it should not mess with us on the next change!
end;

procedure wbMGEFArchtypeAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container: IwbContainerElementRef;
begin
  if VarSameValue(aOldValue, aNewValue) then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if (aNewValue < $FF) and (aOldValue < $FF) then begin
    Container.ElementNativeValues['..\Assoc. Item'] := 0;
    case Integer(aNewValue) of
      11: Container.ElementNativeValues['..\Actor Value'] := 48;//Invisibility
      12: Container.ElementNativeValues['..\Actor Value'] := 49;//Chameleon
      24: Container.ElementNativeValues['..\Actor Value'] := 47;//Paralysis
    else
      Container.ElementNativeValues['..\Actor Value'] := -1;
    end;
  end;
end;

procedure wbCounterEffectsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterByPathAfterSet('DATA - Data\Counter effect count', aElement);
end;

procedure wbMGEFAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterContainerByPathAfterSet('DATA - Data\Counter effect count', 'Counter Effects', aElement);
end;

function wbNAVINVMIDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  case Integer(Container.ElementNativeValues['Type']) of
    $00: Result :=1;
    $20: Result :=2;
    $30: Result :=3;
  end;
end;

function wbIMGSSkinDimmerDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container : IwbContainer;
  SubRecord : IwbSubRecord;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  if Supports(Container, IwbSubRecord, SubRecord) then
    if SubRecord.SubRecordHeaderSize in [132, 148] then
      Result := 1;
end;

function wbCOEDOwnerDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container  : IwbContainer;
  LinksTo    : IwbElement;
  MainRecord : IwbMainRecord;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  LinksTo := Container.ElementLinksTo['Owner'];

  if not Supports(LinksTo, IwbMainRecord, MainRecord) then
    Exit;
    if MainRecord.Signature = 'NPC_' then
      Result := 1
    else if MainRecord.Signature = 'FACT' then
      Result := 2;
end;

function wbCreaLevelDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
  i: Int64;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  i := Container.ElementByName['Flags'].NativeValue;
  if i and $00000080 <> 0 then
    Result := 1;
end;


function wbGMSTUnionDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  rEDID: IwbRecord;
  s: string;
begin
  Result := 1;
  rEDID := aElement.Container.RecordBySignature[EDID];
  if not Assigned(rEDID) then
    Exit;

  s := rEDID.Value;
  if Length(s) > 0 then
    case s[1] of
      's': Result := 0;
      'f': Result := 2;
    end;
end;

function wbFLSTLNAMIsSorted(const aContainer: IwbContainer): Boolean;
var
  rEDID      : IwbRecord;
  s          : string;
  _File      : IwbFile;
  MainRecord : IwbMainRecord;
const
  OrderedList = 'OrderedList';
begin
  Result := wbSortFLST; {>>> Should not be sorted according to Arthmoor and JustinOther, left as sorted for compatibility <<<}
  if Result then begin
    rEDID := aContainer.RecordBySignature[EDID];
    if Assigned(rEDID) then begin
      s := rEDID.Value;
      if Length(s) > Length(OrderedList) then
        Delete(s, 1, Length(s)-Length(OrderedList));

      if SameText(s, OrderedList) then
        Result := False;
    end;
  end;
  if Result then begin
    MainRecord := aContainer.ContainingMainRecord;
    if not Assigned(MainRecord) then
      Exit;
    MainRecord := MainRecord.MasterOrSelf;
    if not Assigned(MainRecord) then
      Exit;
    _File := MainRecord._File;
    if not Assigned(_File) then
      Exit;
    if not SameText(_File.FileName, 'WeaponModKits.esp') then
      Exit;
    case MainRecord.FormID.ObjectID of
      $0130EB, $0130ED, $01522D, $01522E, $0158D5, $0158D6, $0158D7, $0158D8, $0158D9, $0158DA, $0158DC, $0158DD, $018E20:
        Result := False;
    end;
  end;
end;

function wbPerkDATADecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  rPRKE: IwbRecord;
  eType: IwbElement;
begin
  Result := 0;
  rPRKE := aElement.Container.RecordBySignature[PRKE];
  if not Assigned(rPRKE) then
    Exit;

  eType := rPRKE.ElementByName['Type'];
  if not Assigned(eType) then
    Exit;

  Result := eType.NativeValue;
end;

function wbEPFDDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainerElementRef;
begin
  Result := 0;
  if not Assigned(aElement) then
    Exit;

  if not Supports(aElement.Container, IwbContainerElementRef, Container) then
    Exit;

  Result := Container.ElementNativeValues['EPFT'];

  if Result = 2 then
    if Integer(Container.ElementNativeValues['..\DATA\Entry Point\Function']) = 5 then
      Result := 5;
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
    ptQuestStage,    //?? Integer
    ptMiscStat,      //?? Enum
    ptAlignment,     //?? Enum
    ptEquipType,     //?? Enum
    ptFormType,      //?? Enum
    ptCriticalStage, //?? Enum

    ptObjectReference,    //REFR, ACHR, ACRE, PGRE
    ptInventoryObject,    //ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, NOTE, ARMA
    ptActor,              //ACHR, ACRE
    ptVoiceType,          //VTYP
    ptIdleForm,           //IDLE
    ptFormList,           //FLST
    ptNote,               //NOTE
    ptQuest,              //QUST
    ptFaction,            //FACT
    ptWeapon,             //WEAP
    ptCell,               //CELL
    ptClass,              //CLAS
    ptRace,               //RACE
    ptActorBase,          //NPC_, CREA
    ptGlobal,             //GLOB
    ptWeather,            //WTHR
    ptPackage,            //PACK
    ptEncounterZone,      //ECZN
    ptPerk,               //PERK
    ptOwner,              //FACT, NPC_
    ptFurniture,          //FURN
    ptMagicItem,          //SPEL
    ptMagicEffect,        //MGEF
    ptWorldspace,         //WRLD
    ptVATSValueFunction,
    ptVATSValueParam,
    ptCreatureType,
    ptMenuMode,
    ptPlayerAction,
    ptBodyLocation,
    ptReferencableObject  //TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM
  );

  PCTDAFunction = ^TCTDAFunction;
  TCTDAFunction = record
    Index: Integer;
    Name: string;
    ParamType1: TCTDAFunctionParamType;
    ParamType2: TCTDAFunctionParamType;
  end;

const
  wbCTDAFunctions : array[0..243] of TCTDAFunction = (
    // Added by Fallout 3
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
    (Index:  25; Name: 'IsMoving'),
    (Index:  26; Name: 'IsTurning'),
    (Index:  27; Name: 'GetLineOfSight'; ParamType1: ptObjectReference),
    (Index:  32; Name: 'GetInSameCell'; ParamType1: ptObjectReference),
    (Index:  35; Name: 'GetDisabled'),
    (Index:  36; Name: 'MenuMode'; ParamType1: ptMenuMode),
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
    (Index:  98; Name: 'GetPlayerControlsDisabled'; ParamType1: ptInteger; ParamType2: ptInteger{; ParamType3: ptInteger; ParamType4: ptInteger; ParamType5: ptInteger; ParamType6: ptInteger; ParamType7: ptInteger}),
    (Index:  99; Name: 'GetHeadingAngle'; ParamType1: ptObjectReference),
    (Index: 101; Name: 'IsWeaponOut'),
    (Index: 102; Name: 'IsTorchOut'),
    (Index: 103; Name: 'IsShieldOut'),
    (Index: 106; Name: 'IsFacingUp'),
    (Index: 107; Name: 'GetKnockedState'),
    (Index: 108; Name: 'GetWeaponAnimType'),
    (Index: 109; Name: 'IsWeaponSkillType'; ParamType1: ptActorValue),
    (Index: 110; Name: 'GetCurrentAIPackage'),
    (Index: 111; Name: 'IsWaiting'),
    (Index: 112; Name: 'IsIdlePlaying'),
    (Index: 116; Name: 'GetMinorCrimeCount'),
    (Index: 117; Name: 'GetMajorCrimeCount'),
    (Index: 118; Name: 'GetActorAggroRadiusViolated'),
    (Index: 122; Name: 'GetCrime'; ParamType1: ptActor; ParamType2: ptCrimeType),
    (Index: 123; Name: 'IsGreetingPlayer'),
    (Index: 125; Name: 'IsGuard'),
    (Index: 127; Name: 'HasBeenEaten'),
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
    (Index: 172; Name: 'GetTalkedToPCParam'; ParamType1: ptActor),
    (Index: 175; Name: 'IsPCSleeping'),
    (Index: 176; Name: 'IsPCAMurderer'),
    (Index: 180; Name: 'GetDetectionLevel'; ParamType1: ptActor),
    (Index: 182; Name: 'GetEquipped'; ParamType1: ptInventoryObject),
    (Index: 185; Name: 'IsSwimming'),
    (Index: 190; Name: 'GetAmountSoldStolen'),
    (Index: 192; Name: 'GetIgnoreCrime'),
    (Index: 193; Name: 'GetPCExpelled'; ParamType1: ptFaction),
    (Index: 195; Name: 'GetPCFactionMurder'; ParamType1: ptFaction),
    (Index: 197; Name: 'GetPCEnemyofFaction'; ParamType1: ptFaction),
    (Index: 199; Name: 'GetPCFactionAttack'; ParamType1: ptFaction),
    (Index: 203; Name: 'GetDestroyed'),
    (Index: 214; Name: 'HasMagicEffect'; ParamType1: ptMagicEffect),
    (Index: 215; Name: 'GetDefaultOpen'),
    (Index: 219; Name: 'GetAnimAction'),
    (Index: 223; Name: 'IsSpellTarget'; ParamType1: ptMagicItem),
    (Index: 224; Name: 'GetVATSMode'),
    (Index: 225; Name: 'GetPersuasionNumber'),
    (Index: 226; Name: 'GetSandman'),
    (Index: 227; Name: 'GetCannibal'),
    (Index: 228; Name: 'GetIsClassDefault'; ParamType1: ptClass),
    (Index: 229; Name: 'GetClassDefaultMatch'),
    (Index: 230; Name: 'GetInCellParam'; ParamType1: ptCell; ParamType2: ptObjectReference),
    (Index: 235; Name: 'GetVatsTargetHeight'),
    (Index: 237; Name: 'GetIsGhost'),
    (Index: 242; Name: 'GetUnconscious'),
    (Index: 244; Name: 'GetRestrained'),
    (Index: 246; Name: 'GetIsUsedItem'; ParamType1: ptReferencableObject),
    (Index: 247; Name: 'GetIsUsedItemType'; ParamType1: ptFormType),
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
    (Index: 278; Name: 'IsOwner'; ParamType1: ptOwner),
    (Index: 280; Name: 'IsCellOwner'; ParamType1: ptCell; ParamType2: ptOwner),
    (Index: 282; Name: 'IsHorseStolen'),
    (Index: 285; Name: 'IsLeftUp'),
    (Index: 286; Name: 'IsSneaking'),
    (Index: 287; Name: 'IsRunning'),
    (Index: 288; Name: 'GetFriendHit'),
    (Index: 289; Name: 'IsInCombat'),
    (Index: 300; Name: 'IsInInterior'),
    (Index: 304; Name: 'IsWaterObject'),
    (Index: 306; Name: 'IsActorUsingATorch'),
    (Index: 309; Name: 'IsXBox'),
    (Index: 310; Name: 'GetInWorldspace'; ParamType1: ptWorldSpace),
    (Index: 312; Name: 'GetPCMiscStat'; ParamType1: ptMiscStat),
    (Index: 313; Name: 'IsActorEvil'),
    (Index: 314; Name: 'IsActorAVictim'),
    (Index: 315; Name: 'GetTotalPersuasionNumber'),
    (Index: 318; Name: 'GetIdleDoneOnce'),
    (Index: 320; Name: 'GetNoRumors'),
    (Index: 323; Name: 'WhichServiceMenu'),
    (Index: 327; Name: 'IsRidingHorse'),
    (Index: 332; Name: 'IsInDangerousWater'),
    (Index: 338; Name: 'GetIgnoreFriendlyHits'),
    (Index: 339; Name: 'IsPlayersLastRiddenHorse'),
    (Index: 353; Name: 'IsActor'),
    (Index: 354; Name: 'IsEssential'),
    (Index: 358; Name: 'IsPlayerMovingIntoNewSpace'),
    (Index: 361; Name: 'GetTimeDead'),
    (Index: 362; Name: 'GetPlayerHasLastRiddenHorse'),
    (Index: 365; Name: 'IsChild'),
    (Index: 367; Name: 'GetLastPlayerAction'),
    (Index: 368; Name: 'IsPlayerActionActive'; ParamType1: ptPlayerAction),
    (Index: 370; Name: 'IsTalkingActivatorActor'; ParamType1: ptActor),
    (Index: 372; Name: 'IsInList'; ParamType1: ptFormList),
    (Index: 382; Name: 'GetHasNote'; ParamType1: ptNote),
    (Index: 391; Name: 'GetHitLocation'),
    (Index: 392; Name: 'IsPC1stPerson'),
    (Index: 397; Name: 'GetCauseofDeath'),
    (Index: 398; Name: 'IsLimbGone'; ParamType1: ptBodyLocation),
    (Index: 399; Name: 'IsWeaponInList'; ParamType1: ptFormList),
    (Index: 403; Name: 'HasFriendDisposition'),
    (Index: 408; Name: 'GetVATSValue'; ParamType1: ptVATSValueFunction; ParamType2: ptVATSValueParam),
    (Index: 409; Name: 'IsKiller'; ParamType1: ptActor),
    (Index: 410; Name: 'IsKillerObject'; ParamType1: ptFormList),
    (Index: 411; Name: 'GetFactionCombatReaction'; ParamType1: ptFaction; ParamType2: ptFaction),
    (Index: 415; Name: 'Exists'; ParamType1: ptObjectReference),
    (Index: 416; Name: 'GetGroupMemberCount'),
    (Index: 417; Name: 'GetGroupTargetCount'),
    (Index: 427; Name: 'GetIsVoiceType'; ParamType1: ptVoiceType),
    (Index: 428; Name: 'GetPlantedExplosive'),
    (Index: 430; Name: 'IsActorTalkingThroughActivator'),
    (Index: 431; Name: 'GetHealthPercentage'),
    (Index: 433; Name: 'GetIsObjectType'; ParamType1: ptFormType),
    (Index: 435; Name: 'GetDialogueEmotion'),
    (Index: 436; Name: 'GetDialogueEmotionValue'),
    (Index: 438; Name: 'GetIsCreatureType'; ParamType1: ptCreatureType),
    (Index: 446; Name: 'GetInZone'; ParamType1: ptEncounterZone),
    (Index: 449; Name: 'HasPerk'; ParamType1: ptPerk),
    (Index: 450; Name: 'GetFactionRelation'; ParamType1: ptActor),
    (Index: 451; Name: 'IsLastIdlePlayed'; ParamType1: ptIdleForm),
    (Index: 454; Name: 'GetPlayerTeammate'),
    (Index: 455; Name: 'GetPlayerTeammateCount'),
    (Index: 459; Name: 'GetActorCrimePlayerEnemy'),
    (Index: 460; Name: 'GetActorFactionPlayerEnemy'),
    (Index: 464; Name: 'IsPlayerGrabbedRef'; ParamType1: ptObjectReference),
    (Index: 471; Name: 'GetDestructionStage'),
    (Index: 474; Name: 'GetIsAlignment'; ParamType1: ptAlignment),
    (Index: 478; Name: 'GetThreatRatio'; ParamType1: ptActor),
    (Index: 480; Name: 'GetIsUsedItemEquipType'; ParamType1: ptEquipType),
    (Index: 489; Name: 'GetConcussed'),
    (Index: 492; Name: 'GetMapMarkerVisible'),
    (Index: 495; Name: 'GetPermanentActorValue'; ParamType1: ptActorValue),
    (Index: 496; Name: 'GetKillingBlowLimb'),
    (Index: 500; Name: 'GetWeaponHealthPerc'),
    (Index: 503; Name: 'GetRadiationLevel'),
    (Index: 510; Name: 'GetLastHitCritical'),
    (Index: 515; Name: 'IsCombatTarget'; ParamType1: ptActor),
    (Index: 518; Name: 'GetVATSRightAreaFree'; ParamType1: ptObjectReference),
    (Index: 519; Name: 'GetVATSLeftAreaFree'; ParamType1: ptObjectReference),
    (Index: 520; Name: 'GetVATSBackAreaFree'; ParamType1: ptObjectReference),
    (Index: 521; Name: 'GetVATSFrontAreaFree'; ParamType1: ptObjectReference),
    (Index: 522; Name: 'GetIsLockBroken'),
    (Index: 523; Name: 'IsPS3'),
    (Index: 524; Name: 'IsWin32'),
    (Index: 525; Name: 'GetVATSRightTargetVisible'; ParamType1: ptObjectReference),
    (Index: 526; Name: 'GetVATSLeftTargetVisible'; ParamType1: ptObjectReference),
    (Index: 527; Name: 'GetVATSBackTargetVisible'; ParamType1: ptObjectReference),
    (Index: 528; Name: 'GetVATSFrontTargetVisible'; ParamType1: ptObjectReference),
    (Index: 531; Name: 'IsInCriticalStage'; ParamType1: ptCriticalStage),
    (Index: 533; Name: 'GetXPForNextLevel'),
    (Index: 546; Name: 'GetQuestCompleted'; ParamType1: ptQuest),
    (Index: 550; Name: 'IsGoreDisabled'),
    (Index: 555; Name: 'GetSpellUsageNum'; ParamType1: ptMagicItem),
    (Index: 557; Name: 'GetActorsInHigh'),
    (Index: 558; Name: 'HasLoaded3D'),

    // Added by FOSE:
    (Index: 1024; Name: 'GetFOSEVersion'; ),
    (Index: 1025; Name: 'GetFOSERevision'; ),
    (Index: 1028; Name: 'GetWeight'; ParamType1: ptInventoryObject; ),
    (Index: 1082; Name: 'IsKeyPressed'; ParamType1: ptInteger;),
    (Index: 1165; Name: 'GetWeaponHasScope'; ParamType1: ptInventoryObject; ),
    (Index: 1166; Name: 'IsControlPressed'; ParamType1: ptInteger; ),
    (Index: 1213; Name: 'GetFOSEBeta'; )
  );
var
  wbCTDAFunctionEditInfo: string;

function wbCTDAParamDescFromIndex(aIndex: Integer): PCTDAFunction;
var
  L, H, I, C: Integer;
begin
  Result := nil;

  L := Low(wbCTDAFunctions);
  H := High(wbCTDAFunctions);
  while L <= H do begin
    I := (L + H) shr 1;
    C := CmpW32(wbCTDAFunctions[I].Index, aIndex);
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
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  if Integer(Container.ElementByName['Type'].NativeValue) and $04 <> 0 then
    Result := 1;
end;

function wbCTDAParam1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Desc: PCTDAFunction;
  Container: IwbContainer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  Desc := wbCTDAParamDescFromIndex(Container.ElementByName['Function'].NativeValue);
  if Assigned(Desc) then
    Result := Succ(Integer(Desc.ParamType1));
end;

function wbCTDAParam2VATSValueParam(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container : IwbContainer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  Result := Container.ElementByName['Parameter #1'].NativeValue;
end;

function wbCTDAParam2Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Desc: PCTDAFunction;
  Container: IwbContainer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  Desc := wbCTDAParamDescFromIndex(Container.ElementByName['Function'].NativeValue);
  if Assigned(Desc) then
    Result := Succ(Integer(Desc.ParamType2));
end;

function wbCTDAFunctionToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Desc : PCTDAFunction;
  i    : Integer;
begin
  Result := '';
  case aType of
    ctToStr, ctToSummary, ctToEditValue: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := Desc.Name
      else if aType in [ctToSummary, ctToEditValue] then
        Result := aInt.ToString
      else
        Result := '<Unknown: '+aInt.ToString+'>';
    end;
    ctToSortKey: Result := IntToHex(aInt, 8);
    ctCheck: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := ''
      else
        Result := '<Unknown: '+aInt.ToString+'>';
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

type
  TPERKEntryPointConditionType = (
    epcDefault,
    epcItem,
    epcWeapon,
    epcWeaponTarget,
    epcTarget,
    epcAttacker,
    epcAttackerAttackee,
    epcAttackerAttackerWeapon
  );

  TPERKEntryPointFunctionType = (
    epfFloat,
    epfLeveledItem,
    epfScript,
    epfUnknown
  );

  TPERKEntryPointFunctionParamType = (
    epfpNone,
    epfpFloat,
    epfpFloatFloat,
    epfpLeveledItem,
    epfpScript
  );

  PPERKEntryPoint = ^TPERKEntryPoint;
  TPERKEntryPoint = record
    Name         : string;
    Condition   : TPERKEntryPointConditionType;
    FunctionType : TPERKEntryPointFunctionType;
  end;

  PPERKCondition = ^TPERKCondition;
  TPERKCondition = record
    Count    : Integer;
    Caption1 : string;
    Caption2 : string;
    Caption3 : string;
  end;

  PPERKFunction = ^TPERKFunction;
  TPERKFunction = record
    Name         : string;
    FunctionType : TPERKEntryPointFunctionType;
    ParamType    : TPERKEntryPointFunctionParamType;
  end;

const
  wbPERKCondition : array[TPERKEntryPointConditionType] of TPERKCondition = (
    (Count: 1; Caption1: 'Perk Owner'),
    (Count: 2; Caption1: 'Perk Owner'; Caption2: 'Item'),
    (Count: 2; Caption1: 'Perk Owner'; Caption2: 'Weapon'),
    (Count: 3; Caption1: 'Perk Owner'; Caption2: 'Weapon'; Caption3: 'Target'),
    (Count: 2; Caption1: 'Perk Owner'; Caption2: 'Target'),
    (Count: 2; Caption1: 'Perk Owner'; Caption2: 'Attacker'),
    (Count: 3; Caption1: 'Perk Owner'; Caption2: 'Attacker'; Caption3: 'Attackee'),
    (Count: 3; Caption1: 'Perk Owner'; Caption2: 'Attacker'; Caption3: 'Attacker Weapon')
  );

  wbPERKFunctions : array[0..9] of TPERKFunction = (
    (Name: ''; FunctionType: epfUnknown; ParamType: epfpNone),
    (Name: 'Set Value'; FunctionType: epfFloat; ParamType: epfpFloat),
    (Name: 'Add Value'; FunctionType: epfFloat; ParamType: epfpFloat),
    (Name: 'Multiply Value'; FunctionType: epfFloat; ParamType: epfpFloat),
    (Name: 'Add Range To Value'; FunctionType: epfFloat; ParamType: epfpFloatFloat),
    (Name: 'Add Actor Value Mult'; FunctionType: epfFloat; ParamType: epfpFloatFloat),
    (Name: ''; FunctionType: epfUnknown; ParamType: epfpNone),
    (Name: ''; FunctionType: epfUnknown; ParamType: epfpNone),
    (Name: 'Add Leveled List'; FunctionType: epfLeveledItem; ParamType: epfpLeveledItem),
    (Name: 'Add Activate Choice'; FunctionType: epfScript; ParamType: epfpScript)
  );

  wbPERKEntryPoints : array[0..36] of TPERKEntryPoint = (
    (Name: 'Calculate Weapon Damage'; Condition: epcWeaponTarget),
    (Name: 'Calculate My Critical Hit Chance'; Condition: epcWeaponTarget),
    (Name: 'Calculate My Critical Hit Damage'; Condition: epcWeaponTarget),
    (Name: 'Calculate Weapon Attack AP Cost'; Condition: epcWeapon),
    (Name: 'Calculate Mine Explode Chance'; Condition: epcItem),
    (Name: 'Adjust Range Penalty'; Condition: epcWeapon),
    (Name: 'Adjust Limb Damage'; Condition: epcAttackerAttackerWeapon),
    (Name: 'Calculate Weapon Range'; Condition: epcWeapon),
    (Name: 'Calculate To Hit Chance'; Condition: epcWeaponTarget),
    (Name: 'Adjust Experience Points'),
    (Name: 'Adjust Gained Skill Points'),
    (Name: 'Adjust Book Skill Points'),
    (Name: 'Modify Recovered Health'),
    (Name: 'Calculate Inventory AP Cost'),
    (Name: 'Get Disposition'; Condition: epcTarget),
    (Name: 'Get Should Attack'; Condition: epcAttacker),
    (Name: 'Get Should Assist'; Condition: epcAttackerAttackee),
    (Name: 'Calculate Buy Price'; Condition: epcItem),
    (Name: 'Get Bad Karma'),
    (Name: 'Get Good Karma'),
    (Name: 'Ignore Locked Terminal'),
    (Name: 'Add Leveled List On Death'; Condition: epcTarget; FunctionType: epfLeveledItem),
    (Name: 'Get Max Carry Weight'),
    (Name: 'Modify Addiction Chance'),
    (Name: 'Modify Addiction Duration'),
    (Name: 'Modify Positive Chem Duration'),
    (Name: 'Adjust Drinking Radiation'),
    (Name: 'Activate'; Condition: epcTarget; FunctionType: epfScript),
    (Name: 'Mysterious Stranger'),
    (Name: 'Has Paralyzing Palm'),
    (Name: 'Hacking Science Bonus'),
    (Name: 'Ignore Running During Detection'),
    (Name: 'Ignore Broken Lock'),
    (Name: 'Has Concentrated Fire'),
    (Name: 'Calculate Gun Spread'; Condition: epcWeapon),
    (Name: 'Player Kill AP Reward'; Condition: epcWeaponTarget),
    (Name: 'Modify Enemy Critical Hit Chance'; Condition: epcWeaponTarget)
  );

  wbPERKFunctionParams: array[TPERKEntryPointFunctionParamType] of string = (
    'None',
    'Float',
    'Float, Float',
    'Leveled Item',
    'Script'
  );

procedure wbPERKEntryPointAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  OldEntryPoint   : PPERKEntryPoint;
  NewEntryPoint   : PPERKEntryPoint;
  OldCondition    : PPERKCondition;
  NewCondition    : PPERKCondition;
  OldFunction     : PPERKFunction;
  EntryPoint      : IwbContainerElementRef;
  Effect          : IwbContainerElementRef;
  PerkConditions  : IwbContainerElementRef;
  PerkCondition   : IwbContainerElementRef;
  Container       : IwbContainerElementRef;
  i               : Integer;
begin
  if aOldValue <> aNewValue then begin
    OldEntryPoint := @wbPERKEntryPoints[Integer(aOldValue)];
    NewEntryPoint := @wbPERKEntryPoints[Integer(aNewValue)];
    OldCondition := @wbPERKCondition[OldEntryPoint.Condition];
    NewCondition := @wbPERKCondition[NewEntryPoint.Condition];

    if not Assigned(aElement) then
      Exit;

    if not Supports(aElement.Container, IwbContainerElementRef, EntryPoint) then
      Exit;

    i := EntryPoint.ElementNativeValues['Function'];
    if (i >= Low(wbPERKFunctions)) and (i <= High(wbPERKFunctions)) then
      OldFunction := @wbPERKFunctions[i]
    else
      OldFunction := nil;

    if not Assigned(OldFunction) or (OldFunction.FunctionType <> NewEntryPoint.FunctionType) then
      for i := Low(wbPERKFunctions) to High(wbPERKFunctions) do
        with wbPERKFunctions[i] do
          if FunctionType = NewEntryPoint.FunctionType then begin
            EntryPoint.ElementNativeValues['Function'] := i;
            Break;
          end;

    EntryPoint.ElementNativeValues['Perk Condition Tab Count'] := NewCondition.Count;

    if not Supports(EntryPoint.Container, IwbContainerElementRef, Container) then
      Exit;

    if not Supports(Container.Container, IwbContainerElementRef, Effect) then
      Exit;

    if not Supports(Effect.ElementByName['Perk Conditions'], IwbContainerElementRef, PerkConditions) then
      Exit;

    for i := Pred(PerkConditions.ElementCount) downto 0 do
      if Supports(PerkConditions.Elements[i], IwbContainerElementRef, PerkCondition) then
        if Integer(PerkCondition.ElementNativeValues['PRKC']) >= NewCondition.Count then
          PerkCondition.Remove
        else
          case Integer(PerkCondition.ElementNativeValues['PRKC']) of
            2: if OldCondition.Caption2 <> NewCondition.Caption2 then
                 PerkCondition.Remove;
            3: if OldCondition.Caption3 <> NewCondition.Caption3 then
                 PerkCondition.Remove;
          end;
  end;
end;

function wbPRKCToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container     : IwbContainerElementRef;
  EntryPointVar : Variant;
  EntryPoint    : Integer;
begin
  case aType of
    ctToStr, ctToSummary:
    begin
      Result := aInt.ToString;
      if aType = ctToStr then
        Result := Result + ' <Warning: Could not resolve Entry Point>';
    end;
    ctToEditValue: Result := aInt.ToString;
    ctToSortKey:
    begin
      Result := IntToHex64(aInt, 2);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Entry Point>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  EntryPointVar := Container.ElementNativeValues['..\..\..\DATA\Entry Point\Entry Point'];
  if VarIsNull(EntryPointVar) or VarIsClear(EntryPointVar) then
    Exit;

  EntryPoint := EntryPointVar;
  if (EntryPoint < Low(wbPERKEntryPoints)) or (EntryPoint > High(wbPERKEntryPoints)) then begin
    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: Unknown Entry Point #'+IntToStr(EntryPoint)+'>';
      end;
      ctCheck: Result := '<Warning: Unknown Entry Point #'+IntToStr(EntryPoint)+'>';
    end;
    Exit;
  end;

  with wbPERKEntryPoints[EntryPoint] do begin
    with wbPERKCondition[Condition] do begin
      case aType of
        ctEditType: Result := 'ComboBox';
        ctEditInfo: with TStringList.Create do try
          if Caption1 <> '' then
            Add(Caption1);
          if Caption2 <> '' then
            Add(Caption2);
          if Caption3 <> '' then
            Add(Caption3);
          Sort;
          Result := CommaText;
        finally
          Free;
        end;
      else
        if (aInt < 0) or (aInt >= Count) then
          case aType of
            ctToStr, ctToSummary: begin
              Result := aInt.ToString;
              if aType = ctToStr then
                Result := Result + ' <Warning: Value out of Bounds for this Entry Point>';
            end;
            ctCheck: Result := '<Warning: Value out of Bounds for this Entry Point>';
          end
        else
          case aType of
            ctToStr, ctToSummary, ctToEditValue: case Integer(aInt) of
              0: Result := Caption1;
              1: Result := Caption2;
              2: Result := Caption3;
            end;
            ctCheck: Result := '';
          end;
      end;
    end;
  end;
end;

function wbPRKCToInt(const aString: string; const aElement: IwbElement): Int64;
var
  Container     : IwbContainerElementRef;
  EntryPointVar : Variant;
  EntryPoint    : Integer;
  s             : string;
begin
  s := Trim(aString);

  Result := StrToInt64Def(s, Low(Integer));
  if Result <> Low(Integer) then
    Exit;

  if s = '' then begin
    Result := 0;
    Exit;
  end;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    raise Exception.Create('Could not resolve Entry Point');

  EntryPointVar := Container.ElementNativeValues['..\..\..\DATA\Entry Point\Entry Point'];
  if VarIsNull(EntryPointVar) or VarIsClear(EntryPointVar) then
    raise Exception.Create('Could not resolve Entry Point');

  EntryPoint := EntryPointVar;
  if (EntryPoint < Low(wbPERKEntryPoints)) or (EntryPoint > High(wbPERKEntryPoints)) then
    raise Exception.Create('Unknown Entry Point #'+IntToStr(EntryPoint));

  with wbPERKEntryPoints[EntryPoint] do
    with wbPERKCondition[Condition] do
      if SameText(aString, Caption1) then
        Result := 0
      else if SameText(aString, Caption2) then
        Result := 1
      else if SameText(aString, Caption3) then
        Result := 2
      else
        raise Exception.Create('"'+s+'" is not valid for this Entry Point');
end;

function wbMESGTNAMDontShow(const aElement: IwbElement): Boolean;
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  Result := False;
  if not Supports(aElement, IwbMainRecord, MainRecord) then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if Integer(Container.ElementNativeValues['DNAM']) and 1 <> 0 then
    Result := True;
end;

function wbEPFDDontShow(const aElement: IwbElement): Boolean;
var
  Container: IwbContainerElementRef;
begin
  Result := False;
  if aElement.Name <> 'Entry Point Function Parameters' then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if not (Integer(Container.ElementNativeValues['EPFT']) in [1..3]) then
    Result := True;
end;

function wbTES4ONAMDontShow(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  if not Assigned(aElement) then
    Exit;

  MainRecord := aElement.ContainingMainRecord;
  if not Assigned(MainRecord) then
    Exit;

  if not MainRecord.IsESM then
    Result := True;
end;


function wbEPF2DontShow(const aElement: IwbElement): Boolean;
var
  Container: IwbContainerElementRef;
begin
  Result := False;
  if aElement.Name <> 'Entry Point Function Parameters' then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if not (Integer(Container.ElementNativeValues['EPFT']) in [4]) then
    Result := True;
end;

function wbPERKPRKCDontShow(const aElement: IwbElement): Boolean;
var
  Container: IwbContainerElementRef;
begin
  Result := False;
  if aElement.Name <> 'Effect' then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if Integer(Container.ElementNativeValues['PRKE\Type']) <> 2 then
    Result := True;
end;

function wbPerkDATAFunctionToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container     : IwbContainerElementRef;
  EntryPointVar : Variant;
  EntryPoint    : Integer;
  i             : Integer;
begin
  case aType of
    ctToStr, ctToSummary: begin
      Result := aInt.ToString;
      if aType = ctToStr then
        Result := Result + ' <Warning: Could not resolve Entry Point>';
    end;
    ctToEditValue: Result := aInt.ToString;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Entry Point>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  EntryPointVar := Container.ElementNativeValues['..\Entry Point'];
  if VarIsNull(EntryPointVar) or VarIsClear(EntryPointVar) then
    Exit;

  EntryPoint := EntryPointVar;
  if (EntryPoint < Low(wbPERKEntryPoints)) or (EntryPoint > High(wbPERKEntryPoints)) then begin
    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: Unknown Entry Point #'+IntToStr(EntryPoint)+'>';
      end;
      ctCheck: Result := '<Warning: Unknown Entry Point #'+IntToStr(EntryPoint)+'>';
    end;
    Exit;
  end;

  with wbPERKEntryPoints[EntryPoint] do begin
    case aType of
      ctEditType: Result := 'ComboBox';
      ctEditInfo: with TStringList.Create do try
        for i := Low(wbPERKFunctions) to High(wbPERKFunctions) do
          if wbPERKFunctions[i].FunctionType = FunctionType then
            if (wbPERKFunctions[i].Name <> '') then
              Add(wbPERKFunctions[i].Name);
        Sort;
        Result := CommaText;
      finally
        Free;
      end;
    else
      if (aInt < Low(wbPERKFunctions)) or (aInt > High(wbPERKFunctions)) then
        case aType of
          ctToStr, ctToSummary: begin
            Result := aInt.ToString;
            if aType = ctToStr then
              Result := Result + ' <Warning: Unknown Function>';
          end;
          ctCheck: Result := '<Warning: Unknown Function>';
        end
      else
        case aType of
          ctToStr, ctToSummary, ctToEditValue: begin
            Result := wbPERKFunctions[Integer(aInt)].Name;
            if (aType = ctToStr) and (wbPERKFunctions[Integer(aInt)].FunctionType <> FunctionType) then
              Result := Result + ' <Warning: Value out of Bounds for this Entry Point>';
          end;
          ctCheck:
            if wbPERKFunctions[Integer(aInt)].FunctionType <> FunctionType then
              Result := '<Warning: Value out of Bounds for this Entry Point>'
            else
              Result := '';
        end;
    end;
  end;
end;

function wbPerkDATAFunctionToInt(const aString: string; const aElement: IwbElement): Int64;
var
  Container     : IwbContainerElementRef;
  EntryPointVar : Variant;
  EntryPoint    : Integer;
  s             : string;
  i             : Integer;
begin
  s := Trim(aString);

  Result := StrToInt64Def(s, Low(Integer));
  if Result <> Low(Integer) then
    Exit;

  if s = '' then
    raise Exception.Create('"" is not a valid value for this field');

  if not Supports(aElement, IwbContainerElementRef, Container) then
    raise Exception.Create('Could not resolve Entry Point');

  EntryPointVar := Container.ElementNativeValues['..\Entry Point'];
  if VarIsNull(EntryPointVar) or VarIsClear(EntryPointVar) then
    raise Exception.Create('Could not resolve Entry Point');

  EntryPoint := EntryPointVar;
  if (EntryPoint < Low(wbPERKEntryPoints)) or (EntryPoint > High(wbPERKEntryPoints)) then
    raise Exception.Create('Unknown Entry Point #'+IntToStr(EntryPoint));

  with wbPERKEntryPoints[EntryPoint] do
    for i := Low(wbPERKFunctions) to High(wbPERKFunctions) do
      if wbPERKFunctions[i].FunctionType = FunctionType then
        if SameText(s, wbPERKFunctions[i].Name) then begin
          Result := i;
          Exit;
        end;

  raise Exception.Create('"'+s+'" is not valid for this Entry Point');
end;

procedure wbPerkDATAFunctionAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  NewFunction : Integer;
  Container   : IwbContainerElementRef;
  OldParamType: Integer;
  NewParamType: Integer;
begin
  NewFunction := aNewValue;
  if (NewFunction < Low(wbPERKFunctions)) or (NewFunction > High(wbPERKFunctions)) then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  OldParamType := Container.ElementNativeValues['..\..\..\Entry Point Function Parameters\EPFT'];
  NewParamType := Ord(wbPERKFunctions[NewFunction].ParamType);

  if (OldParamType = NewParamType) and not VarSameValue(aOldValue, aNewValue) and (NewFunction in [4,5]) then
    Container.ElementNativeValues['..\..\..\Entry Point Function Parameters\EPFT'] := 0;

  Container.ElementNativeValues['..\..\..\Entry Point Function Parameters\EPFT'] := NewParamType;
end;

function wbPerkEPFTToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container       : IwbContainerElementRef;
  FunctionTypeVar : Variant;
  FunctionType    : Integer;
//  i               : Integer;
begin
  case aType of
    ctToStr, ctToSummary: begin
      Result := aInt.ToString;
      if aType = ctToStr then
        Result := Result + ' <Warning: Could not resolve Function>';
    end;
    ctToEditValue: Result := aInt.ToString;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Function>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  FunctionTypeVar := Container.ElementNativeValues['..\..\DATA\Entry Point\Function'];
  if VarIsNull(FunctionTypeVar) or VarIsClear(FunctionTypeVar) then
    Exit;

  FunctionType := FunctionTypeVar;
  if (FunctionType < Low(wbPERKFunctions)) or (FunctionType > High(wbPERKFunctions)) then begin
    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: Unknown Function #'+IntToStr(FunctionType)+'>';
      end;
      ctCheck: Result := '<Warning: Unknown Function #'+IntToStr(FunctionType)+'>';
    end;
    Exit;
  end;

  with wbPERKFunctions[FunctionType] do begin
    case aType of
      ctEditType: Result := 'ComboBox';
      ctEditInfo: Result := '"' + wbPERKFunctionParams[ParamType] + '"';
    else
      if (aInt < Ord(Low(wbPERKFunctionParams))) or (aInt > Ord(High(wbPERKFunctionParams))) then
        case aType of
          ctToStr, ctToSummary: begin
            Result := aInt.ToString;
            if aType = ctToStr then
              Result := Result + ' <Warning: Unknown Function Param Type>';
          end;
          ctCheck: Result := '<Warning: Unknown Function Param Type>';
        end
      else
        case aType of
          ctToStr, ctToSummary, ctToEditValue: begin
            Result := wbPERKFunctionParams[TPERKEntryPointFunctionParamType(aInt)];
            if (aType = ctToStr) and (TPERKEntryPointFunctionParamType(aInt) <> ParamType) then
              Result := Result + ' <Warning: Value out of Bounds for this Function>';
          end;
          ctCheck:
            if TPERKEntryPointFunctionParamType(aInt) <> ParamType then
              Result := Result + ' <Warning: Value out of Bounds for this Function>'
            else
              Result := '';
        end;
    end;
  end;
end;

function wbPerkEPFTToInt(const aString: string; const aElement: IwbElement): Int64;
var
  Container       : IwbContainerElementRef;
  FunctionTypeVar : Variant;
  FunctionType    : Integer;
  s               : string;
//  i               : Integer;
  j               : TPERKEntryPointFunctionParamType;
begin
  s := Trim(aString);

  Result := StrToInt64Def(s, Low(Integer));
  if Result <> Low(Integer) then
    Exit;

  if s = '' then
    raise Exception.Create('"" is not a valid value for this field');

  if not Supports(aElement, IwbContainerElementRef, Container) then
    raise Exception.Create('Could not resolve Function');

  FunctionTypeVar := Container.ElementNativeValues['..\..\DATA\Entry Point\Function'];
  if VarIsNull(FunctionTypeVar) or VarIsClear(FunctionTypeVar) then
    raise Exception.Create('Could not resolve Function');

  FunctionType := FunctionTypeVar;
  if (FunctionType < Low(wbPERKFunctions)) or (FunctionType > High(wbPERKFunctions)) then
    raise Exception.Create('Unknown Function #'+IntToStr(FunctionType));

  with wbPERKFunctions[FunctionType] do begin
    for j := Low(wbPERKFunctionParams) to High(wbPERKFunctionParams) do
      if SameText(s, wbPERKFunctionParams[j]) then begin
        if j <> ParamType then
          raise Exception.Create('"'+s+'" is not a valid Parameter Type for Function "'+Name+'"');
        Result := Ord(j);
        Exit;
      end;
  end;

  raise Exception.Create('"'+s+'" is not a valid Parameter Type');
end;

procedure wbPerkEPFTAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  i: Integer;
  Container: IwbContainerElementRef;
begin
  if VarSameValue(aOldValue, aNewValue) then
    Exit;

  i := aNewValue;

  if (i < Ord(Low(wbPERKFunctionParams))) or (i> Ord(High(wbPERKFunctionParams))) then
    Exit;

  if not Supports(aElement.Container, IwbContainerElementRef, Container) then
    Exit;

  Container.RemoveElement('EPFD');
  Container.RemoveElement('EPF2');
  Container.RemoveElement('EPF3');
  Container.RemoveElement('Embedded Script');

  case TPERKEntryPointFunctionParamType(i) of
    epfpFloat, epfpFloatFloat, epfpLeveledItem:
      Container.Add('EPFD', True);
    epfpScript: begin
      Container.Add('EPF2', True);
      Container.Add('EPF3', True);
      Container.Add('SCHR', True);
    end;
  end;
end;

procedure wbRemoveOFST(const aElement: IwbElement);
var
  Container: IwbContainer;
  rOFST: IwbRecord;
begin
  if not wbRemoveOffsetData then
    Exit;

  if Supports(aElement, IwbContainer, Container) then begin
    if wbBeginInternalEdit then try
      Container.RemoveElement(OFST);
    finally
      wbEndInternalEdit;
    end else begin
      rOFST := Container.RecordBySignature[OFST];
      if Assigned(rOFST) then
        Container.RemoveElement(rOFST);
    end;
  end;
end;

function wbActorTemplateUseTraits(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  if not wbActorTemplateHide then Exit;

  Element := GetElementFromUnion(aElement);
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
    Result := (i and $00000001) <> 0;
  end;
end;

function wbActorTemplateUseStats(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  if not wbActorTemplateHide then Exit;

  Element := GetElementFromUnion(aElement);
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
    Result := (i and $00000002) <> 0;
  end;
end;

function wbActorAutoCalcDontShow(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  if not wbActorTemplateHide then Exit;

  Element := GetElementFromUnion(aElement);
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\Flags'];
    Result := (i and $00000010) <> 0;
  end;
end;

function wbActorTemplateUseStatsAutoCalc(const aElement: IwbElement): Boolean;
begin
  if not wbActorTemplateHide then
    Result := False
  else
    Result := wbActorTemplateUseStats(aElement) or wbActorAutoCalcDontShow(aElement);
end;

function wbActorTemplateUseFactions(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  if not wbActorTemplateHide then Exit;

  Element := GetElementFromUnion(aElement);
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
    Result := (i and $00000004) <> 0;
  end;
end;

function wbActorTemplateUseActorEffectList(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  if not wbActorTemplateHide then Exit;

  Element := GetElementFromUnion(aElement);
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
    Result := (i and $00000008) <> 0;
  end;
end;

function wbActorTemplateUseAIData(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  if not wbActorTemplateHide then Exit;

  Element := GetElementFromUnion(aElement);
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
    Result := (i and $00000010) <> 0;
  end;
end;

function wbActorTemplateUseAIPackages(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  if not wbActorTemplateHide then Exit;

  Element := GetElementFromUnion(aElement);
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
    Result := (i and $00000020) <> 0;
  end;
end;

function wbActorTemplateUseModelAnimation(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  if not wbActorTemplateHide then Exit;

  Element := GetElementFromUnion(aElement);
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
    Result := (i and $00000040) <> 0;
  end;
end;

function wbActorTemplateUseBaseData(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  if not wbActorTemplateHide then Exit;

  Element := GetElementFromUnion(aElement);
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
    Result := (i and $00000080) <> 0;
  end;
end;

function wbActorTemplateUseInventory(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  if not wbActorTemplateHide then Exit;

  Element := GetElementFromUnion(aElement);
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
    Result := (i and $00000100) <> 0;
  end;
end;

function wbActorTemplateUseScript(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  if not wbActorTemplateHide then Exit;

  Element := GetElementFromUnion(aElement);
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
    Result := (i and $00000200) <> 0;
  end;
end;

procedure wbCTDAAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  //Size       : Cardinal;
  TypeFlags  : Cardinal;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    TypeFlags := Container.ElementNativeValues['Type'];
    if (TypeFlags and $02) <> 0 then begin
      if Container.DataSize = 20 then
        Container.DataSize := 28;
      Container.ElementNativeValues['Type'] := TypeFlags and not $02;
      Container.ElementEditValues['Run On'] := 'Target';
    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbMGEFAfterLoad(const aElement: IwbElement);
var
  Container     : IwbContainerElementRef;
  MainRecord    : IwbMainRecord;
  OldActorValue : Integer;
  NewActorValue : Integer;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    OldActorValue := Container.ElementNativeValues['DATA - Data\Actor Value'];
    NewActorValue := OldActorValue;
    case Integer(Container.ElementNativeValues['DATA - Data\Archtype']) of
      01, //Script
      02, //Dispel
      03, //Cure Disease
      13, //Light
      16, //Lock
      17, //Open
      18, //Bound Item
      19, //Summon Creature
      30, //Cure Paralysis
      31, //Cure Addiction
      32, //Cure Poison
      33: //Concussion
        NewActorValue := -1;
      11: //Invisibility
        NewActorValue := 48; //Invisibility
      12: //Chameleon
        NewActorValue := 49; //Chameleon
      24: //Paralysis
        NewActorValue := 47; //Paralysis
    end;
    if OldActorValue <> NewActorValue then
      Container.ElementNativeValues['DATA - Data\Actor Value'] := NewActorValue;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbPACKAfterLoad(const aElement: IwbElement);
var
  Container     : IwbContainerElementRef;
  MainRecord    : IwbMainRecord;
  NewContainer  : IwbContainerElementRef;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    case Integer(Container.ElementNativeValues['PKDT - General\Type']) of
       0: begin {Find}
         Container.Add('PTDT');
       end;
       1: begin {Follow}
         Container.Add('PKFD');
       end;
       2: begin {Escort}
       end;
       3: begin {Eat}
         Container.Add('PTDT');
         Container.Add('PKED');
       end;
       4: begin {Sleep}
         if not Container.ElementExists['Locations'] then
           if Supports(Container.Add('Locations'), IwbContainerElementRef, NewContainer) then
             NewContainer.ElementEditValues['PLDT - Location 1\Type'] := 'Near editor location';
       end;
       5: begin {Wander}
       end;
       6: begin {Travel}
       end;
       7: begin {Accompany}
       end;
       8: begin {Use Item At}
       end;
       9: begin {Ambush}
       end;
      10: begin {Flee Not Combat}
      end;
      12: begin {Sandbox}
      end;
      13: begin {Patrol}
         if not Container.ElementExists['Locations'] then
           if Supports(Container.Add('Locations'), IwbContainerElementRef, NewContainer) then
             NewContainer.ElementEditValues['PLDT - Location 1\Type'] := 'Near linked reference';
        Container.Add('PKPT');
      end;
      14: begin {Guard}
      end;
      15: begin {Dialogue}
      end;
      16: begin {Use Weapon}
      end;
    end;

  finally
    wbEndInternalEdit;
  end;
end;

procedure wbNPCAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
//  BaseRecord : IwbMainRecord;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    if Container.ElementNativeValues['NAM5'] > 255 then
      Container.ElementNativeValues['NAM5'] := 255;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbREFRAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
  BaseRecord : IwbMainRecord;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    Container.RemoveElement('RCLR');

    if Container.ElementExists['Ammo'] then begin
      BaseRecord := MainRecord.BaseRecord;
      if Assigned(BaseRecord) and (BaseRecord.Signature <> 'WEAP') then
        Container.RemoveElement('Ammo');
    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbINFOAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    if (Integer(Container.ElementNativeValues['DATA\Flags 1']) and $80) = 0 then
      Container.RemoveElement('DNAM');

    Container.RemoveElement('SNDD');

    if Container.ElementNativeValues['DATA\Type'] = 3 {Persuasion} then
      Container.ElementNativeValues['DATA\Type'] := 0 {Topic};
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbCELLAfterLoad(const aElement: IwbElement);
var
  Container    : IwbContainerElementRef;
//  Container2   : IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
//  i            : Integer;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    if (not Container.ElementExists['XCLW']) and ((Integer(Container.ElementNativeValues['DATA']) and $02) <> 0) then begin
      Container.Add('XCLW', True);
      Container.ElementEditValues['XCLW'] := 'Default';
    end;

    if (not Container.ElementExists['XNAM']) and ((Integer(Container.ElementNativeValues['DATA']) and $02) <> 0) then
      Container.Add('XNAM', True);

//    if Supports(Container.ElementBySignature[XCLR], IwbContainerElementRef, Container2) then begin
//      for i:= Pred(Container2.ElementCount) downto 0 do
//        if not Supports(Container2.Elements[i].LinksTo, IwbMainRecord, MainRecord) or (MainRecord.Signature <> 'REGN') then
//          Container2.RemoveElement(i);
//      if Container2.ElementCount < 1 then
//        Container2.Remove;
//    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbEmbeddedScriptAfterLoad(const aElement: IwbElement);
var
  Container: IwbContainerElementRef;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if Container.ElementEditValues['SCHR\Type'] = 'Quest' then
      Container.ElementEditValues['SCHR\Type'] := 'Object';
  finally
    wbEndInternalEdit;
  end;
end;


procedure wbSOUNAfterLoad(const aElement: IwbElement);
var
  Container: IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
  OldCntr: IwbContainerElementRef;
  NewCntr: IwbContainerElementRef;
  NewCntr2: IwbContainerElementRef;
  i: Integer;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    if Container.ElementExists['SNDD'] then
      Exit;

    if not Supports(Container.RemoveElement('SNDX - Sound Data'), IwbContainerElementRef, OldCntr) then
      Exit;

    if not Supports(Container.Add('SNDD', True), IwbContainerElementRef, NewCntr) then
      Exit;

    for i := 0 to Pred(Min(OldCntr.ElementCount, NewCntr.ElementCount)) do
      NewCntr.Elements[i].Assign(Low(Integer), OldCntr.Elements[i], False);

    if not Supports(NewCntr.ElementByName['Attenuation Curve'], IwbContainerElementRef, NewCntr2) then
      Assert(False);
    Assert(NewCntr2.ElementCount = 5);

    if Supports(Container.RemoveElement('ANAM'), IwbContainerElementRef, OldCntr) then begin
      Assert(OldCntr.ElementCount = 5);
      for i := 0 to Pred(Min(OldCntr.ElementCount, NewCntr2.ElementCount)) do
        NewCntr2.Elements[i].Assign(Low(Integer), OldCntr.Elements[i], False);
    end else begin
      NewCntr2.Elements[0].NativeValue := 100;
      NewCntr2.Elements[1].NativeValue := 50;
      NewCntr2.Elements[2].NativeValue := 20;
      NewCntr2.Elements[3].NativeValue := 5;
      NewCntr2.Elements[4].NativeValue := 0;
    end;

    if not Supports(NewCntr.ElementByName['Reverb Attenuation Control'], IwbContainerElementRef, NewCntr2) then
      Assert(False);

    if Supports(Container.RemoveElement('GNAM'), IwbContainerElementRef, OldCntr) then
      NewCntr2.Assign(Low(Integer), OldCntr, False)
    else
      NewCntr2.NativeValue := 80;

    if not Supports(NewCntr.ElementByName['Priority'], IwbContainerElementRef, NewCntr2) then
      Assert(False);

    if Supports(Container.RemoveElement('HNAM'), IwbContainerElementRef, OldCntr) then
      NewCntr2.Assign(Low(Integer), OldCntr, False)
    else
      NewCntr2.NativeValue := 128;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbWATRAfterLoad(const aElement: IwbElement);
var
  Container: IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
//  AnimationMultiplier : Extended;
//  AnimationAttackMultiplier : Extended;
  OldCntr: IwbContainerElementRef;
  NewCntr: IwbContainerElementRef;
  i: Integer;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    if Container.ElementExists['DNAM'] then
      Exit;

    if not Supports(Container.RemoveElement('DATA - Visual Data'), IwbContainerElementRef, OldCntr) then
      Exit;
    if not Supports(Container.Add('DNAM', True), IwbContainerElementRef, NewCntr) then
      Exit;
    for i := 0 to Pred(Min(OldCntr.ElementCount, NewCntr.ElementCount)) do
      if OldCntr.Elements[i].Name = 'Damage (Old Format)' then
        Container.ElementNativeValues['DATA - Damage'] := OldCntr.Elements[i].NativeValue
      else
        NewCntr.Elements[i].Assign(Low(Integer), OldCntr.Elements[i], False);

    NewCntr.ElementNativeValues['Noise Properties - Noise Layer One - Amplitude Scale'] := 1.0;
    NewCntr.ElementNativeValues['Noise Properties - Noise Layer Two - Amplitude Scale'] := 0.5;
    NewCntr.ElementNativeValues['Noise Properties - Noise Layer Three - Amplitude Scale'] := 0.25;
  finally
    wbEndInternalEdit;
  end;
end;


procedure wbWEAPAfterLoad(const aElement: IwbElement);
var
  Container: IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    if not Container.ElementExists['DNAM'] then
      Exit;

    if Container.ElementNativeValues['DNAM\Animation Multiplier'] = 0.0 then
      Container.ElementNativeValues['DNAM\Animation Multiplier'] := 1.0;
    if Container.ElementNativeValues['DNAM\Animation Attack Multiplier'] = 0.0 then
      Container.ElementNativeValues['DNAM\Animation Attack Multiplier'] := 1.0;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbMESGAfterLoad(const aElement: IwbElement);
var
  Container    : IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
  IsMessageBox : Boolean;
  HasTimeDelay : Boolean;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    IsMessageBox := (Integer(Container.ElementNativeValues['DNAM']) and 1) = 1;
    HasTimeDelay := Container.ElementExists['TNAM'];

    if IsMessageBox = HasTimeDelay then
      if IsMessageBox then
        Container.RemoveElement('TNAM')
      else begin
        if not Container.ElementExists['DNAM'] then
          Container.Add('DNAM', True);
        Container.ElementNativeValues['DNAM'] := Integer(Container.ElementNativeValues['DNAM']) or 1;
      end;
  finally
    wbEndInternalEdit;
  end;
end;


procedure wbEFSHAfterLoad(const aElement: IwbElement);
var
  Container: IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
  FullParticleBirthRatio : Extended;
  PersistantParticleBirthRatio : Extended;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    if not Container.ElementExists['DATA'] then
      Exit;

    FullParticleBirthRatio := Container.ElementNativeValues['DATA\Particle Shader - Full Particle Birth Ratio'];
    PersistantParticleBirthRatio := Container.ElementNativeValues['DATA\Particle Shader - Persistant Particle Birth Ratio'];

    if ((FullParticleBirthRatio <> 0) and (FullParticleBirthRatio <= 1)) then begin
      FullParticleBirthRatio := FullParticleBirthRatio * 78.0;
      Container.ElementNativeValues['DATA\Particle Shader - Full Particle Birth Ratio'] := FullParticleBirthRatio;
    end;

    if ((PersistantParticleBirthRatio <> 0) and (PersistantParticleBirthRatio <= 1)) then begin
      PersistantParticleBirthRatio := PersistantParticleBirthRatio * 78.0;
      Container.ElementNativeValues['DATA\Particle Shader - Persistant Particle Birth Ratio'] := PersistantParticleBirthRatio;
    end;

  finally
    wbEndInternalEdit;
  end;
end;

procedure wbFACTAfterLoad(const aElement: IwbElement);
var
  Container: IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Container.ElementExists['CNAM'] then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    Container.RemoveElement('CNAM');
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbLIGHAfterLoad(const aElement: IwbElement);
var
  Container: IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    if not Container.ElementExists['FNAM'] then begin
      Container.Add('FNAM', True);
      Container.ElementNativeValues['FNAM'] := 1.0;
    end;

    if Container.ElementExists['DATA'] then begin
      if SameValue(Container.ElementNativeValues['DATA\Falloff Exponent'], 0.0) then
        Container.ElementNativeValues['DATA\Falloff Exponent'] := 1.0;
      if SameValue(Container.ElementNativeValues['DATA\FOV'], 0.0) then
        Container.ElementNativeValues['DATA\FOV'] := 90.0;
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

    MainRecord := Container.ContainingMainRecord;
    if not Assigned(MainRecord) or MainRecord.IsDeleted then
      Exit;

    Element := Container.ElementByPath['..\EFID'];
    if not wbTryGetMainRecord(Element, MainRecord, 'MGEF') then
      Exit;

    ActorValue := MainRecord.ElementNativeValues['DATA - Data\Actor Value'];
    if VarIsNull(ActorValue) or VarIsClear(ActorValue) then
      Exit;

    if VarCompareValue(ActorValue, Container.ElementNativeValues['Actor Value']) <> vrEqual then
      Container.ElementNativeValues['Actor Value'] := ActorValue;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbRPLDAfterLoad(const aElement: IwbElement);
var
  Container: IwbContainer;
  a, b: Single;
  NeedsFlip: Boolean;
begin
  if wbBeginInternalEdit then try
    if Supports(aElement, IwbContainer, Container) then begin
      NeedsFlip := False;
      if Container.ElementCount > 1 then begin
        a := StrToFloat((Container.Elements[0] as IwbContainer).Elements[0].Value);
        b := StrToFloat((Container.Elements[Pred(Container.ElementCount)] as IwbContainer).Elements[0].Value);
        case CompareValue(a, b) of
          EqualsValue: begin
            a := StrToFloat((Container.Elements[0] as IwbContainer).Elements[1].Value);
            b := StrToFloat((Container.Elements[Pred(Container.ElementCount)] as IwbContainer).Elements[1].Value);
            NeedsFlip := CompareValue(a, b) = GreaterThanValue;
          end;
          GreaterThanValue:
            NeedsFlip := True;
        end;
      end;
      if NeedsFlip then
        Container.ReverseElements;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

function wbPKDTFalloutBehaviorFlagsDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container : IwbContainer;
  SubRecord : IwbSubRecord;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  if Supports(Container, IwbSubRecord, SubRecord) then
    if SubRecord.SubRecordHeaderSize = 8 then
      Result := 1;
end;

function wbPKDTSpecificFlagsDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container : IwbContainer;
  SubRecord : IwbSubRecord;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  if Supports(Container, IwbSubRecord, SubRecord) then
    if SubRecord.SubRecordHeaderSize = 8 then
      Exit;
  Result := Container.ElementByName['Type'].NativeValue + 1;
end;

procedure wbIDLAsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Element         : IwbElement;
  Container       : IwbContainer;
  SelfAsContainer : IwbContainer;
begin
  if wbBeginInternalEdit then try
//    if not wbCounterAfterSet('IDLC - Animation Count', aElement) then
      if Supports(aElement.Container, IwbContainer, Container) then begin
        Element := Container.ElementByPath['IDLC\Animation Count'];
        if Assigned(Element) and Supports(aElement, IwbContainer, SelfAsContainer) and
          (Element.GetNativeValue<>SelfAsContainer.GetElementCount) then
          Element.SetNativeValue(SelfAsContainer.GetElementCount);
      end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbAnimationsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Element         : IwbElement;
  Elems           : IwbElement;
  Container       : IwbContainer;
begin
  if wbBeginInternalEdit then try
//    if not wbCounterContainerAfterSet('IDLC - Animation Count', 'IDLA - Animations', aElement) then
      if Supports(aElement, IwbContainer, Container) then begin
        Element := Container.ElementByPath['IDLC\Animation Count'];
        Elems   := Container.ElementByName['IDLA - Animations'];
        if Assigned(Element) and not Assigned(Elems) then
          if Element.GetNativeValue<>0 then
            Element.SetNativeValue(0);
      end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure DefineFO3a;
begin
  wbRecordFlags := wbInteger('Record Flags', itU32, wbFlags([
    {0x00000001}'ESM',
    {0x00000002}'',
    {0x00000004}'',   // Plugin selected (Editor)
    {0x00000008}'',   // Form cannot be saved (Runtime)/Plugin active (Editor)
    {0x00000010}'Form initialized (Runtime only)',  // Plugin cannot be active or selected (Editor)
    {0x00000020}'Deleted',
    {0x00000040}'Border Region / Has Tree LOD / Constant / Hidden From Local Map',
    {0x00000080}'Turn Off Fire',
    {0x00000100}'Inaccessible',
    {0x00000200}'Casts shadows / On Local Map / Motion Blur',
    {0x00000400}'Quest item / Persistent reference',
    {0x00000800}'Initially disabled',
    {0x00001000}'Ignored',
    {0x00002000}'No Voice Filter',
    {0x00004000}'Cannot Save (Runtime only)',
    {0x00008000}'Visible when distant',
    {0x00010000}'Random Anim Start / High Priority LOD',
    {0x00020000}'Dangerous / Off limits (Interior cell) / Radio Station (Talking Activator)',
    {0x00040000}'Compressed',
    {0x00080000}'Can''t wait / Platform Specific Texture / Dead',
    {0x00100000}'Unknown 21',
    {0x00200000}'Load Started', // set when beginning to load the form from save
    {0x00400000}'Unknown 23',
    {0x00800000}'Unknown 24',
    {0x01000000}'Destructible (Runtime only)',
    {0x02000000}'Obstacle / No AI Acquire',
    {0x03000000}'NavMesh Generation - Filter',
    {0x08000000}'NavMesh Generation - Bounding Box',
    {0x10000000}'Non-Pipboy / Reflected by Auto Water',
    {0x20000000}'Child Can Use / Refracted by Auto Water',
    {0x40000000}'NavMesh Generation - Ground',
    {0x80000000}'Multibound'
  ]));

(*   wbInteger('Record Flags 2', itU32, wbFlags([
    {0x00000001}'Unknown 1',
    {0x00000002}'Unknown 2',
    {0x00000004}'Unknown 3',
    {0x00000008}'Unknown 4',
    {0x00000010}'Unknown 5',
    {0x00000020}'Unknown 6',
    {0x00000040}'Unknown 7',
    {0x00000080}'Unknown 8',
    {0x00000100}'Unknown 9',
    {0x00000200}'Unknown 10',
    {0x00000400}'Unknown 11',
    {0x00000800}'Unknown 12',
    {0x00001000}'Unknown 13',
    {0x00002000}'Unknown 14',
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
    {0x03000000}'Unknown 27',
    {0x08000000}'Unknown 28',
    {0x10000000}'Unknown 29',
    {0x20000000}'Unknown 30',
    {0x40000000}'Unknown 31',
    {0x80000000}'Unknown 32'
  ]));                (**)

  wbMainRecordHeader := wbStruct('Record Header', [
    wbString('Signature', 4, cpCritical),
    wbInteger('Data Size', itU32, nil, cpIgnore),
    wbRecordFlags,
    wbFormID('FormID', cpFormID).IncludeFlag(dfSummarySelfAsShortName),
    wbByteArray('Version Control Info 1', 4, cpIgnore).SetToStr(wbVCI1ToStrBeforeFO4),
    wbInteger('Form Version', itU16, nil, cpIgnore).IncludeFlag(dfSummaryShowIgnore),
    wbByteArray('Version Control Info 2', 2, cpIgnore)
  ])
  .SetSummaryKey([5, 3, 2])
  .SetSummaryMemberPrefixSuffix(5, '[v', ']')
  .SetSummaryMemberPrefixSuffix(2, '{', '}')
  .SetSummaryDelimiter(' ')
  .IncludeFlag(dfSummaryMembersNoName)
  .IncludeFlag(dfCollapsed, wbCollapseRecordHeader);

  wbSizeOfMainRecordStruct := 24;

  wbIgnoreRecords.Add(XXXX);

  wbXRGD := wbByteArray(XRGD, 'Ragdoll Data');
  wbXRGB := wbByteArray(XRGB, 'Ragdoll Biped Data');

  wbMusicEnum := wbEnum(['Default', 'Public', 'Dungeon']);
  wbSoundLevelEnum := wbEnum([
     'Loud',
     'Normal',
     'Silent'
    ]);

  wbWeaponAnimTypeEnum := wbEnum([
    {00} 'Hand to Hand',
    {01} 'Melee (1 Hand)',
    {02} 'Melee (2 Hand)',
    {03} 'Pistol - Ballistic (1 Hand)',
    {04} 'Pistol - Energy (1 Hand)',
    {05} 'Rifle - Ballistic (2 Hand)',
    {06} 'Rifle - Automatic (2 Hand)',
    {07} 'Rifle - Energy (2 Hand)',
    {08} 'Handle (2 Hand)',
    {09} 'Launcher (2 Hand)',
    {10} 'Grenade Throw (1 Hand)',
    {11} 'Land Mine (1 Hand)',
    {12} 'Mine Drop (1 Hand)'
  ]);

  wbReloadAnimEnum := wbEnum([
    'ReloadA',
    'ReloadB',
    'ReloadC',
    'ReloadD',
    'ReloadE',
    'ReloadF',
    'ReloadG',
    'ReloadH',
    'ReloadI',
    'ReloadJ',
    'ReloadK'
  ],[255, 'None']);

  wbEDID := wbString(EDID, 'Editor ID', 0, cpNormal); // not cpBenign according to Arthmoor
  wbEDIDReq := wbString(EDID, 'Editor ID', 0, cpNormal, True); // not cpBenign according to Arthmoor
  wbEDIDReqKC := wbStringKC(EDID, 'Editor ID', 0, cpNormal, True); // not cpBenign according to Arthmoor
  wbFULL := wbStringKC(FULL, 'Name', 0, cpTranslate);
  wbFULLActor := wbStringKC(FULL, 'Name', 0, cpTranslate, False, wbActorTemplateUseBaseData);
  wbFULLReq := wbStringKC(FULL, 'Name', 0, cpTranslate, True);
  wbDESC := wbStringKC(DESC, 'Description', 0, cpTranslate);
  wbDESCReq := wbStringKC(DESC, 'Description', 0, cpTranslate, True);
  wbXSCL := wbFloat(XSCL, 'Scale');
  wbREPL := wbFormIDCkNoReach(REPL, 'Repair List', [FLST]);
  wbEITM := wbFormIDCk(EITM, 'Object Effect', [ENCH, SPEL]);
  wbBIPL := wbFormIDCk(BIPL, 'Biped Model List', [FLST]);
  wbCOED := wbStructExSK(COED, [2], [0, 1], 'Extra Data', [
    {00} wbFormIDCkNoReach('Owner', [NPC_, FACT, NULL]),
    {04} wbUnion('Global Variable / Required Rank', wbCOEDOwnerDecider, [
           wbByteArray('Unused', 4, cpIgnore),
           wbFormIDCk('Global Variable', [GLOB, NULL]),
           wbInteger('Required Rank', itU32)
         ]),
    {08} wbFloat('Item Condition')
  ]);

  wbYNAM := wbFormIDCk(YNAM, 'Sound - Pick Up', [SOUN]);
  wbZNAM := wbFormIDCk(ZNAM, 'Sound - Drop', [SOUN]);

  wbMODS := wbArrayS(MODS, 'Alternate Textures', wbAlternateTexture, -1);
  wbMO2S := wbArrayS(MO2S, 'Alternate Textures', wbAlternateTexture, -1);
  wbMO3S := wbArrayS(MO3S, 'Alternate Textures', wbAlternateTexture, -1);
  wbMO4S := wbArrayS(MO4S, 'Alternate Textures', wbAlternateTexture, -1);

  wbMODD :=
    wbInteger(MODD, 'FaceGen Model Flags', itU8, wbFlags([
      'Head',
      'Torso',
      'Right Hand',
      'Left Hand'
    ]));
  wbMOSD :=
    wbInteger(MOSD, 'FaceGen Model Flags', itU8, wbFlags([
      'Head',
      'Torso',
      'Right Hand',
      'Left Hand'
    ]));

  wbDEST := wbRStruct('Destructible', [
    wbStruct(DEST, 'Header', [
      wbInteger('Health', itS32),
      wbInteger('Count', itU8),
      wbInteger('Flags', itU8, wbFlags([
        'VATS Targetable'
      ], True)),
      wbByteArray('Unused', 2)
    ]),
    wbRArray('Stages',
      wbRStruct('Stage', [
        wbStruct(DSTD, 'Destruction Stage Data', [
          wbInteger('Health %', itU8),
          wbInteger('Index', itU8),
          wbInteger('Damage Stage', itU8),
          wbInteger('Flags', itU8, wbFlags([
            'Cap Damage',
            'Disable',
            'Destroy'
          ])),
          wbInteger('Self Damage per Second', itS32),
          wbFormIDCk('Explosion', [EXPL, NULL]),
          wbFormIDCk('Debris', [DEBR, NULL]),
          wbInteger('Debris Count', itS32)
        ], cpNormal, True),
        wbRStructSK([0], 'Model', [
          wbString(DMDL, 'Model FileName'),
          wbDMDT
        ], [])
        .SetSummaryKey([0])
        .IncludeFlag(dfCollapsed, wbCollapseModels),
        wbEmpty(DSTF, 'End Marker', cpNormal, True)
      ], [])
    )
  ], []);

  wbDESTActor := wbRStruct('Destructible', [
    wbStruct(DEST, 'Header', [
      wbInteger('Health', itS32),
      wbInteger('Count', itU8),
      wbInteger('Flags', itU8, wbFlags([
        'VATS Targetable'
      ])),
      wbByteArray('Unused', 2)
    ]),
    wbRArray('Stages',
      wbRStruct('Stage', [
        wbStruct(DSTD, 'Destruction Stage Data', [
          wbInteger('Health %', itU8),
          wbInteger('Index', itU8),
          wbInteger('Damage Stage', itU8),
          wbInteger('Flags', itU8, wbFlags([
            'Cap Damage',
            'Disable',
            'Destroy'
          ])),
          wbInteger('Self Damage per Second', itS32),
          wbFormIDCk('Explosion', [EXPL, NULL]),
          wbFormIDCk('Debris', [DEBR, NULL]),
          wbInteger('Debris Count', itS32)
        ], cpNormal, True),
        wbRStructSK([0], 'Model', [
          wbString(DMDL, 'Model FileName'),
          wbDMDT
        ], [])
        .SetSummaryKey([0])
        .IncludeFlag(dfCollapsed, wbCollapseModels),
        wbEmpty(DSTF, 'End Marker', cpNormal, True)
      ], [])
    )
  ], [], cpNormal, False, wbActorTemplateUseModelAnimation);

  wbSCRI := wbFormIDCk(SCRI, 'Script', [SCPT]);
  wbSCRIActor := wbFormIDCk(SCRI, 'Script', [SCPT], False, cpNormal, False, wbActorTemplateUseScript);
  wbENAM := wbFormIDCk(ENAM, 'Object Effect', [ENCH]);

  wbXESP := wbStruct(XESP, 'Enable Parent', [
    wbFormIDCk('Reference', [PLYR, REFR, ACRE, ACHR, PGRE, PMIS, PBEA]),
    wbInteger('Flags', itU8, wbFlags([
      'Set Enable State to Opposite of Parent',
      'Pop In'
    ])),
    wbByteArray('Unused', 3)
  ]);

  wbSCHRReq := wbStruct(SCHR, 'Basic Script Data', [
    wbByteArray('Unused', 4),
    wbInteger('RefCount', itU32),
    wbInteger('CompiledSize', itU32),
    wbInteger('VariableCount', itU32),
    wbInteger('Type', itU16, wbEnum([
      'Object',
      'Quest'
    ], [
      $100, 'Effect'
    ])),
    wbInteger('Flags', itU16, wbFlags([
      'Enabled'
    ]), cpNormal, False, nil, nil, 1)
  ], cpNormal, True);

  wbSCROs :=
    wbRArray('References',
      wbRUnion('', [
        wbFormID(SCRO, 'Global Reference'),
//        wbFormIDCk(SCRO, 'Global Reference',
//          [ACTI, DOOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, IMAD,
//           BOOK, KEYM, ALCH, LIGH, QUST, PLYR, PACK, LVLI, ECZN, EXPL, FLST, IDLM, PMIS,
//           FACT, ACHR, REFR, ACRE, GLOB, DIAL, CELL, SOUN, MGEF, WTHR, CLAS, EFSH, RACE,
//           LVLC, CSTY, WRLD, SCPT, IMGS, MESG, MSTT, MUSC, NOTE, PERK, PGRE, PROJ, LVLN,
//           WATR, ENCH, TREE, TERM, HAIR, EYES, ADDN, NULL]),
        wbInteger(SCRV, 'Local Variable', itU32)
      ], [])
    ).IncludeFlag(dfNotAlignable);

  wbSLSD := wbStructSK(SLSD, [0], 'Local Variable Data', [
    wbInteger('Index', itU32),
    wbByteArray('Unused', 12),
    wbInteger('Flags', itU8, wbFlags(['IsLongOrShort']), cpCritical),
    wbByteArray('Unused', 7)
  ]);

  wbEmbeddedScript := wbRStruct('Embedded Script', [
    wbSCHRReq,
    wbByteArray(SCDA, 'Compiled Embedded Script', 0, cpNormal{, True}),
    wbStringScript(SCTX, 'Embedded Script Source', 0, cpNormal{, True}),
    wbRArrayS('Local Variables', wbRStructSK([0], 'Local Variable', [
      wbSLSD,
      wbString(SCVR, 'Name', 0, cpCritical, True)
    ], [])),
    wbSCROs
  ], [], cpNormal, False, nil, False, wbEmbeddedScriptAfterLoad).SetToStr(wbScriptToStr);

  wbEmbeddedScriptPerk := wbRStruct('Embedded Script', [
    wbSCHRReq,
    wbByteArray(SCDA, 'Compiled Embedded Script', 0, cpNormal, True),
    wbStringScript(SCTX, 'Embedded Script Source', 0, cpNormal, True),
    wbRArrayS('Local Variables', wbRStructSK([0], 'Local Variable', [
      wbSLSD,
      wbString(SCVR, 'Name', 0, cpCritical, True)
    ], [])),
    wbSCROs
  ], [], cpNormal, False, wbEPF2DontShow, False, wbEmbeddedScriptAfterLoad).SetToStr(wbScriptToStr);

  wbEmbeddedScriptReq := wbRStruct('Embedded Script', [
    wbSCHRReq,
    wbByteArray(SCDA, 'Compiled Embedded Script', 0, cpNormal{, True}),
    wbStringScript(SCTX, 'Embedded Script Source', 0, cpNormal{, True}),
    wbRArrayS('Local Variables', wbRStructSK([0], 'Local Variable', [
      wbSLSD,
      wbString(SCVR, 'Name', 0, cpCritical, True)
    ], [])),
    wbSCROs
  ], [], cpNormal, True, nil, False, wbEmbeddedScriptAfterLoad).SetToStr(wbScriptToStr);


  wbXLCM := wbInteger(XLCM, 'Level Modifier', itS32);

  wbRefRecord(ACHR, 'Placed NPC', [
    wbEDID,
    wbFormIDCk(NAME, 'Base', [NPC_], False, cpNormal, True),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),

    {--- Ragdoll ---}
    wbXRGD,
    wbXRGB,

    {--- Patrol Data ---}
    wbRStruct('Patrol Data', [
      wbFloat(XPRD, 'Idle Time', cpNormal, True),
      wbEmpty(XPPA, 'Patrol Script Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, 'Topic', [DIAL, NULL], False, cpNormal, True)
    ], []),

    {--- Leveled Actor ----}
    wbXLCM,

    {--- Merchant Container ----}
    wbFormIDCk(XMRC, 'Merchant Container', [REFR], True),

    {--- Extra ---}
    wbInteger(XCNT, 'Count', itS32),
    wbFloat(XRDS, 'Radius'),
    wbFloat(XHLP, 'Health'),

    {--- Decals ---}
    wbRArrayS('Linked Decals',
      wbStructSK(XDCR, [0], 'Decal', [
        wbFormIDCk('Reference', [REFR]),
        wbUnknown
      ])
    ),

    {--- Linked Ref ---}
    wbFormIDCk(XLKR, 'Linked Reference', [REFR, ACRE, ACHR, PGRE, PMIS, PBEA, PLYR]),
    wbStruct(XCLP, 'Linked Reference Color', [
      wbStruct('Link Start Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Link End Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA)
    ]),

    {--- Activate Parents ---}
    wbRStruct('Activate Parents', [
      wbInteger(XAPD, 'Flags', itU8, wbFlags([
        'Parent Activate Only'
      ], True)),
      wbRArrayS('Activate Parent Refs',
        wbStructSK(XAPR, [0], 'Activate Parent Ref', [
          wbFormIDCk('Reference', [REFR, ACRE, ACHR, PGRE, PMIS, PBEA, PLYR]),
          wbFloat('Delay')
        ])
      )
    ], []),

    {--- Enable Parent ---}
    wbXESP,

    {--- Emittance ---}
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),

    {--- Flags ---}
    wbEmpty(XIBS, 'Ignored By Sandbox'),

    {--- 3D Data ---}
    wbXSCL,
    wbDATAPosRot
  ], True, wbPlacedAddInfo);

  wbXOWN := wbFormIDCkNoReach(XOWN, 'Owner', [FACT, ACHR, CREA, NPC_]); // Ghouls can own too aparently !

  wbRefRecord(ACRE, 'Placed Creature', [
    wbEDID,
    wbFormIDCk(NAME, 'Base', [CREA], False, cpNormal, True),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),

    wbXRGD,
    wbXRGB,

    {--- Patrol Data ---}
    wbRStruct('Patrol Data', [
      wbFloat(XPRD, 'Idle Time', cpNormal, True),
      wbEmpty(XPPA, 'Patrol Script Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, 'Topic', [DIAL, NULL], False, cpNormal, True)
    ], []),

    {--- Leveled Actor ----}
    wbXLCM,

    {--- Ownership ---}
    wbOwnership(wbXOWN, [XCMT, XCMO]),

    {--- Merchant Container ----}
    wbFormIDCk(XMRC, 'Merchant Container', [REFR], True),

    {--- Extra ---}
    wbInteger(XCNT, 'Count', itS32),
    wbFloat(XRDS, 'Radius'),
    wbFloat(XHLP, 'Health'),

    {--- Decals ---}
    wbRArrayS('Linked Decals',
      wbStructSK(XDCR, [0], 'Decal', [
        wbFormIDCk('Reference', [REFR, ACRE, ACHR, PGRE, PMIS, PBEA]),
        wbUnknown
      ])
    ),

    {--- Linked Ref ---}
    wbFormIDCk(XLKR, 'Linked Reference', [REFR, ACRE, ACHR, PGRE, PMIS, PBEA, PLYR]),
    wbStruct(XCLP, 'Linked Reference Color', [
      wbStruct('Link Start Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Link End Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA)
    ]),

    {--- Activate Parents ---}
    wbRStruct('Activate Parents', [
      wbInteger(XAPD, 'Flags', itU8, wbFlags([
        'Parent Activate Only'
      ], True)),
      wbRArrayS('Activate Parent Refs',
        wbStructSK(XAPR, [0], 'Activate Parent Ref', [
          wbFormIDCk('Reference', [REFR, ACRE, ACHR, PGRE, PMIS, PBEA, PLYR]),
          wbFloat('Delay')
        ])
      )
    ], []),

    {--- Enable Parent ---}
    wbXESP,

    {--- Emittance ---}
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),

    {--- Flags ---}
    wbEmpty(XIBS, 'Ignored By Sandbox'),

    {--- 3D Data ---}
    wbXSCL,
    wbDATAPosRot
  ], True, wbPlacedAddInfo);

  wbRecord(ACTI, 'Activator', [
    wbEDIDReq,
    wbOBND(True),
    wbFULL,
    wbGenericModel,
    wbSCRI,
    wbDEST,
    wbFormIDCk(SNAM, 'Sound - Looping', [SOUN]),
    wbFormIDCk(VNAM, 'Sound - Activation', [SOUN]),
    wbFormIDCk(RNAM, 'Radio Station', [TACT]),
    wbFormIDCk(WNAM, 'Water Type', [WATR])
  ]);

  wbICON := wbRStruct('Icon', [
    wbString(ICON, 'Large Icon FileName'),
    wbString(MICO, 'Small Icon FileName')
  ], []);

  wbICONReq := wbRStruct('Icon', [
    wbString(ICON, 'Large Icon FileName'),
    wbString(MICO, 'Small Icon FileName')
  ], [], cpNormal, True);

  wbVatsValueFunctionEnum :=
    wbEnum([
      'Weapon Is',
      'Weapon In List',
      'Target Is',
      'Target In List',
      'Target Distance',
      'Target Part',
      'VATS Action',
      'Is Success',
      'Is Critical',
      'Critical Effect Is',
      'Critical Effect In List',
      'Is Fatal',
      'Explode Part',
      'Dismember Part',
      'Cripple Part',
      'Weapon Type Is',
      'Is Stranger',
      'Is Paralyzing Palm'
    ]);

  wbActorValueEnum :=
    wbEnum([
        {00} 'Aggression',
        {01} 'Confidence',
        {02} 'Energy',
        {03} 'Responsibility',
        {04} 'Mood',
        {05} 'Strength',
        {06} 'Perception',
        {07} 'Endurance',
        {08} 'Charisma',
        {09} 'Intelligence',
        {10} 'Agility',
        {11} 'Luck',
        {12} 'Action Points',
        {13} 'Carry Weight',
        {14} 'Critical Chance',
        {15} 'Heal Rate',
        {16} 'Health',
        {17} 'Melee Damage',
        {18} 'Damage Resistance',
        {19} 'Poison Resistance',
        {20} 'Rad Resistance',
        {21} 'Speed Multiplier',
        {22} 'Fatigue',
        {23} 'Karma',
        {24} 'XP',
        {25} 'Perception Condition',
        {26} 'Endurance Condition',
        {27} 'Left Attack Condition',
        {28} 'Right Attack Condition',
        {29} 'Left Mobility Condition',
        {30} 'Right Mobility Condition',
        {31} 'Brain Condition',
        {32} 'Barter',
        {33} 'Big Guns',
        {34} 'Energy Weapons',
        {35} 'Explosives',
        {36} 'Lockpick',
        {37} 'Medicine',
        {38} 'Melee Weapons',
        {39} 'Repair',
        {40} 'Science',
        {41} 'Small Guns',
        {42} 'Sneak',
        {43} 'Speech',
        {44} 'Throwing (unused)',
        {45} 'Unarmed',
        {46} 'Inventory Weight',
        {47} 'Paralysis',
        {48} 'Invisibility',
        {49} 'Chameleon',
        {50} 'Night Eye',
        {51} 'Detect Life Range',
        {52} 'Fire Resistance',
        {53} 'Water Breathing',
        {54} 'Rad Level',
        {55} 'Bloody Mess',
        {56} 'Unarmed Damage',
        {57} 'Assistance',
        {58} 'Electric Resistance',
        {59} 'Frost Resistance',
        {60} 'Energy Resistance',
        {61} 'EMP Resistance',
        {62} 'Variable01',
        {63} 'Variable02',
        {64} 'Variable03',
        {65} 'Variable04',
        {66} 'Variable05',
        {67} 'Variable06',
        {68} 'Variable07',
        {79} 'Variable08',
        {70} 'Variable09',
        {71} 'Variable10',
        {72} 'Ignore Negative Effects'
      ], [
        -1, 'None'
      ]);

  wbSkillEnum :=
    wbEnum([
      'Barter',
      'Big Guns',
      'Energy Weapons',
      'Explosives',
      'Lockpick',
      'Medicine',
      'Melee Weapons',
      'Repair',
      'Science',
      'Small Guns',
      'Sneak',
      'Speech',
      'Throwing (unused)',
      'Unarmed'
    ], [
      -1, 'None'
    ]);

  wbCrimeTypeEnum :=
    wbEnum([
      'Steal',
      'Pickpocket',
      'Trespass',
      'Attack',
      'Murder'
    ], [
      -1, 'None'
    ]);

  wbActorValue := wbInteger('Actor Value', itS32, wbActorValueEnum);

  wbEquipTypeEnum :=
    wbEnum([
        {00} 'Big Guns',
        {01} 'Energy Weapons',
        {02} 'Small Guns',
        {03} 'Melee Weapons',
        {04} 'Unarmed Weapon',
        {05} 'Thrown Weapons',
        {06} 'Mine',
        {07} 'Body Wear',
        {08} 'Head Wear',
        {09} 'Hand Wear',
        {10} 'Chems',
        {11} 'Stimpak',
        {12} 'Food',
        {13} 'Alcohol'
      ], [
        -1, 'None'
      ]);

  wbETYP := wbInteger(ETYP, 'Equipment Type', itS32, wbEquipTypeEnum);
  wbETYPReq := wbInteger(ETYP, 'Equipment Type', itS32, wbEquipTypeEnum, cpNormal, True);

  wbFormTypeEnum :=
    wbEnum([], [
      $04, 'Texture Set',
      $05, 'Menu Icon',
      $06, 'Global',
      $07, 'Class',
      $08, 'Faction',
      $09, 'Head Part',
      $0A, 'Hair',
      $0B, 'Eyes',
      $0C, 'Race',
      $0D, 'Sound',
      $0E, 'Acoustic Space',
      $0F, 'Skill',
      $10, 'Base Effect',
      $11, 'Script',
      $12, 'Landscape Texture',
      $13, 'Object Effect',
      $14, 'Actor Effect',
      $15, 'Activator',
      $16, 'Talking Activator',
      $17, 'Terminal',
      $18, 'Armor',
      $19, 'Book',
      $1A, 'Clothing',
      $1B, 'Container',
      $1C, 'Door',
      $1D, 'Ingredient',
      $1E, 'Light',
      $1F, 'Misc',
      $20, 'Static',
      $21, 'Static Collection',
      $22, 'Movable Static',
      $23, 'Placeable Water',
      $24, 'Grass',
      $25, 'Tree',
      $26, 'Flora',
      $27, 'Furniture',
      $28, 'Weapon',
      $29, 'Ammo',
      $2A, 'NPC',
      $2B, 'Creature',
      $2C, 'Leveled Creature',
      $2D, 'Leveled NPC',
      $2E, 'Key',
      $2F, 'Ingestible',
      $30, 'Idle Marker',
      $31, 'Note',
      $32, 'Constructible Object',
      $33, 'Projectile',
      $34, 'Leveled Item',
      $35, 'Weather',
      $36, 'Climate',
      $37, 'Region',
      $39, 'Cell',
      $3A, 'Placed Object',
      $3B, 'Placed Character',
      $3C, 'Placed Creature',
      $3E, 'Placed Grenade',
      $41, 'Worldspace',
      $42, 'Landscape',
      $43, 'Navigation Mesh',
      $45, 'Dialog Topic',
      $46, 'Dialog Response',
      $47, 'Quest',
      $48, 'Idle Animation',
      $49, 'Package',
      $4A, 'Combat Style',
      $4B, 'Load Screen',
      $4C, 'Leveled Spell',
      $4D, 'Animated Object',
      $4E, 'Water',
      $4F, 'Effect Shader',
      $51, 'Explosion',
      $52, 'Debris',
      $53, 'Image Space',
      $54, 'Image Space Modifier',
      $55, 'FormID List',
      $56, 'Perk',
      $57, 'Body Part Data',
      $58, 'Addon Node',
      $59, 'Actor Value Info',
      $5A, 'Radiation Stage',
      $5B, 'Camera Shot',
      $5C, 'Camera Path',
      $5D, 'Voice Type',
      $5E, 'Impact Data',
      $5F, 'Impact DataSet',
      $60, 'Armor Addon',
      $61, 'Encounter Zone',
      $62, 'Message',
      $63, 'Ragdoll',
      $64, 'Default Object Manager',
      $65, 'Lighting Template',
      $66, 'Music Type'
  ]);

  wbMenuModeEnum :=
    wbEnum([],[
      1, 'Type: Character Interface',
      2, 'Type: Other',
      3, 'Type: Console',
      1001, 'Specific: Message',
      1002, 'Specific: Inventory',
      1003, 'Specific: Stats',
      1004, 'Specific: HUDMainMenu',
      1007, 'Specific: Loading',
      1008, 'Specific: Container',
      1009, 'Specific: Dialog',
      1012, 'Specific: Sleep/Wait',
      1013, 'Specific: Pause',
      1014, 'Specific: LockPick',
      1016, 'Specific: Quantity',
      1027, 'Specific: Level Up',
      1035, 'Specific: Pipboy Repair',
      1036, 'Specific: Race / Sex',
      1047, 'Specific: Credits',
      1048, 'Specific: CharGen',
      1051, 'Specific: TextEdit',
      1053, 'Specific: Barter',
      1054, 'Specific: Surgery',
      1055, 'Specific: Hacking',
      1056, 'Specific: VATS',
      1057, 'Specific: Computers',
      1058, 'Specific: Vendor Repair',
      1059, 'Specific: Tutorial',
      1060, 'Specific: You''re SPECIAL book'
    ]);
end;

procedure DefineFO3b;
begin
  wbMiscStatEnum :=
    wbEnum([
      'Quests Completed',
      'Locations Discovered',
      'People Killed',
      'Creatures Killed',
      'Locks Picked',
      'Computers Hacked',
      'Stimpaks Taken',
      'Rad-X Taken',
      'RadAway Taken',
      'Chems Taken',
      'Times Addicted',
      'Mines Disarmed',
      'Speech Successes',
      'Pockets Picked',
      'Pants Exploded',
      'Books Read',
      'Bobbleheads Found',
      'Weapons Created',
      'People Mezzed',
      'Captives Rescued',
      'Sandman Kills',
      'Paralyzing Punches',
      'Robots Disabled',
      'Contracts Completed',
      'Corpses Eaten',
      'Mysterious Stranger Visits'
    ]);

  wbAlignmentEnum :=
    wbEnum([
      'Good',
      'Neutral',
      'Evil',
      'Very Good',
      'Very Evil'
    ]);

  wbCriticalStageEnum :=
    wbEnum([
      'None',
      'Goo Start',
      'Goo End',
      'Disintegrate Start',
      'Disintegrate End'
    ]);

  wbCreatureTypeEnum :=
    wbEnum([
      'Animal',
      'Mutated Animal',
      'Mutated Insect',
      'Abomination',
      'Super Mutant',
      'Feral Ghoul',
      'Robot',
      'Giant'
    ]);

  wbPlayerActionEnum :=
    wbEnum([
      '',
      'Swinging Melee Weapon',
      'Throwing Grenade',
      'Fire Weapon',
      'Lay Mine',
      'Z Key Object',
      'Jumping',
      'Knocking over Objects',
      'Stand on Table/Chair',
      'Iron Sites',
      'Destroying Object'
    ]);

  wbBodyLocationEnum :=
    wbEnum([
      'Torso',
      'Head 1',
      'Head 2',
      'Left Arm 1',
      'Left Arm 2',
      'Right Arm 1',
      'Right Arm 2',
      'Left Leg 1',
      'Left Leg 2',
      'Left Leg 3',
      'Right Leg 1',
      'Right Leg 2',
      'Right Leg 3',
      'Brain'
    ], [
      -1, 'None'
    ]);


  wbEFID := wbFormIDCk(EFID, 'Base Effect', [MGEF]);

  wbEFIT :=
    wbStructSK(EFIT, [3, 4], '', [
      wbInteger('Magnitude', itU32),
      wbInteger('Area', itU32),
      wbInteger('Duration', itU32),
      wbInteger('Type', itU32, wbEnum(['Self', 'Touch', 'Target'])),
      wbActorValue
    ], cpNormal, True, nil, -1, wbEFITAfterLoad);

  wbCTDA :=
    wbStructSK(CTDA, [3, 4], 'Condition', [
   {0}wbInteger('Type', itU8, wbCtdaTypeToStr, wbCtdaTypeToInt, cpNormal, False, nil, wbCtdaTypeAfterSet),
   {1}wbByteArray('Unused', 3),
   {2}wbUnion('Comparison Value', wbCTDACompValueDecider, [
        wbFloat('Comparison Value - Float'),
        wbFormIDCk('Comparison Value - Global', [GLOB])
      ]),
   {3}wbInteger('Function', itU16, wbCTDAFunctionToStr, wbCTDAFunctionToInt),   // Limited to itu16
   {4}wbByteArray('Unused', 2, cpIgnore, False, wbNeverShow),
   {5}wbUnion('Parameter #1', wbCTDAParam1Decider, [
        {00} wbByteArray('Unknown', 4),
        {01} wbByteArray('None', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
        {02} wbInteger('Integer', itS32),
        {03} wbInteger('Variable Name (INVALID)', itS32).IncludeFlag(dfZeroSortKey),
        {04} wbInteger('Sex', itU32, wbSexEnum),
        {05} wbInteger('Actor Value', itS32, wbActorValueEnum),
        {06} wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
        {07} wbInteger('Axis', itU32, wbAxisEnum),
        {08} wbInteger('Quest Stage (INVALID)', itS32).IncludeFlag(dfZeroSortKey),
        {09} wbInteger('Misc Stat', itU32, wbMiscStatEnum),
        {10} wbInteger('Alignment', itU32, wbAlignmentEnum),
        {11} wbInteger('Equip Type', itU32, wbEquipTypeEnum),
        {12} wbInteger('Form Type', itU32, wbFormTypeEnum),
        {13} wbInteger('Critical Stage', itU32, wbCriticalStageEnum),
        {14} wbFormIDCkNoReach('Object Reference', [PLYR, REFR, ACHR, ACRE, PGRE, PMIS, PBEA, TRGT], True),
        {16} wbFormIDCkNoReach('Inventory Object', [ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, NOTE, FLST]),
        {17} wbFormIDCkNoReach('Actor', [PLYR, ACHR, ACRE, TRGT], True),
        {18} wbFormIDCkNoReach('Voice Type', [VTYP]),
        {19} wbFormIDCkNoReach('Idle', [IDLE]),
        {20} wbFormIDCkNoReach('Form List', [FLST]),
        {21} wbFormIDCkNoReach('Note', [NOTE]),
        {22} wbFormIDCkNoReach('Quest', [QUST]),
        {23} wbFormIDCkNoReach('Faction', [FACT]),
        {24} wbFormIDCkNoReach('Weapon', [WEAP]),
        {25} wbFormIDCkNoReach('Cell', [CELL]),
        {26} wbFormIDCkNoReach('Class', [CLAS]),
        {27} wbFormIDCkNoReach('Race', [RACE]),
        {28} wbFormIDCkNoReach('Actor Base', [NPC_, CREA, ACTI, TACT]),
        {29} wbFormIDCkNoReach('Global', [GLOB]),
        {30} wbFormIDCkNoReach('Weather', [WTHR]),
        {31} wbFormIDCkNoReach('Package', [PACK]),
        {32} wbFormIDCkNoReach('Encounter Zone', [ECZN]),
        {33} wbFormIDCkNoReach('Perk', [PERK]),
        {34} wbFormIDCkNoReach('Owner', [FACT, NPC_]),
        {35} wbFormIDCkNoReach('Furniture', [FURN, FLST]),
        {36} wbFormIDCkNoReach('Effect Item', [SPEL, ENCH, ALCH, INGR]),
        {37} wbFormIDCkNoReach('Base Effect', [MGEF]),
        {38} wbFormIDCkNoReach('Worldspace', [WRLD]),
        {39} wbInteger('VATS Value Function', itU32, wbVATSValueFunctionEnum),
        {40} wbInteger('VATS Value Param (INVALID)', itU32).IncludeFlag(dfZeroSortKey),
        {41} wbInteger('Creature Type', itU32, wbCreatureTypeEnum),
        {42} wbInteger('Menu Mode', itU32, wbMenuModeEnum),
        {43} wbInteger('Player Action', itU32, wbPlayerActionEnum),
        {44} wbInteger('Body Location', itS32, wbBodyLocationEnum),
        {45} wbFormIDCkNoReach('Referenceable Object', [CREA, NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM, FLST, LVLC, LVLN],
                                                [CREA, NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM, LVLC, LVLN])
      ]),
   {6}wbUnion('Parameter #2', wbCTDAParam2Decider, [
        {00} wbByteArray('Unknown', 4),
        {01} wbByteArray('None', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
        {02} wbInteger('Integer', itS32),
        {03} wbInteger('Variable Name', itS32, wbCTDAParam2VariableNameToStr, wbCTDAParam2VariableNameToInt),
        {04} wbInteger('Sex', itU32, wbSexEnum),
        {05} wbInteger('Actor Value', itS32, wbActorValueEnum),
        {06} wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
        {07} wbInteger('Axis', itU32, wbAxisEnum),
        {08} wbInteger('Quest Stage', itS32, wbCTDAParam2QuestStageToStr, wbCTDAParam2QuestStageToInt),
        {09} wbInteger('Misc Stat', itU32, wbMiscStatEnum),
        {10} wbInteger('Alignment', itU32, wbAlignmentEnum),
        {11} wbInteger('Equip Type', itU32, wbEquipTypeEnum),
        {12} wbInteger('Form Type', itU32, wbFormTypeEnum),
        {13} wbInteger('Critical Stage', itU32, wbCriticalStageEnum),
        {14} wbFormIDCkNoReach('Object Reference', [PLYR, REFR, PMIS, PBEA, ACHR, ACRE, PGRE, TRGT], True),
        {16} wbFormIDCkNoReach('Inventory Object', [ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, NOTE, FLST]),
        {17} wbFormIDCkNoReach('Actor', [PLYR, ACHR, ACRE, TRGT], True),
        {18} wbFormIDCkNoReach('Voice Type', [VTYP]),
        {19} wbFormIDCkNoReach('Idle', [IDLE]),
        {20} wbFormIDCkNoReach('Form List', [FLST]),
        {21} wbFormIDCkNoReach('Note', [NOTE]),
        {22} wbFormIDCkNoReach('Quest', [QUST]),
        {23} wbFormIDCkNoReach('Faction', [FACT]),
        {24} wbFormIDCkNoReach('Weapon', [WEAP]),
        {25} wbFormIDCkNoReach('Cell', [CELL]),
        {26} wbFormIDCkNoReach('Class', [CLAS]),
        {27} wbFormIDCkNoReach('Race', [RACE]),
        {28} wbFormIDCkNoReach('Actor Base', [NPC_, CREA, ACTI, TACT]),
        {29} wbFormIDCkNoReach('Global', [GLOB]),
        {30} wbFormIDCkNoReach('Weather', [WTHR]),
        {31} wbFormIDCkNoReach('Package', [PACK]),
        {32} wbFormIDCkNoReach('Encounter Zone', [ECZN]),
        {33} wbFormIDCkNoReach('Perk', [PERK]),
        {34} wbFormIDCkNoReach('Owner', [FACT, NPC_]),
        {35} wbFormIDCkNoReach('Furniture', [FURN, FLST]),
        {36} wbFormIDCkNoReach('Effect Item', [SPEL, ENCH, ALCH, INGR]),
        {37} wbFormIDCkNoReach('Base Effect', [MGEF]),
        {38} wbFormIDCkNoReach('Worldspace', [WRLD]),
        {39} wbInteger('VATS Value Function (INVALID)', itU32),
        {40} wbUnion('VATS Value Param', wbCTDAParam2VATSValueParam, [
               wbFormIDCkNoReach('Weapon', [WEAP]),
               wbFormIDCkNoReach('Weapon List', [FLST], [WEAP]),
               wbFormIDCkNoReach('Target', [NPC_, CREA]),
               wbFormIDCkNoReach('Target List', [FLST], [NPC_, CREA]),
               wbByteArray('Unused', 4, cpIgnore),
               wbInteger('Target Part', itS32, wbActorValueEnum),
               wbInteger('VATS Action', itU32, wbEnum([
                 'Unarmed Attack',
                 'One Hand Melee Attack',
                 'Two Hand Melee Attack',
                 'Fire Pistol',
                 'Fire Rifle',
                 'Fire Handle Weapon',
                 'Fire Launcher',
                 'Throw Grenade',
                 'Place Mine',
                 'Reload',
                 'Crouch',
                 'Stand',
                 'Switch Weapon',
                 'Toggle Weapon Drawn',
                 'Heal',
                 'Player Death'
               ])),
               wbByteArray('Unused', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
               wbByteArray('Unused', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
               wbFormIDCkNoReach('Critical Effect', [SPEL]),
               wbFormIDCkNoReach('Critical Effect List', [FLST], [SPEL]),
               wbByteArray('Unused', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
               wbByteArray('Unused', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
               wbByteArray('Unused', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
               wbByteArray('Unused', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
               wbInteger('Weapon Type', itU32, wbWeaponAnimTypeEnum),
               wbByteArray('Unused', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
               wbByteArray('Unused', 4, cpIgnore).IncludeFlag(dfZeroSortKey)
             ]),
        {41} wbInteger('Creature Type', itU32, wbCreatureTypeEnum),
        {42} wbInteger('Menu Mode', itU32, wbMenuModeEnum),
        {43} wbInteger('Player Action', itU32, wbPlayerActionEnum),
        {44} wbInteger('Body Location', itS32, wbBodyLocationEnum),
        {45} wbFormIDCkNoReach('Referenceable Object', [CREA, NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM, FLST, LVLC, LVLN],
                                                [CREA, NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM, LVLC, LVLN])
      ]),
   {7}wbInteger('Run On', itU32, wbEnum([
        'Subject',
        'Target',
        'Reference',
        'Combat Target',
        'Linked Reference'
      ]), cpNormal, False, nil, wbCTDARunOnAfterSet),
   {8}wbUnion('Reference', wbCTDAReferenceDecider, [
        wbInteger('Unused', itU32, nil, cpIgnore),
        wbFormIDCkNoReach('Reference', [PLYR, ACHR, ACRE, REFR, PMIS, PBEA, PGRE], True)
      ])
    ], cpNormal, False, nil, 7, wbCTDAAfterLoad).SetToStr(wbConditionToStr).IncludeFlag(dfCollapsed, wbCollapseConditions);
  wbCTDAs := wbRArray('Conditions', wbCTDA);
  wbCTDAsReq := wbRArray('Conditions', wbCTDA, cpNormal, True);

  var wbEffect :=
    wbRStruct('Effect', [
      wbEFID,
      wbEFIT,
      wbCTDAs
    ], []);

  wbEffects :=
    wbRArray('Effects', wbEffect);

  wbEffectsReq :=
    wbRArray('Effects', wbEffect, cpNormal, True);

  wbRecord(ALCH, 'Ingestible', [
    wbEDIDReq,
    wbOBND(True),
    wbFULLReq,
    wbGenericModel,
    wbICON,
    wbSCRI,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbETYPReq,
    wbFloat(DATA, 'Weight', cpNormal, True),
    wbStruct(ENIT, 'Effect Data', [
      wbInteger('Value', itS32),
      wbInteger('Flags?', itU8, wbFlags([
        'No Auto-Calc (Unused)',
        'Food Item',
        'Medicine'
      ])),
      wbByteArray('Unused', 3),
      wbFormIDCk('Withdrawal Effect', [SPEL, NULL]),
      wbFloat('Addiction Chance'),
      wbFormIDCk('Sound - Consume', [SOUN])
    ], cpNormal, True),
    wbEffectsReq
  ]);

  wbRecord(AMMO, 'Ammunition', [
    wbEDIDReq,
    wbOBND(True),
    wbFULLReq,
    wbGenericModel,
    wbICON,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbStruct(DATA, 'Data', [
      wbFloat('Speed'),
      wbInteger('Flags', itU8, wbFlags([
        'Ignores Normal Weapon Resistance',
        'Non-Playable'
      ])),
      wbByteArray('Unused', 3),
      wbInteger('Value', itS32),
      wbInteger('Clip Rounds', itU8)
    ], cpNormal, True),
    wbStringKC(ONAM, 'Short Name', 0, cpTranslate)
  ]);

  wbRecord(ANIO, 'Animated Object', [
    wbEDIDReq,
    wbGenericModel(True),
    wbFormIDCk(DATA, 'Animation', [IDLE], False, cpNormal, True)
  ]);

  wbBMDT := wbStruct(BMDT, 'Biped Data', [
      wbInteger('Biped Flags', itU32, wbFlags([
        {0x00000001} 'Head',
        {0x00000002} 'Hair',
        {0x00000004} 'Upper Body',
        {0x00000008} 'Left Hand',
        {0x00000010} 'Right Hand',
        {0x00000020} 'Weapon',
        {0x00000040} 'PipBoy',
        {0x00000080} 'Backpack',
        {0x00000100} 'Necklace',
        {0x00000200} 'Headband',
        {0x00000400} 'Hat',
        {0x00000800} 'Eye Glasses',
        {0x00001000} 'Nose Ring',
        {0x00002000} 'Earrings',
        {0x00004000} 'Mask',
        {0x00008000} 'Choker',
        {0x00010000} 'Mouth Object',
        {0x00020000} 'Body AddOn 1',
        {0x00040000} 'Body AddOn 2',
        {0x00080000} 'Body AddOn 3'
      ])),
      wbInteger('General Flags', itU8, wbFlags([
        {0x0001} '',
        {0x0002} '',
        {0x0004} '',
        {0x0008} '',
        {0x0010} '',
        {0x0020} 'Power Armor',
        {0x0040} 'Non-Playable',
        {0x0080} 'Heavy'
      ], True)),
      wbByteArray('Unused', 3)
    ], cpNormal, True);

  wbRecord(ARMO, 'Armor', [
    wbEDIDReq,
    wbOBND(True),
    wbFULL,
    wbSCRI,
    wbEITM,
    wbBMDT,
    wbTexturedModel('Male biped model', [MODL, MODT], [wbMODS, wbMODD]),
    wbTexturedModel('Male world model', [MOD2, MO2T], [wbMO2S, nil]),
    wbString(ICON, 'Male icon FileName'),
    wbString(MICO, 'Male mico FileName'),
    wbTexturedModel('Female biped model', [MOD3, MO3T], [wbMO3S, wbMOSD]),
    wbTexturedModel('Female world model', [MOD4, MO4T], [wbMO4S, nil]),
    wbString(ICO2, 'Female icon FileName'),
    wbString(MIC2, 'Female mico FileName'),
    wbString(BMCT, 'Ragdoll Constraint Template'),
    wbDEST,
    wbREPL,
    wbBIPL,
    wbETYPReq,
    wbYNAM,
    wbZNAM,
    wbStruct(DATA, 'Data', [
      wbInteger('Value', itS32),
      wbInteger('Max Condition', itS32),
      wbFloat('Weight')
    ], cpNormal, True),
    wbStruct(DNAM, '', [
      wbInteger('AR', itS16, wbDiv(100)),
      wbInteger('Flags', itU16, wbFlags([
        'Modulates Voice'
      ]))
    ], cpNormal, True)
  ]);

  wbRecord(ARMA, 'Armor Addon', [
    wbEDIDReq,
    wbOBND(True),
    wbFULL,
    wbBMDT,
    wbTexturedModel('Male biped model', [MODL, MODT], [wbMODS, wbMODD]),
    wbTexturedModel('Male world model', [MOD2, MO2T], [wbMO2S, nil]),
    wbString(ICON, 'Male icon FileName'),
    wbString(MICO, 'Male mico FileName'),
    wbTexturedModel('Female biped model', [MOD3, MO3T], [wbMO3S, wbMOSD]),
    wbTexturedModel('Female world model', [MOD4, MO4T], [wbMO4S, nil]),
    wbString(ICO2, 'Female icon FileName'),
    wbString(MIC2, 'Female mico FileName'),
    wbETYPReq,
    wbStruct(DATA, 'Data', [
      wbInteger('Value', itS32),
      wbInteger('Max Condition', itS32),
      wbFloat('Weight')
    ], cpNormal, True),
    wbStruct(DNAM, '', [
      wbInteger('AR', itS16, wbDiv(100)),
      wbInteger('Flags', itU16, wbFlags([
        'Modulates Voice'
      ]))
    ], cpNormal, True)
  ]);

  wbRecord(BOOK, 'Book', [
    wbEDIDReq,
    wbOBND(True),
    wbFULL,
    wbGenericModel,
    wbICON,
    wbSCRI,
    wbDESCReq,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbStruct(DATA, 'Data', [
      wbInteger('Flags', itU8, wbFlags([
        'Scroll',
        'Can''t be Taken'
      ])),
      wbInteger('Skill', itS8, wbSkillEnum),
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True)
  ]);

  wbSPLO := wbFormIDCk(SPLO, 'Actor Effect', [SPEL]);
  wbSPLOs := wbRArrayS('Actor Effects', wbSPLO, cpNormal, False, nil, nil, wbActorTemplateUseActorEffectList);

  wbRecord(CELL, 'Cell', [
    wbEDID,
    wbFULL,
    wbInteger(DATA, 'Flags', itU8, wbFlags([
      {0x01} 'Is Interior Cell',
      {0x02} 'Has water',
      {0x04} 'Invert Fast Travel behavior',
      {0x08} 'No LOD Water',
      {0x10} '',
      {0x20} 'Public place',
      {0x40} 'Hand changed',
      {0x80} 'Behave like exterior'
    ]), cpNormal, True),
    wbCellGrid,
    wbStruct(XCLL, 'Lighting', [
      wbStruct('Ambient Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Directional Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Fog Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbFloat('Fog Near'),
      wbFloat('Fog Far'),
      wbInteger('Directional Rotation XY', itS32),
      wbInteger('Directional Rotation Z', itS32),
      wbFloat('Directional Fade'),
      wbFloat('Fog Clip Dist'),
      wbFloat('Fog Power')
    ], cpNormal, False, nil, 7),
    wbArray(IMPF, 'Footstep Materials', wbString('Unknown', 30), [
      'ConcSolid',
      'ConcBroken',
      'MetalSolid',
      'MetalHollow',
      'MetalSheet',
      'Wood',
      'Sand',
      'Dirt',
      'Grass',
      'Water'
    ]),
    wbRStruct('Light Template', [
      wbFormIDCk(LTMP, 'Template', [LGTM, NULL]),
      wbInteger(LNAM, 'Inherit', itU32, wbFlags([
        {0x00000001}'Ambient Color',
        {0x00000002}'Directional Color',
        {0x00000004}'Fog Color',
        {0x00000008}'Fog Near',
        {0x00000010}'Fog Far',
        {0x00000020}'Directional Rotation',
        {0x00000040}'Directional Fade',
        {0x00000080}'Clip Distance',
        {0x00000100}'Fog Power'
      ]), cpNormal, True)
    ], [], cpNormal, True ),
    wbFloat(XCLW, 'Water Height'),
    wbString(XNAM, 'Water Noise Texture'),
    wbArrayS(XCLR, 'Regions', wbFormIDCk('Region', [REGN])),
    wbFormIDCk(XCIM, 'Image Space', [IMGS]),
    wbByteArray(XCET, 'Unknown', 1, cpIgnore),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),
    wbFormIDCk(XCCM, 'Climate', [CLMT]),
    wbFormIDCk(XCWT, 'Water', [WATR]),
    wbOwnership(wbXOWN, [XCMT, XCMO]),
    wbFormIDCk(XCAS, 'Acoustic Space', [ASPC]),
    wbByteArray(XCMT, 'Unused', 1, cpIgnore),
    wbFormIDCk(XCMO, 'Music Type', [MUSC])
  ], True, wbCellAddInfo, cpNormal, False, wbCELLAfterLoad);

  wbServiceFlags :=
    wbFlags([
      {0x00000001} 'Weapons',
      {0x00000002} 'Armor',
      {0x00000004} 'Alcohol',
      {0x00000008} 'Books',
      {0x00000010} 'Food',
      {0x00000020} 'Chems',
      {0x00000040} 'Stimpaks',
      {0x00000080} 'Lights?',
      {0x00000100} '',
      {0x00000200} '',
      {0x00000400} 'Miscellaneous',
      {0x00000800} '',
      {0x00001000} '',
      {0x00002000} 'Potions?',
      {0x00004000} 'Training',
      {0x00008000} '',
      {0x00010000} 'Recharge',
      {0x00020000} 'Repair'
    ]);

  wbSpecializationEnum := wbEnum(['Combat', 'Magic', 'Stealth']);

  wbRecord(CLAS, 'Class', [
    wbEDIDReq,
    wbFULLReq,
    wbDESCReq,
    wbICON,
    wbStruct(DATA, '', [
      wbArray('Tag Skills', wbInteger('Tag Skill', itS32, wbActorValueEnum), 4),
      wbInteger('Flags', itU32, wbFlags(['Playable', 'Guard'], True)),
      wbInteger('Buys/Sells and Services', itU32, wbServiceFlags),
      wbInteger('Teaches', itS8, wbSkillEnum),
      wbInteger('Maximum training level', itU8),
      wbByteArray('Unused', 2)
    ], cpNormal, True),
    wbArray(ATTR, 'Attributes', wbInteger('Attribute', itU8), [
      'Strength',
      'Perception',
      'Endurance',
      'Charisma',
      'Intelligence',
      'Agility',
      'Luck'
    ], cpNormal, True)
  ]);
end;

procedure DefineFO3c;
begin
  wbRecord(CLMT, 'Climate', [
    wbEDIDReq,
    wbArrayS(WLST, 'Weather Types', wbStructSK([0], 'Weather Type', [
      wbFormIDCk('Weather', [WTHR, NULL]),
      wbInteger('Chance', itS32),
      wbFormIDCk('Global', [GLOB, NULL])
    ])),
    wbString(FNAM, 'Sun Texture'),
    wbString(GNAM, 'Sun Glare Texture'),
    wbGenericModel,
    wbClimateTiming(wbClmtTime, wbClmtMoonsPhaseLength)
  ]);

  wbCNTO :=
    wbRStructExSK([0], [1], 'Item', [
      wbStructExSK(CNTO, [0], [1], 'Item', [
        wbFormIDCk('Item', [ARMO, AMMO, MISC, WEAP, BOOK, LVLI, KEYM, ALCH, NOTE, MSTT{?}, STAT{?}]),
        wbInteger('Count', itS32)
      ]),
      wbCOED
    ], []).SetToStr(wbItemToStr).IncludeFlag(dfCollapsed, wbCollapseItems);

  wbCNTOs := wbRArrayS('Items', wbCNTO);

  wbRecord(CONT, 'Container', [
    wbEDIDReq,
    wbOBND(True),
    wbFULL,
    wbGenericModel,
    wbSCRI,
    wbCNTOs,
    wbDEST,
    wbStruct(DATA, '', [
      wbInteger('Flags', itU8, wbFlags(['', 'Respawns'])),
      wbFloat('Weight')
    ], cpNormal, True),
    wbFormIDCk(SNAM, 'Sound - Open', [SOUN]),
    wbFormIDCk(QNAM, 'Sound - Close', [SOUN])
  ], True);

  wbCSDT := wbRStructSK([0], 'Sound Type', [
    wbInteger(CSDT, 'Type', itU32,wbEnum([
      {0x00} 'Left Foot',
      {0x01} 'Right Foot',
      {0x02} 'Left Back Foot',
      {0x03} 'Right Back Foot',
      {0x04} 'Idle',
      {0x05} 'Aware',
      {0x06} 'Attack',
      {0x07} 'Hit',
      {0x08} 'Death',
      {0x09} 'Weapon',
      {0x0A} 'Movement',
      {0x0B} 'Conscious'
    ])),
    wbSoundTypeSounds
  ], []);

  wbCSDTs := wbRArrayS('Sound Types', wbCSDT, cpNormal, False, nil, nil, wbActorTemplateUseModelAnimation);

  wbAgressionEnum := wbEnum([
    'Unaggressive',
    'Aggressive',
    'Very Aggressive',
    'Frenzied'
  ]);

  wbConfidenceEnum := wbEnum([
    'Cowardly',
    'Cautious',
    'Average',
    'Brave',
    'Foolhardy'
  ]);

  wbMoodEnum := wbEnum([
    'Neutral',
    'Afraid',
    'Annoyed',
    'Cocky',
    'Drugged',
    'Pleasant',
    'Angry',
    'Sad'
  ]);

  wbAssistanceEnum := wbEnum([
    'Helps Nobody',
    'Helps Allies',
    'Helps Friends and Allies'
  ]);

  wbAggroRadiusFlags := wbFlags([
    'Aggro Radius Behavior'
  ]);

  wbAIDT :=
    wbStruct(AIDT, 'AI Data', [
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
     {10} wbInteger('Aggro Radius', itS32)
    ], cpNormal, True, wbActorTemplateUseAIData);

  wbAttackAnimationEnum :=
    wbEnum([
    ], [
       26, 'AttackLeft',
       27, 'AttackLeftUp',
       28, 'AttackLeftDown',
       29, 'AttackLeftIS',
       30, 'AttackLeftISUp',
       31, 'AttackLeftISDown',
       32, 'AttackRight',
       33, 'AttackRightUp',
       34, 'AttackRightDown',
       35, 'AttackRightIS',
       36, 'AttackRightISUp',
       37, 'AttackRightISDown',
       38, 'Attack3',
       39, 'Attack3Up',
       40, 'Attack3Down',
       41, 'Attack3IS',
       42, 'Attack3ISUp',
       43, 'Attack3ISDown',
       44, 'Attack4',
       45, 'Attack4Up',
       46, 'Attack4Down',
       47, 'Attack4IS',
       48, 'Attack4ISUp',
       49, 'Attack4ISDown',
       50, 'Attack5',
       51, 'Attack5Up',
       52, 'Attack5Down',
       53, 'Attack5IS',
       54, 'Attack5ISUp',
       55, 'Attack5ISDown',
       56, 'Attack6',
       57, 'Attack6Up',
       58, 'Attack6Down',
       59, 'Attack6IS',
       60, 'Attack6ISUp',
       61, 'Attack6ISDown',
       62, 'Attack7',
       63, 'Attack7Up',
       64, 'Attack7Down',
       65, 'Attack7IS',
       66, 'Attack7ISUp',
       67, 'Attack7ISDown',
       68, 'Attack8',
       69, 'Attack8Up',
       70, 'Attack8Down',
       71, 'Attack8IS',
       72, 'Attack8ISUp',
       73, 'Attack8ISDown',
       74, 'AttackLoop',
       75, 'AttackLoopUp',
       76, 'AttackLoopDown',
       77, 'AttackLoopIS',
       78, 'AttackLoopISUp',
       79, 'AttackLoopISDown',
       80, 'AttackSpin',
       81, 'AttackSpinUp',
       82, 'AttackSpinDown',
       83, 'AttackSpinIS',
       84, 'AttackSpinISUp',
       85, 'AttackSpinISDown',
       86, 'AttackSpin2',
       87, 'AttackSpin2Up',
       88, 'AttackSpin2Down',
       89, 'AttackSpin2IS',
       90, 'AttackSpin2ISUp',
       91, 'AttackSpin2ISDown',
       92, 'AttackPower',
       93, 'AttackForwardPower',
       94, 'AttackBackPower',
       95, 'AttackLeftPower',
       96, 'AttackRightPower',
       97, 'PlaceMine',
       98, 'PlaceMineUp',
       99, 'PlaceMineDown',
      100, 'PlaceMineIS',
      101, 'PlaceMineISUp',
      102, 'PlaceMineISDown',
      103, 'PlaceMine2',
      104, 'PlaceMine2Up',
      105, 'PlaceMine2Down',
      106, 'PlaceMine2IS',
      107, 'PlaceMine2ISUp',
      108, 'PlaceMine2ISDown',
      109, 'AttackThrow',
      110, 'AttackThrowUp',
      111, 'AttackThrowDown',
      112, 'AttackThrowIS',
      113, 'AttackThrowISUp',
      114, 'AttackThrowISDown',
      115, 'AttackThrow2',
      116, 'AttackThrow2Up',
      117, 'AttackThrow2Down',
      118, 'AttackThrow2IS',
      119, 'AttackThrow2ISUp',
      120, 'AttackThrow2ISDown',
      121, 'AttackThrow3',
      122, 'AttackThrow3Up',
      123, 'AttackThrow3Down',
      124, 'AttackThrow3IS',
      125, 'AttackThrow3ISUp',
      126, 'AttackThrow3ISDown',
      127, 'AttackThrow4',
      128, 'AttackThrow4Up',
      129, 'AttackThrow4Down',
      130, 'AttackThrow4IS',
      131, 'AttackThrow4ISUp',
      132, 'AttackThrow4ISDown',
      133, 'AttackThrow5',
      134, 'AttackThrow5Up',
      135, 'AttackThrow5Down',
      136, 'AttackThrow5IS',
      137, 'AttackThrow5ISUp',
      138, 'AttackThrow5ISDown',

      167, 'PipBoy',
      178, 'PipBoyChild',

      255, ' ANY'
    ]);

  wbImpactMaterialTypeEnum :=
    wbEnum([
      'Stone',
      'Dirt',
      'Grass',
      'Glass',
      'Metal',
      'Wood',
      'Organic',
      'Cloth',
      'Water',
      'Hollow Metal',
      'Organic Bug',
      'Organic Glow'
    ]);

  wbTemplateFlags := wbFlags([
    'Use Traits',
    'Use Stats',
    'Use Factions',
    'Use Actor Effect List',
    'Use AI Data',
    'Use AI Packages',
    'Use Model/Animation',
    'Use Base Data',
    'Use Inventory',
    'Use Script'
  ]);

  wbRecord(CREA, 'Creature', [
    wbEDIDReq,
    wbOBND(True),
    wbFULLActor,
    wbGenericModel(False, wbActorTemplateUseModelAnimation),
    wbSPLOs,
    wbFormIDCk(EITM, 'Unarmed Attack Effect', [ENCH, SPEL], False, cpNormal, False, wbActorTemplateUseActorEffectList),
    wbInteger(EAMT, 'Unarmed Attack Animation', itU16, wbAttackAnimationEnum, cpNormal, True, False, wbActorTemplateUseActorEffectList),
    wbArrayS(NIFZ, 'Model List', wbStringLC('Model'), 0, cpNormal, False, nil, nil, wbActorTemplateUseModelAnimation),
    wbModelInfos(NIFT, 'Model List Textures', wbActorTemplateUseModelAnimation),
    wbStruct(ACBS, 'Configuration', [
      {00} wbInteger('Flags', itU32, wbFlags([
             {0x000001} 'Biped',
             {0x000002} 'Essential',
             {0x000004} 'Weapon & Shield?',
             {0x000008} 'Respawn',
             {0x000010} 'Swims',
             {0x000020} 'Flies',
             {0x000040} 'Walks',
             {0x000080} 'PC Level Mult',
             {0x000100} 'Unknown 8',
             {0x000200} 'No Low Level Processing',
             {0x000400} '',
             {0x000800} 'No Blood Spray',
             {0x001000} 'No Blood Decal',
             {0x002000} '',
             {0x004000} '',
             {0x008000} 'No Head',
             {0x010000} 'No Right Arm',
             {0x020000} 'No Left Arm',
             {0x040000} 'No Combat in Water',
             {0x080000} 'No Shadow',
             {0x100000} 'No VATS Melee',
           {0x00200000} 'Allow PC Dialogue',
           {0x00400000} 'Can''t Open Doors',
           {0x00800000} 'Immobile',
           {0x01000000} 'Tilt Front/Back',
           {0x02000000} 'Tilt Left/Right',
           {0x03000000} 'No Knockdowns',
           {0x08000000} 'Not Pushable',
           {0x10000000} 'Allow Pickpocket',
           {0x20000000} 'Is Ghost',
           {0x40000000} 'No Rotating To Head-track',
           {0x80000000} 'Invulnerable'
           ], [
             {0x000001 Biped} wbActorTemplateUseModelAnimation,
             {0x000002 Essential} wbActorTemplateUseBaseData,
             {0x000004 Weapon & Shield} nil,
             {0x000008 Respawn} wbActorTemplateUseBaseData,
             {0x000010 Swims} wbActorTemplateUseModelAnimation,
             {0x000020 Flies} wbActorTemplateUseModelAnimation,
             {0x000040 Walks} wbActorTemplateUseModelAnimation,
             {0x000080 PC Level Mult} wbActorTemplateUseStats,
             {0x000100 Unknown 8} nil,
             {0x000200 No Low Level Processing} wbActorTemplateUseBaseData,
             {0x000400 } nil,
             {0x000800 No Blood Spray} wbActorTemplateUseModelAnimation,
             {0x001000 No Blood Decal} wbActorTemplateUseModelAnimation,
             {0x002000 } nil,
             {0x004000 } nil,
             {0x008000 No Head} wbActorTemplateUseModelAnimation,
             {0x010000 No Right Arm} wbActorTemplateUseModelAnimation,
             {0x020000 No Left Arm} wbActorTemplateUseModelAnimation,
             {0x040000 No Combat in Water} wbActorTemplateUseModelAnimation,
             {0x080000 No Shadow} wbActorTemplateUseModelAnimation,
             {0x100000 No VATS Melee} nil,
           {0x00200000 Allow PC Dialogue} wbActorTemplateUseBaseData,
           {0x00400000 Can''t Open Doors} wbActorTemplateUseBaseData,
           {0x00800000 Immobile} wbActorTemplateUseModelAnimation,
           {0x01000000 Tilt Front/Back} wbActorTemplateUseModelAnimation,
           {0x02000000 Tilt Left/Right} wbActorTemplateUseModelAnimation,
           {0x03000000 No Knockdowns} nil,
           {0x08000000 Not Pushable} wbActorTemplateUseModelAnimation,
           {0x10000000 Allow Pickpocket} wbActorTemplateUseBaseData,
           {0x20000000 Is Ghost} nil,
           {0x40000000 No Rotating To Head-track} wbActorTemplateUseModelAnimation,
           {0x80000000 Invulnerable} nil
           ])),
      {04} wbInteger('Fatigue', itU16, nil, cpNormal, False, wbActorTemplateUseStats),
      {06} wbInteger('Barter gold', itU16, nil, cpNormal, False, wbActorTemplateUseAIData),
      {08} wbUnion('Level', wbCreaLevelDecider, [
             wbInteger('Level', itS16, nil, cpNormal, False, wbActorTemplateUseStats),
             wbInteger('Level Mult', itS16, wbDiv(1000), cpNormal, False, wbActorTemplateUseStats)
           ], cpNormal, False, wbActorTemplateUseStats),
      {10} wbInteger('Calc min', itU16, nil, cpNormal, False, wbActorTemplateUseStats),
      {12} wbInteger('Calc max', itU16, nil, cpNormal, False, wbActorTemplateUseStats),
      {14} wbInteger('Speed Multiplier', itU16, nil, cpNormal, False, wbActorTemplateUseStats),
      {16} wbFloat('Karma (Alignment)', cpNormal, False, 1, -1, wbActorTemplateUseTraits),
      {20} wbInteger('Disposition Base', itS16, nil, cpNormal, False, wbActorTemplateUseTraits),
      {22} wbInteger('Template Flags', itU16, wbTemplateFlags)
    ], cpNormal, True),
    wbRArrayS('Factions', wbFaction, cpNormal, False, nil, nil, wbActorTemplateUseFactions),
    wbFormIDCk(INAM, 'Death item', [LVLI], False, cpNormal, False, wbActorTemplateUseTraits),
    wbFormIDCk(VTCK, 'Voice', [VTYP], False, cpNormal, False, wbActorTemplateUseTraits),
    wbFormIDCk(TPLT, 'Template', [CREA, LVLC]),
    wbDESTActor,
    wbSCRIActor,
    wbRArrayS('Items', wbCNTO, cpNormal, False, nil, nil, wbActorTemplateUseInventory),
    wbAIDT,
    wbRArray('Packages', wbFormIDCk(PKID, 'Package', [PACK]), cpNormal, False, nil, nil, wbActorTemplateUseAIPackages),
    wbArrayS(KFFZ, 'Animations', wbStringLC('Animation'), 0, cpNormal, False, nil, nil, wbActorTemplateUseModelAnimation),
    wbStruct(DATA, '', [
      {00} wbInteger('Type', itU8, wbCreatureTypeEnum, cpNormal, False, wbActorTemplateUseTraits),
      {01} wbInteger('Combat Skill', itU8, nil, cpNormal, False, wbActorTemplateUseStats),
      {02} wbInteger('Magic Skill', itU8, nil, cpNormal, False, wbActorTemplateUseStats),
      {03} wbInteger('Stealth Skill', itU8, nil, cpNormal, False, wbActorTemplateUseStats),
      {04} wbInteger('Health', itS16, nil, cpNormal, False, wbActorTemplateUseStats),
      {06} wbByteArray('Unused', 2),
      {08} wbInteger('Damage', itS16, nil, cpNormal, False, wbActorTemplateUseStats),
      {10} wbArray('Attributes', wbInteger('Attribute', itU8), [
            'Strength',
            'Perception',
            'Endurance',
            'Charisma',
            'Intelligence',
            'Agility',
            'Luck'
          ], cpNormal, False, wbActorTemplateUseStats)
    ], cpNormal, True),
    wbInteger(RNAM, 'Attack reach', itU8, nil, cpNormal, True, False, wbActorTemplateUseTraits),
    wbFormIDCk(ZNAM, 'Combat Style', [CSTY], False, cpNormal, False, wbActorTemplateUseTraits),
    wbFormIDCk(PNAM, 'Body Part Data', [BPTD], False, cpNormal, True, wbActorTemplateUseModelAnimation),
    wbFloat(TNAM, 'Turning Speed', cpNormal, True, 1, -1, wbActorTemplateUseStats),
    wbFloat(BNAM, 'Base Scale', cpNormal, True, 1, -1, wbActorTemplateUseStats),
    wbFloat(WNAM, 'Foot Weight', cpNormal, True, 1, -1, wbActorTemplateUseStats),
    wbInteger(NAM4, 'Impact Material Type', itU32, wbImpactMaterialTypeEnum, cpNormal, True, False, wbActorTemplateUseModelAnimation),
    wbInteger(NAM5, 'Sound Level', itU32, wbSoundLevelEnum, cpNormal, True, False, wbActorTemplateUseModelAnimation),
    wbFormIDCk(CSCR, 'Inherits Sounds from', [CREA], False, cpNormal, False, wbActorTemplateUseModelAnimation),
    wbCSDTs,
    wbFormIDCk(CNAM, 'Impact Dataset', [IPDS], False, cpNormal, False, wbActorTemplateUseModelAnimation),
    wbFormIDCk(LNAM, 'Melee Weapon List', [FLST], False, cpNormal, False, wbActorTemplateUseTraits)
  ], True);

end;

procedure DefineFO3d;
begin
  wbRecord(CSTY, 'Combat Style', [
    wbEDIDReq,
    wbStruct(CSTD, 'Advanced - Standard', [
      {000}wbInteger('Maneuver Decision - Dodge % Chance', itU8),
      {001}wbInteger('Maneuver Decision - Left/Right % Chance', itU8),
      {002}wbByteArray('Unused', 2),
      {004}wbFloat('Maneuver Decision - Dodge L/R Timer (min)'),
      {008}wbFloat('Maneuver Decision - Dodge L/R Timer (max)'),
      {012}wbFloat('Maneuver Decision - Dodge Forward Timer (min)'),
      {016}wbFloat('Maneuver Decision - Dodge Forward Timer (max)'),
      {020}wbFloat('Maneuver Decision - Dodge Back Timer Min'),
      {024}wbFloat('Maneuver Decision - Dodge Back Timer Max'),
      {028}wbFloat('Maneuver Decision - Idle Timer min'),
      {032}wbFloat('Maneuver Decision - Idle Timer max'),
      {036}wbInteger('Melee Decision - Block % Chance', itU8),
      {037}wbInteger('Melee Decision - Attack % Chance', itU8),
      {038}wbByteArray('Unused', 2),
      {040}wbFloat('Melee Decision - Recoil/Stagger Bonus to Attack'),
      {044}wbFloat('Melee Decision - Unconscious Bonus to Attack'),
      {048}wbFloat('Melee Decision - Hand-To-Hand Bonus to Attack'),
      {052}wbInteger('Melee Decision - Power Attacks - Power Attack % Chance', itU8),
      {053}wbByteArray('Unused', 3),
      {056}wbFloat('Melee Decision - Power Attacks - Recoil/Stagger Bonus to Power'),
      {060}wbFloat('Melee Decision - Power Attacks - Unconscious Bonus to Power Attack'),
      {064}wbInteger('Melee Decision - Power Attacks - Normal', itU8),
      {065}wbInteger('Melee Decision - Power Attacks - Forward', itU8),
      {066}wbInteger('Melee Decision - Power Attacks - Back', itU8),
      {067}wbInteger('Melee Decision - Power Attacks - Left', itU8),
      {068}wbInteger('Melee Decision - Power Attacks - Right', itU8),
      {069}wbByteArray('Unused', 3),
      {072}wbFloat('Melee Decision - Hold Timer (min)'),
      {076}wbFloat('Melee Decision - Hold Timer (max)'),
      {080}wbInteger('Flags', itU16, wbFlags([
             'Choose Attack using % Chance',
             'Melee Alert OK',
             'Flee Based on Personal Survival',
             '',
             'Ignore Threats',
             'Ignore Damaging Self',
             'Ignore Damaging Group',
             'Ignore Damaging Spectators',
             'Cannot Use Stealthboy'
           ])),
      {082}wbByteArray('Unused', 2),
      {085}wbInteger('Maneuver Decision - Acrobatic Dodge % Chance', itU8),
      {085}wbInteger('Melee Decision - Power Attacks - Rushing Attack % Chance', itU8),
      {086}wbByteArray('Unused', 2),
      {088}wbFloat('Melee Decision - Power Attacks - Rushing Attack Distance Mult')
    ], cpNormal, True),
    wbStruct(CSAD, 'Advanced - Advanced', [
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
    ], cpNormal, True),
    wbStruct(CSSD, 'Simple', [
      {00} wbFloat('Cover Search Radius'),
      {04} wbFloat('Take Cover Chance'),
      {08} wbFloat('Wait Timer (min)'),
      {12} wbFloat('Wait Timer (max)'),
      {16} wbFloat('Wait to Fire Timer (min)'),
      {20} wbFloat('Wait to Fire Timer (max)'),
      {24} wbFloat('Fire Timer (min)'),
      {28} wbFloat('Fire Timer (max)'),
      {32} wbFloat('Ranged Weapon Range Mult (min)'),
      {36} wbByteArray('Unused', 4),
      {40} wbInteger('Weapon Restrictions', itU32, wbEnum([
        'None',
        'Melee Only',
        'Ranged Only'
      ])),
      {44} wbFloat('Ranged Weapon Range Mult (max)'),
      {48} wbFloat('Max Targeting FOV'),
      {52} wbFloat('Combat Radius'),
      {56} wbFloat('Semi-Auto Firing Delay Mult (min)'),
      {60} wbFloat('Semi-Auto Firing Delay Mult (max)')
    ], cpNormal, True)
  ]);

  wbRecord(DIAL, 'Dialog Topic', [
    wbEDIDReqKC,
    wbRArrayS('Quests', wbFormIDCkNoReach(QSTI, 'Quest', [QUST], False, cpBenign)),
    wbRArrayS('Quests?', wbFormIDCkNoReach(QSTR, 'Quest?', [QUST], False, cpBenign)),
    wbFULL,
    wbFloat(PNAM, 'Priority', cpNormal, True, 1, -1, nil, nil, 50.0),
    wbStruct(DATA, '', [
      wbInteger('Type', itU8, wbEnum([
        {0} 'Topic',
        {1} 'Conversation',
        {2} 'Combat',
        {3} 'Persuasion',
        {4} 'Detection',
        {5} 'Service',
        {6} 'Miscellaneous',
        {7} 'Radio'
      ])),
      wbInteger('Flags', itU8, wbFlags([
        'Rumors',
        'Top-level'
      ]))
    ], cpNormal, True, nil, 1)
  ], True);

  wbRecord(DOOR, 'Door', [
    wbEDIDReq,
    wbOBND(True),
    wbFULL,
    wbGenericModel(True),
    wbSCRI,
    wbDEST,
    wbFormIDCk(SNAM, 'Sound - Open', [SOUN]),
    wbFormIDCk(ANAM, 'Sound - Close', [SOUN]),
    wbFormIDCk(BNAM, 'Sound - Looping', [SOUN]),
    wbInteger(FNAM, 'Flags', itU8, wbFlags([
      '',
      'Automatic Door',
      'Hidden',
      'Minimal Use',
      'Sliding Door'
    ]), cpNormal, True)
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
    'Add',
    'Subtract',
    'Reverse Subtract',
    'Minimum',
    'Maximum'
  ]);
  wbZTestFuncEnum := wbEnum([
    '',
    '',
    '',
    'Equal To',
    'Normal',
    'Greater Than',
    '',
    'Greater Than or Equal Than',
    'Always Show'
  ]);

  wbRecord(EFSH, 'Effect Shader', [
    wbEDID,
    wbString(ICON, 'Fill Texture'),
    wbString(ICO2, 'Particle Shader Texture'),
    wbString(NAM7, 'Holes Texture'),
    wbStruct(DATA, '', [
      wbInteger('Flags', itU8, wbFlags([
        {0} 'No Membrane Shader',
        {1} '',
        {2} '',
        {3} 'No Particle Shader',
        {4} 'Edge Effect - Inverse',
        {5} 'Membrane Shader - Affect Skin Only'
      ])),
      wbByteArray('Unused', 3),
      wbInteger('Membrane Shader - Source Blend Mode', itU32, wbBlendModeEnum),
      wbInteger('Membrane Shader - Blend Operation', itU32, wbBlendOpEnum),
      wbInteger('Membrane Shader - Z Test Function', itU32, wbZTestFuncEnum),
      wbStruct('Fill/Texture Effect - Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbFloat('Fill/Texture Effect - Alpha Fade In Time'),
      wbFloat('Fill/Texture Effect - Full Alpha Time'),
      wbFloat('Fill/Texture Effect - Alpha Fade Out Time'),
      wbFloat('Fill/Texture Effect - Presistent Alpha Ratio'),
      wbFloat('Fill/Texture Effect - Alpha Pulse Amplitude'),
      wbFloat('Fill/Texture Effect - Alpha Pulse Frequency'),
      wbFloat('Fill/Texture Effect - Texture Animation Speed (U)'),
      wbFloat('Fill/Texture Effect - Texture Animation Speed (V)'),
      wbFloat('Edge Effect - Fall Off'),
      wbStruct('Edge Effect - Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbFloat('Edge Effect - Alpha Fade In Time'),
      wbFloat('Edge Effect - Full Alpha Time'),
      wbFloat('Edge Effect - Alpha Fade Out Time'),
      wbFloat('Edge Effect - Persistent Alpha Ratio'),
      wbFloat('Edge Effect - Alpha Pulse Amplitude'),
      wbFloat('Edge Effect - Alpha Pusle Frequence'),
      wbFloat('Fill/Texture Effect - Full Alpha Ratio'),
      wbFloat('Edge Effect - Full Alpha Ratio'),
      wbInteger('Membrane Shader - Dest Blend Mode', itU32, wbBlendModeEnum),
      wbInteger('Particle Shader - Source Blend Mode', itU32, wbBlendModeEnum),
      wbInteger('Particle Shader - Blend Operation', itU32, wbBlendOpEnum),
      wbInteger('Particle Shader - Z Test Function', itU32, wbZTestFuncEnum),
      wbInteger('Particle Shader - Dest Blend Mode', itU32, wbBlendModeEnum),
      wbFloat('Particle Shader - Particle Birth Ramp Up Time'),
      wbFloat('Particle Shader - Full Particle Birth Time'),
      wbFloat('Particle Shader - Particle Birth Ramp Down Time'),
      wbFloat('Particle Shader - Full Particle Birth Ratio'),
      wbFloat('Particle Shader - Persistant Particle Birth Ratio'),
      wbFloat('Particle Shader - Particle Lifetime'),
      wbFloat('Particle Shader - Particle Lifetime +/-'),
      wbFloat('Particle Shader - Initial Speed Along Normal'),
      wbFloat('Particle Shader - Acceleration Along Normal'),
      wbFloat('Particle Shader - Initial Velocity #1'),
      wbFloat('Particle Shader - Initial Velocity #2'),
      wbFloat('Particle Shader - Initial Velocity #3'),
      wbFloat('Particle Shader - Acceleration #1'),
      wbFloat('Particle Shader - Acceleration #2'),
      wbFloat('Particle Shader - Acceleration #3'),
      wbFloat('Particle Shader - Scale Key 1'),
      wbFloat('Particle Shader - Scale Key 2'),
      wbFloat('Particle Shader - Scale Key 1 Time'),
      wbFloat('Particle Shader - Scale Key 2 Time'),
      wbStruct('Color Key 1 - Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Color Key 2 - Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Color Key 3 - Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbFloat('Color Key 1 - Color Alpha'),
      wbFloat('Color Key 2 - Color Alpha'),
      wbFloat('Color Key 3 - Color Alpha'),
      wbFloat('Color Key 1 - Color Key Time'),
      wbFloat('Color Key 2 - Color Key Time'),
      wbFloat('Color Key 3 - Color Key Time'),
      wbFloat('Particle Shader - Initial Speed Along Normal +/-'),
      wbFloat('Particle Shader - Initial Rotation (deg)'),
      wbFloat('Particle Shader - Initial Rotation (deg) +/-'),
      wbFloat('Particle Shader - Rotation Speed (deg/sec)'),
      wbFloat('Particle Shader - Rotation Speed (deg/sec) +/-'),
      wbFormIDCk('Addon Models', [DEBR, NULL]),
      wbFloat('Holes - Start Time'),
      wbFloat('Holes - End Time'),
      wbFloat('Holes - Start Val'),
      wbFloat('Holes - End Val'),
      wbFloat('Edge Width (alpha units)'),
      wbStruct('Edge Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbFloat('Explosion Wind Speed'),
      wbInteger('Texture Count U', itU32),
      wbInteger('Texture Count V', itU32),
      wbFloat('Addon Models - Fade In Time'),
      wbFloat('Addon Models - Fade Out Time'),
      wbFloat('Addon Models - Scale Start'),
      wbFloat('Addon Models - Scale End'),
      wbFloat('Addon Models - Scale In Time'),
      wbFloat('Addon Models - Scale Out Time')
    ], cpNormal, True, nil, 57)
  ], False, nil, cpNormal, False, wbEFSHAfterLoad);

  wbRecord(ENCH, 'Object Effect', [
    wbEDIDReq,
    wbFULL,
    wbStruct(ENIT, 'Effect Data', [
      wbInteger('Type', itU32, wbEnum([
        {0} '',
        {1} '',
        {2} 'Weapon',
        {3} 'Apparel'
      ])),
      wbByteArray('Unused', 4),
      wbByteArray('Unused', 4),
      wbInteger('Flags', itU8, wbFlags([
        'No Auto-Calc',
        '',
        'Hide Effect'
      ])),
      wbByteArray('Unused', 3)
    ], cpNormal, True),
    wbEffectsReq
  ]);

  wbRecord(EYES, 'Eyes', [
    wbEDIDReq,
    wbFULLReq,
    wbString(ICON, 'Texture', 0{, cpNormal, True??}),
    wbInteger(DATA, 'Flags', itU8, wbFlags([
      'Playable',
      'Not Male',
      'Not Female'
    ]), cpNormal, True)
  ]);

  var wbFactionRank :=
    wbRStructSK([0], 'Rank', [
      wbInteger(RNAM, 'Rank#', itS32),
      wbString(MNAM, 'Male', 0, cpTranslate),
      wbString(FNAM, 'Female', 0, cpTranslate),
      wbString(INAM, 'Insignia (Unused)')
    ], []);

  wbRecord(FACT, 'Faction', [
    wbEDIDReq,
    wbFULL,
    wbFactionRelations,
    wbStruct(DATA, '', [
      wbInteger('Flags 1', itU8, wbFlags([
        'Hidden from PC',
        'Evil',
        'Special Combat'
      ])),
      wbInteger('Flags 2', itU8, wbFlags([
        'Track Crime',
        'Allow Sell'
      ])),
      wbByteArray('Unused', 2)
    ], cpNormal, True, nil, 1),
    wbFloat(CNAM, 'Unused'),
    wbRArrayS('Ranks', wbFactionRank)
  ], False, nil, cpNormal, False, wbFACTAfterLoad);

  wbRecord(FURN, 'Furniture', [
    wbEDIDReq,
    wbOBND(True),
    wbFULL,
    wbGenericModel(True),
    wbSCRI,
    wbDEST,
    wbByteArray(MNAM, 'Marker Flags', 0, cpNormal, True)
  ]);

  wbRecord(GLOB, 'Global', [
    wbEDIDReq,
    wbInteger(FNAM, 'Type', itU8, wbEnum([], [
      Ord('s'), 'Short',
      Ord('l'), 'Long',
      Ord('f'), 'Float'
    ]), cpNormal, True).SetDefaultEditValue('Float'),
    wbFloat(FLTV, 'Value', cpNormal, True)
  ]);


  wbRecord(GMST, 'Game Setting', [
    wbString(EDID, 'Editor ID', 0, cpCritical, True, nil, wbGMSTEDIDAfterSet),
    wbUnion(DATA, 'Value', wbGMSTUnionDecider, [
      wbString('', 0, cpTranslate),
      wbInteger('', itS32),
      wbFloat('')
    ], cpNormal, True)
  ]);

  wbDODT := wbStruct(DODT, 'Decal Data', [
              wbFloat('Min Width'),
              wbFloat('Max Width'),
              wbFloat('Min Height'),
              wbFloat('Max Height'),
              wbFloat('Depth'),
              wbFloat('Shininess'),
              wbStruct('Parallax', [
                wbFloat('Scale'),
                wbInteger('Passes', itU8)
              ]),
              wbInteger('Flags', itU8, wbFlags([
                'Parallax',
                'Alpha - Blending',
                'Alpha - Testing'
              ], True)),
              wbByteArray('Unused', 2),
              wbStruct('Color', [
                wbInteger('Red', itU8),
                wbInteger('Green', itU8),
                wbInteger('Blue', itU8),
                wbByteArray('Unused', 1)
              ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA)
            ]);

  wbRecord(TXST, 'Texture Set', [
    wbEDIDReq,
    wbOBND(True),
    wbRStruct('Textures (RGB/A)', [
      wbString(TX00,'Base Image / Transparency'),
      wbString(TX01,'Normal Map / Specular'),
      wbString(TX02,'Environment Map Mask / ?'),
      wbString(TX03,'Glow Map / Unused'),
      wbString(TX04,'Parallax Map / Unused'),
      wbString(TX05,'Environment Map / Unused')
    ], []),
    wbDODT,
    wbInteger(DNAM, 'Flags', itU16, wbFlags([
      'No Specular Map'
    ]), cpNormal, True)
  ]);

  wbRecord(MICN, 'Menu Icon', [
    wbEDIDReq,
    wbICONReq
  ]);

  wbRecord(HDPT, 'Head Part', [
    wbEDIDReq,
    wbFULLReq,
    wbGenericModel,
    wbInteger(DATA, 'Flags', itU8, wbFlags([
      'Playable'
    ]), cpNormal, True),
    wbRArrayS('Extra Parts',
      wbFormIDCk(HNAM, 'Part', [HDPT])
    )
  ]);

  wbRecord(ASPC, 'Acoustic Space', [
    wbEDIDReq,
    wbOBND(True),
    wbFormIDCk(SNAM, 'Sound - Looping', [SOUN]),
    wbFormIDCk(RDAT, 'Use Sound from Region (Interiors Only)', [REGN]),
    wbInteger(ANAM, 'Environment Type', itU32, wbEnum([
      'None',
      'Default',
      'Generic',
      'Padded Cell',
      'Room',
      'Bathroom',
      'Livingroom',
      'Stone Room',
      'Auditorium',
      'Concerthall',
      'Cave',
      'Arena',
      'Hangar',
      'Carpeted Hallway',
      'Hallway',
      'Stone Corridor',
      'Alley',
      'Forest',
      'City',
      'Mountains',
      'Quarry',
      'Plain',
      'Parkinglot',
      'Sewerpipe',
      'Underwater',
      'Small Room',
      'Medium Room',
      'Large Room',
      'Medium Hall',
      'Large Hall',
      'Plate'
    ]), cpNormal, True)
  ]);

  wbRecord(TACT, 'Talking Activator', [
    wbEDIDReq,
    wbOBND(True),
    wbFULL,
    wbGenericModel(True),
    wbSCRI,
    wbDEST,
    wbFormIDCk(SNAM, 'Sound', [SOUN]),
    wbFormIDCk(VNAM, 'Voice Type', [VTYP])
  ]);

  wbRecord(SCPT, 'Script', [
    wbEDIDReq,
    wbSCHRReq,
    wbByteArray(SCDA, 'Compiled Script'),
    wbStringScript(SCTX, 'Script Source', 0, cpNormal{, True}),
    wbRArrayS('Local Variables', wbRStructSK([0], 'Local Variable', [
      wbSLSD,
      wbString(SCVR, 'Name', 0, cpCritical, True)
    ], [])),
    wbSCROs
  ]).SetToStr(wbScriptToStr);

  wbRecord(TERM, 'Terminal', [
    wbEDIDReq,
    wbOBND(True),
    wbFULL,
    wbGenericModel,
    wbSCRI,
    wbDEST,
    wbDESCReq,
    wbFormIDCk(SNAM, 'Sound - Looping', [SOUN]),
    wbFormIDCk(PNAM, 'Password Note', [NOTE]),
    wbStruct(DNAM, '', [
      wbInteger('Base Hacking Difficulty', itU8, wbEnum([
        'Very Easy',
        'Easy',
        'Average',
        'Hard',
        'Very Hard',
        'Requires Key'
      ])),
      wbInteger('Flags', itU8, wbFlags([
        'Leveled',
        'Unlocked',
        'Alternate Colors',
        'Hide Welcome Text when displaying Image'
      ])),
      wbInteger('ServerType', itU8, wbEnum([
        '-Server 1-',
        '-Server 2-',
        '-Server 3-',
        '-Server 4-',
        '-Server 5-',
        '-Server 6-',
        '-Server 7-',
        '-Server 8-',
        '-Server 9-',
        '-Server 10-'
      ])),
      wbByteArray('Unused', 1)
    ], cpNormal, True),
    wbRArray('Menu Items',
      wbRStruct('Menu Item', [
        wbStringKC(ITXT, 'Item Text', 0, cpTranslate),
        wbStringKC(RNAM, 'Result Text', 0, cpTranslate, True),
        wbInteger(ANAM, 'Flags', itU8, wbFlags([
          'Add Note',
          'Force Redraw'
        ]), cpNormal, True),
        wbFormIDCk(INAM, 'Display Note', [NOTE]),
        wbFormIDCk(TNAM, 'Sub Menu', [TERM]),
        wbEmbeddedScriptReq,
        wbCTDAs
      ], [])
    )
  ]);

  var wbStaticPart :=
    wbRStruct('Part', [
      wbFormIDCk(ONAM, 'Static', [STAT]),
      wbArrayS(DATA, 'Placements', wbStruct('Placement', [
        wbStruct('Position', [
          wbFloat('X'),
          wbFloat('Y'),
          wbFloat('Z')
        ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),
        wbStruct('Rotation', [
          wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
          wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
          wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
        ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),
        wbFloat('Scale')
      ]), 0, cpNormal, True)
    ], [], cpNormal, True);

  wbRecord(SCOL, 'Static Collection', [
    wbEDIDReq,
    wbOBND(True),
    wbGenericModel(True),
    wbRArray('Parts', wbStaticPart, cpNormal, True)
  ]);

  wbRecord(MSTT, 'Moveable Static', [
    wbEDIDReq,
    wbOBND(True),
    wbFULL,
    wbGenericModel(True),
    wbDEST,
    wbByteArray(DATA, 'Unknown', 1, cpNormal, True),
    wbFormIDCk(SNAM, 'Sound', [SOUN])
  ]);

  wbRecord(PWAT, 'Placeable Water', [
    wbEDIDReq,
    wbOBND(True),
    wbGenericModel(True),
    wbStruct(DNAM, '', [
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001}'Reflects',
        {0x00000002}'Reflects - Actors',
        {0x00000004}'Reflects - Land',
        {0x00000008}'Reflects - LOD Land',
        {0x00000010}'Reflects - LOD Buildings',
        {0x00000020}'Reflects - Trees',
        {0x00000040}'Reflects - Sky',
        {0x00000080}'Reflects - Dynamic Objects',
        {0x00000100}'Reflects - Dead Bodies',
        {0x00000200}'Refracts',
        {0x00000400}'Refracts - Actors',
        {0x00000800}'Refracts - Land',
        {0x00001000}'',
        {0x00002000}'',
        {0x00004000}'',
        {0x00008000}'',
        {0x00010000}'Refracts - Dynamic Objects',
        {0x00020000}'Refracts - Dead Bodies',
        {0x00040000}'Silhouette Reflections',
        {0x00080000}'',
        {0x00100000}'',
        {0x00200000}'',
        {0x00400000}'',
        {0x00800000}'',
        {0x01000000}'',
        {0x02000000}'',
        {0x03000000}'',
        {0x08000000}'',
        {0x10000000}'Depth',
        {0x20000000}'Object Texture Coordinates',
        {0x40000000}'',
        {0x80000000}'No Underwater Fog'
      ])),
      wbFormIDCk('Water', [WATR])
    ], cpNormal, True)
  ]);

  wbRecord(IDLM, 'Idle Marker', [
    wbEDIDReq,
    wbOBND(True),
    wbInteger(IDLF, 'Flags', itU8, wbFlags([
      'Run in Sequence',
      '',
      'Do Once'
    ]), cpNormal, True),
    wbStruct(IDLC, '', [
      wbInteger('Animation Count', itU8),
      wbByteArray('Unused', 3)
    ], cpNormal, True, nil, 1),
    wbFloat(IDLT, 'Idle Timer Setting', cpNormal, True),
    wbArray(IDLA, 'Animations', wbFormIDCk('Animation', [IDLE, NULL]), 0, nil, wbIDLAsAfterSet, cpNormal, True)  // NULL looks valid if IDLS\Animation Count is 0
  ], False, nil, cpNormal, False, nil, wbAnimationsAfterSet);

  wbRecord(NOTE, 'Note', [
    wbEDIDReq,
    wbOBND(True),
    wbFULL,
    wbGenericModel,
    wbICON,
    wbYNAM,
    wbZNAM,
    wbInteger(DATA, 'Type', itU8, wbEnum([
      'Sound',
      'Text',
      'Image',
      'Voice'
    ]), cpNormal, True),
    wbRArrayS('Quests',
      wbFormIDCkNoReach(ONAM, 'Quest', [QUST])
    ),
    wbString(XNAM, 'Texture'),
    wbUnion(TNAM, 'Text / Topic', wbNOTETNAMDecide, [
      wbStringKC('Text'),
      wbFormIDCk('Topic', [DIAL])
    ]),
    wbUnion(SNAM, 'Sound / NPC', wbNOTESNAMDecide, [
      wbFormIDCk('Sound', [SOUN]),
      wbFormIDCk('NPC', [NPC_])
    ])
  ]);

end;

procedure DefineFO3e;
begin
  wbRecord(PROJ, 'Projectile', [
    wbEDIDReq,
    wbOBND(True),
    wbFULL,
    wbGenericModel(True),
    wbDEST,
    wbStruct(DATA, 'Data', [
      {00} wbInteger('Flags', itU16, wbFlags([
        'Hitscan',
        'Explosion',
        'Alt. Trigger',
        'Muzzle Flash',
        '',
        'Can Be Disabled',
        'Can Be Picked Up',
        'Supersonic',
        'Pins Limbs',
        'Pass Through Small Transparent'
      ])),
      {00} wbInteger('Type', itU16, wbEnum([
        {00} '',
        {01} 'Missile',
        {02} 'Lobber',
        {03} '',
        {04} 'Beam',
        {05} '',
        {06} '',
        {07} '',
        {08} 'Flame'
      ])),
      {04} wbFloat('Gravity'),
      {08} wbFloat('Speed'),
      {12} wbFloat('Range'),
      {16} wbFormIDCk('Light', [LIGH, NULL]),
      {20} wbFormIDCk('Muzzle Flash - Light', [LIGH, NULL]),
      {24} wbFloat('Tracer Chance'),
      {28} wbFloat('Explosion - Alt. Trigger - Proximity'),
      {32} wbFloat('Explosion - Alt. Trigger - Timer'),
      {36} wbFormIDCk('Explosion', [EXPL, NULL]),
      {40} wbFormIDCk('Sound', [SOUN, NULL]),
      {44} wbFloat('Muzzle Flash - Duration'),
      {48} wbFloat('Fade Duration'),
      {52} wbFloat('Impact Force'),
      {56} wbFormIDCk('Sound - Countdown', [SOUN, NULL]),
      {60} wbFormIDCk('Sound - Disable', [SOUN, NULL]),
      {64} wbFormIDCk('Default Weapon Source', [WEAP, NULL])
    ], cpNormal, True),
    wbRStructSK([0], 'Muzzle Flash Model', [
      wbString(NAM1, 'Model FileName'),
      wbModelInfo(NAM2)
    ], [], cpNormal, True)
    .SetSummaryKey([0])
    .IncludeFlag(dfCollapsed, wbCollapseModels),
    wbInteger(VNAM, 'Sound Level', itU32, wbSoundLevelEnum, cpNormal, True)
  ]);

  wbRecord(NAVI, 'Navigation Mesh Info Map', [
    wbEDID,
    wbInteger(NVER, 'Version', itU32),
    wbRArray('Navigation Map Infos',
      wbStruct(NVMI, 'Navigation Map Info', [
        wbByteArray('Unknown', 4),
        wbFormIDCk('Navigation Mesh', [NAVM]),
        wbFormIDCk('Location', [CELL, WRLD]),
        wbStruct('Grid', [
          wbInteger('X', itS16),
          wbInteger('Y', itS16)
        ]),
        wbUnknown
{        wbUnion('Data', wbNAVINVMIDecider, [
          wbStruct('Data', [
            wbUnknown
          ]),
          wbStruct('Data', [
            wbArray('Unknown', wbFloat('Unknown'), 3),
            wbByteArray('Unknown', 4)
          ]),
          wbStruct('Data', [
            wbArray('Unknown', wbArray('Unknown', wbFloat('Unknown'), 3), 3),
            wbInteger('Count 1', itU16),
            wbInteger('Count 2', itU16),
            wbArray('Unknown', wbArray('Unknown', wbFloat('Unknown'), 3), [], wbNAVINAVMGetCount1),
            wbUnknown
          ]),
          wbStruct('Data', [
            wbUnknown
          ])
        ])}
      ])
    ),
    wbRArray('Navigation Connection Infos',
      wbStruct(NVCI, 'Navigation Connection Info', [
        wbFormIDCk('Unknown', [NAVM]),
        wbArray('Unknown', wbFormIDCk('Unknown', [NAVM]), -1),
        wbArray('Unknown', wbFormIDCk('Unknown', [NAVM]), -1),
        wbArray('Doors', wbFormIDCk('Door', [REFR]), -1)
      ])
    )
  ]);

  if wbSimpleRecords then begin

    wbRecord(NAVM, 'Navigation Mesh', [
      wbEDID,
      wbInteger(NVER, 'Version', itU32),
      wbStruct(DATA, '', [
        wbFormIDCk('Cell', [CELL]),
        wbInteger('Vertex Count', itU32),
        wbInteger('Triangle Count', itU32),
        wbInteger('External Connections Count', itU32),
        wbInteger('Cover Triangle Count', itU32),
        wbInteger('Doors Count', itU32)
      ]),
      wbByteArray(NVVX, 'Vertices'),
      wbByteArray(NVTR, 'Triangles'),
      wbByteArray(NVCA, 'Cover Triangles'),
      wbArray(NVDP, 'Doors', wbStruct('Door', [
        wbFormIDCk('Reference', [REFR]),
        wbInteger('Triangle', itU16),
        wbByteArray('Unused', 2)
      ])).IncludeFlag(dfNotAlignable),
      wbByteArray(NVGD, 'NavMesh Grid'),
      wbArray(NVEX, 'External Connections', wbStruct('Connection', [
        wbByteArray('Unknown', 4),
        wbFormIDCk('Navigation Mesh', [NAVM], False, cpNormal),
        wbInteger('Triangle', itU16, nil, cpNormal)
      ])).IncludeFlag(dfNotAlignable)
    ], False, wbNAVMAddInfo);

  end else begin

    wbRecord(NAVM, 'Navigation Mesh', [
      wbEDID,
      wbInteger(NVER, 'Version', itU32),
      wbStruct(DATA, '', [
        wbFormIDCk('Cell', [CELL]),
        wbInteger('Vertex Count', itU32),
        wbInteger('Triangle Count', itU32),
        wbInteger('External Connections Count', itU32),
        wbInteger('Cover Triangle Count', itU32),
        wbInteger('Doors Count', itU32) // as of version = 5 (earliest NavMesh version I saw (Fallout3 1.7) is already 11)
      ]),
      wbArray(NVVX, 'Vertices', wbStruct('Vertex', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3)).IncludeFlag(dfNotAlignable),
      wbArray(NVTR, 'Triangles', wbStruct('Triangle', [
        wbArray('Vertices', wbInteger('Vertex', itS16), 3),
        wbArray('Edges', wbInteger('Triangle', itS16, wbNVTREdgeToStr, wbNVTREdgeToInt), [
          '0 <-> 1',
          '1 <-> 2',
          '2 <-> 0'
        ]),
        wbInteger('Flags', itU16, wbFlags([
          'Edge 0 <-> 1 external',  // 0 $0001 1
          'Edge 1 <-> 2 external',  // 1 $0002 2
          'Edge 2 <-> 0 external',  // 2 $0004 4
          '',                       // 3 $0008 8
          'No Large Creatures',     // 4 $0010 16
          'Overlapping',            // 5 $0020 32
          'Preferred',              // 6 $0040 64
          '',                       // 7 $0080 128
          'Unknown 9',              // 8 $0100 256  used in SSE CK source according to Nukem
          'Water',                  // 9 $0200 512
          'Door',                   //10 $0400 1024
          'Found',                  //11 $0800 2048
          'Unknown 13',             //12 $1000 4096 used in SSE CK source according to Nukem
          '',                       //13 $2000 \
          '',                       //14 $4000  |-- used as 3 bit counter inside CK, probably stripped before save
          ''                        //15 $8000 /
        ])),
        { Flags below are wrong. The first 4 bit are an enum as follows:
        0000 = Open Edge No Cover
        1000 = wall no cover
        0100 = ledge cover
        1100 = UNUSED
        0010 = cover  64
        1010 = cover  80
        0110 = cover  96
        1110 = cover 112
        0001 = cover 128
        1001 = cover 144
        0101 = cover 160
        1101 = cover 176
        0011 = cover 192
        1011 = cover 208
        0111 = cover 224
        1111 = max cover
        then 2 bit flags, then another such enum, and the rest is probably flags.
        Can't properly represent that with current record definition methods.
        }
        wbInteger('Cover Flags', itU16, wbFlags([
          'Edge 0 <-> 1 Cover Value 1/4',
          'Edge 0 <-> 1 Cover Value 2/4',
          'Edge 0 <-> 1 Cover Value 3/4',
          'Edge 0 <-> 1 Cover Value 4/4',
          'Edge 0 <-> 1 Left',
          'Edge 0 <-> 1 Right',
          'Edge 1 <-> 2 Cover Value 1/4',
          'Edge 1 <-> 2 Cover Value 2/4',
          'Edge 1 <-> 2 Cover Value 3/4',
          'Edge 1 <-> 2 Cover Value 4/4',
          'Edge 1 <-> 2 Left',
          'Edge 1 <-> 2 Right',
          'Unknown 13',
          'Unknown 14',
          'Unknown 15',
          'Unknown 16'
        ]))
      ])).IncludeFlag(dfNotAlignable),
      wbArray(NVCA, 'Cover Triangles', wbInteger('Cover Triangle', itS16)).IncludeFlag(dfNotAlignable),
      wbArray(NVDP, 'Doors', wbStruct('Door', [
        wbFormIDCk('Reference', [REFR]),
        wbInteger('Triangle', itU16),
        wbByteArray('Unused', 2)
      ])).IncludeFlag(dfNotAlignable),
      wbStruct(NVGD, 'NavMesh Grid', [
        wbInteger('NavMeshGrid Divisor', itU32),
        wbFloat('Max X Distance'),                // Floats named after TES5 definition
        wbFloat('Max Y Distance'),
        wbFloat('Min X'),
        wbFloat('Min Y'),
        wbFloat('Min Z'),
        wbFloat('Max X'),
        wbFloat('Max Y'),
        wbFloat('Max Z'),
        wbArray('Cells', wbArray('Cell', wbInteger('Triangle', itS16).IncludeFlag(dfNotAlignable), -2)).IncludeFlag(dfNotAlignable) // Divisor is row count? , assumed triangle as the values fit the triangle id's
      ]),
      wbArray(NVEX, 'External Connections', wbStruct('Connection', [
        wbByteArray('Unknown', 4),
        wbFormIDCk('Navigation Mesh', [NAVM], False, cpNormal),
        wbInteger('Triangle', itU16, nil, cpNormal)
      ])).IncludeFlag(dfNotAlignable)
    ], False, wbNAVMAddInfo);

  end;

  wbRefRecord(PGRE, 'Placed Grenade', [
    wbEDID,
    wbFormIDCk(NAME, 'Base', [PROJ], False, cpNormal, True),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),

    wbXRGD,
    wbXRGB,

    {--- Patrol Data ---}
    wbRStruct('Patrol Data', [
      wbFloat(XPRD, 'Idle Time', cpNormal, True),
      wbEmpty(XPPA, 'Patrol Script Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, 'Topic', [DIAL, NULL], False, cpNormal, True)
    ], []),

    {--- Ownership ---}
    wbOwnership(wbXOWN, [XCMT, XCMO]),

    {--- Extra ---}
    wbInteger(XCNT, 'Count', itS32),
    wbFloat(XRDS, 'Radius'),
    wbFloat(XHLP, 'Health'),

    {--- Reflected By / Refracted By ---}
    wbRArrayS('Reflected/Refracted By',
      wbStructSK(XPWR, [0], 'Water', [
        wbFormIDCk('Reference', [REFR]),
        wbInteger('Type', itU32, wbFlags([
          'Reflection',
          'Refraction'
        ]))
      ])
    ),

    {--- Decals ---}
    wbRArrayS('Linked Decals',
      wbStructSK(XDCR, [0], 'Decal', [
        wbFormIDCk('Reference', [REFR]),
        wbUnknown
      ])
    ),

    {--- Linked Ref ---}
    wbFormIDCk(XLKR, 'Linked Reference', [REFR, ACRE, ACHR, PGRE, PMIS, PBEA, PLYR]),
    wbStruct(XCLP, 'Linked Reference Color', [
      wbStruct('Link Start Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Link End Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA)
    ]),

    {--- Activate Parents ---}
    wbRStruct('Activate Parents', [
      wbInteger(XAPD, 'Flags', itU8, wbFlags([
        'Parent Activate Only'
      ], True)),
      wbRArrayS('Activate Parent Refs',
        wbStructSK(XAPR, [0], 'Activate Parent Ref', [
          wbFormIDCk('Reference', [REFR, ACRE, ACHR, PGRE, PMIS, PBEA, PLYR]),
          wbFloat('Delay')
        ])
      )
    ], []),

    {--- Enable Parent ---}
    wbXESP,

    {--- Emittance ---}
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),

    {--- Flags ---}
    wbEmpty(XIBS, 'Ignored By Sandbox'),

    {--- 3D Data ---}
    wbXSCL,
    wbDATAPosRot
  ], True, wbPlacedAddInfo);

  wbRefRecord(PMIS, 'Placed Missile', [
    wbEDID,
    wbFormIDCk(NAME, 'Base', [PROJ], False, cpNormal, True),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),

    wbXRGD,
    wbXRGB,

    {--- Patrol Data ---}
    wbRStruct('Patrol Data', [
      wbFloat(XPRD, 'Idle Time', cpNormal, True),
      wbEmpty(XPPA, 'Patrol Script Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, 'Topic', [DIAL, NULL], False, cpNormal, True)
    ], []),

    {--- Ownership ---}
    wbOwnership(wbXOWN, [XCMT, XCMO]),

    {--- Extra ---}
    wbInteger(XCNT, 'Count', itS32),
    wbFloat(XRDS, 'Radius'),
    wbFloat(XHLP, 'Health'),

    {--- Reflected By / Refracted By ---}
    wbRArrayS('Reflected/Refracted By',
      wbStructSK(XPWR, [0], 'Water', [
        wbFormIDCk('Reference', [REFR]),
        wbInteger('Type', itU32, wbFlags([
          'Reflection',
          'Refraction'
        ]))
      ])
    ),

    {--- Decals ---}
    wbRArrayS('Linked Decals',
      wbStructSK(XDCR, [0], 'Decal', [
        wbFormIDCk('Reference', [REFR]),
        wbUnknown
      ])
    ),

    {--- Linked Ref ---}
    wbFormIDCk(XLKR, 'Linked Reference', [REFR, ACRE, ACHR, PGRE, PMIS, PBEA, PLYR]),
    wbStruct(XCLP, 'Linked Reference Color', [
      wbStruct('Link Start Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Link End Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA)
    ]),

    {--- Activate Parents ---}
    wbRStruct('Activate Parents', [
      wbInteger(XAPD, 'Flags', itU8, wbFlags([
        'Parent Activate Only'
      ], True)),
      wbRArrayS('Activate Parent Refs',
        wbStructSK(XAPR, [0], 'Activate Parent Ref', [
          wbFormIDCk('Reference', [REFR, ACRE, ACHR, PGRE, PMIS, PBEA, PLYR]),
          wbFloat('Delay')
        ])
      )
    ], []),

    {--- Enable Parent ---}
    wbXESP,

    {--- Emittance ---}
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),

    {--- Flags ---}
    wbEmpty(XIBS, 'Ignored By Sandbox'),

    {--- 3D Data ---}
    wbXSCL,
    wbDATAPosRot
  ], True, wbPlacedAddInfo);

  wbRefRecord(PBEA, 'Placed Beam', [
    wbEDID,
    wbFormIDCk(NAME, 'Base', [PROJ], False, cpNormal, True),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),

    wbXRGD,
    wbXRGB,

    {--- Patrol Data ---}
    wbRStruct('Patrol Data', [
      wbFloat(XPRD, 'Idle Time', cpNormal, True),
      wbEmpty(XPPA, 'Patrol Script Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, 'Topic', [DIAL, NULL], False, cpNormal, True)
    ], []),

    {--- Ownership ---}
    wbOwnership(wbXOWN, [XCMT, XCMO]),

    {--- Extra ---}
    wbInteger(XCNT, 'Count', itS32),
    wbFloat(XRDS, 'Radius'),
    wbFloat(XHLP, 'Health'),

    {--- Reflected By / Refracted By ---}
    wbRArrayS('Reflected/Refracted By',
      wbStructSK(XPWR, [0], 'Water', [
        wbFormIDCk('Reference', [REFR]),
        wbInteger('Type', itU32, wbFlags([
          'Reflection',
          'Refraction'
        ]))
      ])
    ),

    {--- Decals ---}
    wbRArrayS('Linked Decals',
      wbStructSK(XDCR, [0], 'Decal', [
        wbFormIDCk('Reference', [REFR]),
        wbUnknown
      ])
    ),

    {--- Linked Ref ---}
    wbFormIDCk(XLKR, 'Linked Reference', [REFR, ACRE, ACHR, PGRE, PMIS, PBEA, PLYR]),
    wbStruct(XCLP, 'Linked Reference Color', [
      wbStruct('Link Start Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Link End Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA)
    ]),

    {--- Activate Parents ---}
    wbRStruct('Activate Parents', [
      wbInteger(XAPD, 'Flags', itU8, wbFlags([
        'Parent Activate Only'
      ], True)),
      wbRArrayS('Activate Parent Refs',
        wbStructSK(XAPR, [0], 'Activate Parent Ref', [
          wbFormIDCk('Reference', [REFR, ACRE, ACHR, PGRE, PMIS, PBEA, PLYR]),
          wbFloat('Delay')
        ])
      )
    ], []),

    {--- Enable Parent ---}
    wbXESP,

    {--- Emittance ---}
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),

    {--- Flags ---}
    wbEmpty(XIBS, 'Ignored By Sandbox'),

    {--- 3D Data ---}
    wbXSCL,
    wbDATAPosRot
  ], True, wbPlacedAddInfo);

   wbRecord(EXPL, 'Explosion', [
    wbEDIDReq,
    wbOBND(True),
    wbFULL,
    wbGenericModel,
    wbEITM,
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD]),
    wbStruct(DATA, 'Data', [
      {00} wbFloat('Force'),
      {04} wbFloat('Damage'),
      {08} wbFloat('Radius'),
      {12} wbFormIDCk('Light', [LIGH, NULL]),
      {16} wbFormIDCk('Sound 1', [SOUN, NULL]),
      {20} wbInteger('Flags', itU32, wbFlags([
             {0x00000001}'Unknown 1',
             {0x00000002}'Always Uses World Orientation',
             {0x00000004}'Knock Down - Always',
             {0x00000008}'Knock Down - By Formula',
             {0x00000010}'Ignore LOS Check',
             {0x00000020}'Push Explosion Source Ref Only',
             {0x00000040}'Ignore Image Space Swap'
           ])),
      {24} wbFloat('IS Radius'),
      {28} wbFormIDCk('Impact DataSet', [IPDS, NULL]),
      {32} wbFormIDCk('Sound 2', [SOUN, NULL]),
           wbStruct('Radiation', [
             {36} wbFloat('Level'),
             {40} wbFloat('Dissipation Time'),
             {44} wbFloat('Radius')
           ]),
      {48} wbInteger('Sound Level', itU32, wbSoundLevelEnum, cpNormal, True)
    ], cpNormal, True),
    wbFormIDCk(INAM, 'Placed Impact Object', [TREE, SOUN, ACTI, DOOR, STAT, FURN,
          CONT, ARMO, AMMO, LVLN, LVLC, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS,
          ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM, TXST])
  ]);

  wbRecord(DEBR, 'Debris', [
    wbEDIDReq,
    wbRArray('Models', wbDebrisModel(wbMODT), cpNormal, True)
  ]);

  wbRecord(IMGS, 'Image Space', [
    wbEDIDReq,
    wbStruct(DNAM, '', [
      wbStruct('HDR', [
        {00} wbFloat('Eye Adapt Speed'),
        {04} wbFloat('Blur Radius'),
        {08} wbFloat('Blur Passes'),
        {12} wbFloat('Emissive Mult'),
        {16} wbFloat('Target LUM'),
        {20} wbFloat('Upper LUM Clamp'),
        {24} wbFloat('Bright Scale'),
        {28} wbFloat('Bright Clamp'),
        {32} wbFloat('LUM Ramp No Tex'),
        {36} wbFloat('LUM Ramp Min'),
        {40} wbFloat('LUM Ramp Max'),
        {44} wbFloat('Sunlight Dimmer'),
        {48} wbFloat('Grass Dimmer'),
        {52} wbFloat('Tree Dimmer'),
        {56} wbUnion('Skin Dimmer', wbIMGSSkinDimmerDecider, [
               wbFloat('Skin Dimmer'),
               wbEmpty('Skin Dimmer', cpIgnore)
             ])
      ], cpNormal, False, nil, 14),
      wbStruct('Bloom', [
        {60} wbFloat('Blur Radius'),
        {64} wbFloat('Alpha Mult Interior'),
        {68} wbFloat('Alpha Mult Exterior')
      ]),
      wbStruct('Get Hit', [
        {72} wbFloat('Blur Radius'),
        {76} wbFloat('Blur Damping Constant'),
        {80} wbFloat('Damping Constant')
      ]),
      wbStruct('Night Eye', [
        wbStruct('Tint Color', [
          {84} wbFloat('Red', cpNormal, False, 255, 0),
          {88} wbFloat('Green', cpNormal, False, 255, 0),
          {92} wbFloat('Blue', cpNormal, False, 255, 0)
        ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      {96} wbFloat('Brightness')
      ]),
      wbStruct('Cinematic', [
        {100} wbFloat('Saturation'),
        wbStruct('Contrast', [
          {104} wbFloat('Avg Lum Value'),
          {108} wbFloat('Value')
        ]),
        {112} wbFloat('Cinematic - Brightness - Value'),
        wbStruct('Tint', [
          wbStruct('Color', [
            {116} wbFloat('Red', cpNormal, False, 255, 0),
            {120} wbFloat('Green', cpNormal, False, 255, 0),
            {124} wbFloat('Blue', cpNormal, False, 255, 0)
          ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
        {128} wbFloat('Value')
        ])
      ]),
      wbByteArray('Unused', 4),
      wbByteArray('Unused', 4),
      wbByteArray('Unused', 4),
      wbByteArray('Unused', 4),
      wbInteger('Flags', itU8, wbFlags([
        'Saturation',
        'Contrast',
        'Tint',
        'Brightness'
      ], True)),
      wbByteArray('Unused', 3)
    ], cpNormal, True, nil, 5)
  ]);

  wbRecord(IMAD, 'Image Space Adapter', [
    wbEDID,
    wbStruct(DNAM, 'Data Count', [
      wbInteger('Flags', itU32, wbFlags(['Animatable'])),
      wbFloat('Duration'),
      wbStruct('HDR', [
        wbInteger('Eye Adapt Speed Mult', itU32),
        wbInteger('Eye Adapt Speed Add', itU32),
        wbInteger('Bloom Blur Radius Mult', itU32),
        wbInteger('Bloom Blur Radius Add', itU32),
        wbInteger('Bloom Threshold Mult', itU32),
        wbInteger('Bloom Threshold Add', itU32),
        wbInteger('Bloom Scale Mult', itU32),
        wbInteger('Bloom Scale Add', itU32),
        wbInteger('Target Lum Min Mult', itU32),
        wbInteger('Target Lum Min Add', itU32),
        wbInteger('Target Lum Max Mult', itU32),
        wbInteger('Target Lum Max Add', itU32),
        wbInteger('Sunlight Scale Mult', itU32),
        wbInteger('Sunlight Scale Add', itU32),
        wbInteger('Sky Scale Mult', itU32),
        wbInteger('Sky Scale Add', itU32)
      ]),
      wbInteger('Unknown08 Mult', itU32),
      wbInteger('Unknown48 Add', itU32),
      wbInteger('Unknown09 Mult', itU32),
      wbInteger('Unknown49 Add', itU32),
      wbInteger('Unknown0A Mult', itU32),
      wbInteger('Unknown4A Add', itU32),
      wbInteger('Unknown0B Mult', itU32),
      wbInteger('Unknown4B Add', itU32),
      wbInteger('Unknown0C Mult', itU32),
      wbInteger('Unknown4C Add', itU32),
      wbInteger('Unknown0D Mult', itU32),
      wbInteger('Unknown4D Add', itU32),
      wbInteger('Unknown0E Mult', itU32),
      wbInteger('Unknown4E Add', itU32),
      wbInteger('Unknown0F Mult', itU32),
      wbInteger('Unknown4F Add', itU32),
      wbInteger('Unknown10 Mult', itU32),
      wbInteger('Unknown50 Add', itU32),
      wbStruct('Cinematic', [
        wbInteger('Saturation Mult', itU32),
        wbInteger('Saturation Add', itU32),
        wbInteger('Brightness Mult', itU32),
        wbInteger('Brightness Add', itU32),
        wbInteger('Contrast Mult', itU32),
        wbInteger('Contrast Add', itU32)
      ]),
      wbInteger('Unknown14 Mult', itU32),
      wbInteger('Unknown54 Add', itU32),
      wbInteger('Tint Color', itU32),
      wbInteger('Blur Radius', itU32),
      wbInteger('Double Vision Strength', itU32),
      wbInteger('Radial Blur Strength', itU32),
      wbInteger('Radial Blur Ramp Up', itU32),
      wbInteger('Radial Blur Start', itU32),
      wbInteger('Radial Blur Flags', itU32, wbFlags(['Use Target'])),
      wbFloat('Radial Blur Center X'),
      wbFloat('Radial Blur Center Y'),
      wbInteger('DoF Strength', itU32),
      wbInteger('DoF Distance', itU32),
      wbInteger('DoF Range', itU32),
      wbInteger('DoF Flags', itU32, wbFlags(['Use Target'])),
      wbInteger('Radial Blur Ramp Down', itU32),
      wbInteger('Radial Blur Down Start', itU32),
      wbInteger('Fade Color', itU32),
      wbInteger('Motion Blur Strength', itU32)
    ], cpNormal, True, nil, 26),
    wbArray(BNAM, 'Blur Radius', wbTimeInterpolator),
    wbArray(VNAM, 'Double Vision Strength', wbTimeInterpolator),
    wbArray(TNAM, 'Tint Color', wbColorInterpolator),
    wbArray(NAM3, 'Fade Color', wbColorInterpolator),
    wbArray(RNAM, 'Radial Blur Strength', wbTimeInterpolator),
    wbArray(SNAM, 'Radial Blur Ramp Up', wbTimeInterpolator),
    wbArray(UNAM, 'Radial Blur Start', wbTimeInterpolator),
    wbArray(NAM1, 'Radial Blur Ramp Down', wbTimeInterpolator),
    wbArray(NAM2, 'Radial Blur Down Start', wbTimeInterpolator),
    wbArray(WNAM, 'DoF Strength', wbTimeInterpolator),
    wbArray(XNAM, 'DoF Distance', wbTimeInterpolator),
    wbArray(YNAM, 'DoF Range', wbTimeInterpolator),
    wbArray(NAM4, 'Motion Blur Strength', wbTimeInterpolator),
    wbRStruct('HDR', [
      wbArray(_00_IAD, 'Eye Adapt Speed Mult', wbTimeInterpolator),
      wbArray(_40_IAD, 'Eye Adapt Speed Add', wbTimeInterpolator),
      wbArray(_01_IAD, 'Bloom Blur Radius Mult', wbTimeInterpolator),
      wbArray(_41_IAD, 'Bloom Blur Radius Add', wbTimeInterpolator),
      wbArray(_02_IAD, 'Bloom Threshold Mult', wbTimeInterpolator),
      wbArray(_42_IAD, 'Bloom Threshold Add', wbTimeInterpolator),
      wbArray(_03_IAD, 'Bloom Scale Mult', wbTimeInterpolator),
      wbArray(_43_IAD, 'Bloom Scale Add', wbTimeInterpolator),
      wbArray(_04_IAD, 'Target Lum Min Mult', wbTimeInterpolator),
      wbArray(_44_IAD, 'Target Lum Min Add', wbTimeInterpolator),
      wbArray(_05_IAD, 'Target Lum Max Mult', wbTimeInterpolator),
      wbArray(_45_IAD, 'Target Lum Max Add', wbTimeInterpolator),
      wbArray(_06_IAD, 'Sunlight Scale Mult', wbTimeInterpolator),
      wbArray(_46_IAD, 'Sunlight Scale Add', wbTimeInterpolator),
      wbArray(_07_IAD, 'Sky Scale Mult', wbTimeInterpolator),
      wbArray(_47_IAD, 'Sky Scale Add', wbTimeInterpolator)
    ], []),
    wbUnknown(_08_IAD),
    wbUnknown(_48_IAD),
    wbUnknown(_09_IAD),
    wbUnknown(_49_IAD),
    wbUnknown(_0A_IAD),
    wbUnknown(_4A_IAD),
    wbUnknown(_0B_IAD),
    wbUnknown(_4B_IAD),
    wbUnknown(_0C_IAD),
    wbUnknown(_4C_IAD),
    wbUnknown(_0D_IAD),
    wbUnknown(_4D_IAD),
    wbUnknown(_0E_IAD),
    wbUnknown(_4E_IAD),
    wbUnknown(_0F_IAD),
    wbUnknown(_4F_IAD),
    wbUnknown(_10_IAD),
    wbUnknown(_50_IAD),
    wbCinematicIMAD,
    wbUnknown(_14_IAD),
    wbUnknown(_54_IAD)
  ]);

  wbRecord(FLST, 'FormID List', [
    wbString(EDID, 'Editor ID', 0, cpBenign, True, nil, wbFLSTEDIDAfterSet),
    wbRArrayS('FormIDs', wbFormID(LNAM, 'FormID'), cpNormal, False, nil, nil, nil, wbFLSTLNAMIsSorted)
  ]);

  var wbPerkConditions :=
    wbRStructSK([0], 'Perk Condition', [
      wbInteger(PRKC, 'Run On', itS8, wbPRKCToStr, wbPRKCToInt),
      wbCTDAsReq
    ], [], cpNormal, False, wbPERKPRKCDontShow, False, nil, nil);

  var wbPerkEffect :=
    wbRStructSK([0, 1], 'Effect', [
      wbStructSK(PRKE, [1, 2, 0], 'Header', [
        wbPerkEffectType(wbPERKPRKETypeAfterSet),
        wbInteger('Rank', itU8),
        wbInteger('Priority', itU8)
      ]),
      wbUnion(DATA, 'Effect Data', wbPerkDATADecider, [
        wbStructSK([0, 1], 'Quest + Stage', [
          wbFormIDCk('Quest', [QUST]),
          wbInteger('Quest Stage', itU8, wbPerkDATAQuestStageToStr, wbCTDAParam2QuestStageToInt),
          wbByteArray('Unused', 3)
        ]),
        wbFormIDCk('Ability', [SPEL]),
        wbStructSK([0, 1], 'Entry Point', [
          wbInteger('Entry Point', itU8, wbEnum([
           {00} 'Calculate Weapon Damage',
           {01} 'Calculate My Critical Hit Chance',
           {02} 'Calculate My Critical Hit Damage',
           {03} 'Calculate Weapon Attack AP Cost',
           {04} 'Calculate Mine Explode Chance',
           {05} 'Adjust Range Penalty',
           {06} 'Adjust Limb Damage',
           {07} 'Calculate Weapon Range',
           {08} 'Calculate To Hit Chance',
           {09} 'Adjust Experience Points',
           {10} 'Adjust Gained Skill Points',
           {11} 'Adjust Book Skill Points',
           {12} 'Modify Recovered Health',
           {13} 'Calculate Inventory AP Cost',
           {14} 'Get Disposition',
           {15} 'Get Should Attack',
           {16} 'Get Should Assist',
           {17} 'Calculate Buy Price',
           {18} 'Get Bad Karma',
           {19} 'Get Good Karma',
           {20} 'Ignore Locked Terminal',
           {21} 'Add Leveled List On Death',
           {22} 'Get Max Carry Weight',
           {23} 'Modify Addiction Chance',
           {24} 'Modify Addiction Duration',
           {25} 'Modify Positive Chem Duration',
           {26} 'Adjust Drinking Radiation',
           {27} 'Activate',
           {28} 'Mysterious Stranger',
           {29} 'Has Paralyzing Palm',
           {30} 'Hacking Science Bonus',
           {31} 'Ignore Running During Detection',
           {32} 'Ignore Broken Lock',
           {33} 'Has Concentrated Fire',
           {34} 'Calculate Gun Spread',
           {35} 'Player Kill AP Reward',
           {36} 'Modify Enemy Critical Hit Chance'
          ]), cpNormal, True, nil, wbPERKEntryPointAfterSet),
          wbInteger('Function', itU8, wbPerkDATAFunctionToStr, wbPerkDATAFunctionToInt, cpNormal, False, nil, wbPerkDATAFunctionAfterSet),
          wbInteger('Perk Condition Tab Count', itU8, nil, cpIgnore)
        ])
      ], cpNormal, True),
      wbRArrayS('Perk Conditions', wbPerkConditions),
      wbRStruct('Entry Point Function Parameters', [
        wbInteger(EPFT, 'Type', itU8, wbPerkEPFTToStr, wbPerkEPFTToInt, cpIgnore, False, nil, wbPerkEPFTAfterSet),
        wbUnion(EPFD, 'Data', wbEPFDDecider, [
          wbByteArray('Unknown'),
          wbFloat('Float'),
          wbStruct('Float, Float', [
            wbFloat('Float 1'),
            wbFloat('Float 2')
          ]),
          wbFormIDCk('Leveled Item', [LVLI]),
          wbEmpty('None (Script)'),
          wbStruct('Actor Value, Float', [
            wbInteger('Actor Value', itU32, wbEPFDActorValueToStr, wbEPFDActorValueToInt),
            wbFloat('Float')
          ])
        ], cpNormal, False, wbEPFDDontShow),
        wbStringKC(EPF2, 'Button Label', 0, cpNormal, False, wbEPF2DontShow),
        wbInteger(EPF3, 'Script Flags', itU16, wbFlags([
          'Run Immediately'
        ]), cpNormal, False, False, wbEPF2DontShow),
        wbEmbeddedScriptPerk
      ], [], cpNormal, False, wbPERKPRKCDontShow),
      wbEmpty(PRKF, 'End Marker', cpIgnore, True)
    ], []);

  wbRecord(PERK, 'Perk', [
    wbEDIDReq,
    wbFULL,
    wbDESCReq,
    wbICON,
    wbCTDAs,
    wbStruct(DATA, 'Data', [
      wbInteger('Trait', itU8, wbEnum(['No', 'Yes'])),
      wbInteger('Min Level', itU8),
      wbInteger('Ranks', itU8),
      wbInteger('Playable', itU8, wbEnum(['No', 'Yes'])),
      wbInteger('Hidden', itU8, wbEnum(['No', 'Yes']))
    ], cpNormal, True, nil, 4),
    wbRArrayS('Effects', wbPerkEffect)
  ]);

  wbBPNDStruct := wbStruct(BPND, '', [
    {00} wbFloat('Damage Mult'),
    {04} wbInteger('Flags', itU8, wbFlags([
      'Severable',
      'IK Data',
      'IK Data - Biped Data',
      'Explodable',
      'IK Data - Is Head',
      'IK Data - Headtracking',
      'To Hit Chance - Absolute'
    ])),
    {05} wbInteger('Part Type', itU8, wbEnum([
           'Torso',
           'Head 1',
           'Head 2',
           'Left Arm 1',
           'Left Arm 2',
           'Right Arm 1',
           'Right Arm 2',
           'Left Leg 1',
           'Left Leg 2',
           'Left Leg 3',
           'Right Leg 1',
           'Right Leg 2',
           'Right Leg 3',
           'Brain',
           'Weapon'
         ])),
    {06} wbInteger('Health Percent', itU8),
    {07} wbInteger('Actor Value', itS8, wbActorValueEnum),
    {08} wbInteger('To Hit Chance', itU8),
    {09} wbInteger('Explodable - Explosion Chance %', itU8),
    {10} wbInteger('Explodable - Debris Count', itU16),
    {12} wbFormIDCk('Explodable - Debris', [DEBR, NULL]),
    {16} wbFormIDCk('Explodable - Explosion', [EXPL, NULL]),
    {20} wbFloat('Tracking Max Angle'),
    {24} wbFloat('Explodable - Debris Scale'),
    {28} wbInteger('Severable - Debris Count', itS32),
    {32} wbFormIDCk('Severable - Debris', [DEBR, NULL]),
    {36} wbFormIDCk('Severable - Explosion', [EXPL, NULL]),
    {40} wbFloat('Severable - Debris Scale'),
    wbStruct('Gore Effects Positioning', [
      wbStruct('Translate', [
        {44} wbFloat('X'),
        {48} wbFloat('Y'),
        {52} wbFloat('Z')
      ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),
      wbStruct('Rotation', [
        {56} wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        {60} wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        {64} wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
      ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3)
    ]),
    {68} wbFormIDCk('Severable - Impact DataSet', [IPDS, NULL]),
    {72} wbFormIDCk('Explodable - Impact DataSet', [IPDS, NULL]),
    {28} wbInteger('Severable - Decal Count', itU8),
    {28} wbInteger('Explodable - Decal Count', itU8),
    {76} wbByteArray('Unused', 2),
    {80} wbFloat('Limb Replacement Scale')
  ], cpNormal, True);

  wbRecord(BPTD, 'Body Part Data', [
    wbEDIDReq,
    wbGenericModel(True),
    wbRStructS('Body Parts', 'Body Part', [
      wbString(BPTN, 'Part Name', 0, cpNormal, True),
      wbString(BPNN, 'Part Node', 0, cpNormal, True),
      wbString(BPNT, 'VATS Target', 0, cpNormal, True),
      wbString(BPNI, 'IK Data - Start Node', 0, cpNormal, True),
      wbBPNDStruct,
      wbString(NAM1, 'Limb Replacement Model', 0, cpNormal, True),
      wbString(NAM4, 'Gore Effects - Target Bone', 0, cpNormal, True),
      wbModelInfo(NAM5)
    ], [], cpNormal, True),
    wbFormIDCk(RAGA, 'Ragdoll', [RGDL])
  ]);

  wbRecord(ADDN, 'Addon Node', [
    wbEDIDReq,
    wbOBND(True),
    wbGenericModel(True),
    wbInteger(DATA, 'Node Index', itS32, nil, cpNormal, True),
    wbFormIDCk(SNAM, 'Sound', [SOUN]),
    wbStruct(DNAM, 'Data', [
      wbInteger('Master Particle System Cap', itU16),
      wbByteArray('Unknown', 2)
    ], cpNormal, True)
  ]);

  wbRecord(AVIF, 'ActorValue Information', [
    wbEDIDReq,
    wbFULL,
    wbDESCReq,
    wbICON,
    wbStringKC(ANAM, 'Short Name', 0, cpTranslate)
  ]);

  wbRecord(RADS, 'Radiation Stage', [
    wbEDIDReq,
    wbStruct(DATA, '', [
      wbInteger('Trigger Threshold', itU32),
      wbFormIDCk('Actor Effect', [SPEL])
    ], cpNormal, True)
  ]);

  wbRecord(CAMS, 'Camera Shot', [
    wbEDIDReq,
    wbGenericModel,
    wbStruct(DATA, 'Data', [
      {00} wbInteger('Action', itU32, wbEnum([
        'Shoot',
        'Fly',
        'Hit',
        'Zoom'
      ])),
      {04} wbInteger('Location', itU32, wbEnum([
        'Attacker',
        'Projectile',
        'Target'
      ])),
      {08} wbInteger('Target', itU32, wbEnum([
        'Attacker',
        'Projectile',
        'Target'
      ])),
      {12} wbInteger('Flags', itU32, wbFlags([
        'Position Follows Location',
        'Rotation Follows Target',
        'Don''t Follow Bone',
        'First Person Camera',
        'No Tracer',
        'Start At Time Zero'
      ])),
      wbStruct('Time Multipliers', [
        {16} wbFloat('Player'),
        {20} wbFloat('Target'),
        {24} wbFloat('Global')
      ]),
      {28} wbFloat('Max Time'),
      {32} wbFloat('Min Time'),
      {36} wbFloat('Target % Between Actors')
    ], cpNormal, True, nil, 7),
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD])
  ]);

  wbRecord(CPTH, 'Camera Path', [
    wbEDIDReq,
    wbCTDAs,
    wbArray(ANAM, 'Related Camera Paths', wbFormIDCk('Related Camera Path', [CPTH, NULL]), ['Parent', 'Previous Sibling'], cpNormal, True),
    wbInteger(DATA, 'Camera Zoom', itU8, wbEnum([
      'Default',
      'Disable',
      'Shot List'
    ]), cpNormal, True),
    wbRArray('Camera Shots', wbFormIDCk(SNAM, 'Camera Shot', [CAMS]))
  ]);

  wbRecord(VTYP, 'Voice Type', [
    wbEDIDReq,
    wbInteger(DNAM, 'Flags', itU8, wbFlags([
      'Allow Default Dialog',
      'Female'
    ]), cpNormal, True)
  ]);

  wbRecord(IPCT, 'Impact', [
    wbEDIDReq,
    wbGenericModel,
    wbStruct(DATA, '', [
      wbFloat('Effect - Duration'),
      wbInteger('Effect - Orientation', itU32, wbEnum([
        'Surface Normal',
        'Projectile Vector',
        'Projectile Reflection'
      ])),
      wbFloat('Angle Threshold'),
      wbFloat('Placement Radius'),
      wbInteger('Sound Level', itU32, wbSoundLevelEnum),
      wbInteger('Flags', itU32, wbFlags([
        'No Decal Data'
      ]))
    ], cpNormal, True),
    wbDODT,
    wbFormIDCk(DNAM, 'Texture Set', [TXST]),
    wbFormIDCk(SNAM, 'Sound 1', [SOUN]),
    wbFormIDCk(NAM1, 'Sound 2', [SOUN])
  ]);

  wbRecord(IPDS, 'Impact DataSet', [
    wbEDIDReq,
    wbStruct(DATA, 'Impacts', [
      wbFormIDCk('Stone', [IPCT, NULL]),
      wbFormIDCk('Dirt', [IPCT, NULL]),
      wbFormIDCk('Grass', [IPCT, NULL]),
      wbFormIDCk('Glass', [IPCT, NULL]),
      wbFormIDCk('Metal', [IPCT, NULL]),
      wbFormIDCk('Wood', [IPCT, NULL]),
      wbFormIDCk('Organic', [IPCT, NULL]),
      wbFormIDCk('Cloth', [IPCT, NULL]),
      wbFormIDCk('Water', [IPCT, NULL]),
      wbFormIDCk('Hollow Metal', [IPCT, NULL]),
      wbFormIDCk('Organic Bug', [IPCT, NULL]),
      wbFormIDCk('Organic Glow', [IPCT, NULL])
    ], cpNormal, True, nil, 9)
  ]);

  wbRecord(ECZN, 'Encounter Zone', [
    wbEDIDReq,
    wbStruct(DATA, '', [
      wbFormIDCkNoReach('Owner', [NPC_, FACT, NULL]),
      wbInteger('Rank', itS8),
      wbInteger('Minimum Level', itS8),
      wbInteger('Flags', itU8, wbFlags([
        'Never Resets',
        'Match PC Below Minimum Level'
      ])),
      wbByteArray('Unused', 1)
    ], cpNormal, True)
  ]);

  var wbMenuButton :=
    wbRStruct('Menu Button', [
      wbStringKC(ITXT, 'Button Text', 0, cpTranslate),
      wbCTDAs
    ], []);

  wbRecord(MESG, 'Message', [
    wbEDIDReq,
    wbDESCReq,
    wbFULL,
    wbFormIDCk(INAM, 'Icon', [MICN, NULL], False, cpNormal, True),
    wbByteArray(NAM0, 'Unused', 0, cpIgnore),
    wbByteArray(NAM1, 'Unused', 0, cpIgnore),
    wbByteArray(NAM2, 'Unused', 0, cpIgnore),
    wbByteArray(NAM3, 'Unused', 0, cpIgnore),
    wbByteArray(NAM4, 'Unused', 0, cpIgnore),
    wbByteArray(NAM5, 'Unused', 0, cpIgnore),
    wbByteArray(NAM6, 'Unused', 0, cpIgnore),
    wbByteArray(NAM7, 'Unused', 0, cpIgnore),
    wbByteArray(NAM8, 'Unused', 0, cpIgnore),
    wbByteArray(NAM9, 'Unused', 0, cpIgnore),
    wbInteger(DNAM, 'Flags', itU32, wbFlags([
      'Message Box',
      'Auto Display'
    ]), cpNormal, True, False, nil, wbMESGDNAMAfterSet),
    wbInteger(TNAM, 'Display Time', itU32, nil, cpNormal, False, False, wbMESGTNAMDontShow),
    wbRArray('Menu Buttons', wbMenuButton)
  ], False, nil, cpNormal, False, wbMESGAfterLoad);

  wbRecord(RGDL, 'Ragdoll', [
    wbEDIDReq,
    wbInteger(NVER, 'Version', itU32, nil, cpNormal, True),
    wbStruct(DATA, 'General Data', [
      wbInteger('Dynamic Bone Count', itU32),
      wbByteArray('Unused', 4),
      wbStruct('Enabled', [
        wbInteger('Feedback', itU8, wbEnum(['No', 'Yes'])),
        wbInteger('Foot IK (broken, don''t use)', itU8, wbEnum(['No', 'Yes'])),
        wbInteger('Look IK (broken, don''t use)', itU8, wbEnum(['No', 'Yes'])),
        wbInteger('Grab IK (broken, don''t use)', itU8, wbEnum(['No', 'Yes'])),
        wbInteger('Pose Matching', itU8, wbEnum(['No', 'Yes']))
      ]),
      wbByteArray('Unused', 1)
    ], cpNormal, True),
    wbFormIDCk(XNAM, 'Actor Base', [CREA, NPC_], False, cpNormal, True),
    wbFormIDCk(TNAM, 'Body Part Data', [BPTD], False, cpNormal, True),
    wbStruct(RAFD, 'Feedback Data', [
    {00} wbFloat('Dynamic/Keyframe Blend Amount'),
    {04} wbFloat('Hierarchy Gain'),
    {08} wbFloat('Position Gain'),
    {12} wbFloat('Velocity Gain'),
    {16} wbFloat('Acceleration Gain'),
    {20} wbFloat('Snap Gain'),
    {24} wbFloat('Velocity Damping'),
         wbStruct('Snap Max Settings', [
           {28} wbFloat('Linear Velocity'),
           {32} wbFloat('Angular Velocity'),
           {36} wbFloat('Linear Distance'),
           {40} wbFloat('Angular Distance')
         ]),
         wbStruct('Position Max Velocity', [
           {44} wbFloat('Linear'),
           {48} wbFloat('Angular')
         ]),
         wbStruct('Position Max Velocity', [
           {52} wbInteger('Projectile', itS32, wbDiv(1000)),
           {56} wbInteger('Melee', itS32, wbDiv(1000))
         ])
    ], cpNormal, False),
    wbArray(RAFB, 'Feedback Dynamic Bones', wbInteger('Bone', itU16), 0, nil, nil, cpNormal, False),
    wbStruct(RAPS, 'Pose Matching Data', [
    {00} wbArray('Match Bones', wbInteger('Bone', itU16, wbHideFFFF), 3),
    {06} wbInteger('Flags', itU8, wbFlags([
           'Disable On Move'
         ])),
    {07} wbByteArray('Unused', 1),
    {08} wbFloat('Motors Strength'),
    {12} wbFloat('Pose Activation Delay Time'),
    {16} wbFloat('Match Error Allowance'),
    {20} wbFloat('Displacement To Disable')
    ], cpNormal, True),
    wbString(ANAM, 'Death Pose')
  ]);

  wbRecord(DOBJ, 'Default Object Manager', [
    wbEDIDReq,
    wbArray(DATA, 'Default Objects', wbFormID('Default Object'), [
      'Stimpak',
      'SuperStimpak',
      'RadX',
      'RadAway',
      'Morphine',
      'Perk Paralysis',
      'Player Faction',
      'Mysterious Stranger NPC',
      'Mysterious Stranger Faction',
      'Default Music',
      'Battle Music',
      'Death Music',
      'Success Music',
      'Level Up Music',
      'Player Voice (Male)',
      'Player Voice (Male Child)',
      'Player Voice (Female)',
      'Player Voice (Female Child)',
      'Eat Package Default Food',
      'Every Actor Ability',
      'Drug Wears Off Image Space'
    ], cpNormal, True)
  ]);

  wbRecord(LGTM, 'Lighting Template', [
    wbEDIDReq,
    wbStruct(DATA, 'Lighting', [
      wbStruct('Ambient Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Directional Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Fog Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbFloat('Fog Near'),
      wbFloat('Fog Far'),
      wbInteger('Directional Rotation XY', itS32),
      wbInteger('Directional Rotation Z', itS32),
      wbFloat('Directional Fade'),
      wbFloat('Fog Clip Dist'),
      wbFloat('Fog Power')
    ], cpNormal, True)
  ]);

  wbRecord(MUSC, 'Music Type', [
    wbEDIDReq,
    wbString(FNAM, 'FileName')
  ]);

  wbRecord(GRAS, 'Grass', [
    wbEDIDReq,
    wbOBND(True),
    wbGenericModel(True),
    wbStruct(DATA, '', [
      wbInteger('Density', itU8),
      wbInteger('Min Slope', itU8),
      wbInteger('Max Slope', itU8),
      wbByteArray('Unused', 1),
      wbInteger('Unit from water amount', itU16),
      wbByteArray('Unused', 2),
      wbInteger('Unit from water type', itU32, wbEnum([
        'Above - At Least',
        'Above - At Most',
        'Below - At Least',
        'Below - At Most',
        'Either - At Least',
        'Either - At Most',
        'Either - At Most Above',
        'Either - At Most Below'
      ])),
      wbFloat('Position Range'),
      wbFloat('Height Range'),
      wbFloat('Color Range'),
      wbFloat('Wave Period'),
      wbInteger('Flags', itU8, wbFlags([
        'Vertex Lighting',
        'Uniform Scaling',
        'Fit to Slope'
      ])),
      wbByteArray('Unused', 3)
    ], cpNormal, True)
  ]);

  wbRecord(HAIR, 'Hair', [
    wbEDIDReq,
    wbFULLReq,
    wbGenericModel(True),
    wbString(ICON, 'Texture', 0, cpNormal, True),
    wbInteger(DATA, 'Flags', itU8, wbFlags([
      'Playable',
      'Not Male',
      'Not Female',
      'Fixed'
    ]), cpNormal, True)
  ]);

  wbRecord(IDLE, 'Idle Animation', [
    wbEDID,
    wbGenericModel(True),
    wbCTDAs,
    wbArray(ANAM, 'Related Idle Animations', wbFormIDCk('Related Idle Animation', [IDLE, NULL]), ['Parent', 'Previous Sibling'], cpNormal, True),
    wbStruct(DATA, '', [
      wbInteger('Animation Group Section', itU8, wbIdleAnam),
      wbStruct('Looping', [
        wbInteger('Min', itU8),
        wbInteger('Max', itU8)
      ]),
      wbByteArray('Unused', 1),
      wbInteger('Replay Delay', itS16),
      wbInteger('Flags', itU8, wbFlags([
        'No attacking'
      ])),
      wbByteArray('Unused', 1)
    ], cpNormal, True, nil, 4)
  ]);

  wbRecord(INFO, 'Dialog response', [
    wbStruct(DATA, '', [
      wbInteger('Type', itU8, wbEnum([
        {0} 'Topic',
        {1} 'Conversation',
        {2} 'Combat',
        {3} 'Persuasion',
        {4} 'Detection',
        {5} 'Service',
        {6} 'Miscellaneous',
        {7} 'Radio'
      ])),
      wbNextSpeaker,
      wbInteger('Flags 1', itU8, wbFlags([
        {0x01} 'Goodbye',
        {0x02} 'Random',
        {0x04} 'Say Once',
        {0x08} 'Run Immediately',
        {0x10} 'Info Refusal',
        {0x20} 'Random End',
        {0x40} 'Run for Rumors',
        {0x80} 'Speech Challenge'
      ])),
      wbInteger('Flags 2', itU8, wbFlags([
        {0x01} 'Say Once a Day',
        {0x02} 'Always Darken'
      ]))
    ], cpNormal, True, nil, 3),
    wbFormIDCkNoReach(QSTI, 'Quest', [QUST], False, cpNormal, True),
    wbFormIDCk(TPIC, 'Topic', [DIAL]),
    wbFormIDCkNoReach(PNAM, 'Previous INFO', [INFO, NULL]),
    wbRArray('Add Topics', wbFormIDCk(NAME, 'Topic', [DIAL])),
    wbRArray('Responses',
      wbRStruct('Response', [
        wbStruct(TRDT, 'Response Data', [
          wbInteger('Emotion Type', itU32, wbEnum([
            {0} 'Neutral',
            {1} 'Anger',
            {2} 'Disgust',
            {3} 'Fear',
            {4} 'Sad',
            {5} 'Happy',
            {6} 'Surprise',
            {7} 'Pained'
          ])),
          wbInteger('Emotion Value', itS32),
          wbByteArray('Unused', 4),
          wbInteger('Response number', itU8),
          wbByteArray('Unused', 3),
          wbFormIDCk('Sound', [SOUN, NULL]),
          wbInteger('Flags', itU8, wbFlags([
            'Use Emotion Animation'
          ])),
          wbByteArray('Unused', 3)
        ], cpNormal, False, nil, 5),
        wbStringKC(NAM1, 'Response Text', 0, cpTranslate, True),
        wbString(NAM2, 'Script Notes', 0, cpTranslate, True),
        wbString(NAM3, 'Edits'),
        wbFormIDCk(SNAM, 'Speaker Animation', [IDLE]),
        wbFormIDCk(LNAM, 'Listener Animation', [IDLE])
      ], [])
    ),
    wbCTDAs,
    wbRArray('Choices', wbFormIDCk(TCLT, 'Choice', [DIAL])),
    wbRArray('Link From', wbFormIDCk(TCLF, 'Topic', [DIAL])),
    wbRStruct('Script (Begin)', [
      wbEmbeddedScriptReq
    ], [], cpNormal, True),
    wbRStruct('Script (End)', [
      wbEmpty(NEXT, 'Marker', cpNormal, True),
      wbEmbeddedScriptReq
    ], [], cpNormal, True),
    wbFormIDCk(SNDD, 'Unused', [SOUN]),
    wbStringKC(RNAM, 'Prompt'),
    wbFormIDCk(ANAM, 'Speaker', [CREA, NPC_]),
    wbFormIDCk(KNAM, 'ActorValue/Perk', [AVIF, PERK]),
    wbInteger(DNAM, 'Speech Challenge', itU32, wbEnum([
      '---',
      'Very Easy',
      'Easy',
      'Average',
      'Hard',
      'Very Hard'
    ]))
  ], False, wbINFOAddInfo, cpNormal, False, wbINFOAfterLoad);

  wbRecord(INGR, 'Ingredient', [
    wbEDIDReq,
    wbOBND(True),
    wbFULL,
    wbGenericModel,
    wbICON,
    wbSCRI,
    wbETYPReq,
    wbFloat(DATA, 'Weight', cpNormal, True),
    wbStruct(ENIT, 'Effect Data', [
      wbInteger('Value', itS32),
      wbInteger('Flags', itU8, wbFlags(['No auto-calculation', 'Food item'])),
      wbByteArray('Unused', 3)
    ], cpNormal, True),
    wbEffectsReq
  ]);

  wbRecord(KEYM, 'Key', [
    wbEDIDReq,
    wbOBND(True),
    wbFULLReq,
    wbGenericModel,
    wbICONReq,
    wbSCRI,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbStruct(DATA, '', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True)
  ]);

  if wbSimpleRecords then begin

    wbRecord(LAND, 'Landscape', [
      wbByteArray(DATA, 'Unknown'),
      wbByteArray(VNML, 'Vertex Normals'),
      wbByteArray(VHGT, 'Vertex Height Map'),
      wbByteArray(VCLR, 'Vertex Colours'),
      wbLandscapeLayers(wbSimpleRecords),
      wbArray(VTEX, 'Textures', wbFormIDCk('Texture', [LTEX, NULL]))
    ]);

  end else begin

    wbRecord(LAND, 'Landscape', [
      wbByteArray(DATA, 'Unknown'),
      wbVertexColumns(VNML, 'Vertex Normals'),
      wbVertexHeightMap,
      wbVertexColumns(VCLR, 'Vertex Colours'),
      wbLandscapeLayers(wbSimpleRecords),
      wbArray(VTEX, 'Textures', wbFormIDCk('Texture', [LTEX, NULL]))
    ]);

  end;

  wbRecord(LIGH, 'Light', [
    wbEDIDReq,
    wbOBND(True),
    wbGenericModel,
    wbSCRI,
    wbDEST,
    wbFULL,
    wbICON,
    wbStruct(DATA, '', [
      wbInteger('Time', itS32),
      wbInteger('Radius', itU32),
      wbStruct('Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbInteger('Unused', itU8)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Dynamic',
        {0x00000002} 'Can be Carried',
        {0x00000004} 'Negative',
        {0x00000008} 'Flicker',
        {0x00000010} 'Unused',
        {0x00000020} 'Off By Default',
        {0x00000040} 'Flicker Slow',
        {0x00000080} 'Pulse',
        {0x00000100} 'Pulse Slow',
        {0x00000200} 'Spot Light',
        {0x00000400} 'Spot Shadow'
      ])),
      wbFloat('Falloff Exponent'),
      wbFloat('FOV'),
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ], cpNormal, True),
    wbFloat(FNAM, 'Fade value', cpNormal, True),
    wbFormIDCk(SNAM, 'Sound', [SOUN])
  ], False, nil, cpNormal, False, wbLIGHAfterLoad);

  wbRecord(LSCR, 'Load Screen',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000400} 10, 'Displays In Main Menu'
    ])), [
    wbEDIDReq,
    wbICONReq,
    wbDESCReq,
    wbRArrayS('Locations', wbStructSK(LNAM, [0, 1], 'Location', [
      wbFormIDCkNoReach('Cell', [CELL, WRLD]),
      wbByteArray('Unused', 8)
    ]))
  ]);

  wbRecord(LTEX, 'Landscape Texture', [
    wbEDIDReq,
    wbICON,
    wbFormIDCk(TNAM, 'Texture', [TXST], False, cpNormal, True),
    wbStruct(HNAM, 'Havok Data', [
      wbInteger('Material Type', itU8, wbEnum([
        {00} 'STONE',
        {01} 'CLOTH',
        {02} 'DIRT',
        {03} 'GLASS',
        {04} 'GRASS',
        {05} 'METAL',
        {06} 'ORGANIC',
        {07} 'SKIN',
        {08} 'WATER',
        {09} 'WOOD',
        {10} 'HEAVY STONE',
        {11} 'HEAVY METAL',
        {12} 'HEAVY WOOD',
        {13} 'CHAIN',
        {14} 'SNOW',
        {15} 'ELEVATOR',
        {16} 'HOLLOW METAL',
        {17} 'SHEET METAL',
        {18} 'SAND',
        {19} 'BRIKEN CONCRETE',
        {20} 'VEHILCE BODY',
        {21} 'VEHILCE PART SOLID',
        {22} 'VEHILCE PART HOLLOW',
        {23} 'BARREL',
        {24} 'BOTTLE',
        {25} 'SODA CAN',
        {26} 'PISTOL',
        {27} 'RIFLE',
        {28} 'SHOPPING CART',
        {29} 'LUNCHBOX',
        {30} 'BABY RATTLE',
        {31} 'RUBER BALL'
      ])),
      wbInteger('Friction', itU8),
      wbInteger('Restitution', itU8)
    ], cpNormal, True),
    wbInteger(SNAM, 'Texture Specular Exponent', itU8, nil, cpNormal, True),
    wbRArrayS('Grasses', wbFormIDCk(GNAM, 'Grass', [GRAS]))
  ]);

  wbLeveledListEntryCreature :=
    wbRStructExSK([0], [1], 'Leveled List Entry', [
      wbStructExSK(LVLO, [0, 2], [3], 'Base Data', [
        wbInteger('Level', itS16),
        wbByteArray('Unused', 2),
        wbFormIDCk('Reference', [CREA, LVLC]),
        wbInteger('Count', itS16),
        wbByteArray('Unused', 2)
      ])
      .SetSummaryKeyOnValue([0, 3, 2])
      .SetSummaryPrefixSuffixOnValue(0, '[Lv', ']')
      .SetSummaryPrefixSuffixOnValue(3, '', 'x')
      .SetSummaryDelimiterOnValue(' ')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlagOnValue(dfSummaryNoSortKey)
      , wbCOED
    ], [])
    .SetSummaryMemberMaxDepth(0, 1)
    .IncludeFlag(dfCollapsed, wbCollapseLeveledItems);

  wbLeveledListEntryItem :=
    wbRStructExSK([0], [1], 'Leveled List Entry', [
      wbStructExSK(LVLO, [0, 2], [3], 'Base Data', [
        wbInteger('Level', itS16),
        wbByteArray('Unused', 2),
        wbFormIDCk('Reference', [ARMO, AMMO, MISC, WEAP, BOOK, LVLI, KEYM, ALCH, NOTE]),
        wbInteger('Count', itS16),
        wbByteArray('Unused', 2)
      ])
      .SetSummaryKeyOnValue([0, 3, 2])
      .SetSummaryPrefixSuffixOnValue(0, '[Lv', ']')
      .SetSummaryPrefixSuffixOnValue(3, '', 'x')
      .SetSummaryDelimiterOnValue(' ')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlagOnValue(dfSummaryNoSortKey)
      , wbCOED
    ], [])
    .SetSummaryMemberMaxDepth(0, 1)
    .IncludeFlag(dfCollapsed, wbCollapseLeveledItems);

  wbLeveledListEntryNPC :=
    wbRStructExSK([0], [1], 'Leveled List Entry', [
      wbStructExSK(LVLO, [0, 2], [3], 'Base Data', [
        wbInteger('Level', itS16),
        wbByteArray('Unused', 2),
        wbFormIDCk('Reference', [NPC_, LVLN]),
        wbInteger('Count', itS16),
        wbByteArray('Unused', 2)
      ])
      .SetSummaryKeyOnValue([0, 3, 2])
      .SetSummaryPrefixSuffixOnValue(0, '[Lv', ']')
      .SetSummaryPrefixSuffixOnValue(3, '', 'x')
      .SetSummaryDelimiterOnValue(' ')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlagOnValue(dfSummaryNoSortKey)
      , wbCOED
    ], [])
    .SetSummaryMemberMaxDepth(0, 1)
    .IncludeFlag(dfCollapsed, wbCollapseLeveledItems);

  wbRecord(LVLC, 'Leveled Creature', [
    wbEDIDReq,
    wbOBND(True),
    wbInteger(LVLD, 'Chance none', itU8, nil, cpNormal, True),
    wbInteger(LVLF, 'Flags', itU8, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count'
    ]), cpNormal, True),
    wbRArrayS('Leveled List Entries', wbLeveledListEntryCreature, cpNormal, True),
    wbGenericModel
  ]);

  wbRecord(LVLN, 'Leveled NPC', [
    wbEDIDReq,
    wbOBND(True),
    wbInteger(LVLD, 'Chance none', itU8, nil, cpNormal, True),
    wbInteger(LVLF, 'Flags', itU8, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count'
    ]), cpNormal, True),
    wbRArrayS('Leveled List Entries', wbLeveledListEntryNPC, cpNormal, True),
    wbGenericModel
  ]);

   wbRecord(LVLI, 'Leveled Item', [
    wbEDIDReq,
    wbOBND(True),
    wbInteger(LVLD, 'Chance none', itU8, nil, cpNormal, True),
    wbInteger(LVLF, 'Flags', itU8, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count',
      {0x04} 'Use All'
    ]), cpNormal, True),
    wbFormIDCk(LVLG, 'Global', [GLOB]),
    wbRArrayS('Leveled List Entries', wbLeveledListEntryItem)
  ]);

  wbArchtypeEnum := wbEnum([
    {00} 'Value Modifier',
    {01} 'Script',
    {02} 'Dispel',
    {03} 'Cure Disease',
    {04} '',
    {05} '',
    {06} '',
    {07} '',
    {08} '',
    {09} '',
    {10} '',
    {11} 'Invisibility',
    {12} 'Chameleon',
    {13} 'Light',
    {14} '',
    {15} '',
    {16} 'Lock',
    {17} 'Open',
    {18} 'Bound Item',
    {19} 'Summon Creature',
    {20} '',
    {21} '',
    {22} '',
    {23} '',
    {24} 'Paralysis',
    {25} '',
    {26} '',
    {27} '',
    {28} '',
    {29} '',
    {30} 'Cure Paralysis',
    {31} 'Cure Addiction',
    {32} 'Cure Poison',
    {33} 'Concussion',
    {34} 'Value And Parts'
  ]);

  wbRecord(MGEF, 'Base Effect', [
    wbEDIDReq,
    wbFULL,
    wbDESCReq,
    wbICON,
    wbGenericModel,
    wbStruct(DATA, 'Data', [
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Hostile',
        {0x00000002} 'Recover',
        {0x00000004} 'Detrimental',
        {0x00000008} '',
        {0x00000010} 'Self',
        {0x00000020} 'Touch',
        {0x00000040} 'Target',
        {0x00000080} 'No Duration',
        {0x00000100} 'No Magnitude',
        {0x00000200} 'No Area',
        {0x00000400} 'FX Persist',
        {0x00000800} '',
        {0x00001000} 'Gory Visuals',
        {0x00002000} 'Display Name Only',
        {0x00004000} '',
        {0x00008000} 'Radio Broadcast ??',
        {0x00010000} '',
        {0x00020000} '',
        {0x00040000} '',
        {0x00080000} 'Use skill',
        {0x00100000} 'Use attribute',
        {0x00200000} '',
        {0x00400000} '',
        {0x00800000} '',
        {0x01000000} 'Painless',
        {0x02000000} 'Spray projectile type (or Fog if Bolt is specified as well)',
        {0x04000000} 'Bolt projectile type (or Fog if Spray is specified as well)',
        {0x08000000} 'No Hit Effect',
        {0x10000000} 'No Death Dispel',
        {0x20000000} '????'
      ])),
      {04} wbFloat('Base cost (Unused)'),
      {08} wbUnion('Assoc. Item', wbMGEFFAssocItemDecider, [
             wbFormID('Unused', cpIgnore),
             wbFormID('Assoc. Item'),
             wbFormIDCk('Assoc. Script', [SCPT, NULL]), //Script
             wbFormIDCk('Assoc. Item', [WEAP, ARMO, NULL]), //Bound Item
             wbFormIDCk('Assoc. Creature', [CREA]) //Summon Creature
           ], cpNormal, false, nil, wbMGEFAssocItemAfterSet),
      {12} wbInteger('Magic School (Unused)', itS32, wbEnum([
      ], [
        -1, 'None'
      ])),
      {16} wbInteger('Resistance Type', itS32, wbActorValueEnum),
      {20} wbInteger('Counter effect count', itU16),
      {22} wbByteArray('Unused', 2),
      {24} wbFormIDCk('Light', [LIGH, NULL]),
      {28} wbFloat('Projectile speed'),
      {32} wbFormIDCk('Effect Shader', [EFSH, NULL]),
      {36} wbFormIDCk('Object Display Shader', [EFSH, NULL]),
      {40} wbFormIDCk('Effect sound', [NULL, SOUN]),
      {44} wbFormIDCk('Bolt sound', [NULL, SOUN]),
      {48} wbFormIDCk('Hit sound', [NULL, SOUN]),
      {52} wbFormIDCk('Area sound', [NULL, SOUN]),
      {56} wbFloat('Constant Effect enchantment factor  (Unused)'),
      {60} wbFloat('Constant Effect barter factor (Unused)'),
      {64} wbInteger('Archtype', itU32, wbArchtypeEnum, cpNormal, False, nil, wbMGEFArchtypeAfterSet),
      {68} wbActorValue
    ], cpNormal, True),
    wbRArrayS('Counter Effects', wbFormIDCk(ESCE, 'Effect', [MGEF]), cpNormal, False, nil, wbCounterEffectsAfterSet)
  ], False, nil, cpNormal, False, wbMGEFAfterLoad, wbMGEFAfterSet);

  wbRecord(MISC, 'Misc. Item', [
    wbEDIDReq,
    wbOBND(True),
    wbFULL,
    wbGenericModel,
    wbICON,
    wbSCRI,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbStruct(DATA, '', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True)
  ]);

  wbRecord(COBJ, 'Constructible Object', [
    wbEDID,
    wbOBND,
    wbFULL,
    wbGenericModel,
    wbICON,
    wbSCRI,
    wbYNAM,
    wbZNAM,
    wbStruct(DATA, '', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True)
  ]);

  wbFaceGen := wbRStruct('FaceGen Data', [
    wbByteArray(FGGS, 'FaceGen Geometry-Symmetric', 0, cpNormal, True),
    wbByteArray(FGGA, 'FaceGen Geometry-Asymmetric', 0, cpNormal, True),
    wbByteArray(FGTS, 'FaceGen Texture-Symmetric', 0, cpNormal, True)
  ], [], cpNormal, True);

  wbFaceGenNPC := wbRStruct('FaceGen Data', [
    wbByteArray(FGGS, 'FaceGen Geometry-Symmetric', 0, cpNormal, True),
    wbByteArray(FGGA, 'FaceGen Geometry-Asymmetric', 0, cpNormal, True),
    wbByteArray(FGTS, 'FaceGen Texture-Symmetric', 0, cpNormal, True)
  ], [], cpNormal, True, wbActorTemplateUseModelAnimation);


  wbRecord(NPC_, 'Non-Player Character', [
    wbEDIDReq,
    wbOBND(True),
    wbFULLActor,
    wbGenericModel(False, wbActorTemplateUseModelAnimation),
    wbStruct(ACBS, 'Configuration', [
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
           {0x00800000} '',
           {0x01000000} '',
           {0x02000000} '',
           {0x03000000} 'No Knockdowns',
           {0x08000000} 'Not Pushable',
           {0x10000000} '', {28}
           {0x20000000} '',
           {0x40000000} 'No Rotating To Head-track',
           {0x80000000} ''
           ], [
             {0x000001 Female} wbActorTemplateUseTraits,
             {0x000002 Essential} wbActorTemplateUseBaseData,
             {0x000004 Is CharGen Face Preset} nil,
             {0x000008 Respawn} wbActorTemplateUseBaseData,
             {0x000010 Auto-calc stats} wbActorTemplateUseStats,
             {0x000020 } nil,
             {0x000040 } nil,
             {0x000080 PC Level Mult} wbActorTemplateUseStats,
             {0x000100 Use Template} nil,
             {0x000200 No Low Level Processing} wbActorTemplateUseBaseData,
             {0x000400 } nil,
             {0x000800 No Blood Spray} wbActorTemplateUseModelAnimation,
             {0x001000 No Blood Decal} wbActorTemplateUseModelAnimation,
             {0x002000 } nil,
             {0x004000 } nil,
             {0x008000 } nil,
             {0x010000 } nil,
             {0x020000 } nil,
             {0x040000 } nil,
             {0x080000 } nil,
             {0x100000 No VATS Melee} nil,
           {0x00200000 } nil,
           {0x00400000 Can be all races} nil,
           {0x00800000 } nil,
           {0x01000000 } nil,
           {0x02000000 } nil,
           {0x03000000 No Knockdowns} nil,
           {0x08000000 Not Pushable} wbActorTemplateUseModelAnimation,
           {0x10000000 } nil,
           {0x20000000 } nil,
           {0x40000000 No Rotating To Head-track} wbActorTemplateUseModelAnimation,
           {0x80000000 } nil
           ])),
      {04} wbInteger('Fatigue', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
      {06} wbInteger('Barter gold', itU16, nil, cpNormal, False, wbActorTemplateUseAIData),
      {08} wbUnion('Level', wbCreaLevelDecider, [
             wbInteger('Level', itS16, nil, cpNormal, True, wbActorTemplateUseStats),
             wbInteger('Level Mult', itS16, wbDiv(1000), cpNormal, True, wbActorTemplateUseStats)
           ], cpNormal, True, wbActorTemplateUseStats),
      {10} wbInteger('Calc min', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
      {12} wbInteger('Calc max', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
      {14} wbInteger('Speed Multiplier', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
      {16} wbFloat('Karma (Alignment)', cpNormal, False, 1, -1, wbActorTemplateUseTraits),
      {20} wbInteger('Disposition Base', itS16, nil, cpNormal, False, wbActorTemplateUseTraits),
      {22} wbInteger('Template Flags', itU16, wbTemplateFlags)
    ], cpNormal, True),
    wbRArrayS('Factions', wbFaction, cpNormal, False, nil, nil, wbActorTemplateUseFactions),
    wbFormIDCk(INAM, 'Death item', [LVLI], False, cpNormal, False, wbActorTemplateUseTraits),
    wbFormIDCk(VTCK, 'Voice', [VTYP], False, cpNormal, True, wbActorTemplateUseTraits),
    wbFormIDCk(TPLT, 'Template', [LVLN, NPC_]),
    wbFormIDCk(RNAM, 'Race', [RACE], False, cpNormal, True, wbActorTemplateUseTraits),
    wbSPLOs,
    wbFormIDCk(EITM, 'Unarmed Attack Effect', [ENCH, SPEL], False, cpNormal, False, wbActorTemplateUseActorEffectList),
    wbInteger(EAMT, 'Unarmed Attack Animation', itU16, wbAttackAnimationEnum, cpNormal, True, False, wbActorTemplateUseActorEffectList),
    wbDESTActor,
    wbSCRIActor,
    wbRArrayS('Items', wbCNTO, cpNormal, False, nil, nil, wbActorTemplateUseInventory),
    wbAIDT,
    wbRArray('Packages', wbFormIDCk(PKID, 'Package', [PACK]), cpNormal, False, nil, nil, wbActorTemplateUseAIPackages),
    wbArrayS(KFFZ, 'Animations', wbStringLC('Animation'), 0, cpNormal, False, nil, nil, wbActorTemplateUseModelAnimation),
    wbFormIDCk(CNAM, 'Class', [CLAS], False, cpNormal, True, wbActorTemplateUseTraits),
    wbStruct(DATA, '', [
      {00} wbInteger('Base Health', itS32),
      {04} wbArray('Attributes', wbInteger('Attribute', itU8), [
            'Strength',
            'Perception',
            'Endurance',
            'Charisma',
            'Intelligence',
            'Agility',
            'Luck'
          ], cpNormal, False, wbActorAutoCalcDontShow),
          wbByteArray('Unused'{, 14 - only present in old record versions})
    ], cpNormal, True, wbActorTemplateUseStats),
    wbStruct(DNAM, '', [
      {00} wbArray('Skill Values', wbInteger('Skill', itU8), [
             'Barter',
             'Big Guns',
             'Energy Weapons',
             'Explosives',
             'Lockpick',
             'Medicine',
             'Melee Weapons',
             'Repair',
             'Science',
             'Small Guns',
             'Sneak',
             'Speech',
             'Throwing (unused)',
             'Unarmed'
           ]),
      {14} wbArray('Skill Offsets', wbInteger('Skill', itU8), [
             'Barter',
             'Big Guns',
             'Energy Weapons',
             'Explosives',
             'Lockpick',
             'Medicine',
             'Melee Weapons',
             'Repair',
             'Science',
             'Small Guns',
             'Sneak',
             'Speech',
             'Throwing (unused)',
             'Unarmed'
           ])
    ], cpNormal, False, wbActorTemplateUseStatsAutoCalc),
    wbRArrayS('Head Parts',
      wbFormIDCk(PNAM, 'Head Part', [HDPT]),
    cpNormal, False, nil, nil, wbActorTemplateUseModelAnimation),
    wbFormIDCk(HNAM, 'Hair', [HAIR], False, cpNormal, False, wbActorTemplateUseModelAnimation),
    wbFloat(LNAM, 'Hair length', cpNormal, False, 1, -1, wbActorTemplateUseModelAnimation),
    wbFormIDCk(ENAM, 'Eyes', [EYES], False, cpNormal, False, wbActorTemplateUseModelAnimation),
    wbStruct(HCLR, 'Hair color', [
      wbInteger('Red', itU8),
      wbInteger('Green', itU8),
      wbInteger('Blue', itU8),
      wbByteArray('Unused', 1)
    ], cpNormal, True, wbActorTemplateUseModelAnimation).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
    wbFormIDCk(ZNAM, 'Combat Style', [CSTY], False, cpNormal, False, wbActorTemplateUseTraits),
    wbInteger(NAM4, 'Impact Material Type', itU32, wbImpactMaterialTypeEnum, cpNormal, True, False, wbActorTemplateUseModelAnimation),
    wbFaceGenNPC,
    wbInteger(NAM5, 'Unknown', itU16, nil, cpNormal, True, False, nil, nil, 255),
    wbFloat(NAM6, 'Height', cpNormal, True, 1, -1, wbActorTemplateUseTraits),
    wbFloat(NAM7, 'Weight', cpNormal, True, 1, -1, wbActorTemplateUseTraits)
  ], True, nil, cpNormal, False, wbNPCAfterLoad);

  wbPKDTFlags := wbFlags([
          {0x00000001} 'Offers Services',
          {0x00000002} 'Must reach location',
          {0x00000004} 'Must complete',
          {0x00000008} 'Lock doors at package start',
          {0x00000010} 'Lock doors at package end',
          {0x00000020} 'Lock doors at location',
          {0x00000040} 'Unlock doors at package start',
          {0x00000080} 'Unlock doors at package end',
          {0x00000100} 'Unlock doors at location',
          {0x00000200} 'Continue if PC near',
          {0x00000400} 'Once per day',
          {0x00000800} '',
          {0x00001000} 'Skip fallout behavior',
          {0x00002000} 'Always run',
          {0x00004000} '',
          {0x00008000} '',
          {0x00010000} '',
          {0x00020000} 'Always sneak',
          {0x00040000} 'Allow swimming',
          {0x00080000} 'Allow falls',
          {0x00100000} 'Head-Tracking off',
          {0x00200000} 'Weapons unequipped',
          {0x00400000} 'Defensive combat',
          {0x00800000} 'Weapon Drawn',
          {0x01000000} 'No idle anims',
          {0x02000000} 'Pretend In Combat',
          {0x04000000} 'Continue During Combat',
          {0x08000000} 'No Combat Alert',
          {0x10000000} 'No Warn/Attack Behaviour',
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
           {8} 'Use Item At',
           {9} 'Ambush',
          {10} 'Flee Not Combat',
          {11} '',
          {12} 'Sandbox',
          {13} 'Patrol',
          {14} 'Guard',
          {15} 'Dialogue',
          {16} 'Use Weapon'
        ]);

  wbObjectTypeEnum := wbEnum([
          ' NONE',
          'Activators',
          'Armor',
          'Books',
          'Clothing',
          'Containers',
          'Doors',
          'Ingredients',
          'Lights',
          'Misc',
          'Flora',
          'Furniture',
          'Weapons: Any',
          'Ammo',
          'NPCs',
          'Creatures',
          'Keys',
          'Alchemy',
          'Food',
          ' All: Combat Wearable',
          ' All: Wearable',
          'Weapons: Ranged',
          'Weapons: Melee',
          'Weapons: NONE',
          'Actor Effects: Any',
          'Actor Effects: Range Target',
          'Actor Effects: Range Touch',
          'Actor Effects: Range Self',
          '',
          'Actors: Any'
        ]);


  wbPKDTSpecificFlagsUnused := True;

  wbRecord(PACK, 'Package', [
    wbEDIDReq,
    wbStruct(PKDT, 'General', [
      wbInteger('General Flags', itU32, wbPKDTFlags),
      wbInteger('Type', itU8, wbPKDTType),
      wbByteArray('Unused', 1),
      wbInteger('Fallout Behavior Flags', itU16, wbFlags([
        {0x00000001}'Hellos To Player',
        {0x00000002}'Random Conversations',
        {0x00000004}'Observe Combat Behavior',
        {0x00000008}'Unknown 4',
        {0x00000010}'Reaction To Player Actions',
        {0x00000020}'Friendly Fire Comments',
        {0x00000040}'Aggro Radius Behavior',
        {0x00000080}'Allow Idle Chatter',
        {0x00000100}'Avoid Radiation'
      ], True)),
      wbUnion('Type Specific Flags', wbPKDTSpecificFlagsDecider, [
        wbEmpty('Type Specific Flags (missing)', cpIgnore, False, nil, True),
        wbInteger('Type Specific Flags - Find', itU16, wbFlags([
          {0x00000001}'',
          {0x00000002}'',
          {0x00000004}'',
          {0x00000008}'',
          {0x00000010}'',
          {0x00000020}'',
          {0x00000040}'',
          {0x00000080}'',
          {0x00000100}'Find - Allow Buying',
          {0x00000200}'Find - Allow Killing',
          {0x00000400}'Find - Allow Stealing'
        ], wbPKDTSpecificFlagsUnused)),
        wbInteger('Type Specific Flags - Follow', itU16, wbFlags([], wbPKDTSpecificFlagsUnused)),
        wbInteger('Type Specific Flags - Escort', itU16, wbFlags([
          {0x00000001}'',
          {0x00000002}'',
          {0x00000004}'',
          {0x00000008}'',
          {0x00000010}'',
          {0x00000020}'',
          {0x00000040}'',
          {0x00000080}'',
          {0x00000100}'Escort - Allow Buying',
          {0x00000200}'Escort - Allow Killing',
          {0x00000400}'Escort - Allow Stealing'
        ], wbPKDTSpecificFlagsUnused)),
        wbInteger('Type Specific Flags - Eat', itU16, wbFlags([
          {0x00000001}'',
          {0x00000002}'',
          {0x00000004}'',
          {0x00000008}'',
          {0x00000010}'',
          {0x00000020}'',
          {0x00000040}'',
          {0x00000080}'',
          {0x00000100}'Eat - Allow Buying',
          {0x00000200}'Eat - Allow Killing',
          {0x00000400}'Eat - Allow Stealing'
        ], wbPKDTSpecificFlagsUnused)),
        wbInteger('Type Specific Flags - Sleep', itU16, wbFlags([], wbPKDTSpecificFlagsUnused)),
        wbInteger('Type Specific Flags - Wander', itU16, wbFlags([
          {0x00000001}'Wander - No Eating',
          {0x00000002}'Wander - No Sleeping',
          {0x00000004}'Wander - No Conversation',
          {0x00000008}'Wander - No Idle Markers',
          {0x00000010}'Wander - No Furniture',
          {0x00000020}'Wander - No Wandering'
        ], wbPKDTSpecificFlagsUnused)),
        wbInteger('Type Specific Flags - Travel', itU16, wbFlags([], wbPKDTSpecificFlagsUnused)),
        wbInteger('Type Specific Flags - Accompany', itU16, wbFlags([], wbPKDTSpecificFlagsUnused)),
        wbInteger('Type Specific Flags - Use Item At', itU16, wbFlags([
          {0x00000001}'',
          {0x00000002}'Use Item At - Sit Down',
          {0x00000004}'',
          {0x00000008}'',
          {0x00000010}'',
          {0x00000020}'',
          {0x00000040}'',
          {0x00000080}'',
          {0x00000100}'Use Item At - Allow Buying',
          {0x00000200}'Use Item At - Allow Killing',
          {0x00000400}'Use Item At - Allow Stealing'
        ], wbPKDTSpecificFlagsUnused)),
        wbInteger('Type Specific Flags - Ambush', itU16, wbFlags([
          {0x00000001}'Ambush - Hide While Ambushing'
        ], wbPKDTSpecificFlagsUnused)),
        wbInteger('Type Specific Flags - Flee Not Combat', itU16, wbFlags([], wbPKDTSpecificFlagsUnused)),
        wbInteger('Type Specific Flags - ?', itU16, wbFlags([], wbPKDTSpecificFlagsUnused)),
        wbInteger('Type Specific Flags - Sandbox', itU16, wbFlags([
          {0x00000001}'Sandbox - No Eating',
          {0x00000002}'Sandbox - No Sleeping',
          {0x00000004}'Sandbox - No Conversation',
          {0x00000008}'Sandbox - No Idle Markers',
          {0x00000010}'Sandbox - No Furniture',
          {0x00000020}'Sandbox - No Wandering'
        ], wbPKDTSpecificFlagsUnused)),
        wbInteger('Type Specific Flags - Patrol', itU16, wbFlags([], wbPKDTSpecificFlagsUnused)),
        wbInteger('Type Specific Flags - Guard', itU16, wbFlags([
          {0x00000001}'',
          {0x00000002}'',
          {0x00000004}'Guard - Remain Near Reference to Guard'
        ], wbPKDTSpecificFlagsUnused)),
        wbInteger('Type Specific Flags - Dialogue', itU16, wbFlags([], wbPKDTSpecificFlagsUnused)),
        wbInteger('Type Specific Flags - Use Weapon', itU16, wbFlags([], wbPKDTSpecificFlagsUnused))
      ]),
      wbByteArray('Unused', 2)
    ], cpNormal, True, nil, 2),
    wbRStruct('Locations', [
      wbStruct(PLDT, 'Location 1', [
        wbInteger('Type', itS32, wbEnum([     // Byte + filler
          {0} 'Near reference',
          {1} 'In cell',
          {2} 'Near current location',
          {3} 'Near editor location',
          {4} 'Object ID',
          {5} 'Object Type',
          {6} 'Near linked reference',
          {7} 'At package location'
        ])),
        wbUnion('Location', wbPxDTLocationDecider, [
          wbFormIDCkNoReach('Reference', [REFR, PGRE, PMIS, PBEA, ACHR, ACRE, PLYR], True),
          wbFormIDCkNoReach('Cell', [CELL]),
          wbByteArray('Unused', 4, cpIgnore),
          wbByteArray('Unused', 4, cpIgnore),
          wbFormIDCkNoReach('Object ID', [ACTI, DOOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH]),
          wbInteger('Object Type', itU32, wbObjectTypeEnum),
          wbByteArray('Unused', 4, cpIgnore),
          wbByteArray('Unused', 4, cpIgnore)
        ]),
        wbInteger('Radius', itS32)
      ]),
      wbStruct(PLD2, 'Location 2', [
        wbInteger('Type', itS32, wbEnum([
          {0} 'Near reference',
          {1} 'In cell',
          {2} 'Near current location',
          {3} 'Near editor location',
          {4} 'Object ID',
          {5} 'Object Type',
          {6} 'Near linked reference',
          {7} 'At package location'
        ])),
        wbUnion('Location', wbPxDTLocationDecider, [
          wbFormIDCkNoReach('Reference', [REFR, PGRE, PMIS, PBEA, ACHR, ACRE, PLYR], True),
          wbFormIDCkNoReach('Cell', [CELL]),
          wbByteArray('Unused', 4, cpIgnore),
          wbByteArray('Unused', 4, cpIgnore),
          wbFormIDCkNoReach('Object ID', [ACTI, DOOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH]),
          wbInteger('Object Type', itU32, wbObjectTypeEnum),
          wbByteArray('Unused', 4, cpIgnore),
          wbByteArray('Unused', 4, cpIgnore)
        ]),
        wbInteger('Radius', itS32)
      ])
    ], [], cpNormal, False, nil, True),
    wbStruct(PSDT, 'Schedule', [
      wbInteger('Month', itS8),
      wbInteger('Day of week', itS8, wbEnum([
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Weekdays',
        'Weekends',
        'Monday, Wednesday, Friday',
        'Tuesday, Thursday'
      ], [
        -1, 'Any'
      ])),
      wbInteger('Date', itU8),
      wbInteger('Time', itS8),
      wbInteger('Duration', itS32)
    ], cpNormal, True),
    wbStruct(PTDT, 'Target 1', [
      wbInteger('Type', itS32, wbEnum([
        {0} 'Specific Reference',
        {1} 'Object ID',
        {2} 'Object Type',
        {3} 'Linked Reference'
      ]), cpNormal, False, nil, nil, 2),
      wbUnion('Target', wbPxDTLocationDecider, [
        wbFormIDCkNoReach('Reference', [ACHR, ACRE, REFR, PGRE, PMIS, PBEA, PLYR], True),
        wbFormIDCkNoReach('Object ID', [ACTI, DOOR, STAT, FURN, CREA, SPEL, NPC_, LVLN, LVLC, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, FACT, FLST]),
        wbInteger('Object Type', itU32, wbObjectTypeEnum),
        wbByteArray('Unused', 4, cpIgnore)
      ]),
      wbInteger('Count / Distance', itS32),
      wbFloat('Unknown')
    ], cpNormal, False, nil, 3),
    wbCTDAs,
    wbRStruct('Idle Animations', [
      wbInteger(IDLF, 'Flags', itU8, wbFlags([
        'Run in Sequence',
        '',
        'Do Once'
      ]), cpNormal, True),
      wbStruct(IDLC, '', [
        wbInteger( 'Animation Count', itU8),
        wbByteArray('Unused', 3)
      ], cpNormal, True, nil, 1),
      wbFloat(IDLT, 'Idle Timer Setting', cpNormal, True),
      wbArray(IDLA, 'Animations', wbFormIDCk('Animation', [IDLE]), 0, nil, wbIDLAsAfterSet, cpNormal, True),
      wbByteArray(IDLB, 'Unused', 4, cpIgnore)
    ], [], cpNormal, False, nil, False, nil {cannot be totally removed , wbAnimationsAfterSet}),
    wbFormIDCk(CNAM, 'Combat Style', [CSTY]),
    wbEmpty(PKED, 'Eat Marker'),
    wbInteger(PKE2, 'Escort Distance', itU32),
    wbFloat(PKFD, 'Follow - Start Location - Trigger Radius'),
    wbStruct(PKPT, 'Patrol Flags', [
      wbInteger('Repeatable', itU8, wbEnum(['No', 'Yes']), cpNormal, False, nil, nil, 1),
      wbByteArray('Unused', 1)
    ], cpNormal, False, nil, 1),
    wbStruct(PKW3, 'Use Weapon Data', [
      wbInteger('Flags', itU32, wbFlags([
        'Always Hit',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        'Do No Damage',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        'Crouch To Reload',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        'Hold Fire When Blocked'
      ])),
      wbInteger('Fire Rate', itU8, wbEnum([
        'Auto Fire',
        'Volley Fire'
      ])),
      wbInteger('Fire Count', itU8, wbEnum([
        'Number of Bursts',
        'Repeat Fire'
      ])),
      wbInteger('Number of Bursts', itU16),
      wbStruct('Shoots Per Volleys', [
        wbInteger('Min', itU16),
        wbInteger('Max', itU16)
      ]),
      wbStruct('Pause Between Volleys', [
        wbFloat('Min'),
        wbFloat('Max')
      ]),
      wbByteArray('Unused', 4)
    ]),
    wbStruct(PTD2, 'Target 2', [
      wbInteger('Type', itS32, wbEnum([
        {0} 'Specific reference',
        {1} 'Object ID',
        {2} 'Object Type',
        {3} 'Linked Reference'
      ])),
      wbUnion('Target', wbPxDTLocationDecider, [
        wbFormIDCkNoReach('Reference', [ACHR, ACRE, REFR, PGRE, PMIS, PBEA, PLYR], True),
        wbFormIDCkNoReach('Object ID', [ACTI, DOOR, STAT, FURN, CREA, SPEL, NPC_, LVLN, LVLC, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, FACT, FLST]),
        wbInteger('Object Type', itU32, wbObjectTypeEnum),
        wbByteArray('Unused', 4, cpIgnore)
      ]),
      wbInteger('Count / Distance', itS32),
      wbFloat('Unknown')
    ], cpNormal, False, nil, 3),
    wbEmpty(PUID, 'Use Item Marker'),
    wbEmpty(PKAM, 'Ambush Marker'),
    wbStruct(PKDD, 'Dialogue Data', [
      wbFloat('FOV'),
      wbFormIDCk('Topic', [DIAL, NULL]),
      wbInteger('Flags', itU32, wbFlags([
        'No Headtracking',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        'Don''t Control Target Movement'
      ])),
      wbByteArray('Unused', 4),
      wbInteger('Dialogue Type', itU32, wbEnum([
        'Conversation',
        'Say To'
      ])),
      wbByteArray('Unknown', 4)
    ], cpNormal, False, nil, 3),
    wbStruct(PLD2, 'Location 2 (again??)', [
      wbInteger('Type', itS32, wbEnum([
        {0} 'Near reference',
        {1} 'In cell',
        {2} 'Near current location',
        {3} 'Near editor location',
        {4} 'Object ID',
        {5} 'Object Type',
        {6} 'Near linked reference',
        {7} 'At package location'
      ])),
      wbUnion('Location', wbPxDTLocationDecider, [
        wbFormIDCkNoReach('Reference', [REFR, PGRE, PMIS, PBEA, ACHR, ACRE, PLYR], True),
        wbFormIDCkNoReach('Cell', [CELL]),
        wbByteArray('Unused', 4, cpIgnore),
        wbByteArray('Unused', 4, cpIgnore),
        wbFormIDCkNoReach('Object ID', [ACTI, DOOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH]),
        wbInteger('Object Type', itU32, wbObjectTypeEnum),
        wbByteArray('Unused', 4, cpIgnore),
        wbByteArray('Unused', 4, cpIgnore)
      ]),
      wbInteger('Radius', itS32)
    ]),
    wbRStruct('OnBegin', [
      wbEmpty(POBA, 'OnBegin Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, 'Topic', [DIAL, NULL], False, cpNormal, True)
    ], [], cpNormal, True),
    wbRStruct('OnEnd', [
      wbEmpty(POEA, 'OnEnd Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, 'Topic', [DIAL, NULL], False, cpNormal, True)
    ], [], cpNormal, True),
    wbRStruct('OnChange', [
      wbEmpty(POCA, 'OnChange Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, 'Topic', [DIAL, NULL], False, cpNormal, True)
    ], [], cpNormal, True)
  ], False, nil, cpNormal, False, wbPACKAfterLoad);

  wbRecord(QUST, 'Quest', [
    wbEDIDReq,
    wbSCRI,
    wbFULL,
    wbICON,
    wbStruct(DATA, 'General', [
      wbInteger('Flags', itU8, wbFlags([
        {0x01} 'Start game enabled',
        {0x02} '',
        {0x04} 'Allow repeated conversation topics',
        {0x08} 'Allow repeated stages',
        {0x10} 'Unknown 4'
      ])),
      wbInteger('Priority', itU8),
      wbByteArray('Unused', 2),
      wbFloat('Quest Delay')
    ], cpNormal, True, nil, 3),
    wbCTDAs,
    wbRArrayS('Stages', wbRStructSK([0], 'Stage', [
      wbInteger(INDX, 'Stage Index', itS16),
      wbRArray('Log Entries', wbRStruct('Log Entry', [
        wbInteger(QSDT, 'Stage Flags', itU8, wbFlags([
          {0x01} 'Complete Quest',
          {0x02} 'Fail Quest'
        ])),
        wbCTDAs,
        wbStringKC(CNAM, 'Log Entry', 0, cpTranslate),
        wbEmbeddedScriptReq,
        wbFormIDCk(NAM0, 'Next Quest', [QUST])
      ], []))
    ], [])),
    wbRArray('Objectives', wbRStruct('Objective', [
      wbInteger(QOBJ, 'Objective Index', itS32),
      wbStringKC(NNAM, 'Description', 0, cpNormal, True),
      wbRArray('Targets', wbRStruct('Target', [
        wbStruct(QSTA, 'Target', [
          wbFormIDCkNoReach('Target', [REFR, PGRE, PMIS, PBEA, ACRE, ACHR], True),
          wbInteger('Flags', itU8, wbFlags([
            {0x01} 'Compass Marker Ignores Locks'
          ])),
          wbByteArray('Unused', 3)
        ]),
        wbCTDAs
      ], []))
    ], []))
  ]);

  wbHeadPartIndexEnum := wbEnum([
    'Head',
    'Ears',
    'Mouth',
    'Teeth Lower',
    'Teeth Upper',
    'Tongue',
    'Left Eye',
    'Right Eye'
  ]);

  wbBodyPartIndexEnum := wbEnum([
    'Upper Body',
    'Left Hand',
    'Right Hand',
    'Upper Body Texture'
  ]);

  var wbHeadParts :=
    wbRArrayS('Parts', wbHeadPart(wbHeadPartIndexEnum, wbGenericModel(True), wbHeadPartsAfterSet), cpNormal, True);

  var wbBodyParts :=
    wbRArrayS('Parts',
      wbRStructSK([0], 'Part', [
        wbInteger(INDX, 'Index', itU32, wbBodyPartIndexEnum),
        wbICON,
        wbGenericModel(True)
      ], [])
      .SetSummaryKey([0, 2])
      .SetSummaryMemberPrefixSuffix(0, '[', ']')
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfSummaryNoSortKey)
      .IncludeFlag(dfCollapsed, wbCollapseBodyParts)
    , cpNormal, True);

  wbRecord(RACE, 'Race', [
    wbEDIDReq,
    wbFULLReq,
    wbDESCReq,
    wbFactionRelations,
    wbStruct(DATA, '', [
      wbArrayS('Skill Boosts', wbStructSK([0], 'Skill Boost', [
        wbInteger('Skill', itS8, wbActorValueEnum),
        wbInteger('Boost', itS8)
      ])
      .SetSummaryKey([1, 0])
      .SetSummaryMemberPrefixSuffix(1, '+', '')
      .SetSummaryMemberPrefixSuffix(0, '', '')
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfSummaryNoSortKey)
      .IncludeFlag(dfSummaryMembersNoName).IncludeFlag(dfCollapsed), 7),
      wbByteArray('Unused', 2),
      wbFloat('Male Height'),
      wbFloat('Female Height'),
      wbFloat('Male Weight'),
      wbFloat('Female Weight'),
      wbInteger('Flags', itU32, wbFlags([
        'Playable',
        '',
        'Child'
      ]))
    ], cpNormal, True),
    wbFormIDCk(ONAM, 'Older', [RACE]),
    wbFormIDCk(YNAM, 'Younger', [RACE]),
    wbEmpty(NAM2, 'Unknown Marker', cpNormal, True),
    wbArray(VTCK, 'Voices', wbFormIDCk('Voice', [VTYP]), ['Male', 'Female'], cpNormal, True),
    wbArray(DNAM, 'Default Hair Styles', wbFormIDCk('Default Hair Style', [HAIR, NULL]), ['Male', 'Female'], cpNormal, True),
    wbArray(CNAM, 'Default Hair Colors', wbInteger('Default Hair Color', itU8, wbEnum([
      'Bleached',
      'Brown',
      'Chocolate',
      'Platinum',
      'Cornsilk',
      'Suede',
      'Pecan',
      'Auburn',
      'Ginger',
      'Honey',
      'Gold',
      'Rosewood',
      'Black',
      'Chestnut',
      'Steel',
      'Champagne'
    ])), ['Male', 'Female'], cpNormal, True),
    wbFloat(PNAM, 'FaceGen - Main clamp', cpNormal, True),
    wbFloat(UNAM, 'FaceGen - Face clamp', cpNormal, True),
    wbByteArray(ATTR, 'Unused', 0, cpNormal, True),
    wbRStruct('Head Data', [
      wbEmpty(NAM0, 'Head Data Marker', cpNormal, True),
      wbRStruct('Male Head Data', [
        wbEmpty(MNAM, 'Male Data Marker', cpNormal, True),
        wbHeadParts
      ], [], cpNormal, True),
      wbRStruct('Female Head Data', [
        wbEmpty(FNAM, 'Female Data Marker', cpNormal, True),
        wbHeadParts
      ], [], cpNormal, True)
    ], [], cpNormal, True),
    wbRStruct('Body Data', [
      wbEmpty(NAM1, 'Body Data Marker', cpNormal, True),
      wbRStruct('Male Body Data', [
        wbEmpty(MNAM, 'Male Data Marker'),
        wbBodyParts
      ], [], cpNormal, True),
      wbRStruct('Female Body Data', [
        wbEmpty(FNAM, 'Female Data Marker', cpNormal, True),
        wbBodyParts
      ], [], cpNormal, True)
    ], [], cpNormal, True),
    wbArrayS(HNAM, 'Hairs', wbFormIDCk('Hair', [HAIR]), 0, cpNormal, True),
    wbArrayS(ENAM, 'Eyes', wbFormIDCk('Eye', [EYES]),  0,  cpNormal, True),
    wbRStruct('FaceGen Data', [
      wbRStruct('Male FaceGen Data', [
        wbEmpty(MNAM, 'Male Data Marker', cpNormal, True),
        wbFaceGen,
        wbUnknown(SNAM, cpNormal, True)
      ], [], cpNormal, True),
      wbRStruct('Female FaceGen Data', [
        wbEmpty(FNAM, 'Female Data Marker', cpNormal, True),
        wbFaceGen,
        wbUnknown(SNAM, cpNormal, True)
      ], [], cpNormal, True)
    ], [], cpNormal, True)
  ]);

  wbRefRecord(REFR, 'Placed Object', [
    wbEDID,
    {
    wbStruct(RCLR, 'Linked Reference Color (Old Format?)', [
      wbStruct('Link Start Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]),
      wbStruct('Link End Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ])
    ], cpIgnore),}
    wbByteArray(RCLR, 'Unused', 0, cpIgnore),
    wbFormIDCk(NAME, 'Base', [TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, LVLN, LVLC,
                              MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA,
                              MSTT, NOTE, PWAT, SCOL, TACT, TERM, TXST], False, cpNormal, True),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),

    {--- ?? ---}
    wbXRGD,
    wbXRGB,

    {--- Primitive ---}
    wbStruct(XPRM, 'Primitive', [
      wbStruct('Bounds', [
        wbFloat('X', cpNormal, True, 2, 4),
        wbFloat('Y', cpNormal, True, 2, 4),
        wbFloat('Z', cpNormal, True, 2, 4)
      ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),
      wbStruct('Color', [
        {84} wbFloat('Red', cpNormal, False, 255, 0),
        {88} wbFloat('Green', cpNormal, False, 255, 0),
        {92} wbFloat('Blue', cpNormal, False, 255, 0)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbFloat('Unknown'),
      wbInteger('Type', itU32, wbEnum([
        'None',
        'Box',
        'Sphere',
        'Portal Box'
      ]))
    ]),
    wbInteger(XTRI, 'Collision Layer', itU32, wbEnum([
      'Unidentified',
      'Static',
      'AnimStatic',
      'Transparent',
      'Clutter',
      'Weapon',
      'Projectile',
      'Spell',
      'Biped',
      'Trees',
      'Props',
      'Water',
      'Trigger',
      'Terrain',
      'Trap',
      'Non Collidable',
      'Cloud Trap',
      'Ground',
      'Portal',
      'Debris Small',
      'Debris Large',
      'Acoustic Space',
      'Actor Zone',
      'Projectile Zone',
      'Gas Trap',
      'Shell Casing',
      'Transparent Small',
      'Invisible Wall',
      'Transparent Small Anim',
      'Dead Bip',
      'Char Controller',
      'Avoid Box',
      'Collision Box',
      'Camera Sphere',
      'Door Detection',
      'Camera Pick',
      'Item Pick',
      'Line Of Sight',
      'Path Pick',
      'Custom Pick 1',
      'Custom Pick 2',
      'Spell Explosion',
      'Dropping Pick'
    ])),
    wbEmpty(XMBP, 'MultiBound Primitive Marker'),

    {--- Bound Contents ---}

    {--- Bound Data ---}
    wbStruct(XMBO, 'Bound Half Extents', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),

    {--- Teleport ---}
    wbStruct(XTEL, 'Teleport Destination', [
      wbFormIDCk('Door', [REFR], True),
      wbPosRot,
      wbInteger('Flags', itU32, wbFlags([
        'No Alarm'
      ]))
    ]),

    {--- Map Data ---}
    wbRStruct('Map Marker', [
      wbEmpty(XMRK, 'Map Marker Data'),
      wbInteger(FNAM, 'Flags', itU8, wbFlags([
        {0x01} 'Visible',
        {0x02} 'Can Travel To',
        {0x04} '"Show All" Hidden'
      ]), cpNormal, True),
      wbFULLReq,
      wbStruct(TNAM, '', [
        wbInteger('Type', itU8, wbEnum([
          'None',
          'City',
          'Settlement',
          'Encampment',
          'Natural Landmark',
          'Cave',
          'Factory',
          'Monument',
          'Military',
          'Office',
          'Town Ruins',
          'Urban Ruins',
          'Sewer Ruins',
          'Metro',
          'Vault'
        ])),
        wbByteArray('Unused', 1)
      ], cpNormal, True)
    ], []),

    wbInteger(XSRF, 'Special Rendering Flags', itU32, wbFlags([
      'Unknown 0',
      'Imposter',
      'Use Full Shader in LOD'
    ])),
    wbByteArray(XSRD, 'Special Rendering Data', 4),

    {--- X Target Data ---}
    wbFormIDCk(XTRG, 'Target', [REFR, ACRE, ACHR, PGRE, PMIS, PBEA], True),

    {--- Leveled Actor ----}
    wbXLCM,

    {--- Patrol Data ---}
    wbRStruct('Patrol Data', [
      wbFloat(XPRD, 'Idle Time', cpNormal, True),
      wbEmpty(XPPA, 'Patrol Script Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, 'Topic', [DIAL, NULL], False, cpNormal, True)
    ], []),

    {--- Radio ---}
    wbStruct(XRDO, 'Radio Data', [
      wbFloat('Range Radius'),
      wbInteger('Broadcast Range Type', itU32, wbEnum([
        'Radius',
        'Everywhere',
        'Worldspace and Linked Interiors',
        'Linked Interiors',
        'Current Cell Only'
      ])),
      wbFloat('Static Percentage'),
      wbFormIDCkNoReach('Position Reference', [REFR, ACRE, ACHR, PGRE, PMIS, PBEA, NULL])
    ]),

    {--- Ownership ---}
    wbOwnership(wbXOWN, [XCMT, XCMO]),

    {--- Lock ---}
    wbStruct(XLOC, 'Lock Data', [
      wbInteger('Level', itU8),
      wbByteArray('Unused', 3),
      wbFormIDCkNoReach('Key', [KEYM, NULL]),
      wbInteger('Flags', itU8, wbFlags(['', '', 'Leveled Lock'])),
      wbByteArray('Unused', 3),
      wbByteArray('Unknown', 8)
    ], cpNormal, False, nil, 5),

    {--- Extra ---}
    wbInteger(XCNT, 'Count', itS32),
    wbFloat(XRDS, 'Radius'),
    wbFloat(XHLP, 'Health'),
    wbFloat(XRAD, 'Radiation'),
    wbFloat(XCHG, 'Charge'),
    wbRStruct('Ammo', [
      wbFormIDCk(XAMT, 'Type', [AMMO], False, cpNormal, True),
      wbInteger(XAMC, 'Count', itS32, nil, cpNormal, True)
    ], []),

    {--- Reflected By / Refracted By ---}
    wbRArrayS('Reflected/Refracted By',
      wbStructSK(XPWR, [0], 'Water', [
        wbFormIDCk('Reference', [REFR]),
        wbInteger('Type', itU32, wbFlags([
          'Reflection',
          'Refraction'
        ]))
      ])
    ),

    {--- Lit Water ---}
    wbRArrayS('Lit Water',
      wbFormIDCk(XLTW, 'Water', [REFR])
    ),

    {--- Decals ---}
    wbRArrayS('Linked Decals',
      wbStructSK(XDCR, [0], 'Decal', [
        wbFormIDCk('Reference', [REFR]),
        wbUnknown
      ])
    ),

    {--- Linked Ref ---}
    wbFormIDCk(XLKR, 'Linked Reference', [REFR, ACRE, ACHR, PGRE, PMIS, PBEA, PLYR]),
    wbStruct(XCLP, 'Linked Reference Color', [
      wbStruct('Link Start Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbStruct('Link End Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA)
    ]),

    {--- Activate Parents ---}
    wbRStruct('Activate Parents', [
      wbInteger(XAPD, 'Flags', itU8, wbFlags([
        'Parent Activate Only'
      ], True)),
      wbRArrayS('Activate Parent Refs',
        wbStructSK(XAPR, [0], 'Activate Parent Ref', [
          wbFormIDCk('Reference', [REFR, ACRE, ACHR, PGRE, PMIS, PBEA, PLYR]),
          wbFloat('Delay')
        ])
      )
    ], []),

    {--- Enable Parent ---}
    wbXESP,

    {--- Emittance ---}
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),

    {--- Flags ---}
    wbActionFlag,
    wbEmpty(ONAM, 'Open by Default'),
    wbEmpty(XIBS, 'Ignored By Sandbox'),

    {--- Generated Data ---}
    wbStruct(XNDP, 'Navigation Door Link', [
      wbFormIDCk('Navigation Mesh', [NAVM]),
      wbInteger('Teleport Marker Triangle', itS16, wbREFRNavmeshTriangleToStr, wbStringToInt),
      wbByteArray('Unused', 2)
    ]),

    wbArray(XPOD, 'Portal Data', wbFormIDCk('Room', [REFR, NULL]), 2),
    wbSizePosRot(XPTL, 'Portal Data'),

    wbInteger(XSED, 'SpeedTree Seed', itU8),

    wbRStruct('Room Data', [
      wbStruct(XRMR, 'Header', [
        wbInteger('Linked Rooms Count', itU16),
        wbByteArray('Unknown', 2)
      ]),
      wbRArrayS('Linked Rooms',
        wbFormIDCk(XLRM, 'Linked Room', [REFR])
      )
    ], []),

    wbSizePosRot(XOCP, 'Occlusion Plane Data'),
    wbArray(XORD, 'Linked Occlusion Planes', wbFormIDCk('Plane', [REFR, NULL]), [
      'Right',
      'Left',
      'Bottom',
      'Top'
    ]),

    wbXLOD,

    {--- 3D Data ---}
    wbXSCL,
    wbDATAPosRot
  ], True, wbPlacedAddInfo, cpNormal, False, wbREFRAfterLoad);


  wbRecord(REGN, 'Region', [
    wbEDID,
    wbICON,
    wbStruct(RCLR, 'Map Color', [
      wbInteger('Red', itU8),
      wbInteger('Green', itU8),
      wbInteger('Blue', itU8),
      wbByteArray('Unused', 1)
    ], cpNormal, True).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
    wbFormIDCkNoReach(WNAM, 'Worldspace', [WRLD]),

    wbRArray('Region Areas', wbRStruct('Region Area', [
      wbInteger(RPLI, 'Edge Fall-off', itU32),
      wbArray(RPLD, 'Region Point List Data', wbStruct('Point', [
        wbFloat('X'),
        wbFloat('Y')
      ]), 0, wbRPLDAfterLoad)
    ], [])),

    wbRArrayS('Region Data Entries', wbRStructSK([0], 'Region Data Entry', [
      {always starts with an RDAT}
      wbStructSK(RDAT, [0], 'Data Header', [
        wbInteger('Type', itU32, wbEnum([
          {0}'',
          {1}'',
          {2}'Objects',
          {3}'Weather',
          {4}'Map',
          {5}'Land',
          {6}'Grass',
          {7}'Sound',
          {8}'',
          {9}''
        ])),
        wbInteger('Flags', itU8, wbFlags([
          'Override'
        ])),
        wbInteger('Priority', itU8),
        wbByteArray('Unused')
      ], cpNormal, True),

      {followed by one of these: }

      {--- Objects ---}
      wbArray(RDOT, 'Objects', wbStruct('Object', [
        wbFormIDCk('Object', [TREE, STAT, LTEX]),
        wbInteger('Parent Index', itU16, wbHideFFFF),
        wbByteArray('Unused', 2),
        wbFloat('Density'),
        wbInteger('Clustering', itU8),
        wbInteger('Min Slope', itU8),
        wbInteger('Max Slope', itU8),
        wbInteger('Flags', itU8, wbFlags([
          {0}'Conform to slope',
          {1}'Paint Vertices',
          {2}'Size Variance +/-',
          {3}'X +/-',
          {4}'Y +/-',
          {5}'Z +/-',
          {6}'Tree',
          {7}'Huge Rock'
        ])),
        wbInteger('Radius wrt Parent', itU16),
        wbInteger('Radius', itU16),
        wbFloat('Min Height'),
        wbFloat('Max Height'),
        wbFloat('Sink'),
        wbFloat('Sink Variance'),
        wbFloat('Size Variance'),
        wbStruct('Angle Variance', [
          wbInteger('X', itU16),
          wbInteger('Y', itU16),
          wbInteger('Z', itU16)
        ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),
        wbByteArray('Unused', 2),
        wbByteArray('Unknown', 4)
      ]), 0, nil, nil, cpNormal, False, wbREGNObjectsDontShow),

      {--- Map ---}
      wbString(RDMP, 'Map Name', 0, cpTranslate, False, wbREGNMapDontShow),

      {--- Grass ---}
      wbArrayS(RDGS, 'Grasses', wbStructSK([0], 'Grass', [
        wbFormIDCk('Grass', [GRAS]),
        wbByteArray('Unknown',4)
      ]), 0, cpNormal, False, nil, nil, wbREGNGrassDontShow),

      {--- Sound ---}
      wbInteger(RDMD, 'Music Type', itU32, wbMusicEnum, cpIgnore, False, False, wbNeverShow),
      wbFormIDCk(RDMO, 'Music', [MUSC], False, cpNormal, False, wbREGNSoundDontShow),
      wbRegionSounds,

      {--- Weather ---}
      wbArrayS(RDWT, 'Weather Types', wbStructSK([0], 'Weather Type', [
        wbFormIDCk('Weather', [WTHR]),
        wbInteger('Chance', itU32),
        wbFormIDCk('Global', [GLOB, NULL])
      ]), 0, cpNormal, False, nil, nil, wbREGNWeatherDontShow)
    ], []))
  ], True);

  wbRecord(SOUN, 'Sound', [
    wbEDIDReq,
    wbOBND(True),
    wbString(FNAM, 'Sound FileName'),
    wbRUnion('Sound Data', [
      wbStruct(SNDD, 'Sound Data', [
        wbInteger('Minimum Attenuation Distance', itU8, wbMul(5)),
        wbInteger('Maximum Attenuation Distance', itU8, wbMul(100)),
        wbInteger('Frequency Adjustment %', itS8),
        wbByteArray('Unused', 1),
        wbInteger('Flags', itU32, wbFlags([
          {0x0001} 'Random Frequency Shift',
          {0x0002} 'Play At Random',
          {0x0004} 'Environment Ignored',
          {0x0008} 'Random Location',
          {0x0010} 'Loop',
          {0x0020} 'Menu Sound',
          {0x0040} '2D',
          {0x0080} '360 LFE',
          {0x0100} 'Dialogue Sound',
          {0x0200} 'Envelope Fast',
          {0x0400} 'Envelope Slow',
          {0x0800} '2D Radius',
          {0x1000} 'Mute When Submerged'
        ])),
        wbInteger('Static attenuation cdB', itS16),
        wbInteger('Stop time ', itU8),
        wbInteger('Start time ', itU8),
        wbArray('Attenuation Curve', wbInteger('Point', itS16), 5),
        wbInteger('Reverb Attenuation Control', itS16),
        wbInteger('Priority', itS32),
        wbByteArray('Unknown', 8)
      ], cpNormal, True),
      wbStruct(SNDX, 'Sound Data', [
        wbInteger('Minimum attenuation distance', itU8, wbMul(5)),
        wbInteger('Maximum attenuation distance', itU8, wbMul(100)),
        wbInteger('Frequency adjustment %', itS8),
        wbByteArray('Unused', 1),
        wbInteger('Flags', itU32, wbFlags([
          {0x0001} 'Random Frequency Shift',
          {0x0002} 'Play At Random',
          {0x0004} 'Environment Ignored',
          {0x0008} 'Random Location',
          {0x0010} 'Loop',
          {0x0020} 'Menu Sound',
          {0x0040} '2D',
          {0x0080} '360 LFE',
          {0x0100} 'Dialogue Sound',
          {0x0200} 'Envelope Fast',
          {0x0400} 'Envelope Slow',
          {0x0800} '2D Radius',
          {0x1000} 'Mute When Submerged'
        ])),
        wbInteger('Static attenuation cdB', itS16),
        wbInteger('Stop time ', itU8),
        wbInteger('Start time ', itU8)
      ], cpNormal, True)
    ], [], cpNormal, True),
    wbArray(ANAM, 'Attenuation Curve', wbInteger('Point', itS16), 5, nil, nil, cpNormal, False, wbNeverShow),
    wbInteger(GNAM, 'Reverb Attenuation Control', itS16, nil, cpNormal, False, False, wbNeverShow),
    wbInteger(HNAM, 'Priority', itS32, nil, cpNormal, False, False, wbNeverShow)
  ], False, nil, cpNormal, False, wbSOUNAfterLoad);

  wbRecord(SPEL, 'Actor Effect', [
    wbEDIDReq,
    wbFULL,
    wbStruct(SPIT, '', [
      wbInteger('Type', itU32, wbEnum([
        {0} 'Actor Effect',
        {1} 'Disease',
        {2} 'Power',
        {3} 'Lesser Power',
        {4} 'Ability',
        {5} 'Poison',
        {6} '',
        {7} '',
        {8} '',
        {9} '',
       {10} 'Addiction'
      ])),
      wbInteger('Cost (Unused)', itU32),
      wbInteger('Level (Unused)', itU32, wbEnum([
        {0} 'Unused'
      ])),
      wbInteger('Flags', itU8, wbFlags([
        {0x00000001} 'No Auto-Calc',
        {0x00000002} 'Immune to Silence 1?',
        {0x00000004} 'PC Start Effect',
        {0x00000008} 'Immune to Silence 2?',
        {0x00000010} 'Area Effect Ignores LOS',
        {0x00000020} 'Script Effect Always Applies',
        {0x00000040} 'Disable Absorb/Reflect',
        {0x00000080} 'Force Touch Explode'
      ])),
      wbByteArray('Unused', 3)
    ], cpNormal, True),
    wbEffectsReq
  ]);

  wbRecord(STAT, 'Static', [
    wbEDIDReq,
    wbOBND(True),
    wbGenericModel
  ]);

  wbRecord(TES4, 'Main File Header', [
    wbHEDR,
    wbByteArray(OFST, 'Unknown', 0, cpIgnore),
    wbByteArray(DELE, 'Unknown', 0, cpIgnore),
    wbString(CNAM, 'Author', 0, cpTranslate, True),
    wbString(SNAM, 'Description', 0, cpTranslate),
    wbRArray('Master Files', wbRStruct('Master File', [
      wbStringForward(MAST, 'FileName', 0, cpNormal, True),
      wbByteArray(DATA, 'Unused', 8, cpIgnore, True)
    ], [ONAM])).IncludeFlag(dfInternalEditOnly, not wbAllowMasterFilesEdit),
    wbArray(ONAM, 'Overridden Forms', wbFormIDCk('Form', [REFR, ACHR, ACRE, PMIS, PBEA, PGRE, LAND, NAVM]), 0, nil, nil, cpNormal, False, wbTES4ONAMDontShow),
    wbByteArray(SCRN, 'Screenshot')
  ], True, nil, cpNormal, True, wbRemoveOFST);

  wbRecord(PLYR, 'Player Reference', [
    wbEDID,
    wbFormID(PLYR, 'Player', cpNormal, True).SetDefaultNativeValue($7)
  ]).IncludeFlag(dfInternalEditOnly);

  wbRecord(TREE, 'Tree', [
    wbEDIDReq,
    wbOBND(True),
    wbGenericModel(True),
    wbICONReq,
    wbArrayS(SNAM, 'SpeedTree Seeds', wbInteger('SpeedTree Seed', itU32), 0, cpNormal, True),
    wbStruct(CNAM, 'Tree Data', [
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
      wbFloat('Width'),
      wbFloat('Height')
    ], cpNormal, True)
  ]);
end;

procedure DefineFO3f;
begin
  wbRecord(WATR, 'Water', [
    wbEDIDReq,
    wbFULL,
    wbString(NNAM, 'Noise Map', 0, cpNormal, True),
    wbInteger(ANAM, 'Opacity', itU8, nil, cpNormal, True),
    wbInteger(FNAM, 'Flags', itU8, wbFlags([
      {0}'Causes Damage',
      {1}'Reflective'
    ]), cpNormal, True),
    wbString(MNAM, 'Material ID', 0, cpNormal, True),
    wbFormIDCk(SNAM, 'Sound', [SOUN]),
    wbFormIDCk(XNAM, 'Actor Effect', [SPEL]),
    wbInteger(DATA, 'Damage', itU16, nil, cpNormal, True, True),
    wbRUnion('Visual Data', [
      wbStruct(DNAM, 'Visual Data', [
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Water Properties - Sun Power'),
        wbFloat('Water Properties - Reflectivity Amount'),
        wbFloat('Water Properties - Fresnel Amount'),
        wbByteArray('Unused', 4),
        wbFloat('Fog Properties - Above Water - Fog Distance - Near Plane'),
        wbFloat('Fog Properties - Above Water - Fog Distance - Far Plane'),
        wbStruct('Shallow Color', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unused', 1)
        ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
        wbStruct('Deep Color', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unused', 1)
        ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
        wbStruct('Reflection Color', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unused', 1)
        ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
        wbByteArray('Unused', 4),
        wbFloat('Rain Simulator - Force'),
        wbFloat('Rain Simulator - Velocity'),
        wbFloat('Rain Simulator - Falloff'),
        wbFloat('Rain Simulator - Dampner'),
        wbFloat('Displacement Simulator - Starting Size'),
        wbFloat('Displacement Simulator - Force'),
        wbFloat('Displacement Simulator - Velocity'),
        wbFloat('Displacement Simulator - Falloff'),
        wbFloat('Displacement Simulator - Dampner'),
        wbFloat('Rain Simulator - Starting Size'),
        wbFloat('Noise Properties - Normals - Noise Scale'),
        wbFloat('Noise Properties - Noise Layer One - Wind Direction'),
        wbFloat('Noise Properties - Noise Layer Two - Wind Direction'),
        wbFloat('Noise Properties - Noise Layer Three - Wind Direction'),
        wbFloat('Noise Properties - Noise Layer One - Wind Speed'),
        wbFloat('Noise Properties - Noise Layer Two - Wind Speed'),
        wbFloat('Noise Properties - Noise Layer Three - Wind Speed'),
        wbFloat('Noise Properties - Normals - Depth Falloff Start'),
        wbFloat('Noise Properties - Normals - Depth Falloff End'),
        wbFloat('Fog Properties - Above Water - Fog Amount'),
        wbFloat('Noise Properties - Normals - UV Scale'),
        wbFloat('Fog Properties - Under Water - Fog Amount'),
        wbFloat('Fog Properties - Under Water - Fog Distance - Near Plane'),
        wbFloat('Fog Properties - Under Water - Fog Distance - Far Plane'),
        wbFloat('Water Properties - Distortion Amount'),
        wbFloat('Water Properties - Shininess'),
        wbFloat('Water Properties - Reflection HDR Multiplier'),
        wbFloat('Water Properties - Light Radius'),
        wbFloat('Water Properties - Light Brightness'),
        wbFloat('Noise Properties - Noise Layer One - UV Scale'),
        wbFloat('Noise Properties - Noise Layer Two - UV Scale'),
        wbFloat('Noise Properties - Noise Layer Three - UV Scale'),
        wbFloat('Noise Properties - Noise Layer One - Amplitude Scale'),
        wbFloat('Noise Properties - Noise Layer Two - Amplitude Scale'),
        wbFloat('Noise Properties - Noise Layer Three - Amplitude Scale')
      ], cpNormal, True, nil, 46),
      wbStruct(DATA, 'Visual Data', [
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Water Properties - Sun Power'),
        wbFloat('Water Properties - Reflectivity Amount'),
        wbFloat('Water Properties - Fresnel Amount'),
        wbByteArray('Unused', 4),
        wbFloat('Fog Properties - Above Water - Fog Distance - Near Plane'),
        wbFloat('Fog Properties - Above Water - Fog Distance - Far Plane'),
        wbStruct('Shallow Color', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unused', 1)
        ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
        wbStruct('Deep Color', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unused', 1)
        ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
        wbStruct('Reflection Color', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unused', 1)
        ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
        wbByteArray('Unused', 4),
        wbFloat('Rain Simulator - Force'),
        wbFloat('Rain Simulator - Velocity'),
        wbFloat('Rain Simulator - Falloff'),
        wbFloat('Rain Simulator - Dampner'),
        wbFloat('Displacement Simulator - Starting Size'),
        wbFloat('Displacement Simulator - Force'),
        wbFloat('Displacement Simulator - Velocity'),
        wbFloat('Displacement Simulator - Falloff'),
        wbFloat('Displacement Simulator - Dampner'),
        wbFloat('Rain Simulator - Starting Size'),
        wbFloat('Noise Properties - Normals - Noise Scale'),
        wbFloat('Noise Properties - Noise Layer One - Wind Direction'),
        wbFloat('Noise Properties - Noise Layer Two - Wind Direction'),
        wbFloat('Noise Properties - Noise Layer Three - Wind Direction'),
        wbFloat('Noise Properties - Noise Layer One - Wind Speed'),
        wbFloat('Noise Properties - Noise Layer Two - Wind Speed'),
        wbFloat('Noise Properties - Noise Layer Three - Wind Speed'),
        wbFloat('Noise Properties - Normals - Depth Falloff Start'),
        wbFloat('Noise Properties - Normals - Depth Falloff End'),
        wbFloat('Fog Properties - Above Water - Fog Amount'),
        wbFloat('Noise Properties - Normals - UV Scale'),
        wbFloat('Fog Properties - Under Water - Fog Amount'),
        wbFloat('Fog Properties - Under Water - Fog Distance - Near Plane'),
        wbFloat('Fog Properties - Under Water - Fog Distance - Far Plane'),
        wbFloat('Water Properties - Distortion Amount'),
        wbFloat('Water Properties - Shininess'),
        wbFloat('Water Properties - Reflection HDR Multiplier'),
        wbFloat('Water Properties - Light Radius'),
        wbFloat('Water Properties - Light Brightness'),
        wbFloat('Noise Properties - Noise Layer One - UV Scale'),
        wbFloat('Noise Properties - Noise Layer Two - UV Scale'),
        wbFloat('Noise Properties - Noise Layer Three - UV Scale'),
        wbEmpty('Noise Properties - Noise Layer One - Amplitude Scale'),
        wbEmpty('Noise Properties - Noise Layer Two - Amplitude Scale'),
        wbEmpty('Noise Properties - Noise Layer Three - Amplitude Scale'),
        wbInteger('Damage (Old Format)', itU16)
      ], cpNormal, True)
    ], [], cpNormal, True),
    wbStruct(GNAM, 'Related Waters (Unused)', [
      wbFormIDCk('Daytime', [WATR, NULL]),
      wbFormIDCk('Nighttime', [WATR, NULL]),
      wbFormIDCk('Underwater', [WATR, NULL])
    ], cpNormal, True)
  ], False, nil, cpNormal, False, wbWATRAfterLoad);

  wbRecord(WEAP, 'Weapon', [
    wbEDIDReq,
    wbOBND(True),
    wbFULL,
    wbGenericModel,
    wbICON,
    wbSCRI,
    wbEITM,
    wbInteger(EAMT, 'Enchantment Charge Amount', itS16),
    wbFormIDCkNoReach(NAM0, 'Ammo', [AMMO, FLST]),
    wbDEST,
    wbREPL,
    wbETYPReq,
    wbBIPL,
    wbYNAM,
    wbZNAM,
    wbRStruct('Shell Casing Model', [
      wbString(MOD2, 'Model FileName'),
      wbModelInfo(MO2T),
      wbMO2S
    ], [])
    .SetSummaryKey([0])
    .IncludeFlag(dfCollapsed, wbCollapseModels),
    wbRStruct('Scope Model', [
      wbString(MOD3, 'Model FileName'),
      wbModelInfo(MO3T),
      wbMO3S
    ], [])
    .SetSummaryKey([0])
    .IncludeFlag(dfCollapsed, wbCollapseModels),
    wbFormIDCK(EFSD, 'Scope Effect', [EFSH]),
    wbRStruct('World Model', [
      wbString(MOD4, 'Model FileName'),
      wbModelInfo(MO4T),
      wbMO4S
    ], [])
    .SetSummaryKey([0])
    .IncludeFlag(dfCollapsed, wbCollapseModels),
    wbString(NNAM, 'Embedded Weapon Node'),
    wbFormIDCk(INAM, 'Impact DataSet', [IPDS]),
    wbFormIDCk(WNAM, '1st Person Model', [STAT]),
    wbFormIDCk(SNAM, 'Sound - Gun - Shoot 3D', [SOUN]),
    wbFormIDCk(XNAM, 'Sound - Gun - Shoot 2D', [SOUN]),
    wbFormIDCk(NAM7, 'Sound - Gun - Shoot 3D Looping', [SOUN]),
    wbFormIDCk(TNAM, 'Sound - Melee - Swing / Gun - No Ammo', [SOUN]),
    wbFormIDCk(NAM6, 'Sound - Block', [SOUN]),
    wbFormIDCk(UNAM, 'Sound - Idle', [SOUN]),
    wbFormIDCk(NAM9, 'Sound - Equip', [SOUN]),
    wbFormIDCk(NAM8, 'Sound - Unequip', [SOUN]),
    wbStruct(DATA, '', [
      wbInteger('Value', itS32),
      wbInteger('Health', itS32),
      wbFloat('Weight'),
      wbInteger('Base Damage', itS16),
      wbInteger('Clip Size', itU8)
    ], cpNormal, True),
    wbStruct(DNAM, '', [
      {00} wbInteger('Animation Type', itU32, wbWeaponAnimTypeEnum),
      {04} wbFloat('Animation Multiplier'),
      {08} wbFloat('Reach'),
      {12} wbInteger('Flags 1', itU8, wbFlags([
        'Ignores Normal Weapon Resistance',
        'Is Automatic',
        'Has Scope',
        'Can''t Drop',
        'Hide Backpack',
        'Embedded Weapon',
        'Don''t Use 1st Person IS Animations',
        'Non-Playable'
      ])),
      {13} wbInteger('Grip Animation', itU8, wbEnum([
      ], [
        171, 'HandGrip1',
        172, 'HandGrip2',
        173, 'HandGrip3',
        255, 'DEFAULT'
      ])),
      {14} wbInteger('Ammo Use', itU8),
      {15} wbInteger('Reload Animation', itU8, wbReloadAnimEnum),
      {16} wbFloat('Min Spread'),
      {20} wbFloat('Spread'),
      {24} wbFloat('Unknown'),
      {28} wbFloat('Sight FOV'),
      {32} wbByteArray('Unused', 4),
      {36} wbFormIDCk('Projectile', [PROJ, NULL]),
      {40} wbInteger('Base VATS To-Hit Chance', itU8),
      {41} wbInteger('Attack Animation', itU8, wbEnum([
           ], [
             26, 'AttackLeft',
             32, 'AttackRight',
             38, 'Attack3',
             44, 'Attack4',
             50, 'Attack5',
             56, 'Attack6',
             62, 'Attack7',
             68, 'Attack8',
             74, 'AttackLoop',
             80, 'AttackSpin',
             86, 'AttackSpin2',
             97, 'PlaceMine',
            103, 'PlaceMine2',
            109, 'AttackThrow',
            115, 'AttackThrow2',
            121, 'AttackThrow3',
            127, 'AttackThrow4',
            133, 'AttackThrow5',
            255, 'DEFAULT'
           ])),
      {42} wbInteger('Projectile Count', itU8),
      {43} wbInteger('Embedded Weapon - Actor Value', itU8, wbEnum([
        {00} 'Perception',
        {01} 'Endurance',
        {02} 'Left Attack',
        {03} 'Right Attack',
        {04} 'Left Mobility',
        {05} 'Right Mobility',
        {06} 'Brain'
      ])),
      {44} wbFloat('Min Range'),
      {48} wbFloat('Max Range'),
      {52} wbInteger('On Hit', itU32, wbEnum([
        'Normal formula behavior',
        'Dismember Only',
        'Explode Only',
        'No Dismember/Explode'
      ])),
      {56} wbInteger('Flags 2', itU32, wbFlags([
        {0x00000001}'Player Only',
        {0x00000002}'NPCs Use Ammo',
        {0x00000004}'No Jam After Reload',
        {0x00000008}'Override - Action Points',
        {0x00000010}'Minor Crime',
        {0x00000020}'Range - Fixed',
        {0x00000040}'Not Used In Normal Combat',
        {0x00000080}'Override - Damage to Weapon Mult',
        {0x00000100}'Don''t Use 3rd Person IS Animations',
        {0x00000200}'Short Burst',
        {0x00000400}'Rumble Alternate',
        {0x00000800}'Long Burst'
      ])),
      {60} wbFloat('Animation Attack Multiplier'),
      {64} wbFloat('Fire Rate'),
      {68} wbFloat('Override - Action Points'),
      {72} wbFloat('Rumble - Left Motor Strength'),
      {76} wbFloat('Rumble - Right Motor Strength'),
      {80} wbFloat('Rumble - Duration'),
      {84} wbFloat('Override - Damage to Weapon Mult'),
      {88} wbFloat('Attack Shots/Sec'),
      {92} wbFloat('Reload Time'),
      {96} wbFloat('Jam Time'),
     {100} wbFloat('Aim Arc'),
     {104} wbInteger('Skill', itS32, wbActorValueEnum),
     {108} wbInteger('Rumble - Pattern', itU32, wbEnum([
       'Constant',
       'Square',
       'Triangle',
       'Sawtooth'
     ])),
     {112} wbFloat('Rumble - Wavelength'),
     {116} wbFloat('Limb Dmg Mult'),
     {120} wbInteger('Resist Type', itS32, wbActorValueEnum),
     {124} wbFloat('Sight Usage'),
     {128} wbFloat('Semi-Automatic Fire Delay Min'),
     {132} wbFloat('Semi-Automatic Fire Delay Max')
    ], cpNormal, True, nil, 36),

   wbStruct(CRDT, 'Critical Data', [
      {00} wbInteger('Critical Damage', itU16),
      {09} wbByteArray('Unused', 2),
      {04} wbFloat('Crit % Mult'),
      {08} wbInteger('Flags', itU8, wbFlags([
        'On Death'
      ])),
      {09} wbByteArray('Unused', 3),
      {12} wbFormIDCk('Effect', [SPEL, NULL])
    ], cpNormal, True),
    wbInteger(VNAM, 'Sound Level', itU32, wbSoundLevelEnum, cpNormal, True)
  ], False, nil, cpNormal, False, wbWEAPAfterLoad);

  if wbSimpleRecords then
    wbRecord(WRLD, 'Worldspace', [
      wbEDIDReq,
      wbFULL,
      wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),
      wbRStruct('Parent', [
        wbFormIDCk(WNAM, 'Worldspace', [WRLD]),
        wbStruct(PNAM, '', [
          wbInteger('Flags', itU8, wbFlags([
            {0x00000001}'Use Land Data',
            {0x00000002}'Use LOD Data',
            {0x00000004}'Use Map Data',
            {0x00000008}'Use Water Data',
            {0x00000010}'Use Climate Data',
            {0x00000020}'Use Image Space Data',
            {0x00000040}'',
            {0x00000080}'Needs Water Adjustment'
          ], True)),
          wbByteArray('Unknown', 1)
        ], cpNormal, True)
      ], []),
      wbFormIDCk(CNAM, 'Climate', [CLMT]),
      wbFormIDCk(NAM2, 'Water', [WATR]),
      wbFormIDCk(NAM3, 'LOD Water Type', [WATR]),
      wbFloat(NAM4, 'LOD Water Height'),
      wbStruct(DNAM, 'Land Data', [
        wbFloat('Default Land Height'),
        wbFloat('Default Water Height')
      ]),
      wbICON,
      wbStruct(MNAM, 'Map Data', [
        wbStruct('Usable Dimensions', [
          wbInteger('X', itS32),
          wbInteger('Y', itS32)
        ]),
        wbStruct('Cell Coordinates', [
          wbStruct('NW Cell', [
            wbInteger('X', itS16),
            wbInteger('Y', itS16)
          ]),
          wbStruct('SE Cell', [
            wbInteger('X', itS16),
            wbInteger('Y', itS16)
          ])
        ])
      ]),
      wbStruct(ONAM, 'World Map Offset Data', [
        wbFloat('World Map Scale'),
        wbFloat('Cell X Offset'),
        wbFloat('Cell Y Offset')
      ], cpNormal, True),
      wbFormIDCk(INAM, 'Image Space', [IMGS]),
      wbInteger(DATA, 'Flags', itU8, wbFlags([
        {0x01} 'Small World',
        {0x02} 'Can''t Fast Travel',
        {0x04} '',
        {0x08} '',
        {0x10} 'No LOD Water',
        {0x20} 'No LOD Noise',
        {0x40} 'Don''t Allow NPC Fall Damage',
        {0x80} 'Needs Water Adjustment'
      ]), cpNormal, True),
      wbWorldspaceOBND,
      wbFormIDCk(ZNAM, 'Music', [MUSC]),
      wbString(NNAM, 'Canopy Shadow', 0, cpNormal, True),
      wbString(XNAM, 'Water Noise Texture', 0, cpNormal, True),
      wbRArrayS('Swapped Impacts', wbStructExSK(IMPS, [0, 1], [2], 'Swapped Impact', [
        wbInteger('Material Type', itU32, wbImpactMaterialTypeEnum),
        wbFormIDCkNoReach('Old', [IPCT]),
        wbFormIDCk('New', [IPCT, NULL])
      ])),
      wbArray(IMPF, 'Footstep Materials', wbString('Unknown', 30), [
        'ConcSolid',
        'ConcBroken',
        'MetalSolid',
        'MetalHollow',
        'MetalSheet',
        'Wood',
        'Sand',
        'Dirt',
        'Grass',
        'Water'
      ]),
      wbByteArray(OFST, 'Offset Data')
    ], False, nil, cpNormal, False, wbRemoveOFST)
  else
    wbRecord(WRLD, 'Worldspace', [
      wbEDIDReq,
      wbFULL,
      wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),
      wbRStruct('Parent', [
        wbFormIDCk(WNAM, 'Worldspace', [WRLD]),
        wbStruct(PNAM, '', [
          wbInteger('Flags', itU8, wbFlags([
            {0x00000001}'Use Land Data',
            {0x00000002}'Use LOD Data',
            {0x00000004}'Use Map Data',
            {0x00000008}'Use Water Data',
            {0x00000010}'Use Climate Data',
            {0x00000020}'Use Image Space Data',
            {0x00000040}'',
            {0x00000080}'Needs Water Adjustment'
          ], True)),
          wbByteArray('Unknown', 1)
        ], cpNormal, True)
      ], []),
      wbFormIDCk(CNAM, 'Climate', [CLMT]),
      wbFormIDCk(NAM2, 'Water', [WATR]),
      wbFormIDCk(NAM3, 'LOD Water Type', [WATR]),
      wbFloat(NAM4, 'LOD Water Height'),
      wbStruct(DNAM, 'Land Data', [
        wbFloat('Default Land Height'),
        wbFloat('Default Water Height')
      ]),
      wbICON,
      wbStruct(MNAM, 'Map Data', [
        wbStruct('Usable Dimensions', [
          wbInteger('X', itS32),
          wbInteger('Y', itS32)
        ]),
        wbStruct('Cell Coordinates', [
          wbStruct('NW Cell', [
            wbInteger('X', itS16),
            wbInteger('Y', itS16)
          ]),
          wbStruct('SE Cell', [
            wbInteger('X', itS16),
            wbInteger('Y', itS16)
          ])
        ])
      ]),
      wbStruct(ONAM, 'World Map Offset Data', [
        wbFloat('World Map Scale'),
        wbFloat('Cell X Offset'),
        wbFloat('Cell Y Offset')
      ], cpNormal, True),
      wbFormIDCk(INAM, 'Image Space', [IMGS]),
      wbInteger(DATA, 'Flags', itU8, wbFlags([
        {0x01} 'Small World',
        {0x02} 'Can''t Fast Travel',
        {0x04} '',
        {0x08} '',
        {0x10} 'No LOD Water',
        {0x20} 'No LOD Noise',
        {0x40} 'Don''t Allow NPC Fall Damage',
        {0x80} 'Needs Water Adjustment'
      ]), cpNormal, True),
      wbWorldspaceOBND,
      wbFormIDCk(ZNAM, 'Music', [MUSC]),
      wbString(NNAM, 'Canopy Shadow', 0, cpNormal, True),
      wbString(XNAM, 'Water Noise Texture', 0, cpNormal, True),
      wbRArrayS('Swapped Impacts', wbStructExSK(IMPS, [0, 1], [2], 'Swapped Impact', [
        wbInteger('Material Type', itU32, wbImpactMaterialTypeEnum),
        wbFormIDCkNoReach('Old', [IPCT]),
        wbFormIDCk('New', [IPCT, NULL])
      ])),
      wbArray(IMPF, 'Footstep Materials', wbString('Unknown', 30), [
        'ConcSolid',
        'ConcBroken',
        'MetalSolid',
        'MetalHollow',
        'MetalSheet',
        'Wood',
        'Sand',
        'Dirt',
        'Grass',
        'Water'
      ]),
      wbOFST
    ], False, nil, cpNormal, False, wbRemoveOFST);

  wbRecord(WTHR, 'Weather', [
    wbEDIDReq,
    wbFormIDCk(_0_IAD, 'Sunrise Image Space Modifier', [IMAD]),
    wbFormIDCk(_1_IAD, 'Day Image Space Modifier', [IMAD]),
    wbFormIDCk(_2_IAD, 'Sunset Image Space Modifier', [IMAD]),
    wbFormIDCk(_3_IAD, 'Night Image Space Modifier', [IMAD]),
    wbString(DNAM, 'Cloud Textures - Layer 0', 0, cpNormal, True),
    wbString(CNAM, 'Cloud Textures - Layer 1', 0, cpNormal, True),
    wbString(ANAM, 'Cloud Textures - Layer 2', 0, cpNormal, True),
    wbString(BNAM, 'Cloud Textures - Layer 3', 0, cpNormal, True),
    wbGenericModel,
    wbByteArray(LNAM, 'Unknown', 4, cpNormal, True),
    wbArray(ONAM, 'Cloud Speed', wbInteger('Layer', itU8{, wbDiv(2550)}), 4, nil, nil, cpNormal, True),
    wbArray(PNAM, 'Cloud Layer Colors',
      wbArray('Layer',
        wbStruct('Color', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unused', 1)
        ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
        ['Sunrise', 'Day', 'Sunset', 'Night']
      ),
    4),
    wbArray(NAM0, 'Colors by Types/Times',
      wbArray('Type',
        wbStruct('Time', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unused', 1)
        ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
        ['Sunrise', 'Day', 'Sunset', 'Night']
      ),
      ['Sky-Upper','Fog','Unused','Ambient','Sunlight','Sun','Stars','Sky-Lower','Horizon','Unused']
    , cpNormal, True),
    wbStruct(FNAM, 'Fog Distance', [
      wbFloat('Day - Near'),
      wbFloat('Day - Far'),
      wbFloat('Night - Near'),
      wbFloat('Night - Far'),
      wbFloat('Day - Power'),
      wbFloat('Night - Fower')
    ], cpNormal, True),
    wbByteArray(INAM, 'Unused', 304, cpIgnore, True),
    wbStruct(DATA, '', [
      wbInteger('Wind Speed', itU8),
      wbInteger('Cloud Speed (Lower)', itU8),
      wbInteger('Cloud Speed (Upper)', itU8),
      wbInteger('Trans Delta', itU8),
      wbInteger('Sun Glare', itU8),
      wbInteger('Sun Damage', itU8),
      wbInteger('Precipitation - Begin Fade In', itU8),
      wbInteger('Precipitation - End Fade Out', itU8),
      wbInteger('Thunder/Lightning - Begin Fade In', itU8),
      wbInteger('Thunder/Lightning - End Fade Out', itU8),
      wbInteger('Thunder/Lightning - Frequency', itU8),
      wbInteger('Weather Classification', itU8, wbWthrDataClassification),
      wbStruct('Lightning Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA)
    ], cpNormal, True),
    wbWeatherSounds
  ]);

  wbAddGroupOrder(GMST);
  wbAddGroupOrder(TXST);
  wbAddGroupOrder(MICN);
  wbAddGroupOrder(GLOB);
  wbAddGroupOrder(CLAS);
  wbAddGroupOrder(FACT);
  wbAddGroupOrder(HDPT);
  wbAddGroupOrder(HAIR);
  wbAddGroupOrder(EYES);
  wbAddGroupOrder(RACE);
  wbAddGroupOrder(SOUN);
  wbAddGroupOrder(ASPC);
  wbAddGroupOrder(MGEF);
  wbAddGroupOrder(SCPT);
  wbAddGroupOrder(LTEX);
  wbAddGroupOrder(ENCH);
  wbAddGroupOrder(SPEL);
  wbAddGroupOrder(ACTI);
  wbAddGroupOrder(TACT);
  wbAddGroupOrder(TERM);
  wbAddGroupOrder(ARMO);
  wbAddGroupOrder(BOOK);
  wbAddGroupOrder(CONT);
  wbAddGroupOrder(DOOR);
  wbAddGroupOrder(INGR);
  wbAddGroupOrder(LIGH);
  wbAddGroupOrder(MISC);
  wbAddGroupOrder(STAT);
  wbAddGroupOrder(SCOL);
  wbAddGroupOrder(MSTT);
  wbAddGroupOrder(PWAT);
  wbAddGroupOrder(GRAS);
  wbAddGroupOrder(TREE);
  wbAddGroupOrder(FURN);
  wbAddGroupOrder(WEAP);
  wbAddGroupOrder(AMMO);
  wbAddGroupOrder(NPC_);
  wbAddGroupOrder(PLYR);
  wbAddGroupOrder(CREA);
  wbAddGroupOrder(LVLC);
  wbAddGroupOrder(LVLN);
  wbAddGroupOrder(KEYM);
  wbAddGroupOrder(ALCH);
  wbAddGroupOrder(IDLM);
  wbAddGroupOrder(NOTE);
  wbAddGroupOrder(PROJ);
  wbAddGroupOrder(LVLI);
  wbAddGroupOrder(WTHR);
  wbAddGroupOrder(CLMT);
  wbAddGroupOrder(COBJ);
  wbAddGroupOrder(REGN);
  wbAddGroupOrder(NAVI);
  wbAddGroupOrder(CELL);
  wbAddGroupOrder(WRLD);
  wbAddGroupOrder(DIAL);
  wbAddGroupOrder(QUST);
  wbAddGroupOrder(IDLE);
  wbAddGroupOrder(PACK);
  wbAddGroupOrder(CSTY);
  wbAddGroupOrder(LSCR);
  wbAddGroupOrder(ANIO);
  wbAddGroupOrder(WATR);
  wbAddGroupOrder(EFSH);
  wbAddGroupOrder(EXPL);
  wbAddGroupOrder(DEBR);
  wbAddGroupOrder(IMGS);
  wbAddGroupOrder(IMAD);
  wbAddGroupOrder(FLST);
  wbAddGroupOrder(PERK);
  wbAddGroupOrder(BPTD);
  wbAddGroupOrder(ADDN);
  wbAddGroupOrder(AVIF);
  wbAddGroupOrder(RADS);
  wbAddGroupOrder(CAMS);
  wbAddGroupOrder(CPTH);
  wbAddGroupOrder(VTYP);
  wbAddGroupOrder(IPCT);
  wbAddGroupOrder(IPDS);
  wbAddGroupOrder(ARMA);
  wbAddGroupOrder(ECZN);
  wbAddGroupOrder(MESG);
  wbAddGroupOrder(RGDL);
  wbAddGroupOrder(DOBJ);
  wbAddGroupOrder(LGTM);
  wbAddGroupOrder(MUSC);
end;

procedure DefineFO3;
begin
  wbNexusModsUrl := 'https://www.nexusmods.com/fallout3/mods/637';
  if wbToolMode = tmLODgen then
    wbNexusModsUrl := 'https://www.nexusmods.com/fallout3/mods/21174';
  DefineFO3a;
  DefineFO3b;
  DefineFO3c;
  DefineFO3d;
  DefineFO3e;
  DefineFO3f;
end;

end.
