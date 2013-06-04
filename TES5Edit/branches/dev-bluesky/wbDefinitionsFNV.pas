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

unit wbDefinitionsFNV;

interface

procedure DefineFNV;

implementation

uses
  Types, Classes, SysUtils, Math, Variants,
  wbInterface;

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
  _4_IAD : TwbSignature = #4'IAD';
  _5_IAD : TwbSignature = #5'IAD';
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
  MMRK : TwbSignature = 'MMRK';
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
  DAT2 : TwbSignature = 'DAT2';
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
  RDID : TwbSignature = 'RDID';
  RDSI : TwbSignature = 'RDSI';
  RDSB : TwbSignature = 'RDSB';
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
  VANM : TwbSignature = 'VANM';
  MOD3 : TwbSignature = 'MOD3';
  MOD4 : TwbSignature = 'MOD4';
  MODB : TwbSignature = 'MODB';
  MODD : TwbSignature = 'MODD';
  MODL : TwbSignature = 'MODL';
  MODS : TwbSignature = 'MODS';
  MODT : TwbSignature = 'MODT';
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
  XSRF : TwbSignature = 'XSRF';
  XSRD : TwbSignature = 'XSRD';
  MWD1 : TwbSignature = 'MWD1';
  MWD2 : TwbSignature = 'MWD2';
  MWD3 : TwbSignature = 'MWD3';
  MWD4 : TwbSignature = 'MWD4';
  MWD5 : TwbSignature = 'MWD5';
  MWD6 : TwbSignature = 'MWD6';
  MWD7 : TwbSignature = 'MWD7';
  WNM1 : TwbSignature = 'WNM1';
  WNM2 : TwbSignature = 'WNM2';
  WNM3 : TwbSignature = 'WNM3';
  WNM4 : TwbSignature = 'WNM4';
  WNM5 : TwbSignature = 'WNM5';
  WNM6 : TwbSignature = 'WNM6';
  WNM7 : TwbSignature = 'WNM7';
  WMI1 : TwbSignature = 'WMI1';
  WMI2 : TwbSignature = 'WMI2';
  WMI3 : TwbSignature = 'WMI3';
  WMS1 : TwbSignature = 'WMS1';
  WMS2 : TwbSignature = 'WMS2';
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
  OFST : TwbSignature = 'OFST';
  ONAM : TwbSignature = 'ONAM';
  PACK : TwbSignature = 'PACK';
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
  TDUM : TwbSignature = 'TDUM';
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
  RCIL : TwbSignature = 'RCIL';
  RCQY : TwbSignature = 'RCQY';
  RCOD : TwbSignature = 'RCOD';
  QOBJ : TwbSignature = 'QOBJ';
  QSDT : TwbSignature = 'QSDT';
  QSTA : TwbSignature = 'QSTA';
  QSTI : TwbSignature = 'QSTI';
  TPIC : TwbSignature = 'TPIC';
  QSTR : TwbSignature = 'QSTR';
  INFC : TwbSignature = 'INFC';
  INFX : TwbSignature = 'INFX';
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
  SCDA : TwbSignature = 'SCDA';
  SCHR : TwbSignature = 'SCHR';
  SCOL : TwbSignature = 'SCOL';
  SCPT : TwbSignature = 'SCPT';
  SCRI : TwbSignature = 'SCRI';
  SCRN : TwbSignature = 'SCRN';
  SCRO : TwbSignature = 'SCRO';
  SCRV : TwbSignature = 'SCRV';
  SCTX : TwbSignature = 'SCTX';
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
  BRUS : TwbSignature = 'BRUS';
  TACT : TwbSignature = 'TACT';
  TCLF : TwbSignature = 'TCLF';
  TCFU : TwbSignature = 'TCFU';
  TCLT : TwbSignature = 'TCLT';
  TERM : TwbSignature = 'TERM';
  TES4 : TwbSignature = 'TES4';
  TNAM : TwbSignature = 'TNAM';
  TPLT : TwbSignature = 'TPLT';
  TRDT : TwbSignature = 'TRDT';
  TREE : TwbSignature = 'TREE';
  TX00 : TwbSignature = 'TX00';
  TX01 : TwbSignature = 'TX01';
  INTV : TwbSignature = 'INTV';
  TX02 : TwbSignature = 'TX02';
  TX03 : TwbSignature = 'TX03';
  TX04 : TwbSignature = 'TX04';
  TX05 : TwbSignature = 'TX05';
  TXST : TwbSignature = 'TXST';
  UNAM : TwbSignature = 'UNAM';
  VATS : TwbSignature = 'VATS';
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
  XATO : TwbSignature = 'XATO';
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
  XTEL : TwbSignature = 'XTEL';
  XTRG : TwbSignature = 'XTRG';
  XTRI : TwbSignature = 'XTRI';
  XXXX : TwbSignature = 'XXXX';
  YNAM : TwbSignature = 'YNAM';
  ZNAM : TwbSignature = 'ZNAM';
  IMOD : TwbSignature = 'IMOD';
  REPU : TwbSignature = 'REPU';
  RCPE : TwbSignature = 'RCPE';
  RCCT : TwbSignature = 'RCCT';
  CHIP : TwbSignature = 'CHIP';
  CSNO : TwbSignature = 'CSNO';
  LSCT : TwbSignature = 'LSCT';
  MSET : TwbSignature = 'MSET';
  ALOC : TwbSignature = 'ALOC';
  CHAL : TwbSignature = 'CHAL';
  AMEF : TwbSignature = 'AMEF';
  CCRD : TwbSignature = 'CCRD';
  CARD : TwbSignature = 'CARD';
  CMNY : TwbSignature = 'CMNY';
  CDCK : TwbSignature = 'CDCK';
  DEHY : TwbSignature = 'DEHY';
  HUNG : TwbSignature = 'HUNG';
  SLPD : TwbSignature = 'SLPD';

var
  wbPKDTSpecificFlagsUnused : Boolean;
  wbEDID: IwbSubRecordDef;
  wbEDIDReq: IwbSubRecordDef;
  wbBMDT: IwbSubRecordDef;
  wbYNAM: IwbSubRecordDef;
  wbZNAM: IwbSubRecordDef;
  wbCOED: IwbSubRecordDef;
  wbXLCM: IwbSubRecordDef;
  wbEITM: IwbSubRecordDef;
  wbREPL: IwbSubRecordDef;
  wbBIPL: IwbSubRecordDef;
  wbOBND: IwbSubRecordDef;
  wbOBNDReq: IwbSubRecordDef;
  wbDEST: IwbSubRecordStructDef;
  wbDESTActor: IwbSubRecordStructDef;
  wbDODT: IwbSubRecordDef;
  wbXOWN: IwbSubRecordDef;
  wbXGLB: IwbSubRecordDef;
  wbXRGD: IwbSubRecordDef;
  wbXRGB: IwbSubRecordDef;
  wbSpecializationEnum: IwbEnumDef;
  wbWeaponAnimTypeEnum: IwbEnumDef;
  wbReloadAnimEnum: IwbEnumDef;
  wbMusicEnum: IwbEnumDef;
  wbSoundLevelEnum: IwbEnumDef;
  wbSLSD: IwbSubRecordDef;
  wbHeadPartIndexEnum: IwbEnumDef;
  wbBodyPartIndexEnum: IwbEnumDef;
  wbAttackAnimationEnum: IwbEnumDef;
  wbImpactMaterialTypeEnum: IwbEnumDef;
  wbCreatureTypeEnum: IwbEnumDef;
  wbPlayerActionEnum: IwbEnumDef;
  wbBodyLocationEnum: IwbEnumDef;
  wbSPLO: IwbSubRecordDef;
  wbSPLOs: IwbSubRecordArrayDef;
  wbCNTO: IwbSubRecordStructDef;
  wbCNTOs: IwbSubRecordArrayDef;
  wbAIDT: IwbSubRecordDef;
  wbCSDT: IwbSubRecordStructDef;
  wbCSDTs: IwbSubRecordArrayDef;
  wbFULL: IwbSubRecordDef;
  wbFULLActor: IwbSubRecordDef;
  wbFULLReq: IwbSubRecordDef;
  wbXNAM: IwbSubRecordDef;
  wbXNAMs: IwbSubRecordArrayDef;
  wbDESC: IwbSubRecordDef;
  wbDESCReq: IwbSubRecordDef;
  wbXSCL: IwbSubRecordDef;
  wbDATAPosRot : IwbSubRecordDef;
  wbPosRot : IwbStructDef;
  wbMODD: IwbSubRecordDef;
  wbMOSD: IwbSubRecordDef;
  wbMODL: IwbSubRecordStructDef;
  wbMODS: IwbSubRecordDef;
  wbMO2S: IwbSubRecordDef;
  wbMO3S: IwbSubRecordDef;
  wbMO4S: IwbSubRecordDef;
  wbMODLActor: IwbSubRecordStructDef;
  wbMODLReq: IwbSubRecordStructDef;
  wbCTDA: IwbSubRecordDef;
  wbSCHRReq: IwbSubRecordDef;
  wbCTDAs: IwbSubRecordArrayDef;
  wbCTDAsReq: IwbSubRecordArrayDef;
  wbSCROs: IwbSubRecordArrayDef;
  wbPGRP: IwbSubRecordDef;
  wbEmbeddedScript: IwbSubRecordStructDef;
  wbEmbeddedScriptPerk: IwbSubRecordStructDef;
  wbEmbeddedScriptReq: IwbSubRecordStructDef;
  wbSCRI: IwbSubRecordDef;
  wbSCRIActor: IwbSubRecordDef;
  wbFaceGen: IwbSubRecordStructDef;
  wbFaceGenNPC: IwbSubRecordStructDef;
  wbENAM: IwbSubRecordDef;
  wbFGGS: IwbSubRecordDef;
  wbXLOD: IwbSubRecordDef;
  wbXESP: IwbSubRecordDef;
  wbICON: IwbSubRecordStructDef;
  wbICONReq: IwbSubRecordStructDef;
  wbActorValue: IwbIntegerDef;
  wbModEffectEnum: IwbEnumDef;
  wbCrimeTypeEnum: IwbEnumDef;
  wbVatsValueFunctionEnum: IwbEnumDef;
  wbSkillEnum: IwbEnumDef;
  wbETYP: IwbSubRecordDef;
  wbETYPReq: IwbSubRecordDef;
  wbEquipTypeEnum: IwbEnumDef;
  wbFormTypeEnum: IwbEnumDef;
  wbMenuModeEnum: IwbEnumDef;
  wbMiscStatEnum: IwbEnumDef;
  wbAlignmentEnum: IwbEnumDef;
  wbAxisEnum: IwbEnumDef;
  wbCriticalStageEnum: IwbEnumDef;
  wbSexEnum: IwbEnumDef;
  wbServiceFlags: IwbFlagsDef;
  wbPKDTType: IwbEnumDef;
  wbPKDTFlags: IwbFlagsDef;
  wbObjectTypeEnum: IwbEnumDef;
  wbQuadrantEnum: IwbEnumDef;
  wbBlendModeEnum: IwbEnumDef;
  wbBlendOpEnum: IwbEnumDef;
  wbZTestFuncEnum: IwbEnumDef;
  wbEFID: IwbSubRecordDef;
  wbEFIT: IwbSubRecordDef;
  wbFunctionsEnum: IwbEnumDef;
  wbEffects: IwbSubRecordArrayDef;
  wbEffectsReq: IwbSubRecordArrayDef;

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
      Flags := Container.ElementNativeValues['..\..\标志'];
      IsExternal := Flags and (Cardinal(1) shl Index) <> 0;
    end;
  end;

  if IsExternal then begin
    case aType of
      ctToStr: begin
        Result := IntToStr(aInt);
        if Container.ElementExists['..\..\..\..\NVEX\连接 #' + IntToStr(aInt)] then
          Result := Result + ' (三角 #' +
            Container.ElementValues['..\..\..\..\NVEX\连接 #' + IntToStr(aInt) + '\三角'] + ' in ' +
            Container.ElementValues['..\..\..\..\NVEX\连接 #' + IntToStr(aInt) + '\导航模型'] + ')'
        else
          Result := Result + ' <Error: NVEX\连接 #' + IntToStr(aInt) + ' 丢失>';
      end;
      ctToSortKey:
        if Container.ElementExists['..\..\..\..\NVEX\连接 #' + IntToStr(aInt)] then
          Result :=
            Container.ElementSortKeys['..\..\..\..\NVEX\连接 #' + IntToStr(aInt) + '\导航模型', True] + '|' +
            Container.ElementSortKeys['..\..\..\..\NVEX\连接 #' + IntToStr(aInt) + '\三角', True];
      ctCheck:
        if Container.ElementExists['..\..\..\..\NVEX\连接 #' + IntToStr(aInt)] then
          Result := ''
        else
          Result := 'NVEX\连接 #' + IntToStr(aInt) + ' 丢失';
    end
  end else
    case aType of
      ctToStr: Result := IntToStr(aInt);
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
    ctToStr: Result := wbActorValueEnum.ToString(aInt, aElement);
    ctToSortKey: Result := wbActorValueEnum.ToSortKey(aInt, aElement);
    ctCheck: Result := wbActorValueEnum.Check(aInt, aElement);
    ctToEditValue: Result := wbActorValueEnum.ToEditValue(aInt, aElement);
    ctEditType: Result := 'ComboBox';
    ctEditInfo: Result := wbActorValueEnum.EditInfo[aInt, aElement];
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

  Script := Script.HighestOverrideOrSelf[aElement._File.LoadOrder];

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
    ctToStr: Result := IntToStr(aInt) + ' <Warning: Could not resolve Quest>';
    ctToEditValue: Result := IntToStr(aInt);
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Quest>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not Assigned(aElement) then Exit;
  Container := GetContainerRefFromUnionOrValue(aElement);
  if not Assigned(Container) then Exit;

  Param1 := Container.ElementByName['任务'];

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
    if Supports(MainRecord.ElementByName['目标'], IwbContainerElementRef, Objectives) then begin
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
              ctToStr, ctToEditValue: Result := t;
              ctCheck: Result := '';
            end;
            Exit;
          end;
        end;
    end;

    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: Quest Objective not found in "' + MainRecord.Name + '">';
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

function wbCTDAParam2QuestObjectiveToInt(const aString: string; const aElement: IwbElement): Int64;
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
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 4)
  else if aType = ctToStr then
    Result := TimeToStr( EncodeTime(aInt div 6, (aInt mod 6) * 10, 0, 0) )
  else
    Result := '';
end;

function wbAlocTime(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 4)
  else if aType = ctToStr then
    Result := TimeToStr( aInt / 256 )
  else
    Result := '';
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
      Result := '等于,大于,小于,或者,"使用全局","Run on Target"';
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

function wbCtdaTypeToInt(const aString: string; const aElement: IwbElement): Int64;
var
  s: string;
begin
  s := aString + '000000';
//  Result := 0;
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
  if s[4] = '1' then
    Result := Result or $01;
  if s[6] = '1' then
    Result := Result or $02;
  if s[5] = '1' then
    Result := Result or $04;
end;

procedure wbMESGDNAMAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  OldValue, NewValue : Integer;
  Container          : IwbContainerElementRef;
begin
  if VarSameValue(aOldValue, aNewValue) then
    Exit;
  if Supports(aElement.Container, IwbContainerElementRef, Container) then begin
    OldValue := Integer(aOldValue) and 1;
    NewValue := Integer(aNewValue) and 1;
    if NewValue = OldValue then
      Exit;
    if NewValue = 1 then
      Container.RemoveElement('TNAM')
    else
      Container.Add('TNAM', True);
  end;
end;

procedure wbGMSTEDIDAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  OldValue, NewValue : string;
  Container          : IwbContainerElementRef;
begin
  if VarSameValue(aOldValue, aNewValue) then
    Exit;
  if Supports(aElement.Container, IwbContainerElementRef, Container) then begin
    OldValue := aOldValue;
    NewValue := aNewValue;
    if (Length(OldValue) < 1) or (Length(OldValue) < 1) or (OldValue[1] <> NewValue[1]) then begin
      Container.RemoveElement('DATA');
      Container.Add('DATA', True);
    end;
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
  if Supports(aElement.Container, IwbContainerElementRef, Container) then begin
    OldValue := aOldValue;
    NewValue := aNewValue;

    if Length(OldValue) > Length(OrderedList) then
      Delete(OldValue, 1, Length(OldValue)-Length(OrderedList));
    if Length(NewValue) > Length(OrderedList) then
      Delete(NewValue, 1, Length(NewValue)-Length(OrderedList));

    OldOrdered := SameText(OldValue, OrderedList);
    NewOrdered := SameText(NewValue, OrderedList);

    if OldOrdered <> NewOrdered then
      Container.RemoveElement('表单序号');
  end;
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

  OldValue := aOldValue and $04;
  NewValue := aNewValue and $04;
  if OldValue <> NewValue then
    Container.ElementNativeValues['..\比较值'] := 0;

  if aNewValue and $02 then begin
    Container.ElementNativeValues['..\运行于'] := 1;
    if Integer(Container.ElementNativeValues['..\运行于']) = 1 then
      aElement.NativeValue := Byte(aNewValue) and not $02;
  end;
end;

function wbMODTCallback(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Strings: TDynStrings;
  i: Integer;
begin
  Result := '';
  if wbLoaderDone and (aType in [ctToStr, ctToSortKey] ) then begin
    Strings := wbContainerHandler.ResolveHash(aInt);
    for i := Low(Strings) to High(Strings) do
      Result := Result + Strings[i] + ', ';
    SetLength(Result, Length(Result) -2 );
  end;
end;


function wbIdleAnam(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr: begin
      case aInt and not $C0 of
        0: Result := 'Idle';
        1: Result := 'Movement';
        2: Result := 'Left Arm';
        3: Result := '左手';
        4: Result := '武器';
        5: Result := 'Weapon Up';
        6: Result := 'Weapon Down';
        7: Result := 'Special Idle';
       20: Result := 'Whole Body';
       21: Result := 'Upper Body';
      else
        Result := '<未知: '+IntToStr(aInt and not $C0)+'>';
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
        Result := '<未知: '+IntToStr(aInt and not $C0)+'>';
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
      Result := Result + '位于 ' + s;
    end;
  end;
end;

function wbINFOAddInfo(const aMainRecord: IwbMainRecord): string;
var
  Container: IwbContainer;
  s: string;
begin
  Result := Trim(aMainRecord.ElementValues['回复\回复\NAM1']);
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
      Result := Result + '位于 ' + s;
    end;
  end;

  s := Trim(aMainRecord.ElementValues['QSTI']);
  if s <> '' then begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + '给 ' + s;
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
  if Assigned(Rec) then begin
    Element := Rec.ElementByName['场景'];
    if Assigned(Element) then
      Element := Element.LinksTo;
    if Assigned(Element) then
      s := Trim(Element.Name);
    if s <> '' then
      Result := '给 ' + s;
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

function wbWthrDataClassification(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr: begin
      case aInt and not 192 of
        0: Result := '无';
        1: Result := '晴朗';
        2: Result := '多云';
        4: Result := '下雨';
        8: Result := '下雪';
      else
        Result := '<未知: '+IntToStr(aInt and not 192)+'>';
      end;
    end;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2)
    end;
    ctCheck: begin
      case aInt and not 192 of
        0, 1, 2, 4, 8: Result := '';
      else
        Result := '<未知: '+IntToStr(aInt and not 192)+'>';
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
    Result := (Cardinal(aBasePtr) - Cardinal(aBasePtr)) div 4
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
    Assert(DataContainer.Name = '数据');
    Result := PWord(Cardinal(DataContainer.DataBasePtr) + 3*3*4)^;
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
    Assert(DataContainer.Name = '数据');
    Result := PWord(Cardinal(DataContainer.DataBasePtr) + 3*3*4 + 2)^;
  end;
end;

procedure wbCTDARunOnAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  if aOldValue <> aNewValue then
    if aNewValue <> 2 then
      aElement.Container.ElementNativeValues['衍生'] := 0;
end;

procedure wbPERKPRKETypeAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container : IwbContainerElementRef;
//  rDATA     : IwbRecord;
begin
  if aOldValue <> aNewValue then
    if Supports(aElement.Container, IwbContainerElementRef, Container) then begin
      if Supports(Container.Container, IwbContainerElementRef, Container) then begin
        Container.RemoveElement('DATA');
        Container.Add('DATA', True);
        Container.RemoveElement('天赋条件');
        Container.RemoveElement('记录点函数参数');
        if aNewValue = 2 then begin
          Container.Add('EPFT', True);
          Container.ElementNativeValues['DATA\记录点\函数'] := 2;
        end;
      end;
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
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  VarClear(ArchType);
  Element := Container.ElementByName['原型'];
  if Assigned(Element) then
    ArchType := Element.NativeValue
  else if Supports(Container, IwbDataContainer, DataContainer) and
          DataContainer.IsValidOffset(aBasePtr, aEndPtr, OffsetArchtype) then begin // we are part a proper structure
      aBasePtr := Pointer(Cardinal(aBasePtr) + OffsetArchtype);
      ArchType := PCardinal(aBasePtr)^;
    end;

  if not VarIsEmpty(ArchType) then
    case Integer(ArchType) of
      01: Result := 2;//Script
      18: Result := 3;//Bound Item
      19: Result := 4;//Summon Creature
    else
      Result := 0;
    end;
end;

procedure wbMGEFFAssocItemAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container : IwbContainer;
  Element   : IwbElement;
begin
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;
  if (aNewValue <> 0) then begin
    Element := Container.ElementByName['原型'];
    if Assigned(Element) and Element.NativeValue = 0 then
        Element.NativeValue := $FF; // Signals ArchType that it should not mess with us on the next change!
  end;
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
    Container.ElementNativeValues['..\关联道具'] := 0;
    case Integer(aNewValue) of
      11: Container.ElementNativeValues['..\角色数值'] := 48;//Invisibility
      12: Container.ElementNativeValues['..\角色数值'] := 49;//Chameleon
      24: Container.ElementNativeValues['..\角色数值'] := 47;//Paralysis
      36: Container.ElementNativeValues['..\角色数值'] := 51;//Turbo
    else
      Container.ElementNativeValues['..\角色数值'] := -1;
    end;
  end;
end;

function wbCTDAReferenceDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  if Integer(Container.ElementNativeValues['运行于']) = 2 then
    Result := 1;
end;

function wbNAVINVMIDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  case Integer(Container.ElementNativeValues['类型']) of
    $00: Result :=1;
    $20: Result :=2;
    $30: Result :=3;
  end;
end;

function wbIMGSSkinDimmerDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
  DataContainer : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;
  if Supports(Container.Container, IwbDataContainer, DataContainer) then begin
    if DataContainer.DataSize in [132, 148] then
      Result := 1;
  end;
end;

function wbCOEDOwnerDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container  : IwbContainer;
  LinksTo    : IwbElement;
  MainRecord : IwbMainRecord;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  LinksTo := Container.ElementByName['所有者'].LinksTo;

  if Supports(LinksTo, IwbMainRecord, MainRecord) then
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
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;
  i := Container.ElementByName['标志'].NativeValue;
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
  if Assigned(rEDID) then begin
    s := rEDID.Value;
    if Length(s) > 0 then
      case s[1] of
        's': Result := 0;
        'f': Result := 2;
      end;
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
  rEDID := aContainer.RecordBySignature[EDID];
  if Assigned(rEDID) then begin
    s := rEDID.Value;
    if Length(s) > Length(OrderedList) then
      Delete(s, 1, Length(s)-Length(OrderedList));
    if SameText(s, OrderedList) then
      Result := False;
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
    case (MainRecord.FormID and $FFFFFF) of
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
  if Assigned(rPRKE) then begin
    eType := rPRKE.ElementByName['类型'];
    if Assigned(eType) then begin
      Result := eType.NativeValue;
    end;
  end;
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
    if Integer(Container.ElementNativeValues['..\DATA\记录点\函数']) = 5 then
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
    ptReferencableObject, //TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM
    ptQuestObjective,     //?? Integer
    ptReputation,         //REPU
    ptRegion,             //REGN
    ptChallenge,          //CHAL
    ptCasino              //CSNO
  );

  PCTDAFunction = ^TCTDAFunction;
  TCTDAFunction = record
    Index: Integer;
    Name: string;
    ParamType1: TCTDAFunctionParamType;
    ParamType2: TCTDAFunctionParamType;
  end;

const
  wbCTDAFunctions : array[0..249] of TCTDAFunction = (
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
    (Index: 420; Name: 'GetObjectiveCompleted'; ParamType1: ptQuest; ParamType2: ptQuestObjective),
    (Index: 421; Name: 'GetObjectiveDisplayed'; ParamType1: ptQuest; ParamType2: ptQuestObjective),
    (Index: 427; Name: 'GetIsVoiceType'; ParamType1: ptVoiceType),
    (Index: 428; Name: 'GetPlantedExplosive'),
    (Index: 430; Name: 'IsActorTalkingThroughActivator'),
    (Index: 431; Name: 'GetHealthPercentage'),
    (Index: 433; Name: 'GetIsObjectType'; ParamType1: ptFormType),
    (Index: 435; Name: 'GetDialogueEmotion'),
    (Index: 436; Name: 'GetDialogueEmotionValue'),
    (Index: 438; Name: 'GetIsCreatureType'; ParamType1: ptCreatureType),
    (Index: 446; Name: 'GetInZone'; ParamType1: ptEncounterZone),
    (Index: 449; Name: 'HasPerk'; ParamType1: ptPerk; ParamType2: ptInteger{Alt?}),
    (Index: 450; Name: 'GetFactionRelation'; ParamType1: ptActor),
    (Index: 451; Name: 'IsLastIdlePlayed'; ParamType1: ptIdleForm),
    (Index: 454; Name: 'GetPlayerTeammate'),
    (Index: 455; Name: 'GetPlayerTeammateCount'),
    (Index: 459; Name: 'GetActorCrimePlayerEnemy'),
    (Index: 460; Name: 'GetActorFactionPlayerEnemy'),
    (Index: 462; Name: 'IsPlayerTagSkill'; ParamType1: ptActorValue),
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
    (Index: 573; Name: 'GetReputation'; ParamType1: ptReputation; ParamType2: ptInteger),
    (Index: 574; Name: 'GetReputationPct'; ParamType1: ptReputation; ParamType2: ptInteger),
    (Index: 575; Name: 'GetReputationThreshold'; ParamType1: ptReputation; ParamType2: ptInteger),
    (Index: 586; Name: 'IsHardcore'),
    (Index: 601; Name: 'GetForceHitReaction'),
    (Index: 607; Name: 'ChallengeLocked'; ParamType1: ptChallenge),
    (Index: 610; Name: 'GetCasinoWinningStage'; ParamType1: ptCasino),
    (Index: 612; Name: 'PlayerInRegion'; ParamType1: ptRegion),
    (Index: 614; Name: 'GetChallengeCompleted'; ParamType1: ptChallenge),
    (Index: 619; Name: 'IsAlwaysHardcore')
  );
var
  wbCTDAFunctionEditInfo: string;

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

function wbCTDAParam2VATSValueParam(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container : IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;
  Result := Container.ElementByName['参数 #1'].NativeValue;
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
    (Count: 2; Caption1: 'Perk Owner'; Caption2: '物品'),
    (Count: 2; Caption1: 'Perk Owner'; Caption2: '武器'),
    (Count: 3; Caption1: 'Perk Owner'; Caption2: '武器'; Caption3: '目标'),
    (Count: 2; Caption1: 'Perk Owner'; Caption2: '目标'),
    (Count: 2; Caption1: 'Perk Owner'; Caption2: '攻击者'),
    (Count: 3; Caption1: 'Perk Owner'; Caption2: '攻击者'; Caption3: 'Attackee'),
    (Count: 3; Caption1: 'Perk Owner'; Caption2: '攻击者'; Caption3: 'Attacker Weapon')
  );

  wbPERKFunctions : array[0..9] of TPERKFunction = (
    (Name: ''; FunctionType: epfUnknown; ParamType: epfpNone),
    (Name: '设置数值'; FunctionType: epfFloat; ParamType: epfpFloat),
    (Name: '添加数值（加）'; FunctionType: epfFloat; ParamType: epfpFloat),
    (Name: '添加数值（乘）'; FunctionType: epfFloat; ParamType: epfpFloat),
    (Name: '添加范围到数值'; FunctionType: epfFloat; ParamType: epfpFloatFloat),
    (Name: '添加角色数值加乘'; FunctionType: epfFloat; ParamType: epfpFloatFloat),
    (Name: '绝对值'; FunctionType: epfFloat; ParamType: epfpNone),
    (Name: '负绝对值'; FunctionType: epfFloat; ParamType: epfpNone),
    (Name: '添加等级列表'; FunctionType: epfLeveledItem; ParamType: epfpLeveledItem),
    (Name: '添加激活选项'; FunctionType: epfScript; ParamType: epfpScript)
  );

  wbPERKEntryPoints : array[0..73] of TPERKEntryPoint = (
    (Name: '计算武器伤害'; Condition: epcWeaponTarget),
    (Name: '计算我的致命攻击概率'; Condition: epcWeaponTarget),
    (Name: '计算我的致命攻击伤害'; Condition: epcWeaponTarget),
    (Name: 'Calculate Weapon Attack AP Cost'; Condition: epcWeapon),
    (Name: '计算地雷爆炸概率'; Condition: epcItem),
    (Name: 'Adjust Range Penalty'; Condition: epcWeapon),
    (Name: '调整肢体伤害'; Condition: epcAttackerAttackerWeapon),
    (Name: 'Calculate Weapon Range'; Condition: epcWeapon),
    (Name: 'Calculate To Hit Chance'; Condition: epcWeaponTarget),
    (Name: 'Adjust Experience Points'),
    (Name: 'Adjust Gained Skill Points'),
    (Name: '调整书籍技能点'),
    (Name: '修改生命恢复'),
    (Name: 'Calculate Inventory AP Cost'),
    (Name: 'Get Disposition'; Condition: epcTarget),
    (Name: '获取肩膀攻击'; Condition: epcAttacker),
    (Name: 'Get Should Assist'; Condition: epcAttackerAttackee),
    (Name: 'Calculate Buy Price'; Condition: epcItem),
    (Name: 'Get Bad Karma'),
    (Name: 'Get Good Karma'),
    (Name: 'Ignore Locked Terminal'),
    (Name: '添加死亡等级列表'; Condition: epcTarget; FunctionType: epfLeveledItem),
    (Name: '获取最大负重'),
    (Name: '修改上瘾概率'),
    (Name: '修改上瘾时长'),
    (Name: '修改主动化学时长'),
    (Name: 'Adjust Drinking Radiation'),
    (Name: '激活'; Condition: epcTarget; FunctionType: epfScript),
    (Name: 'Mysterious Stranger'),
    (Name: 'Has Paralyzing Palm'),
    (Name: 'Hacking Science Bonus'),
    (Name: '侦测时忽略跑步'),
    (Name: '忽略损坏的锁'),
    (Name: 'Has Concentrated Fire'),
    (Name: 'Calculate Gun Spread'; Condition: epcWeapon),
    (Name: 'Player Kill AP Reward'; Condition: epcWeaponTarget),
{36}(Name: '修改敌人致命攻击概率'; Condition: epcWeaponTarget),
{37}(Name: 'Reload Speed'; Condition: epcWeapon),
{38}(Name: 'Equip Speed'; Condition: epcWeapon),
{39}(Name: 'Action Point Regen'; Condition: epcWeapon),
{40}(Name: 'Action Point Cost'; Condition: epcWeapon),
{41}(Name: 'Miss Fortune'; Condition: epcDefault),
{42}(Name: 'Modify Run Speed'; Condition: epcDefault),
{43}(Name: 'Modify Attack Speed'; Condition: epcWeapon),
{44}(Name: 'Modify Radiation Consumed'; Condition: epcDefault),
{45}(Name: 'Has Pip Hacker'; Condition: epcDefault),
{46}(Name: 'Has Meltdown'; Condition: epcDefault),
{47}(Name: 'See Enemy Health'; Condition: epcDefault),
{48}(Name: 'Has Jury Rigging'; Condition: epcDefault),
{49}(Name: 'Modify Threat Range'; Condition: epcWeapon),
{50}(Name: 'Modify Thread'; Condition: epcWeapon),
{51}(Name: 'Has Fast Travel Always'; Condition: epcDefault),
{52}(Name: 'Knockdown Chance'; Condition: epcWeapon),
{53}(Name: 'Modify Weapon Strength Req'; Condition: epcWeapon),
{54}(Name: 'Modify Aiming Move Speed'; Condition: epcWeapon),
{55}(Name: 'Modify Light Items'; Condition: epcDefault),
{56}(Name: 'Modify Damage Threshold (defender)'; Condition: epcWeaponTarget),
{57}(Name: 'Modify Chance for Ammo Item'; Condition: epcWeapon),
{58}(Name: 'Modify Damage Threshold (attacker)'; Condition: epcWeaponTarget),
{59}(Name: 'Modify Throwing Velocity'; Condition: epcWeapon),
{60}(Name: 'Chance for Item on Fire'; Condition: epcWeapon),
{61}(Name: 'Has Unarmed Forward Power Attack'; Condition: epcDefault),
{62}(Name: 'Has Unarmed Back Power Attack'; Condition: epcWeaponTarget),
{63}(Name: 'Has Unarmed Crouched Power Attack'; Condition: epcDefault),
{64}(Name: 'Has Unarmed Counter Attack'; Condition: epcWeaponTarget),
{65}(Name: 'Has Unarmed Left Power Attack'; Condition: epcDefault),
{66}(Name: 'Has Unarmed Right Power Attack'; Condition: epcDefault),
{67}(Name: 'VATS HelperChance'; Condition: epcDefault),
{68}(Name: 'Modify Item Damage'; Condition: epcDefault),
{69}(Name: 'Has Improved Detection'; Condition: epcDefault),
{70}(Name: 'Has Improved Spotting'; Condition: epcDefault),
{71}(Name: 'Has Improved Item Detection'; Condition: epcDefault),
{72}(Name: 'Adjust Explosion Radius'; Condition: epcWeapon),
{73}(Name: 'Reserved'; Condition: epcWeapon)
  );

  wbPERKFunctionParams: array[TPERKEntryPointFunctionParamType] of string = (
    '无',
    '浮点数',
    '浮点数, 浮点数',
    '等级物品',
    '脚本'
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
    i := EntryPoint.ElementNativeValues['函数'];
    if (i >= Low(wbPERKFunctions)) and (i <= High(wbPERKFunctions)) then
      OldFunction := @wbPERKFunctions[i]
    else
      OldFunction := nil;
    if not Assigned(OldFunction) or (OldFunction.FunctionType <> NewEntryPoint.FunctionType) then
      for i := Low(wbPERKFunctions) to High(wbPERKFunctions) do
        with wbPERKFunctions[i] do
          if FunctionType = NewEntryPoint.FunctionType then begin
            EntryPoint.ElementNativeValues['函数'] := i;
            Break;
          end;
    EntryPoint.ElementNativeValues['天赋条件选项总数'] := NewCondition.Count;

    if not Supports(EntryPoint.Container, IwbContainerElementRef, Container) then
      Exit;
    if not Supports(Container.Container, IwbContainerElementRef, Effect) then
      Exit;

    if not Supports(Effect.ElementByName['天赋条件'], IwbContainerElementRef, PerkConditions) then
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
    ctToStr: Result := IntToStr(aInt) + ' <Warning: Could not resolve Entry Point>';
    ctToEditValue: Result := IntToStr(aInt);
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
  EntryPointVar := Container.ElementNativeValues['..\..\..\DATA\记录点\记录点'];
  if VarIsNull(EntryPointVar) or VarIsClear(EntryPointVar) then
    Exit;
  EntryPoint := EntryPointVar;
  if (EntryPoint < Low(wbPERKEntryPoints)) or (EntryPoint > High(wbPERKEntryPoints)) then begin
    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: Unknown Entry Point #'+IntToStr(EntryPoint)+'>';
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
            ctToStr: Result := IntToStr(aInt) + ' <Warning: Value out of Bounds for this Entry Point>';
            ctCheck: Result := '<Warning: Value out of Bounds for this Entry Point>';
          end
        else
          case aType of
            ctToStr, ctToEditValue: case Integer(aInt) of
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
  EntryPointVar := Container.ElementNativeValues['..\..\..\DATA\记录点\记录点'];
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

function wbNeverShow(const aElement: IwbElement): Boolean;
begin
  Result := wbHideNeverShow;
end;

function GetREGNType(aElement: IwbElement): Integer;
var
  Container: IwbContainerElementRef;
begin
  Result := -1;
  if not Assigned(aElement) then
    Exit;
  while aElement.Name <> '边缘数据记录' do begin
    aElement := aElement.Container;
    if not Assigned(aElement) then
      Exit;
  end;
  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;
  Result := Container.ElementNativeValues['RDAT\类型'];
end;

function wbREGNObjectsDontShow(const aElement: IwbElement): Boolean;
begin
  Result := GetREGNType(aElement) <> 2;
end;

function wbREGNWeatherDontShow(const aElement: IwbElement): Boolean;
begin
  Result := GetREGNType(aElement) <> 3;
end;

function wbREGNMapDontShow(const aElement: IwbElement): Boolean;
begin
  Result := GetREGNType(aElement) <> 4;
end;

function wbREGNLandDontShow(const aElement: IwbElement): Boolean;
begin
  Result := GetREGNType(aElement) <> 5;
end;

function wbREGNGrassDontShow(const aElement: IwbElement): Boolean;
begin
  Result := GetREGNType(aElement) <> 6;
end;

function wbREGNSoundDontShow(const aElement: IwbElement): Boolean;
begin
  Result := GetREGNType(aElement) <> 7;
end;

function wbREGNImposterDontShow(const aElement: IwbElement): Boolean;
begin
  Result := GetREGNType(aElement) <> 8;
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
  if aElement.Name <> '记录点函数参数' then
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
  if aElement.Name <> '记录点函数参数' then
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
  if aElement.Name <> '效果' then
    Exit;
  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;
  if Integer(Container.ElementNativeValues['PRKE\类型']) <> 2 then
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
    ctToStr: Result := IntToStr(aInt) + ' <Warning: Could not resolve Entry Point>';
    ctToEditValue: Result := IntToStr(aInt);
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
  EntryPointVar := Container.ElementNativeValues['..\记录点'];
  if VarIsNull(EntryPointVar) or VarIsClear(EntryPointVar) then
    Exit;
  EntryPoint := EntryPointVar;
  if (EntryPoint < Low(wbPERKEntryPoints)) or (EntryPoint > High(wbPERKEntryPoints)) then begin
    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: Unknown Entry Point #'+IntToStr(EntryPoint)+'>';
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
          ctToStr: Result := IntToStr(aInt) + ' <Warning: Unknown Function>';
          ctCheck: Result := '<Warning: Unknown Function>';
        end
      else
        case aType of
          ctToStr, ctToEditValue: begin
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
  EntryPointVar := Container.ElementNativeValues['..\记录点'];
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
  OldParamType := Container.ElementNativeValues['..\..\..\记录点函数参数\EPFT'];
  NewParamType := Ord(wbPERKFunctions[NewFunction].ParamType);
  if (OldParamType = NewParamType) and not VarSameValue(aOldValue, aNewValue) and (NewFunction in [4,5]) then
    Container.ElementNativeValues['..\..\..\记录点函数参数\EPFT'] := 0;
  Container.ElementNativeValues['..\..\..\记录点函数参数\EPFT'] := NewParamType;
end;

function wbPerkEPFTToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container       : IwbContainerElementRef;
  FunctionTypeVar : Variant;
  FunctionType    : Integer;
//  i               : Integer;
begin
  case aType of
    ctToStr: Result := IntToStr(aInt) + ' <Warning: Could not resolve Function>';
    ctToEditValue: Result := IntToStr(aInt);
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
  FunctionTypeVar := Container.ElementNativeValues['..\..\DATA\记录点\函数'];
  if VarIsNull(FunctionTypeVar) or VarIsClear(FunctionTypeVar) then
    Exit;
  FunctionType := FunctionTypeVar;
  if (FunctionType < Low(wbPERKFunctions)) or (FunctionType > High(wbPERKFunctions)) then begin
    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: Unknown Function #'+IntToStr(FunctionType)+'>';
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
          ctToStr: Result := IntToStr(aInt) + ' <Warning: Unknown Function Param Type>';
          ctCheck: Result := '<Warning: Unknown Function Param Type>';
        end
      else
        case aType of
          ctToStr, ctToEditValue: begin
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
  FunctionTypeVar := Container.ElementNativeValues['..\..\DATA\记录点\函数'];
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
  Element := aElement;
  MainRecord := nil;
  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;
  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\模版标志'];
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
  Element := aElement;
  MainRecord := nil;
  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;
  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\模版标志'];
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
  Element := aElement;
  MainRecord := nil;
  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;
  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\标志'];
    Result := (i and $00000010) <> 0;
  end;
end;

function wbActorTemplateUseStatsAutoCalc(const aElement: IwbElement): Boolean;
begin
  Result := wbActorTemplateUseStats(aElement) or wbActorAutoCalcDontShow(aElement);
end;

function wbActorTemplateUseFactions(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  Element := aElement;
  MainRecord := nil;
  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;
  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\模版标志'];
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
  Element := aElement;
  MainRecord := nil;
  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;
  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\模版标志'];
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
  Element := aElement;
  MainRecord := nil;
  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;
  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\模版标志'];
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
  Element := aElement;
  MainRecord := nil;
  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;
  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\模版标志'];
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
  Element := aElement;
  MainRecord := nil;
  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;
  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\模版标志'];
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
  Element := aElement;
  MainRecord := nil;
  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;
  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\模版标志'];
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
  Element := aElement;
  MainRecord := nil;
  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;
  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\模版标志'];
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
  Element := aElement;
  MainRecord := nil;
  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;
  if Assigned(MainRecord) then begin
    i := MainRecord.ElementNativeValues['ACBS\模版标志'];
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

    TypeFlags := Container.ElementNativeValues['类型'];
    if (TypeFlags and $02) <> 0 then begin
      if Container.DataSize = 20 then
        Container.DataSize := 28;
      Container.ElementNativeValues['类型'] := TypeFlags and not $02;
      Container.ElementEditValues['运行于'] := '目标';
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
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    OldActorValue := Container.ElementNativeValues['DATA - 数据\角色数值'];
    NewActorValue := OldActorValue;
    case Integer(Container.ElementNativeValues['DATA - 数据\原型']) of
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
      33, //Concussion
      35: //Limb Condition
        NewActorValue := -1;
      11: //Invisibility
        NewActorValue := 48; //Invisibility
      12: //Chameleon
        NewActorValue := 49; //Chameleon
      24: //Paralysis
        NewActorValue := 47; //Paralysis
      36: //Turbo
        NewActorValue := 51; //Turbo
    end;
    if OldActorValue <> NewActorValue then
      Container.ElementNativeValues['DATA - 数据\角色数值'] := NewActorValue;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbPACKAfterLoad(const aElement: IwbElement);
var
  Container     : IwbContainerElementRef;
  MainRecord    : IwbMainRecord;
//  OldContainer  : IwbContainerElementRef;
  NewContainer  : IwbContainerElementRef;
//  NewContainer2 : IwbContainerElementRef;
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

    case Integer(Container.ElementNativeValues['PKDT - General\类型']) of
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
             NewContainer.ElementEditValues['PLDT - Location 1\类型'] := '接近编辑器位置';
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
             NewContainer.ElementEditValues['PLDT - Location 1\类型'] := '接近连接的衍生';
        Container.Add('PKPT');
      end;
      14: begin {Guard}
      end;
      15: begin {Dialogue}
      end;
      16: begin {Use Weapon}
      end;
    end;

    {>>>
    Removing PLD2 actualy causes troubles
    http://forums.bethsoft.com/topic/1409718-wipz-tes5dumpfuture-tes5edit/page__view__findpost__p__21536789
    <<<}
//    if Supports(Container.RemoveElement('PLD2'), IwbContainerElementRef, OldContainer) then begin
//      if not Supports(Container.Add('Locations'), IwbContainerElementRef, NewContainer) then
//        Assert(False);
//      NewContainer.RemoveElement('PLD2');
//      NewContainer.AddElement(OldContainer);
//    end;
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
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
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
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
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
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    if (Integer(Container.ElementNativeValues['DATA\标志 1']) and $80) = 0 then
      Container.RemoveElement('DNAM');

    Container.RemoveElement('SNDD');

    if Container.ElementNativeValues['DATA\类型'] = 3 {Persuasion} then
      Container.ElementNativeValues['DATA\类型'] := 0 {Topic};
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
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    if (not Container.ElementExists['XCLW']) and ((Integer(Container.ElementNativeValues['DATA']) and $02) <> 0) then begin
      Container.Add('XCLW', True);
      Container.ElementEditValues['XCLW'] := '默认';
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

    if Container.ElementEditValues['SCHR\类型'] = '任务' then
      Container.ElementEditValues['SCHR\类型'] := '对象';
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
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    if Container.ElementExists['SNDD'] then
      Exit;

    if not Supports(Container.RemoveElement('SNDX - Sound Data'), IwbContainerElementRef, OldCntr) then
      Exit;
    if not Supports(Container.Add('SNDD', True), IwbContainerElementRef, NewCntr) then
      Exit;
    for i := 0 to Pred(Min(OldCntr.ElementCount, NewCntr.ElementCount)) do
      NewCntr.Elements[i].Assign(Low(Integer), OldCntr.Elements[i], False);

    if not Supports(NewCntr.ElementByName['衰减曲线'], IwbContainerElementRef, NewCntr2) then
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

    if not Supports(NewCntr.ElementByName['优先级'], IwbContainerElementRef, NewCntr2) then
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
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    if Container.ElementExists['DNAM'] then
      Exit;

    if not Supports(Container.RemoveElement('DATA - 可视化数据'), IwbContainerElementRef, OldCntr) then
      Exit;
    if not Supports(Container.Add('DNAM', True), IwbContainerElementRef, NewCntr) then
      Exit;
    for i := 0 to Pred(Min(OldCntr.ElementCount, NewCntr.ElementCount)) do
      if OldCntr.Elements[i].Name = 'Damage (Old Format)' then
        Container.ElementNativeValues['DATA - Damage'] := OldCntr.Elements[i].NativeValue
      else
        NewCntr.Elements[i].Assign(Low(Integer), OldCntr.Elements[i], False);

    NewCntr.ElementNativeValues['噪波属性 - 噪波图层一 - 振幅规模'] := 1.0;
    NewCntr.ElementNativeValues['噪波属性 - 噪波图层二 - 振幅规模'] := 0.5;
    NewCntr.ElementNativeValues['噪波属性 - 噪波图层三 - 振幅规模'] := 0.25;
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
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    if not Container.ElementExists['DNAM'] then
      Exit;

    if Container.ElementNativeValues['DNAM\动作加成'] = 0.0 then
      Container.ElementNativeValues['DNAM\动作加成'] := 1.0;
    if Container.ElementNativeValues['DNAM\动作攻击加成'] = 0.0 then
      Container.ElementNativeValues['DNAM\动作攻击加成'] := 1.0;
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
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
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

    FullParticleBirthRatio := Container.ElementNativeValues['DATA\粒子着色器 - 完整粒子产生比率'];
    PersistantParticleBirthRatio := Container.ElementNativeValues['DATA\粒子着色器 - 固定粒子产生比率'];

    if ((FullParticleBirthRatio <> 0) and (FullParticleBirthRatio <= 1)) then begin
      FullParticleBirthRatio := FullParticleBirthRatio * 78.0;
      Container.ElementNativeValues['DATA\粒子着色器 - 完整粒子产生比率'] := FullParticleBirthRatio;
    end;

    if ((PersistantParticleBirthRatio <> 0) and (PersistantParticleBirthRatio <= 1)) then begin
      PersistantParticleBirthRatio := PersistantParticleBirthRatio * 78.0;
      Container.ElementNativeValues['DATA\粒子着色器 - 固定粒子产生比率'] := PersistantParticleBirthRatio;
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
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    if not Container.ElementExists['FNAM'] then begin
      Container.Add('FNAM', True);
      Container.ElementNativeValues['FNAM'] := 1.0;
    end;

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
    if not Assigned(Element) then
      Exit;
    if not Supports(Element.LinksTo, IwbMainRecord, MainRecord) then
      Exit;
    if MainRecord.Signature <> 'MGEF' then
      Exit;
    ActorValue := MainRecord.ElementNativeValues['DATA - 数据\角色数值'];
    if VarIsNull(ActorValue) or VarIsClear(ActorValue) then
      Exit;
    if VarCompareValue(ActorValue, Container.ElementNativeValues['角色数值']) <> vrEqual then
      Container.ElementNativeValues['角色数值'] := ActorValue;
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

function wbPKDTFalloutBehaviorFlagsDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
  DataContainer : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;
  if Supports(Container, IwbDataContainer, DataContainer) then
    if DataContainer.DataSize = 8 then
      Result := 1;
end;

function wbPKDTSpecificFlagsDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
  DataContainer : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;
  if Supports(Container, IwbDataContainer, DataContainer) then
    if DataContainer.DataSize = 8 then
      Exit;
  Result := Container.ElementByName['类型'].NativeValue + 1;
end;

procedure DefineFNVa;
begin
  wbRecordFlags := wbInteger('记录标志', itU32, wbFlags([
    {0x00000001}'ESM',
    {0x00000002}'',
    {0x00000004}'',
    {0x00000008}'',
    {0x00000010}'',
    {0x00000020}'已删除',
    {0x00000040}'边界地区 / 含树木LOD / 恒定 / 小地图隐藏',
    {0x00000080}'关闭火',
    {0x00000100}'无法碰触',
    {0x00000200}'投射阴影 / 在小地图 / 动态模糊',
    {0x00000400}'任务物品 / 固定衍生',
    {0x00000800}'初始禁用',
    {0x00001000}'已忽略',
    {0x00002000}'无音效过滤',
    {0x00004000}'',
    {0x00008000}'远景可见',
    {0x00010000}'随机开始动画 / 高清晰LOD',
    {0x00020000}'危险 / 禁止进入 (室内场景) / 无线电台 (对话触发器)',
    {0x00040000}'已压缩',
    {0x00080000}'无法等待 / 工作平台专用材质',
    {0x00100000}'未知 21',
    {0x00200000}'未知 22',
    {0x00400000}'未知 23',
    {0x00800000}'未知 24',
    {0x01000000}'未知 25',
    {0x02000000}'障碍 / 无AI要求',
    {0x03000000}'NavMesh 生成 - 过滤器',
    {0x08000000}'NavMesh 生成 - 边界框',
    {0x10000000}'Non-Pipboy / 被动态水源反射',
    {0x20000000}'小孩可以使用 / 被动态水源反射',
    {0x40000000}'NavMesh 生成 - 范围',
    {0x80000000}'未知 32'
  ]));

(*   wbInteger('Record Flags 2', itU32, wbFlags([
    {0x00000001}'未知 1',
    {0x00000002}'未知 2',
    {0x00000004}'未知 3',
    {0x00000008}'未知 4',
    {0x00000010}'未知 5',
    {0x00000020}'未知 6',
    {0x00000040}'未知 7',
    {0x00000080}'未知 8',
    {0x00000100}'未知 9',
    {0x00000200}'未知 10',
    {0x00000400}'未知 11',
    {0x00000800}'未知 12',
    {0x00001000}'未知 13',
    {0x00002000}'未知 14',
    {0x00004000}'未知 15',
    {0x00008000}'未知 16',
    {0x00010000}'未知 17',
    {0x00020000}'未知 18',
    {0x00040000}'未知 19',
    {0x00080000}'未知 20',
    {0x00100000}'未知 21',
    {0x00200000}'未知 22',
    {0x00400000}'未知 23',
    {0x00800000}'未知 24',
    {0x01000000}'未知 25',
    {0x02000000}'未知 26',
    {0x03000000}'未知 27',
    {0x08000000}'未知 28',
    {0x10000000}'未知 29',
    {0x20000000}'未知 30',
    {0x40000000}'未知 31',
    {0x80000000}'未知 32'
  ]));                (**)

  wbMainRecordHeader := wbStruct('记录头', [
    wbString('签名', 4, cpCritical),
    wbInteger('数据体积', itU32, nil, cpIgnore),
    wbRecordFlags,
    wbFormID('表单序号', cpFormID),
    wbByteArray('版本控制信息 1', 4, cpIgnore),
    wbInteger('表单版本', itU16, nil, cpIgnore),
    wbByteArray('版本控制信息 2', 2, cpIgnore)
  ]);

  wbSizeOfMainRecordStruct := 24;

  wbIgnoreRecords.Add(XXXX);

  wbXRGD := wbByteArray(XRGD, '布娃娃数据');
  wbXRGB := wbByteArray(XRGB, '两足布娃娃数据');

  wbMusicEnum := wbEnum(['默认', '公众场所', '地牢']);
  wbSoundLevelEnum := wbEnum([
     '大声',
     '正常',
     '细声'
    ]);

  wbWeaponAnimTypeEnum := wbEnum([
    {00} '徒手格斗',
    {01} 'Melee (1 Hand)',
    {02} 'Melee (2 Hand)',
    {03} 'Pistol - Balistic (1 Hand)',
    {04} 'Pistol - Energy (1 Hand)',
    {05} 'Rifle - Balistic (2 Hand)',
    {06} 'Rifle - Automatic (2 Hand)',
    {07} 'Rifle - Energy (2 Hand)',
    {08} 'Handle (2 Hand)',
    {09} 'Launcher (2 Hand)',
    {10} 'Grenade Throw (1 Hand)',
    {11} 'Land Mine (1 Hand)',
    {12} 'Mine Drop (1 Hand)',
    {13} 'Thrown (1 Hand)'
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
    'ReloadK',
    'ReloadL',
    'ReloadM',
    'ReloadN',
    'ReloadO',
    'ReloadP',
    'ReloadQ',
    'ReloadR',
    'ReloadS',
//    'ReloadT',
//    'ReloadU',
//    'ReloadV',
    'ReloadW',
    'ReloadX',
    'ReloadY',
    'ReloadZ'
  ]);

  wbEDID := wbString(EDID, '编辑器标识', 0, cpNormal); // not cpBenign according to Arthmoor
  wbEDIDReq := wbString(EDID, '编辑器标识', 0, cpNormal, True); // not cpBenign according to Arthmoor
  wbFULL := wbString(FULL, '名称', 0, cpTranslate);
  wbFULLActor := wbString(FULL, '名称', 0, cpTranslate, False, wbActorTemplateUseBaseData);
  wbFULLReq := wbString(FULL, '名称', 0, cpNormal, True);
  wbDESC := wbString(DESC, '描述', 0, cpTranslate);
  wbDESCReq := wbString(DESC, '描述', 0, cpTranslate, True);
  wbXSCL := wbFloat(XSCL, '范围');
  wbOBND := wbArray(OBND, '物体方位', wbStruct('Corner', [
    wbInteger('X', itS16),
    wbInteger('Y', itS16),
    wbInteger('Z', itS16)
  ]));
  wbOBNDReq := wbArray(OBND, '物体方位', wbStruct('Corner', [
    wbInteger('X', itS16),
    wbInteger('Y', itS16),
    wbInteger('Z', itS16)
  ]), 2, nil, nil, cpNormal, True);
  wbREPL := wbFormIDCkNoReach(REPL, '修复列表', [FLST]);
  wbEITM := wbFormIDCk(EITM, '附魔', [ENCH, SPEL]);
  wbBIPL := wbFormIDCk(BIPL, '双足模型列表', [FLST]);
  wbCOED := wbStructExSK(COED, [2], [0, 1], '额外数据', [
    {00} wbFormIDCkNoReach('所有者', [NPC_, FACT, NULL]),
    {04} wbUnion('全局变量 / 要求级别', wbCOEDOwnerDecider, [
           wbByteArray('未使用', 4, cpIgnore),
           wbFormIDCk('全局变量', [GLOB, NULL]),
           wbInteger('要求级别', itU32)
         ]),
    {08} wbFloat('物品状况')
  ]);

  wbYNAM := wbFormIDCk(YNAM, '音效 - 拾起', [SOUN]);
  wbZNAM := wbFormIDCk(ZNAM, '音效 - 丢弃', [SOUN]);

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

  wbMODS :=
    wbArrayS(MODS, '替换材质',
      wbStructSK([0, 2], '替换材质', [
        wbLenString('3D 名称'),
        wbFormIDCk('新版材质', [TXST]),
        wbInteger('3D 索引', itS32)
      ]),
    -1);
  wbMO2S :=
    wbArrayS(MO2S, '替换材质',
      wbStructSK([0, 2], '替换材质', [
        wbLenString('3D 名称'),
        wbFormIDCk('新版材质', [TXST]),
        wbInteger('3D 索引', itS32)
      ]),
    -1);
  wbMO3S :=
    wbArrayS(MO3S, '替换材质',
      wbStructSK([0, 2], '替换材质', [
        wbLenString('3D 名称'),
        wbFormIDCk('新版材质', [TXST]),
        wbInteger('3D 索引', itS32)
      ]),
    -1);
  wbMO4S :=
    wbArrayS(MO4S, '替换材质',
      wbStructSK([0, 2], '替换材质', [
        wbLenString('3D 名称'),
        wbFormIDCk('新版材质', [TXST]),
        wbInteger('3D 索引', itS32)
      ]),
    -1);

  wbMODD :=
    wbInteger(MODD, '脸部生成模型标志', itU8, wbFlags([
      '头部',
      '躯干',
      '右手',
      '左手'
    ]));
  wbMOSD :=
    wbInteger(MOSD, '脸部生成模型标志', itU8, wbFlags([
      '头部',
      '躯干',
      '右手',
      '左手'
    ]));

  wbMODL :=
    wbRStructSK([0], '模型', [
      wbString(MODL, '模型'),
      wbByteArray(MODB, '未知', 4, cpIgnore),
      wbByteArray(MODT, '材质文件哈希值', 0, cpIgnore),
//      wbArray(MODT, '材质文件哈希值',
//        wbByteArray('未知', 24, cpBenign),
//        wbArray('Hashes', wbInteger('Hash', itU64, wbMODTCallback), 3),
//      0, nil, nil, cpBenign),
      wbMODS,
      wbMODD
    ], [], cpNormal, False, nil, True);

  wbMODLActor :=
    wbRStructSK([0], '模型', [
      wbString(MODL, '模型'),
      wbByteArray(MODB, '未知', 4, cpIgnore),
      wbByteArray(MODT, '材质文件哈希值', 0, cpIgnore),
//      wbArray(MODT, '材质文件哈希值',
//        wbByteArray('未知', 24, cpBenign),
//        wbArray('Hashes', wbInteger('Hash', itU64, wbMODTCallback), 3),
//      0, nil, nil, cpBenign),
      wbMODS,
      wbMODD
    ], [], cpNormal, False, wbActorTemplateUseModelAnimation, True);

  wbMODLReq :=
    wbRStructSK([0], '模型', [
      wbString(MODL, '模型'),
      wbByteArray(MODB, '未知', 4, cpIgnore),
      wbByteArray(MODT, '材质文件哈希值', 0, cpIgnore),
//      wbArray(MODT, 'Texture Files',
//        wbByteArray('未知', 24, cpBenign),
//        wbArray('Hashes', wbInteger('Hash', itU64, wbMODTCallback), 3),
//      0, nil, nil, cpBenign),
      wbMODS,
      wbMODD
    ], [], cpNormal, True, nil, True);


  wbDEST := wbRStruct('可损坏', [
    wbStruct(DEST, '数据头', [
      wbInteger('生命', itS32),
      wbInteger('数量', itU8),
      wbInteger('标志', itU8, wbFlags([
        '可被终结技'
      ], True)),
      wbByteArray('未使用', 2)
    ]),
    wbRArray('阶段',
      wbRStruct('阶段', [
        wbStruct(DSTD, '损坏阶段数据', [
          wbInteger('生命 %', itU8),
          wbInteger('索引', itU8),
          wbInteger('损坏阶段', itU8),
          wbInteger('标志', itU8, wbFlags([
            '损坏上限',
            '禁用',
            '破坏'
          ])),
          wbInteger('每秒自身伤害', itS32),
          wbFormIDCk('爆炸', [EXPL, NULL]),
          wbFormIDCk('碎片', [DEBR, NULL]),
          wbInteger('碎片数', itS32)
        ], cpNormal, True),
        wbRStructSK([0], '模型', [
          wbString(DMDL, '模型'),
          wbByteArray(DMDT, '材质文件哈希值', 0, cpIgnore)
//          wbArray(DMDT, '未知',
//            wbByteArray('未知', 24, cpBenign),
//          0, nil, nil, cpBenign)
        ], []),
        wbEmpty(DSTF, '结束标记', cpNormal, True)
      ], [])
    )
  ], []);

  wbDESTActor := wbRStruct('可损坏', [
    wbStruct(DEST, '数据头', [
      wbInteger('生命', itS32),
      wbInteger('数量', itU8),
      wbInteger('标志', itU8, wbFlags([
        '可被终结技'
      ])),
      wbByteArray('未使用', 2)
    ]),
    wbRArray('阶段',
      wbRStruct('阶段', [
        wbStruct(DSTD, '损坏阶段数据', [
          wbInteger('生命 %', itU8),
          wbInteger('索引', itU8),
          wbInteger('损坏阶段', itU8),
          wbInteger('标志', itU8, wbFlags([
            '损坏上限',
            '禁用',
            '破坏'
          ])),
          wbInteger('每秒自身伤害', itS32),
          wbFormIDCk('爆炸', [EXPL, NULL]),
          wbFormIDCk('碎片', [DEBR, NULL]),
          wbInteger('碎片数', itS32)
        ], cpNormal, True),
        wbRStructSK([0], '模型', [
          wbString(DMDL, '模型'),
          wbByteArray(DMDT, '材质文件哈希值', 0, cpIgnore)
//          wbArray(DMDT, '未知',
//            wbByteArray('未知', 24, cpBenign),
//          0, nil, nil, cpBenign)
        ], []),
        wbEmpty(DSTF, '结束标记', cpNormal, True)
      ], [])
    )
  ], [], cpNormal, False, wbActorTemplateUseModelAnimation);

  wbSCRI := wbFormIDCk(SCRI, '脚本', [SCPT]);
  wbSCRIActor := wbFormIDCk(SCRI, '脚本', [SCPT], False, cpNormal, False, wbActorTemplateUseScript);
  wbENAM := wbFormIDCk(ENAM, '附魔', [ENCH]);

  wbXLOD := wbArray(XLOD, '远景细节数据', wbFloat('未知'), 3);

  wbXESP := wbStruct(XESP, '启用根源', [
    wbFormIDCk('衍生', [PLYR, REFR, ACRE, ACHR, PGRE, PMIS]),
    wbInteger('标志', itU8, wbFlags([
      '设置父系为相反状态',
      '突然出现'
    ])),
    wbByteArray('未使用', 3)
  ]);

  wbSCHRReq := wbStruct(SCHR, 'Basic Script Data', [
    wbByteArray('未使用', 4),
    wbInteger('RefCount', itU32),
    wbInteger('CompiledSize', itU32),
    wbInteger('VariableCount', itU32),
    wbInteger('类型', itU16, wbEnum([
      '对象',
      '任务'
    ], [
      $100, '效果'
    ])),
    wbInteger('标志', itU16, wbFlags([
      '开启'
    ]), cpNormal, False, nil, nil, 1)
  ], cpNormal, True);

  wbSCROs :=
    wbRArray('衍生',
      wbRUnion('', [
        wbFormIDCk(SCRO, 'Global Reference',
          [ACTI, DOOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, IMAD,
           BOOK, KEYM, ALCH, LIGH, QUST, PLYR, PACK, LVLI, ECZN, EXPL, FLST, IDLM, PMIS,
           FACT, ACHR, REFR, ACRE, GLOB, DIAL, CELL, SOUN, MGEF, WTHR, CLAS, EFSH, RACE,
           LVLC, CSTY, WRLD, SCPT, IMGS, MESG, MSTT, MUSC, NOTE, PERK, PGRE, PROJ, LVLN,
           WATR, ENCH, TREE, REPU, REGN, CSNO, CHAL, IMOD, RCCT, CMNY, CDCK, CHIP, CCRD,
           NULL]),
        wbInteger(SCRV, 'Local Variable', itU32)
      ], [])
    );

  wbSLSD := wbStructSK(SLSD, [0], 'Local Variable Data', [
    wbInteger('索引', itU32),
    wbByteArray('未使用', 12),
    wbInteger('标志', itU8, wbFlags(['IsLongOrShort']), cpCritical),
    wbByteArray('未使用', 7)
  ]);

  wbEmbeddedScript := wbRStruct('Embedded Script', [
    wbSCHRReq,
    wbByteArray(SCDA, 'Compiled Embedded Script', 0, cpNormal{, True}),
    wbStringScript(SCTX, 'Embedded Script Source', 0, cpNormal{, True}),
    wbRArrayS('Local Variables', wbRStructSK([0], 'Local Variable', [
      wbSLSD,
      wbString(SCVR, '名称', 0, cpCritical, True)
    ], [])),
    wbSCROs
  ], [], cpNormal, False, nil, False, wbEmbeddedScriptAfterLoad);

  wbEmbeddedScriptPerk := wbRStruct('Embedded Script', [
    wbSCHRReq,
    wbByteArray(SCDA, 'Compiled Embedded Script', 0, cpNormal, True),
    wbStringScript(SCTX, 'Embedded Script Source', 0, cpNormal, True),
    wbRArrayS('Local Variables', wbRStructSK([0], 'Local Variable', [
      wbSLSD,
      wbString(SCVR, '名称', 0, cpCritical, True)
    ], [])),
    wbSCROs
  ], [], cpNormal, False, wbEPF2DontShow, False, wbEmbeddedScriptAfterLoad);

  wbEmbeddedScriptReq := wbRStruct('Embedded Script', [
    wbSCHRReq,
    wbByteArray(SCDA, 'Compiled Embedded Script', 0, cpNormal{, True}),
    wbStringScript(SCTX, 'Embedded Script Source', 0, cpNormal{, True}),
    wbRArrayS('Local Variables', wbRStructSK([0], 'Local Variable', [
      wbSLSD,
      wbString(SCVR, '名称', 0, cpCritical, True)
    ], [])),
    wbSCROs
  ], [], cpNormal, True, nil, False, wbEmbeddedScriptAfterLoad);


  wbXLCM := wbInteger(XLCM, '等级调整', itS32);

  wbRecord(ACHR, 'Placed NPC', [
    wbEDID,
    wbFormIDCk(NAME, '基础', [NPC_], False, cpNormal, True),
    wbFormIDCk(XEZN, '遭遇区域', [ECZN]),

    {--- Ragdoll ---}
    wbXRGD,
    wbXRGB,

    {--- Patrol Data ---}
    wbRStruct('巡逻数据', [
      wbFloat(XPRD, '空闲时间', cpNormal, True),
      wbEmpty(XPPA, '巡逻脚本标记', cpNormal, True),
      wbFormIDCk(INAM, '空闲动作', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, '话题', [DIAL, NULL], False, cpNormal, True)
    ], []),

    {--- Leveled Actor ----}
    wbXLCM,

    {--- Merchant Container ----}
    wbFormIDCk(XMRC, '商人容器', [REFR], True),

    {--- Extra ---}
    wbInteger(XCNT, '数量', itS32),
    wbFloat(XRDS, '半径'),
    wbFloat(XHLP, '生命'),

    {--- Decals ---}
    wbRArrayS('Linked Decals',
      wbStructSK(XDCR, [0], 'Decal', [
        wbFormIDCk('衍生', [REFR]),
        wbUnknown
      ])
    ),

    {--- Linked Ref ---}
    wbFormIDCk(XLKR, '连接的衍生', [REFR, ACRE, ACHR, PGRE, PMIS]),
    wbStruct(XCLP, '连结衍生颜色', [
      wbStruct('连结起始颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbStruct('连结结束颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ])
    ]),

    {--- Activate Parents ---}
    wbRStruct('激活根源', [
      wbInteger(XAPD, '标志', itU8, wbFlags([
        '仅激活根源'
      ], True)),
      wbRArrayS('激活根源衍生',
        wbStructSK(XAPR, [0], '激活根源衍生', [
          wbFormIDCk('衍生', [REFR, ACRE, ACHR, PGRE, PMIS]),
          wbFloat('推延')
        ])
      )
    ], []),

    wbString(XATO, '激活提示'),

    {--- Enable Parent ---}
    wbXESP,

    {--- Emittance ---}
    wbFormIDCk(XEMI, '辐射颜色', [LIGH, REGN]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, '多限制衍生', [REFR]),

    {--- Flags ---}
    wbEmpty(XIBS, '被沙盒忽略'),

    {--- 3D Data ---}
    wbXSCL,
    wbDATAPosRot
  ], True, wbPlacedAddInfo);

  wbXOWN := wbFormIDCkNoReach(XOWN, '所有者', [FACT, ACHR, NPC_]);
  wbXGLB := wbFormIDCk(XGLB, '全局变量', [GLOB]);

  wbRecord(ACRE, 'Placed Creature', [
    wbEDID,
    wbFormIDCk(NAME, '基础', [CREA], False, cpNormal, True),
    wbFormIDCk(XEZN, '遭遇区域', [ECZN]),

    wbXRGD,
    wbXRGB,

    {--- Patrol Data ---}
    wbRStruct('巡逻数据', [
      wbFloat(XPRD, '空闲时间', cpNormal, True),
      wbEmpty(XPPA, '巡逻脚本标记', cpNormal, True),
      wbFormIDCk(INAM, '空闲动作', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, '话题', [DIAL, NULL], False, cpNormal, True)
    ], []),

    {--- Leveled Actor ----}
    wbXLCM,

    {--- Ownership ---}
    wbRStruct('所有权', [
      wbXOWN,
      wbInteger(XRNK, '派系等级', itS32)
    ], [XCMT, XCMO]),

    {--- Merchant Container ----}
    wbFormIDCk(XMRC, '商人容器', [REFR], True),

    {--- Extra ---}
    wbInteger(XCNT, '数量', itS32),
    wbFloat(XRDS, '半径'),
    wbFloat(XHLP, '生命'),

    {--- Decals ---}
    wbRArrayS('Linked Decals',
      wbStructSK(XDCR, [0], 'Decal', [
        wbFormIDCk('衍生', [REFR, ACRE, ACHR, PGRE, PMIS]),
        wbUnknown
      ])
    ),

    {--- Linked Ref ---}
    wbFormIDCk(XLKR, '连接的衍生', [REFR, ACRE, ACHR, PGRE, PMIS]),
    wbStruct(XCLP, '连结衍生颜色', [
      wbStruct('连结起始颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbStruct('连结结束颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ])
    ]),

    {--- Activate Parents ---}
    wbRStruct('激活根源', [
      wbInteger(XAPD, '标志', itU8, wbFlags([
        '仅激活根源'
      ], True)),
      wbRArrayS('激活根源衍生',
        wbStructSK(XAPR, [0], '激活根源衍生', [
          wbFormIDCk('衍生', [REFR, ACRE, ACHR, PGRE, PMIS]),
          wbFloat('推延')
        ])
      )
    ], []),

    wbString(XATO, '激活提示'),

    {--- Enable Parent ---}
    wbXESP,

    {--- Emittance ---}
    wbFormIDCk(XEMI, '辐射颜色', [LIGH, REGN]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, '多限制衍生', [REFR]),

    {--- Flags ---}
    wbEmpty(XIBS, '被沙盒忽略'),

    {--- 3D Data ---}
    wbXSCL,
    wbDATAPosRot
  ], True, wbPlacedAddInfo);

  wbRecord(ACTI, 'Activator', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbSCRI,
    wbDEST,
    wbFormIDCk(SNAM, '音效 - 循环', [SOUN]),
    wbFormIDCk(VNAM, '音效 - 触发', [SOUN]),
    wbFormIDCk(INAM, 'Radio Template', [SOUN]),
    wbFormIDCk(RNAM, 'Radio Station', [TACT]),
    wbFormIDCk(WNAM, '水质类型', [WATR]),
    wbString(XATO, '激活提示')
  ]);

  wbICON := wbRStruct('图标', [
    wbString(ICON, '大图标文件'),
    wbString(MICO, '小图标文件')
  ], [], cpNormal, False, nil, True);

  wbICONReq := wbRStruct('图标', [
    wbString(ICON, '大图标文件'),
    wbString(MICO, '小图标文件')
  ], [], cpNormal, True, nil, True);

  wbVatsValueFunctionEnum :=
    wbEnum([
      '武器是',
      '武器在列表',
      '目标是',
      '目标在列表',
      '目标距离',
      '目标部分',
      '终结技操作',
      '成功',
      '致命',
      '致命效果是',
      '致命效果在列表',
      '毁灭',
      '爆炸部分',
      '肢解部分',
      '残废部分',
      '武器类型是',
      '陌生人',
      '迷魂拳'
    ]);

  wbActorValueEnum :=
    wbEnum([
        {00} '好战',
        {01} '信心',
        {02} '活力',
        {03} '品德',
        {04} '情绪',
        {05} '力量',
        {06} 'Perception',
        {07} '耐力',
        {08} 'Charisma',
        {09} '智力',
        {10} '敏捷',
        {11} '运气',
        {12} 'Action Points',
        {13} '负重',
        {14} '致命概率',
        {15} '生命倍率',
        {16} '生命',
        {17} '近战伤害',
        {18} '伤害抵抗ance',
        {19} '毒性抵抗ance',
        {20} 'Rad Resistance',
        {21} '速度加成',
        {22} '体力',
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
        {33} 'Big Guns (obsolete)',
        {34} 'Energy Weapons',
        {35} 'Explosives',
        {36} 'Lockpick',
        {37} '药物',
        {38} 'Melee Weapons',
        {39} 'Repair',
        {40} 'Science',
        {41} 'Guns',
        {42} '潜行',
        {43} '口才',
        {44} 'Survival',
        {45} 'Unarmed',
        {46} '装备栏重量',
        {47} '麻痹',
        {48} '隐形',
        {49} 'Chameleon',
        {50} '夜视',
        {51} 'Turbo',
        {52} 'Fire Resistance',
        {53} '水下呼吸',
        {54} 'Rad Level',
        {55} 'Bloody Mess',
        {56} '徒手伤害',
        {57} '协助',
        {58} 'Electric Resistance',
        {59} 'Frost Resistance',
        {60} 'Energy Resistance',
        {61} 'EMP Resistance',
        {62} '变量01',
        {63} '变量02',
        {64} '变量03',
        {65} '变量04',
        {66} '变量05',
        {67} '变量06',
        {68} '变量07',
        {79} '变量08',
        {70} '变量09',
        {71} '变量10',
        {72} 'Ignore Crippled Limbs',
        {73} 'Dehydration',
        {74} 'Hunger',
        {75} 'Sleep Deprivation',
        {76} 'Damage Threshold'
      ], [
        -1, '无'
      ]);

  wbModEffectEnum :=
    wbEnum([
      {00} '无',
      {01} 'Increase Weapon Damage',
      {02} 'Increase Clip Capacity',
      {03} 'Decrease Spread',
      {04} 'Decrease Weight',
      {05} 'Regenerate Ammo (shots)',
      {06} 'Regenerate Ammo (seconds)',
      {07} 'Decrease Equip Time',
      {08} 'Increase Rate of Fire',
      {09} 'Increase Projectile Speed',
      {10} 'Increase Max. Condition',
      {11} 'Silence',
      {12} 'Split Beam',
      {13} 'VATS Bonus',
      {14} 'Increase Zoom'
    ]);

  wbSkillEnum :=
    wbEnum([
      'Barter',
      'Big Guns (obsolete)',
      'Energy Weapons',
      'Explosives',
      'Lockpick',
      '药物',
      'Melee Weapons',
      'Repair',
      'Science',
      'Guns',
      '潜行',
      '口才',
      'Survival',
      'Unarmed'
    ], [
      -1, '无'
    ]);

  wbCrimeTypeEnum :=
    wbEnum([
      '偷窃',
      '扒窃',
      '非法入侵',
      '攻击',
      '谋杀'
    ], [
      -1, '无'
    ]);

  wbActorValue := wbInteger('角色数值', itS32, wbActorValueEnum);

  wbEquipTypeEnum :=
    wbEnum([
        {00} 'Big Guns',
        {01} 'Energy Weapons',
        {02} 'Small Guns',
        {03} 'Melee Weapons',
        {04} 'Unarmed Weapon',
        {05} 'Thrown Weapons',
        {06} '矿山',
        {07} 'Body Wear',
        {08} 'Head Wear',
        {09} 'Hand Wear',
        {10} 'Chems',
        {11} 'Stimpack',
        {12} 'Food',
        {13} 'Alcohol'
      ], [
        -1, '无'
      ]);

  wbETYP := wbInteger(ETYP, 'Equiptment Type', itS32, wbEquipTypeEnum);
  wbETYPReq := wbInteger(ETYP, 'Equiptment Type', itS32, wbEquipTypeEnum, cpNormal, True);

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
      $66, 'Music Type',
      $67, 'Item Mod',
      $68, 'Reputation',
      $69, '?PCBE', //no such records in FalloutNV.esm
      $6A, 'Recipe',
      $6B, 'Recipe Category',
      $6C, 'Casino Chip',
      $6D, 'Casino',
      $6E, 'Load Screen Type',
      $6F, 'Media Set',
      $70, 'Media Location Controller',
      $71, 'Challenge',
      $72, 'Ammo Effect',
      $73, 'Caravan Card',
      $74, 'Caravan Money',
      $75, 'Caravan Deck',
      $76, 'Dehydration Stages',
      $77, 'Hunger Stages',
      $78, 'Sleep Deprivation Stages'
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

procedure DefineFNVb;
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
      '好的',
      '中立',
      '有害',
      '非常好的',
      '非常有害'
    ]);

  wbAxisEnum :=
    wbEnum([], [
      88, 'X',
      89, 'Y',
      90, 'Z'
    ]);

  wbCriticalStageEnum :=
    wbEnum([
      '无',
      '粘性起始',
      '粘性结束',
      '分解起始',
      '分解结束'
    ]);

  wbSexEnum :=
    wbEnum(['男性','女性']);

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
      'Throwing Granade',
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
      '躯干',
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
      -1, '无'
    ]);


  wbEFID := wbFormIDCk(EFID, '基本效果', [MGEF]);

  wbEFIT :=
    wbStructSK(EFIT, [3, 4], '', [
      wbInteger('量级', itU32),
      wbInteger('范围', itU32),
      wbInteger('持续时间', itU32),
      wbInteger('类型', itU32, wbEnum(['自身', '接触', '目标'])),
      wbActorValue
    ], cpNormal, True, nil, -1, wbEFITAfterLoad);

  wbCTDA :=
    wbStruct(CTDA, '条件', [
      wbInteger('类型', itU8, wbCtdaTypeToStr, wbCtdaTypeToInt, cpNormal, False, nil, wbCtdaTypeAfterSet),
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
        {05} wbInteger('角色数值', itS32, wbActorValueEnum),
        {06} wbInteger('犯罪类型', itU32, wbCrimeTypeEnum),
        {07} wbInteger('坐标', itU32, wbAxisEnum),
        {08} wbInteger('任务阶段 (不可用)', itS32),
        {09} wbInteger('杂项状态', itU32, wbMiscStatEnum),
        {10} wbInteger('队列', itU32, wbAlignmentEnum),
        {11} wbInteger('装备类型', itU32, wbEquipTypeEnum),
        {12} wbInteger('表单类型', itU32, wbFormTypeEnum),
        {13} wbInteger('致命阶段', itU32, wbCriticalStageEnum),
        {14} wbFormIDCkNoReach('衍生对象', [PLYR, REFR, ACHR, ACRE, PGRE, PMIS, TRGT], True),
        {16} wbFormIDCkNoReach('装备栏对象', [ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, NOTE, FLST, CHIP, CMNY, IMOD]),
        {17} wbFormIDCkNoReach('角色', [PLYR, ACHR, ACRE, TRGT], True),
        {18} wbFormIDCkNoReach('语音', [VTYP]),
        {19} wbFormIDCkNoReach('Idle', [IDLE]),
        {20} wbFormIDCkNoReach('表单列表', [FLST]),
        {21} wbFormIDCkNoReach('Note', [NOTE]),
        {22} wbFormIDCkNoReach('任务', [QUST]),
        {23} wbFormIDCkNoReach('派系', [FACT]),
        {24} wbFormIDCkNoReach('武器', [WEAP]),
        {25} wbFormIDCkNoReach('场景', [CELL]),
        {26} wbFormIDCkNoReach('职业', [CLAS]),
        {27} wbFormIDCkNoReach('种族', [RACE]),
        {28} wbFormIDCkNoReach('角色基础', [NPC_, CREA, ACTI, TACT]),
        {29} wbFormIDCkNoReach('全局', [GLOB]),
        {30} wbFormIDCkNoReach('天气', [WTHR]),
        {31} wbFormIDCkNoReach('AI包', [PACK]),
        {32} wbFormIDCkNoReach('遭遇区域', [ECZN]),
        {33} wbFormIDCkNoReach('天赋', [PERK]),
        {34} wbFormIDCkNoReach('所有者', [FACT, NPC_]),
        {35} wbFormIDCkNoReach('家具', [FURN, FLST]),
        {36} wbFormIDCkNoReach('效果物品', [SPEL, ENCH, ALCH, INGR]),
        {37} wbFormIDCkNoReach('基本效果', [MGEF]),
        {38} wbFormIDCkNoReach('世界空间', [WRLD]),
        {39} wbInteger('终结技数值函数', itU32, wbVATSValueFunctionEnum),
        {40} wbInteger('终结技数值参数 (无效)', itU32),
        {41} wbInteger('Creature Type', itU32, wbCreatureTypeEnum),
        {42} wbInteger('Menu Mode', itU32, wbMenuModeEnum),
        {43} wbInteger('玩家行为', itU32, wbPlayerActionEnum),
        {44} wbInteger('Body Location', itS32, wbBodyLocationEnum),
        {45} wbFormIDCkNoReach('衍生对象', [CREA, NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM, FLST, CHIP, IMOD],
                                                [CREA, NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM, IMOD, CMNY, CCRD, CHIP]),
        {46} wbInteger('Quest Objective (INVALID)', itS32),
        {47} wbFormIDCkNoReach('Reputation', [REPU]),
        {48} wbFormIDCkNoReach('地区', [REGN]),
        {49} wbFormIDCkNoReach('Challenge', [CHAL]),
        {50} wbFormIDCkNoReach('Casino', [CSNO])
      ]),
      wbUnion('参数 #2', wbCTDAParam2Decider, [
        {00} wbByteArray('未知', 4),
        {01} wbByteArray('无', 4, cpIgnore),
        {02} wbInteger('整数', itS32),
        {03} wbInteger('Variable Name', itS32, wbCTDAParam2VariableNameToStr, wbCTDAParam2VariableNameToInt),
        {04} wbInteger('性别', itU32, wbSexEnum),
        {05} wbInteger('角色数值', itS32, wbActorValueEnum),
        {06} wbInteger('犯罪类型', itU32, wbCrimeTypeEnum),
        {07} wbInteger('坐标', itU32, wbAxisEnum),
        {08} wbInteger('任务阶段', itS32, wbCTDAParam2QuestStageToStr, wbCTDAParam2QuestStageToInt),
        {09} wbInteger('杂项状态', itU32, wbMiscStatEnum),
        {10} wbInteger('队列', itU32, wbAlignmentEnum),
        {11} wbInteger('装备类型', itU32, wbEquipTypeEnum),
        {12} wbInteger('表单类型', itU32, wbFormTypeEnum),
        {13} wbInteger('致命阶段', itU32, wbCriticalStageEnum),
        {14} wbFormIDCkNoReach('衍生对象', [PLYR, REFR, PMIS, ACHR, ACRE, PGRE, TRGT], True),
        {16} wbFormIDCkNoReach('装备栏对象', [ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, NOTE, FLST, CHIP, CMNY, IMOD]),
        {17} wbFormIDCkNoReach('角色', [PLYR, ACHR, ACRE, TRGT], True),
        {18} wbFormIDCkNoReach('语音', [VTYP]),
        {19} wbFormIDCkNoReach('Idle', [IDLE]),
        {20} wbFormIDCkNoReach('表单列表', [FLST]),
        {21} wbFormIDCkNoReach('Note', [NOTE]),
        {22} wbFormIDCkNoReach('任务', [QUST]),
        {23} wbFormIDCkNoReach('派系', [FACT]),
        {24} wbFormIDCkNoReach('武器', [WEAP]),
        {25} wbFormIDCkNoReach('场景', [CELL]),
        {26} wbFormIDCkNoReach('职业', [CLAS]),
        {27} wbFormIDCkNoReach('种族', [RACE]),
        {28} wbFormIDCkNoReach('角色基础', [NPC_, CREA, ACTI, TACT]),
        {29} wbFormIDCkNoReach('全局', [GLOB]),
        {30} wbFormIDCkNoReach('天气', [WTHR]),
        {31} wbFormIDCkNoReach('AI包', [PACK]),
        {32} wbFormIDCkNoReach('遭遇区域', [ECZN]),
        {33} wbFormIDCkNoReach('天赋', [PERK]),
        {34} wbFormIDCkNoReach('所有者', [FACT, NPC_]),
        {35} wbFormIDCkNoReach('家具', [FURN, FLST]),
        {36} wbFormIDCkNoReach('效果物品', [SPEL, ENCH, ALCH, INGR]),
        {37} wbFormIDCkNoReach('Base Effect', [MGEF]),
        {38} wbFormIDCkNoReach('世界空间', [WRLD]),
        {39} wbInteger('终结技数值函数 (无效)', itU32),
        {40} wbUnion('终结技数值参数', wbCTDAParam2VATSValueParam, [
               wbFormIDCkNoReach('武器', [WEAP]),
               wbFormIDCkNoReach('武器列表', [FLST], [WEAP]),
               wbFormIDCkNoReach('目标', [NPC_, CREA]),
               wbFormIDCkNoReach('目标列表', [FLST], [NPC_, CREA]),
               wbByteArray('未使用', 4, cpIgnore),
               wbInteger('目标部分', itS32, wbActorValueEnum),
               wbInteger('终结技操作', itU32, wbEnum([
                 '徒手攻击',
                 '单手近战攻击',
                 '双手近战攻击',
                 'Fire Pistol',
                 'Fire Rifle',
                 'Fire Handle Weapon',
                 'Fire Launcher',
                 'Throw Grenade',
                 'Place Mine',
                 '重载',
                 '蹲伏',
                 '站立',
                 '切换武器',
                 '收/拔武器',
                 '治愈',
                 '玩家死亡',
                 'Special Weapon Attack',
                 'Special Unarmed Attack',
                 'Kill Camera Shot',
                 'Throw Weapon'
               ])),
               wbByteArray('未使用', 4, cpIgnore),
               wbByteArray('未使用', 4, cpIgnore),
               wbFormIDCkNoReach('致命效果', [SPEL]),
               wbFormIDCkNoReach('致命效果列表', [FLST], [SPEL]),
               wbByteArray('未使用', 4, cpIgnore),
               wbByteArray('未使用', 4, cpIgnore),
               wbByteArray('未使用', 4, cpIgnore),
               wbByteArray('未使用', 4, cpIgnore),
               wbInteger('武器类型', itU32, wbWeaponAnimTypeEnum),
               wbByteArray('未使用', 4, cpIgnore),
               wbByteArray('未使用', 4, cpIgnore)
             ]),
        {41} wbInteger('Creature Type', itU32, wbCreatureTypeEnum),
        {42} wbInteger('Menu Mode', itU32, wbMenuModeEnum),
        {43} wbInteger('玩家行为', itU32, wbPlayerActionEnum),
        {44} wbInteger('Body Location', itS32, wbBodyLocationEnum),
        {45} wbFormIDCkNoReach('衍生对象', [CREA, NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM, FLST, CHIP, IMOD],
                                                [CREA, NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM, IMOD, CMNY, CCRD, CHIP]),
        {46} wbInteger('Quest Objective', itS32, wbCTDAParam2QuestObjectiveToStr, wbCTDAParam2QuestObjectiveToInt),
        {47} wbFormIDCkNoReach('Reputation', [REPU]),
        {48} wbFormIDCkNoReach('地区', [REGN]),
        {49} wbFormIDCkNoReach('Challenge', [CHAL]),
        {50} wbFormIDCkNoReach('Casino', [CSNO])
      ]),
      wbInteger('运行于', itU32, wbEnum([
        '主体',
        '目标',
        '衍生',
        '战斗目标',
        '连接的衍生'
      ]), cpNormal, False, nil, wbCTDARunOnAfterSet),
      wbUnion('衍生', wbCTDAReferenceDecider, [
        wbInteger('未使用', itU32, nil, cpIgnore),
        wbFormIDCkNoReach('衍生', [PLYR, ACHR, ACRE, REFR, PMIS, PGRE], True)
      ])
    ], cpNormal, False, nil, 6, wbCTDAAfterLoad);
  wbCTDAs := wbRArray('条件', wbCTDA);
  wbCTDAsReq := wbRArray('条件', wbCTDA, cpNormal, True);

  wbEffects :=
    wbRStructs('效果','效果', [
      wbEFID,
      wbEFIT,
      wbCTDAs
    ], []);

  wbEffectsReq :=
    wbRStructs('效果','效果', [
      wbEFID,
      wbEFIT,
      wbCTDAs
    ], [], cpNormal, True);


  wbRecord(ALCH, 'Ingestible', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULLReq,
    wbMODL,
    wbICON,
    wbSCRI,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbETYPReq,
    wbFloat(DATA, '重量', cpNormal, True),
    wbStruct(ENIT, '效果数据', [
      wbInteger('价值', itS32),
      wbInteger('Flags?', itU8, wbFlags([
        '不自动计算 (未使用)',
        '食物',
        '药物'
      ])),
      wbByteArray('未使用', 3),
      wbFormIDCk('副作用', [SPEL, NULL]),
      wbFloat('上瘾概率'),
      wbFormIDCk('音效  - 食用', [SOUN, NULL])
    ], cpNormal, True),
    wbEffectsReq
  ]);

  wbRecord(AMMO, 'Ammunition', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULLReq,
    wbMODL,
    wbICON,
    wbSCRI,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbStruct(DATA, '数据', [
      wbFloat('速度'),
      wbInteger('标志', itU8, wbFlags([
        '无视普通武器抗性',
        '玩家不可用'
      ])),
      wbByteArray('未使用', 3),
      wbInteger('价值', itS32),
      wbInteger('Clip Rounds', itU8)
    ], cpNormal, True),
    wbStruct(DAT2, 'Data 2', [
      wbInteger('Proj. per Shot', itU32),
      wbFormIDCk('抛射物', [PROJ, NULL]),
      wbFloat('重量'),
      wbFormIDCk('Consumed Ammo', [AMMO, MISC, NULL]),
      wbFloat('Consumed Percentage')
    ], cpNormal, False, nil, 3),
    wbString(ONAM, '简称'),
    wbString(QNAM, 'Abbrev.'),
    wbRArray('Ammo Effects',
      wbFormIDCk(RCIL, '效果', [AMEF])
    )
  ]);

  wbRecord(ANIO, 'Animated Object', [
    wbEDIDReq,
    wbMODLReq,
    wbFormIDCk(DATA, '动作', [IDLE], False, cpNormal, True)
  ]);

  wbBMDT := wbStruct(BMDT, 'Biped Data', [
      wbInteger('Biped Flags', itU32, wbFlags([
        {0x00000001} '头部',
        {0x00000002} '发型',
        {0x00000004} 'Upper Body',
        {0x00000008} '左手',
        {0x00000010} '右手',
        {0x00000020} '武器',
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
        {0x00020000} '身体扩展 1',
        {0x00040000} '身体扩展 2',
        {0x00080000} '身体扩展 3'
      ])),
      wbInteger('一般标志', itU8, wbFlags([
        {0x0001} '1',
        {0x0002} '2',
        {0x0004} 'Has Backpack',
        {0x0008} '中等',
        {0x0010} '5',
        {0x0020} 'Power Armor',
        {0x0040} '玩家不可用',
        {0x0080} 'Heavy'
      ], True)),
      wbByteArray('未使用')
    ], cpNormal, True);

  wbRecord(ARMO, 'Armor', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbSCRI,
    wbEITM,
    wbBMDT,
    wbRStruct('Male biped model', [
      wbString(MODL, '模型'),
      wbByteArray(MODT, '材质文件哈希值', 0, cpIgnore),
      wbMODS,
      wbMODD
    ], [], cpNormal, False, nil, True),
    wbRStruct('男性世界模型', [
      wbString(MOD2, '模型'),
      wbByteArray(MO2T, '材质文件哈希值', 0, cpIgnore),
      wbMO2S
    ], []),
    wbString(ICON, 'Male icon filename'),
    wbString(MICO, 'Male mico filename'),
    wbRStruct('Female biped model', [
      wbString(MOD3, '模型'),
      wbByteArray(MO3T, '材质文件哈希值', 0, cpIgnore),
      wbMO3S,
      wbMOSD
    ], [], cpNormal, False, nil, True),
    wbRStruct('女性世界模型', [
      wbString(MOD4, '模型'),
      wbByteArray(MO4T, '材质文件哈希值', 0, cpIgnore),
      wbMO4S
    ], []),
    wbString(ICO2, 'Female icon filename'),
    wbString(MIC2, 'Female mico filename'),
    wbString(BMCT, '布娃娃约束模版'),
    wbREPL,
    wbBIPL,
    wbETYPReq,
    wbYNAM,
    wbZNAM,
    wbStruct(DATA, '数据', [
      wbInteger('价值', itS32),
      wbInteger('生命', itS32),
      wbFloat('重量')
    ], cpNormal, True),
    wbStruct(DNAM, '', [
      wbInteger('AR', itS16, wbDiv(100)),
      wbInteger('标志', itU16, wbFlags([
        '改变声音'
      ])),
      wbFloat('DT'),
      wbByteArray('?', 4)
    ], cpNormal, True, nil, 2),
    wbInteger(BNAM, 'Overrides Animation Sounds', itU32, wbEnum(['否', '是'])),
    wbRArray('Animation Sounds',
      wbStruct(SNAM, 'Animation Sound', [
        wbFormIDCk('音效', [SOUN]),
        wbInteger('概率', itU8),
        wbByteArray('未使用', 3),
        wbInteger('类型', itU32, wbEnum([], [
          19, '跑步',
          21, 'Run (Armor)',
          18, '潜行',
          20, 'Sneak (Armor)',
          17, '步行',
          22, 'Walk (Armor)'
        ]))
      ])
    ),
    wbFormIDCk(TNAM, 'Anmation Sounds Template', [ARMO])
  ]);

  wbRecord(ARMA, 'Armor Addon', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbBMDT,
    wbRStruct('Male biped model', [
      wbString(MODL, '模型'),
      wbByteArray(MODT, '材质文件哈希值', 0, cpIgnore),
      wbMODS,
      wbMODD
    ], [], cpNormal, False, nil, True),
    wbRStruct('男性世界模型', [
      wbString(MOD2, '模型'),
      wbByteArray(MO2T, '材质文件哈希值', 0, cpIgnore),
      wbMO2S
    ], []),
    wbString(ICON, 'Male icon filename'),
    wbString(MICO, 'Male mico filename'),
    wbRStruct('Female biped model', [
      wbString(MOD3, '模型'),
      wbByteArray(MO3T, '材质文件哈希值', 0, cpIgnore),
      wbMO3S,
      wbMOSD
    ], [], cpNormal, False, nil, True),
    wbRStruct('女性世界模型', [
      wbString(MOD4, '模型'),
      wbByteArray(MO4T, '材质文件哈希值', 0, cpIgnore),
      wbMO4S
    ], []),
    wbString(ICO2, 'Female icon filename'),
    wbString(MIC2, 'Female mico filename'),
    wbETYPReq,
    wbStruct(DATA, '数据', [
      wbInteger('价值', itS32),
      wbInteger('Max Condition', itS32),
      wbFloat('重量')
    ], cpNormal, True),
    wbStruct(DNAM, '', [
      wbInteger('AR', itS16, wbDiv(100)),
      wbInteger('标志', itU16, wbFlags([
        '改变声音'
      ])),
      wbUnknown
    ], cpNormal, True)
  ]);

  wbRecord(BOOK, 'Book', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbDESCReq,
    wbDEST,
    wbStruct(DATA, '数据', [
      wbInteger('标志', itU8, wbFlags([
        '',
        '无法带走'
      ])),
      wbInteger('技能', itS8, wbSkillEnum),
      wbInteger('价值', itS32),
      wbFloat('重量')
    ], cpNormal, True)
  ]);

  wbSPLO := wbFormIDCk(SPLO, '魔法', [SPEL]);
  wbSPLOs := wbRArrayS('魔法', wbSPLO, cpNormal, False, nil, nil, wbActorTemplateUseActorEffectList);

  wbRecord(CELL, 'Cell', [
    wbEDID,
    wbFULL,
    wbInteger(DATA, '标志', itU8, wbFlags([
      {0x01} '室内场景',
      {0x02} '存在水源',
      {0x04} '无法快速旅行到这边',
      {0x08} '无LOD水',
      {0x10} '',
      {0x20} '公共场所',
      {0x40} '已手动修改',
      {0x80} '表现为室外'
    ]), cpNormal, True),
    wbStruct(XCLC, '网格', [
      wbInteger('X', itS32),
      wbInteger('Y', itS32),
      wbInteger('强制隐藏景观', itU32, wbFlags([
        'Quad 1',
        'Quad 2',
        'Quad 3',
        'Quad 4'
      ], True))
    ], cpNormal, False, nil, 2),
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
      wbFloat('指向淡出'),
      wbFloat('雾裁剪距离'),
      wbFloat('雾浓度')
    ], cpNormal, False, nil, 7),
    wbArray(IMPF, 'Footstep Materials', wbString('未知', 30), [
      'ConcSolid',
      'ConcBroken',
      'MetalSolid',
      'MetalHollow',
      'MetalSheet',
      'Wood',
      'Sand',
      'Dirt',
      '草地',
      '水源'
    ]),
    wbRStruct('Light Template', [
      wbFormIDCk(LTMP, '模版', [LGTM, NULL]),
      wbInteger(LNAM, 'Inherit', itU32, wbFlags([
        {0x00000001}'环境颜色',
        {0x00000002}'指向颜色',
        {0x00000004}'雾颜色',
        {0x00000008}'雾近距离',
        {0x00000010}'雾远距离',
        {0x00000020}'指向角度',
        {0x00000040}'指向淡出',
        {0x00000080}'裁剪距离',
        {0x00000100}'雾浓度'
      ]), cpNormal, True)
    ], [], cpNormal, True ),
    wbFloat(XCLW, '水面高度'),
    wbString(XNAM, '水面噪波纹理'),
    wbArrayS(XCLR, '地区', wbFormIDCk('地区', [REGN])),
    wbFormIDCk(XCIM, '图像空间', [IMGS]),
    wbByteArray(XCET, '未知', 1, cpIgnore),
    wbFormIDCk(XEZN, '遭遇区域', [ECZN]),
    wbFormIDCk(XCCM, '气候', [CLMT]),
    wbFormIDCk(XCWT, '水源', [WATR]),
    wbRStruct('所有权', [
      wbXOWN,
      wbInteger(XRNK, '派系等级', itS32)
    ], [XCMT, XCMO]),
    wbFormIDCk(XCAS, '声学空间', [ASPC]),
    wbByteArray(XCMT, '未使用', 1, cpIgnore),
    wbFormIDCk(XCMO, '音乐类型', [MUSC])
  ], True, wbCellAddInfo, cpNormal, False, wbCELLAfterLoad);

  wbServiceFlags :=
    wbFlags([
      {0x00000001} 'Weapons',
      {0x00000002} 'Armor',
      {0x00000004} 'Alcohol',
      {0x00000008} 'Books',
      {0x00000010} 'Food',
      {0x00000020} 'Chems',
      {0x00000040} 'Stimpacks',
      {0x00000080} 'Lights?',
      {0x00000100} '',
      {0x00000200} '',
      {0x00000400} '杂项',
      {0x00000800} '',
      {0x00001000} '',
      {0x00002000} 'Potions?',
      {0x00004000} 'Training',
      {0x00008000} '',
      {0x00010000} 'Recharge',
      {0x00020000} 'Repair'
    ]);

  wbSpecializationEnum := wbEnum(['战斗', 'Magic', 'Stealth']);

  wbRecord(CLAS, 'Class', [
    wbEDIDReq,
    wbFULLReq,
    wbDESCReq,
    wbICON,
    wbStruct(DATA, '', [
      wbArray('Tag Skills', wbInteger('Tag Skill', itS32, wbActorValueEnum), 4),
      wbInteger('标志', itU32, wbFlags(['玩家可用', 'Guard'], True)),
      wbInteger('Buys/Sells and Services', itU32, wbServiceFlags),
      wbInteger('传授', itS8, wbSkillEnum),
      wbInteger('最大训练等级', itU8),
      wbByteArray('未使用', 2)
    ], cpNormal, True),
    wbArray(ATTR, 'Attributes', wbInteger('Attribute', itU8), [
      '力量',
      'Perception',
      '耐力',
      'Charisma',
      '智力',
      '敏捷',
      '运气'
    ], cpNormal, True)
  ]);
end;

procedure DefineFNVc;
begin
  wbRecord(CLMT, 'Climate', [
    wbEDIDReq,
    wbArrayS(WLST, '天气类型', wbStructSK([0], '天气类型', [
      wbFormIDCk('天气', [WTHR, NULL]),
      wbInteger('概率', itS32),
      wbFormIDCk('全局', [GLOB, NULL])
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

  wbCNTO :=
    wbRStructExSK([0], [1], '物品', [
      wbStructExSK(CNTO, [0], [1], '物品', [
        wbFormIDCk('物品', [ARMO, AMMO, MISC, WEAP, BOOK, LVLI, KEYM, ALCH, NOTE, IMOD, CMNY, CCRD, LIGH, CHIP{, MSTT{?}{, STAT{?}]),
        wbInteger('数量', itS32)
      ]),
      wbCOED
    ], []);

  wbCNTOs := wbRArrayS('物品', wbCNTO);

  wbRecord(CONT, 'Container', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbSCRI,
    wbCNTOs,
    wbDEST,
    wbStruct(DATA, '', [
      wbInteger('标志', itU8, wbFlags(['', '重生'])),
      wbFloat('重量')
    ], cpNormal, True),
    wbFormIDCk(SNAM, '音效 - 开启', [SOUN]),
    wbFormIDCk(QNAM, '音效 - 关闭', [SOUN]),
    wbFormIDCk(RNAM, 'Sound - Random/Looping', [SOUN])
  ], True);

  wbCSDT := wbRStructSK([0], '声音类型', [
    wbInteger(CSDT, '类型', itU32,wbEnum([
      {00} '左脚',
      {01} '右脚',
      {02} '左脚后退',
      {03} '右脚后退',
      {04} '待机',
      {05} '清醒',
      {06} '攻击',
      {07} '打击',
      {08} '死亡',
      {09} '武器',
      {10} '运动循环',
      {11} '意识循环',
      {12} '辅助 1',
      {13} '辅助 2',
      {14} '辅助 3',
      {15} '辅助 4',
      {16} '辅助 5',
      {17} '辅助 6',
      {18} '辅助 7',
      {19} '辅助 8',
      {19} '辅助 8',
      {20} '跳动',
      {21} '随机/循环'
    ])),
    wbRArrayS('音效', wbRStructSK([0], '音效', [
      wbFormIDCk(CSDI, '音效', [SOUN, NULL], False, cpNormal, True),
      wbInteger(CSDC, '声音概率', itU8, nil, cpNormal, True)
    ], []), cpNormal, True)
  ], []);

  wbCSDTs := wbRArrayS('声音类型', wbCSDT, cpNormal, False, nil, nil, wbActorTemplateUseModelAnimation);

  wbAIDT :=
    wbStruct(AIDT, 'AI数据', [
     {00} wbInteger('好战', itU8, wbEnum([
            '不具攻击性',
            '好战',
            '非常好战',
            '狂热'
          ])),
     {01} wbInteger('信心', itU8, wbEnum([
            '胆小',
            '谨慎',
            '普通',
            '勇敢',
            '愚勇'
          ])),
     {02} wbInteger('活力', itU8),
     {03} wbInteger('品德', itU8),
     {04} wbInteger('情绪', itU8, wbEnum([
            '无表情',
            '害怕',
            '烦闷',
            '自大',
            '麻木',
            '愉快',
            '生气',
            '伤心'
          ])),
          wbByteArray('未使用', 3),
          wbInteger('Buys/Sells and Services', itU32, wbServiceFlags),
          wbInteger('传授', itS8, wbSkillEnum),
          wbInteger('最大训练等级', itU8),
          wbInteger('协助', itS8, wbEnum([
            '不帮助',
            '帮助盟友',
            '帮助朋友和盟友'
          ])),
          wbInteger('感应半径', itU8, wbFlags([
            '感应半径'
          ])),
          wbInteger('Aggro Radius', itS32)
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
      '草地',
      'Glass',
      'Metal',
      'Wood',
      'Organic',
      'Cloth',
      '水源',
      'Hollow Metal',
      'Organic Bug',
      'Organic Glow'
    ]);

  wbRecord(CREA, 'Creature', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULLActor,
    wbMODLActor,
    wbSPLOs,
    wbFormIDCk(EITM, 'Unarmed Attack Effect', [ENCH, SPEL], False, cpNormal, False, wbActorTemplateUseActorEffectList),
    wbInteger(EAMT, 'Unarmed Attack Animation', itU16, wbAttackAnimationEnum, cpNormal, True, False, wbActorTemplateUseActorEffectList),
    wbArrayS(NIFZ, 'Model List', wbStringLC('模型'), 0, cpNormal, False, nil, nil, wbActorTemplateUseModelAnimation),
    wbByteArray(NIFT, '材质文件哈希值', 0, cpIgnore, False, False, wbActorTemplateUseModelAnimation),
    wbStruct(ACBS, '构造', [
      {00} wbInteger('标志', itU32, wbFlags([
             {0x000001} 'Biped',
             {0x000002} '不死',
             {0x000004} 'Weapon & Shield?',
             {0x000008} '重生',
             {0x000010} '游泳',
             {0x000020} '飞行',
             {0x000040} '步行',
             {0x000080} '玩家等级加成',
             {0x000100} '未知 8',
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
             {0x080000} '没有影子',
             {0x100000} 'No VATS Melee',
           {0x00200000} '允许玩家对话',
           {0x00400000} '无法开门',
           {0x00800000} '固定的',
           {0x01000000} '前后倾斜',
           {0x02000000} '左右倾斜',
           {0x03000000} '无法击倒',
           {0x08000000} '不可推动',
           {0x10000000} '允许扒窃',
           {0x20000000} '鬼魂',
           {0x40000000} 'No Rotating To Head-track',
           {0x80000000} '无法伤害'
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
           {0x02000000 左右倾斜} wbActorTemplateUseModelAnimation,
           {0x03000000 No Knockdowns} nil,
           {0x08000000 Not Pushable} wbActorTemplateUseModelAnimation,
           {0x10000000 Allow Pickpocket} wbActorTemplateUseBaseData,
           {0x20000000 Is Ghost} nil,
           {0x40000000 No Rotating To Head-track} wbActorTemplateUseModelAnimation,
           {0x80000000 Invulnerable} nil
           ])),
      {04} wbInteger('体力', itU16, nil, cpNormal, False, wbActorTemplateUseStats),
      {06} wbInteger('Barter gold', itU16, nil, cpNormal, False, wbActorTemplateUseAIData),
      {08} wbUnion('等级', wbCreaLevelDecider, [
             wbInteger('等级', itS16, nil, cpNormal, False, wbActorTemplateUseStats),
             wbInteger('等级加成', itS16, wbDiv(1000), cpNormal, False, wbActorTemplateUseStats)
           ], cpNormal, False, wbActorTemplateUseStats),
      {10} wbInteger('Calc min', itU16, nil, cpNormal, False, wbActorTemplateUseStats),
      {12} wbInteger('Calc max', itU16, nil, cpNormal, False, wbActorTemplateUseStats),
      {14} wbInteger('速度加成', itU16, nil, cpNormal, False, wbActorTemplateUseStats),
      {16} wbFloat('Karma (Alignment)', cpNormal, False, 1, -1, wbActorTemplateUseTraits),
      {20} wbInteger('基本性格', itS16, nil, cpNormal, False, wbActorTemplateUseTraits),
      {22} wbInteger('模版标志', itU16, wbFlags([
        '使用特征',
        '使用属性',
        '使用派系',
        'Use Actor Effect List',
        '使用AI数据',
        '使用AI包',
        'Use Model/Animation',
        '使用基本数据',
        '使用物品栏',
        '使用脚本'
      ]))
    ], cpNormal, True),
    wbRArrayS('派系',
      wbStructSK(SNAM, [0], '派系', [
        wbFormIDCk('派系', [FACT]),
        wbInteger('等级', itU8),
        wbByteArray('未使用', 3)
      ]),
    cpNormal, False, nil, nil, wbActorTemplateUseFactions),
    wbFormIDCk(INAM, '死亡物品', [LVLI], False, cpNormal, False, wbActorTemplateUseTraits),
    wbFormIDCk(VTCK, '语音', [VTYP], False, cpNormal, False, wbActorTemplateUseTraits),
    wbFormIDCk(TPLT, '模版', [CREA, LVLC]),
    wbDESTActor,
    wbSCRIActor,
    wbRArrayS('物品', wbCNTO, cpNormal, False, nil, nil, wbActorTemplateUseInventory),
    wbAIDT,
    wbRArray('AI包', wbFormIDCk(PKID, 'AI包', [PACK]), cpNormal, False, wbActorTemplateUseAIPackages),
    wbArrayS(KFFZ, '动作', wbStringLC('动作'), 0, cpNormal, False, nil, nil, wbActorTemplateUseModelAnimation),
    wbStruct(DATA, '', [
      {00} wbInteger('类型', itU8, wbCreatureTypeEnum, cpNormal, False, wbActorTemplateUseTraits),
      {01} wbInteger('Combat Skill', itU8, nil, cpNormal, False, wbActorTemplateUseStats),
      {02} wbInteger('魔法技能', itU8, nil, cpNormal, False, wbActorTemplateUseStats),
      {03} wbInteger('Stealth Skill', itU8, nil, cpNormal, False, wbActorTemplateUseStats),
      {04} wbInteger('生命', itS16, nil, cpNormal, False, wbActorTemplateUseStats),
      {06} wbByteArray('未使用', 2),
      {08} wbInteger('伤害', itS16, nil, cpNormal, False, wbActorTemplateUseStats),
      {10} wbArray('Attributes', wbInteger('Attribute', itU8), [
            '力量',
            'Perception',
            '耐力',
            'Charisma',
            '智力',
            '敏捷',
            '运气'
          ], cpNormal, False, wbActorTemplateUseStats)
    ], cpNormal, True),
    wbInteger(RNAM, 'Attack reach', itU8, nil, cpNormal, True, False, wbActorTemplateUseTraits),
    wbFormIDCk(ZNAM, '战斗风格', [CSTY], False, cpNormal, False, wbActorTemplateUseTraits),
    wbFormIDCk(PNAM, '身体部分数据', [BPTD], False, cpNormal, True, wbActorTemplateUseModelAnimation),
    wbFloat(TNAM, 'Turning Speed', cpNormal, True, 1, -1, wbActorTemplateUseStats),
    wbFloat(BNAM, 'Base Scale', cpNormal, True, 1, -1, wbActorTemplateUseStats),
    wbFloat(WNAM, 'Foot Weight', cpNormal, True, 1, -1, wbActorTemplateUseStats),
    wbInteger(NAM4, 'Impact Material Type', itU32, wbImpactMaterialTypeEnum, cpNormal, True, False, wbActorTemplateUseModelAnimation),
    wbInteger(NAM5, '音量级别', itU32, wbSoundLevelEnum, cpNormal, True, False, wbActorTemplateUseModelAnimation),
    wbFormIDCk(CSCR, 'Inherits Sounds from', [CREA], False, cpNormal, False, wbActorTemplateUseModelAnimation),
    wbCSDTs,
    wbFormIDCk(CNAM, 'Impact Dataset', [IPDS], False, cpNormal, False, wbActorTemplateUseModelAnimation),
    wbFormIDCk(LNAM, 'Melee Weapon List', [FLST], False, cpNormal, False, wbActorTemplateUseTraits)
  ], True);

end;

procedure DefineFNVd;
begin
  wbRecord(CSTY, 'Combat Style', [
    wbEDIDReq,
    wbStruct(CSTD, 'Advanced - Standard', [
      {000}wbInteger('Maneuver Decision - Dodge % Chance', itU8),
      {001}wbInteger('Maneuver Decision - Left/Right % Chance', itU8),
      {002}wbByteArray('未使用', 2),
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
      {038}wbByteArray('未使用', 2),
      {040}wbFloat('Melee Decision - Recoil/Stagger Bonus to Attack'),
      {044}wbFloat('Melee Decision - Unconscious Bonus to Attack'),
      {048}wbFloat('Melee Decision - Hand-To-Hand Bonus to Attack'),
      {052}wbInteger('Melee Decision - Power Attacks - Power Attack % Chance', itU8),
      {053}wbByteArray('未使用', 3),
      {056}wbFloat('Melee Decision - Power Attacks - Recoil/Stagger Bonus to Power'),
      {060}wbFloat('Melee Decision - Power Attacks - Unconscious Bonus to Power Attack'),
      {064}wbInteger('Melee Decision - Power Attacks - Normal', itU8),
      {065}wbInteger('Melee Decision - Power Attacks - Forward', itU8),
      {066}wbInteger('Melee Decision - Power Attacks - Back', itU8),
      {067}wbInteger('Melee Decision - Power Attacks - Left', itU8),
      {068}wbInteger('Melee Decision - Power Attacks - Right', itU8),
      {069}wbByteArray('未使用', 3),
      {072}wbFloat('Melee Decision - Hold Timer (min)'),
      {076}wbFloat('Melee Decision - Hold Timer (max)'),
      {080}wbInteger('标志', itU16, wbFlags([
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
      {082}wbByteArray('未使用', 2),
      {085}wbInteger('Maneuver Decision - Acrobatic Dodge % Chance', itU8),
      {085}wbInteger('Melee Decision - Power Attacks - Rushing Attack % Chance', itU8),
      {086}wbByteArray('未使用', 2),
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
      {36} wbByteArray('未使用', 4),
      {40} wbInteger('Weapon Restrictions', itU32, wbEnum([
        '无',
        'Melee Only',
        'Ranged Only'
      ])),
      {44} wbFloat('Ranged Weapon Range Mult (max)'),
      {48} wbFloat('Max Targeting 视场'),
      {52} wbFloat('Combat Radius'),
      {56} wbFloat('Semi-Auto Firing Delay Mult (min)'),
      {60} wbFloat('Semi-Auto Firing Delay Mult (max)')
    ], cpNormal, True)
  ]);

  wbRecord(DIAL, 'Dialog Topic', [
    wbEDIDReq,
    wbRArrayS('Added Quests', wbRStructSK([0], 'Added Quest', [
      wbFormIDCkNoReach(QSTI, '任务', [QUST], False, cpBenign),
      wbRArray('未知', wbRStruct('未知', [
        wbFormIDCk(INFC, '未知', [INFO]),
        wbInteger(INFX, '未知', itS32)
      ], []))
    ], [])),
    wbRArrayS('Removed Quests', wbRStructSK([0], 'Removed Quest', [
      wbFormIDCkNoReach(QSTR, '任务', [QUST], False, cpBenign),
      wbRArray('未知', wbRStruct('未知', [
        wbFormIDCk(INFC, '未知', [INFO]),
        wbInteger(INFX, '未知', itS32)
      ], []))
    ], [])),
    wbFULL,
    wbFloat(PNAM, '优先级', cpNormal, True, 1, -1, nil, nil, 50.0),
    wbString(TDUM),
    wbStruct(DATA, '', [
      wbInteger('类型', itU8, wbEnum([
        {0} '话题',
        {1} '交谈',
        {2} '战斗',
        {3} '说服',
        {4} '侦察',
        {5} '服务',
        {6} '杂项',
        {7} 'Radio'
      ])),
      wbInteger('标志', itU8, wbFlags([
        'Rumors',
        'Top-level'
      ]))
    ], cpNormal, True, nil, 1)
  ], True);

  wbRecord(DOOR, 'Door', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODLReq,
    wbSCRI,
    wbDEST,
    wbFormIDCk(SNAM, '音效 - 开启', [SOUN]),
    wbFormIDCk(ANAM, '音效 - 关闭', [SOUN]),
    wbFormIDCk(BNAM, '音效 - 循环', [SOUN]),
    wbInteger(FNAM, '标志', itU8, wbFlags([
      '',
      '自动门',
      '隐藏',
      '最小使用',
      '推拉门'
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
    wbString(NAM7, '洞口材质'),
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
      wbFloat('颜色检索3 - 颜色检索时间'),
      wbFloat('粒子着色器 - 沿法线初始速度 +/-'),
      wbFloat('粒子着色器 - 初始角度 (度数)'),
      wbFloat('粒子着色器 - 初始角度 (度数) +/-'),
      wbFloat('粒子着色器 - 旋转 (度数/秒)'),
      wbFloat('粒子着色器 - 旋转 (度数/秒) +/-'),
      wbFormIDCk('附加模型', [DEBR, NULL]),
      wbFloat('洞口 - 起始时间'),
      wbFloat('洞口 - 结束时间'),
      wbFloat('洞口 - 起始数值'),
      wbFloat('洞口 - 结束数值'),
      wbFloat('边缘宽度(alpha 单位)'),
      wbStruct('边缘颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbFloat('爆炸风速度'),
      wbInteger('材质数量 U', itU32),
      wbInteger('材质数量 V', itU32),
      wbFloat('附加模型 - 淡入时间'),
      wbFloat('附加模型 - 淡出时间'),
      wbFloat('附加模型 - 扩展开始'),
      wbFloat('附加模型 - 扩展结束'),
      wbFloat('附加模型 - 向内扩展时间'),
      wbFloat('附加模型 - 向外扩展时间')
    ], cpNormal, True, nil, 57)
  ], False, nil, cpNormal, False, wbEFSHAfterLoad);

  wbRecord(ENCH, 'Object Effect', [
    wbEDIDReq,
    wbFULL,
    wbStruct(ENIT, '效果数据', [
      wbInteger('类型', itU32, wbEnum([
        {0} '',
        {1} '',
        {2} '武器',
        {3} 'Apparel'
      ])),
      wbByteArray('未使用', 4),
      wbByteArray('未使用', 4),
      wbInteger('标志', itU8, wbFlags([
        '不自动计算',
        '',
        'Hide Effect'
      ])),
      wbByteArray('未使用', 3)
    ], cpNormal, True),
    wbEffectsReq
  ]);

  wbRecord(EYES, 'Eyes', [
    wbEDIDReq,
    wbFULLReq,
    wbString(ICON, '材质', 0{, cpNormal, True??}),
    wbInteger(DATA, '标志', itU8, wbFlags([
      '玩家可用',
      '非男性',
      '非女性'
    ]), cpNormal, True)
  ]);

  wbXNAM :=
    wbStructSK(XNAM, [0], '关系', [
      wbFormIDCkNoReach('派系', [FACT, RACE]),
      wbInteger('修正', itS32),
      wbInteger('集团作战反应', itU32, wbEnum([
        '中立',
        '敌人',
        '同伴',
        '好友'
      ]))
    ]);

  wbXNAMs := wbRArrayS('关系', wbXNAM);

  wbRecord(FACT, 'Faction', [
    wbEDIDReq,
    wbFULL,
    wbXNAMs,
    wbStruct(DATA, '', [
      wbInteger('标志 1', itU8, wbFlags([
        '从 PC 隐藏',
        '有害',
        '特殊战斗'
      ])),
      wbInteger('标志 2', itU8, wbFlags([
        '跟踪罪行',
        'Allow Sell'
      ])),
      wbByteArray('未使用', 2)
    ], cpNormal, True, nil, 1),
    wbFloat(CNAM, '未使用'),
    wbRStructsSK('等级', '等级', [0], [
      wbInteger(RNAM, '等级#', itS32),
      wbString(MNAM, '男性', 0, cpTranslate),
      wbString(FNAM, '女性', 0, cpTranslate),
      wbString(INAM, '记号 (Unused)')
    ], []),
    wbFormIDCk(WMI1, 'Reputation', [REPU])
  ], False, nil, cpNormal, False, wbFACTAfterLoad);

  wbRecord(FURN, 'Furniture', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODLReq,
    wbSCRI,
    wbDEST,
    wbByteArray(MNAM, 'Marker Flags', 0, cpNormal, True)
  ]);

  wbRecord(GLOB, 'Global', [
    wbEDIDReq,
    wbInteger(FNAM, '类型', itU8, wbGLOBFNAM, nil, cpNormal, True),
    wbFloat(FLTV, '数值', cpNormal, True)
  ]);


  wbRecord(GMST, 'Game Setting', [
    wbString(EDID, '编辑器标识', 0, cpCritical, True, nil, wbGMSTEDIDAfterSet),
    wbUnion(DATA, '数值', wbGMSTUnionDecider, [
      wbString('', 0, cpTranslate),
      wbInteger('', itS32),
      wbFloat('')
    ], cpNormal, True)
  ]);

  wbDODT := wbStruct(DODT, '贴花数据', [
              wbFloat('最小宽度'),
              wbFloat('最大宽度'),
              wbFloat('最小高度'),
              wbFloat('最大高度'),
              wbFloat('深度'),
              wbFloat('亮度'),
              wbStruct('视差', [
                wbFloat('范围'),
                wbInteger('通道', itU8)
              ]),
              wbInteger('标志', itU8, wbFlags([
                '视差',
                'Alpha - 混合',
                'Alpha - 测试'
              ], True)),
              wbByteArray('未使用', 2),
              wbStruct('颜色', [
                wbInteger('红', itU8),
                wbInteger('绿', itU8),
                wbInteger('蓝', itU8),
                wbByteArray('未使用', 1)
              ])
            ]);

  wbRecord(TXST, 'Texture Set', [
    wbEDIDReq,
    wbOBNDReq,
    wbRStruct('材质 (RGB/A)', [
      wbString(TX00,'基底影像 / 透明度'),
      wbString(TX01,'法线贴图 / 高光'),
      wbString(TX02,'环境遮罩 / ?'),
      wbString(TX03,'辉光贴图 / 未使用'),
      wbString(TX04,'视差贴图 / 未使用'),
      wbString(TX05,'环境贴图 / 未使用')
    ], []),
    wbDODT,
    wbInteger(DNAM, '标志', itU16, wbFlags([
      '无高光贴图'
    ]), cpNormal, True)
  ]);

  wbRecord(MICN, 'Menu Icon', [
    wbEDIDReq,
    wbICONReq
  ]);

  wbRecord(HDPT, 'Head Part', [
    wbEDIDReq,
    wbFULLReq,
    wbMODL,
    wbInteger(DATA, '标志', itU8, wbFlags([
      '玩家可用'
    ]), cpNormal, True),
    wbRArrayS('额外部分',
      wbFormIDCk(HNAM, '部分', [HDPT])
    )
  ]);

  wbRecord(ASPC, 'Acoustic Space', [
    wbEDIDReq,
    wbOBNDReq,

    wbFormIDCk(SNAM, 'Dawn / Default Loop', [NULL, SOUN], False, cpNormal, True),
    wbFormIDCk(SNAM, 'Afternoon', [NULL, SOUN], False, cpNormal, True),
    wbFormIDCk(SNAM, 'Dusk', [NULL, SOUN], False, cpNormal, True),
    wbFormIDCk(SNAM, '夜晚', [NULL, SOUN], False, cpNormal, True),
    wbFormIDCk(SNAM, 'Walla', [NULL, SOUN], False, cpNormal, True),

    wbInteger(WNAM, 'Walla Trigger Count', itU32, nil, cpNormal, True),
    wbFormIDCk(RDAT, '来源于地区的音效 (仅室内)', [REGN]),
    wbInteger(ANAM, '环境类型', itU32, wbEnum([
      '无',
      '默认',
      'Generic',
      'Padded Cell',
      'Room',
      'Bathroom',
      'Livingroom',
      'Stone Room',
      'Auditorium',
      'Concerthall',
      '洞穴',
      'Arena',
      'Hangar',
      'Carpeted Hallway',
      'Hallway',
      'Stone Corridor',
      'Alley',
      'Forest',
      '城市',
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
    ]), cpNormal, True),
    wbInteger(INAM, 'Is Interior', itU32, wbEnum(['否', '是']), cpNormal, True)
  ]);

  wbRecord(TACT, 'Talking Activator', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODLReq,
    wbSCRI,
    wbDEST,
    wbFormIDCk(SNAM, '循环音效', [SOUN]),
    wbFormIDCk(VNAM, '语音', [VTYP]),
    wbFormIDCk(INAM, 'Radio Template', [SOUN])
  ]);

  wbRecord(SCPT, 'Script', [
    wbEDIDReq,
    wbSCHRReq,
    wbByteArray(SCDA, 'Compiled Script'),
    wbStringScript(SCTX, 'Script Source', 0, cpNormal{, True}),
    wbRArrayS('Local Variables', wbRStructSK([0], 'Local Variable', [
      wbSLSD,
      wbString(SCVR, '名称', 0, cpCritical, True)
    ], [])),
    wbSCROs
  ]);

  wbRecord(TERM, 'Terminal', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbSCRI,
    wbDEST,
    wbDESCReq,
    wbFormIDCk(SNAM, '音效 - 循环', [SOUN]),
    wbFormIDCk(PNAM, 'Password Note', [NOTE]),
    wbStruct(DNAM, '', [
      wbInteger('Base Hacking Difficulty', itU8, wbEnum([
        '非常简单',
        '简单',
        '普通',
        '困难',
        '非常困难',
        '需要钥匙'
      ])),
      wbInteger('标志', itU8, wbFlags([
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
      wbByteArray('未使用', 1)
    ], cpNormal, True),
    wbRArray('Menu Items',
      wbRStruct('Menu Item', [
        wbString(ITXT, 'Item Text'),
        wbString(RNAM, 'Result Text', 0, cpNormal, True),
        wbInteger(ANAM, '标志', itU8, wbFlags([
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

  wbRecord(SCOL, 'Static Collection', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODLReq,
    wbRStructsSK('部分', '部分', [0], [
      wbFormIDCk(ONAM, 'Static', [STAT]),
      wbArrayS(DATA, 'Placements', wbStruct('Placement', [
        wbStruct('方位', [
          wbFloat('X'),
          wbFloat('Y'),
          wbFloat('Z')
        ]),
        wbStruct('角度', [
          wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
          wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
          wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
        ]),
        wbFloat('范围')
      ]), 0, cpNormal, True)
    ], [], cpNormal, True)
  ]);

  wbRecord(MSTT, 'Moveable Static', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODLReq,
    wbDEST,
    wbByteArray(DATA, '未知', 1, cpNormal, True),
    wbFormIDCk(SNAM, '音效', [SOUN])
  ]);

  wbRecord(PWAT, 'Placeable Water', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODLReq,
    wbStruct(DNAM, '', [
      wbInteger('标志', itU32, wbFlags([
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
      wbFormIDCk('水源', [WATR])
    ], cpNormal, True)
  ]);

  wbRecord(IDLM, 'Idle Marker', [
    wbEDIDReq,
    wbOBNDReq,
    wbInteger(IDLF, '标志', itU8, wbFlags([
      '按顺序运行',
      '',
      '运行一次'
    ]), cpNormal, True),
    wbStruct(IDLC, '', [
      wbInteger('动作数量', itU8),
      wbByteArray('未使用', 3)
    ], cpNormal, True, nil, 1),
    wbFloat(IDLT, '动作计时器设定', cpNormal, True),
    wbArray(IDLA, '动作', wbFormIDCk('动作', [IDLE]), 0, nil, nil, cpNormal, True)
  ]);

  wbRecord(NOTE, 'Note', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbYNAM,
    wbZNAM,
    wbInteger(DATA, '类型', itU8, wbEnum([
      '音效',
      '文本',
      'Image',
      '语音'
    ]), cpNormal, True),
    wbRArrayS('任务',
      wbFormIDCkNoReach(ONAM, '任务', [QUST])
    ),
    wbString(XNAM, '材质'),
    wbUnion(TNAM, 'Text / Topic', wbNOTETNAMDecide, [
      wbString('文本'),
      wbFormIDCk('话题', [DIAL])
    ]),
    wbUnion(SNAM, 'Sound / NPC', wbNOTESNAMDecide, [
      wbFormIDCk('音效', [SOUN]),
      wbFormIDCk('角色', [NPC_, CREA])
    ])
  ]);

end;

procedure DefineFNVe;
begin
  wbRecord(PROJ, 'Projectile', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODLReq,
    wbDEST,
    wbStruct(DATA, '数据', [
      {00} wbInteger('标志', itU16, wbFlags([
        '即时命中',
        '爆炸',
        '替代触发器',
        '开火闪光',
        '',
        '可以被禁止',
        '可以被拾取',
        '超音速',
        '连接肢体',
        '穿过小型易透',
        '爆破',
        '旋转'
      ])),
      {02} wbInteger('类型', itU16, wbEnum([
        {00} '',
        {01} '直线型',
        {02} '高投式',
        {03} '',
        {04} '散射式',
        {05} '',
        {06} '',
        {07} '',
        {08} '喷射式',
        {09} '',
        {10} '',
        {11} '',
        {12} '',
        {13} '',
        {14} '',
        {15} '',
        {16} 'Continuous Beam'
      ])),
      {04} wbFloat('重力'),
      {08} wbFloat('速度'),
      {12} wbFloat('规模'),
      {16} wbFormIDCk('光效', [LIGH, NULL]),
      {20} wbFormIDCk('开火闪光 - 光效', [LIGH, NULL]),
      {24} wbFloat('示踪概率'),
      {28} wbFloat('爆炸 - 替代触发器 - 距离'),
      {32} wbFloat('爆炸 - 替代触发器 - 计时'),
      {36} wbFormIDCk('爆炸', [EXPL, NULL]),
      {40} wbFormIDCk('音效', [SOUN, NULL]),
      {44} wbFloat('开火闪光 - 持续时间'),
      {48} wbFloat('淡出持续时间'),
      {52} wbFloat('冲击强度'),
      {56} wbFormIDCk('音效 - 倒计时', [SOUN, NULL]),
      {60} wbFormIDCk('音效 - 禁止', [SOUN, NULL]),
      {64} wbFormIDCk('默认武器源', [WEAP, NULL]),
      {68} wbStruct('角度', [
      {68}   wbFloat('X'),
      {72}   wbFloat('Y'),
      {76}   wbFloat('Z')
           ]),
      {80} wbFloat('Bouncy Mult')
    ], cpNormal, True),
    wbRStructSK([0], '开火闪光模型', [
      wbString(NAM1, '模型'),
      wbByteArray(NAM2, '材质文件哈希值', 0, cpIgnore)
    ], [], cpNormal, True),
    wbInteger(VNAM, '音量级别', itU32, wbSoundLevelEnum, cpNormal, True)
  ]);

  wbRecord(NAVI, 'Navigation Mesh Info Map', [
    wbEDID,
    wbInteger(NVER, '版本', itU32),
    wbRArray('导航地图信息',
      wbStruct(NVMI, '导航地图信息', [
        wbByteArray('未知', 4),
        wbFormIDCk('导航模型', [NAVM]),
        wbFormIDCk('位置', [CELL, WRLD]),
        wbStruct('网格', [
          wbInteger('X', itS16),
          wbInteger('Y', itS16)
        ]),
        wbUnknown
{        wbUnion('数据', wbNAVINVMIDecider, [
          wbStruct('数据', [
            wbUnknown
          ]),
          wbStruct('数据', [
            wbArray('未知', wbFloat('未知'), 3),
            wbByteArray('未知', 4)
          ]),
          wbStruct('数据', [
            wbArray('未知', wbArray('未知', wbFloat('未知'), 3), 3),
            wbInteger('Count 1', itU16),
            wbInteger('Count 2', itU16),
            wbArray('未知', wbArray('未知', wbFloat('未知'), 3), [], wbNAVINAVMGetCount1),
            wbUnknown
          ]),
          wbStruct('数据', [
            wbUnknown
          ])
        ])}
      ])
    ),
    wbRArray('未知',
      wbStruct(NVCI, '未知', [
        wbFormIDCk('未知', [NAVM]),
        wbArray('未知', wbFormIDCk('未知', [NAVM]), -1),
        wbArray('未知', wbFormIDCk('未知', [NAVM]), -1),
        wbArray('Doors', wbFormIDCk('门', [REFR]), -1)
      ])
    )
  ]);

  if wbSimpleRecords then begin

    wbRecord(NAVM, 'Navigation Mesh', [
      wbEDID,
      wbInteger(NVER, '版本', itU32),
      wbStruct(DATA, '', [
        wbFormIDCk('场景', [CELL]),
        wbInteger('Vertex Count', itU32),
        wbInteger('Triangle Count', itU32),
        wbInteger('外部连接 Count', itU32),
        wbInteger('NVCA Count', itU32),
        wbInteger('Doors Count', itU32)
      ]),
      wbByteArray(NVVX, '顶点'),
      wbByteArray(NVTR, '三角'),
      wbByteArray(NVCA, '未知'),
      wbArray(NVDP, 'Doors', wbStruct('门', [
        wbFormIDCk('衍生', [REFR]),
        wbInteger('未知', itU16),
        wbByteArray('未使用', 2)
      ])),
      wbByteArray(NVGD, '未知'),
      wbArray(NVEX, '外部连接', wbStruct('连接', [
        wbByteArray('未知', 4),
        wbFormIDCk('导航模型', [NAVM], False, cpNormal),
        wbInteger('三角', itU16, nil, cpNormal)
      ]))
    ], False, wbNAVMAddInfo);

  end else begin

    wbRecord(NAVM, 'Navigation Mesh', [
      wbEDID,
      wbInteger(NVER, '版本', itU32),
      wbStruct(DATA, '', [
        wbFormIDCk('场景', [CELL]),
        wbInteger('Vertex Count', itU32),
        wbInteger('Triangle Count', itU32),
        wbInteger('外部连接 Count', itU32),
        wbInteger('NVCA Count', itU32),
        wbInteger('Doors Count', itU32)
      ]),
      wbArray(NVVX, '顶点', wbStruct('顶点', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ])),
      wbArray(NVTR, '三角', wbStruct('三角', [
        wbArray('顶点', wbInteger('顶点', itS16), 3),
        wbArray('边缘', wbInteger('三角', itS16, wbNVTREdgeToStr, wbNVTREdgeToInt), [
          '0 <-> 1',
          '1 <-> 2',
          '2 <-> 0'
        ]),
        wbInteger('标志', itU32, wbFlags([
          'Triangle #0 Is External',
          'Triangle #1 Is External',
          'Triangle #2 Is External',
          '未知 4',
          '未知 5',
          '未知 6',
          '未知 7',
          '未知 8',
          '未知 9',
          '未知 10',
          '未知 11',
          '未知 12',
          '未知 13',
          '未知 14',
          '未知 15',
          '未知 16',
          '未知 17',
          '未知 18',
          '未知 19',
          '未知 20',
          '未知 21',
          '未知 22',
          '未知 23',
          '未知 24',
          '未知 25',
          '未知 26',
          '未知 27',
          '未知 28',
          '未知 29',
          '未知 30',
          '未知 31',
          '未知 32'
        ]))
      ])),
      wbArray(NVCA, '未知', wbInteger('未知', itS16)),
      wbArray(NVDP, 'Doors', wbStruct('门', [
        wbFormIDCk('衍生', [REFR]),
        wbInteger('未知', itU16),
        wbByteArray('未使用', 2)
      ])),
      wbStruct(NVGD, '未知', [
        wbByteArray('未知', 4),
        wbFloat('未知'),
        wbFloat('未知'),
        wbFloat('未知'),
        wbFloat('未知'),
        wbFloat('未知'),
        wbFloat('未知'),
        wbFloat('未知'),
        wbFloat('未知'),
        wbArray('未知', wbArray('未知', wbInteger('未知', itU16), -2))
      ]),
      wbArray(NVEX, '外部连接', wbStruct('连接', [
        wbByteArray('未知', 4),
        wbFormIDCk('导航模型', [NAVM], False, cpNormal),
        wbInteger('三角', itU16, nil, cpNormal)
      ]))
    ], False, wbNAVMAddInfo);

  end;

  wbRecord(PGRE, 'Placed Grenade', [
    wbEDID,
    wbFormIDCk(NAME, '基础', [PROJ], False, cpNormal, True),
    wbFormIDCk(XEZN, '遭遇区域', [ECZN]),

    wbXRGD,
    wbXRGB,

    {--- Patrol Data ---}
    wbRStruct('巡逻数据', [
      wbFloat(XPRD, '空闲时间', cpNormal, True),
      wbEmpty(XPPA, '巡逻脚本标记', cpNormal, True),
      wbFormIDCk(INAM, '空闲动作', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, '话题', [DIAL, NULL], False, cpNormal, True)
    ], []),

    {--- Ownership ---}
    wbRStruct('所有权', [
      wbXOWN,
      wbInteger(XRNK, '派系等级', itS32)
    ], [XCMT, XCMO]),

    {--- Extra ---}
    wbInteger(XCNT, '数量', itS32),
    wbFloat(XRDS, '半径'),
    wbFloat(XHLP, '生命'),

    {--- Reflected By / Refracted By ---}
    wbRArrayS('反射/折射',
      wbStructSK(XPWR, [0], '水源', [
        wbFormIDCk('衍生', [REFR]),
        wbInteger('类型', itU32, wbFlags([
          '反射',
          '折射'
        ]))
      ])
    ),

    {--- Decals ---}
    wbRArrayS('Linked Decals',
      wbStructSK(XDCR, [0], 'Decal', [
        wbFormIDCk('衍生', [REFR]),
        wbUnknown
      ])
    ),

    {--- Linked Ref ---}
    wbFormIDCk(XLKR, '连接的衍生', [REFR, ACRE, ACHR, PGRE, PMIS]),
    wbStruct(XCLP, '连结衍生颜色', [
      wbStruct('连结起始颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbStruct('连结结束颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ])
    ]),

    {--- Activate Parents ---}
    wbRStruct('激活根源', [
      wbInteger(XAPD, '标志', itU8, wbFlags([
        '仅激活根源'
      ], True)),
      wbRArrayS('激活根源衍生',
        wbStructSK(XAPR, [0], '激活根源衍生', [
          wbFormIDCk('衍生', [REFR, ACRE, ACHR, PGRE, PMIS]),
          wbFloat('推延')
        ])
      )
    ], []),

    wbString(XATO, '激活提示'),

    {--- Enable Parent ---}
    wbXESP,

    {--- Emittance ---}
    wbFormIDCk(XEMI, '辐射颜色', [LIGH, REGN]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, '多限制衍生', [REFR]),

    {--- Flags ---}
    wbEmpty(XIBS, '被沙盒忽略'),

    {--- 3D Data ---}
    wbXSCL,
    wbDATAPosRot
  ], True, wbPlacedAddInfo);

  wbRecord(PMIS, 'Placed Missile', [
    wbEDID,
    wbFormIDCk(NAME, '基础', [PROJ], False, cpNormal, True),
    wbFormIDCk(XEZN, '遭遇区域', [ECZN]),

    wbXRGD,
    wbXRGB,

    {--- Patrol Data ---}
    wbRStruct('巡逻数据', [
      wbFloat(XPRD, '空闲时间', cpNormal, True),
      wbEmpty(XPPA, '巡逻脚本标记', cpNormal, True),
      wbFormIDCk(INAM, '空闲动作', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, '话题', [DIAL, NULL], False, cpNormal, True)
    ], []),

    {--- Ownership ---}
    wbRStruct('所有权', [
      wbXOWN,
      wbInteger(XRNK, '派系等级', itS32)
    ], [XCMT, XCMO]),

    {--- Extra ---}
    wbInteger(XCNT, '数量', itS32),
    wbFloat(XRDS, '半径'),
    wbFloat(XHLP, '生命'),

    {--- Reflected By / Refracted By ---}
    wbRArrayS('反射/折射',
      wbStructSK(XPWR, [0], '水源', [
        wbFormIDCk('衍生', [REFR]),
        wbInteger('类型', itU32, wbFlags([
          '反射',
          '折射'
        ]))
      ])
    ),

    {--- Decals ---}
    wbRArrayS('Linked Decals',
      wbStructSK(XDCR, [0], 'Decal', [
        wbFormIDCk('衍生', [REFR]),
        wbUnknown
      ])
    ),

    {--- Linked Ref ---}
    wbFormIDCk(XLKR, '连接的衍生', [REFR, ACRE, ACHR, PGRE, PMIS]),
    wbStruct(XCLP, '连结衍生颜色', [
      wbStruct('连结起始颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbStruct('连结结束颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ])
    ]),

    {--- Activate Parents ---}
    wbRStruct('激活根源', [
      wbInteger(XAPD, '标志', itU8, wbFlags([
        '仅激活根源'
      ], True)),
      wbRArrayS('激活根源衍生',
        wbStructSK(XAPR, [0], '激活根源衍生', [
          wbFormIDCk('衍生', [REFR, ACRE, ACHR, PGRE, PMIS]),
          wbFloat('推延')
        ])
      )
    ], []),

    wbString(XATO, '激活提示'),

    {--- Enable Parent ---}
    wbXESP,

    {--- Emittance ---}
    wbFormIDCk(XEMI, '辐射颜色', [LIGH, REGN]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, '多限制衍生', [REFR]),

    {--- Flags ---}
    wbEmpty(XIBS, '被沙盒忽略'),

    {--- 3D Data ---}
    wbXSCL,
    wbDATAPosRot
  ], True, wbPlacedAddInfo);


   wbRecord(EXPL, 'Explosion', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbEITM,
    wbFormIDCk(MNAM, '图像空间变换', [IMAD]),
    wbStruct(DATA, '数据', [
      {00} wbFloat('威力'),
      {04} wbFloat('伤害'),
      {08} wbFloat('半径'),
      {12} wbFormIDCk('光效', [LIGH, NULL]),
      {16} wbFormIDCk('音效 1', [SOUN, NULL]),
      {20} wbInteger('标志', itU32, wbFlags([
             {0x00000001}'未知 1',
             {0x00000002}'始终使用世界定位',
             {0x00000004}'击倒 - 始终',
             {0x00000008}'击倒 - 依公式',
             {0x00000010}'忽略直线对穿检查',
             {0x00000020}'仅推动爆炸源衍生',
             {0x00000040}'忽略图像空间交换'
           ])),
      {24} wbFloat('图像空间半径'),
      {28} wbFormIDCk('Impact DataSet', [IPDS, NULL]),
      {32} wbFormIDCk('音效 2', [SOUN, NULL]),
           wbStruct('Radiation', [
             {36} wbFloat('等级'),
             {40} wbFloat('Dissipation Time'),
             {44} wbFloat('半径')
           ]),
      {48} wbInteger('音量级别', itU32, wbSoundLevelEnum, cpNormal, True)
    ], cpNormal, True),
    wbFormIDCk(INAM, 'Placed Impact Object', [TREE, SOUN, ACTI, DOOR, STAT, FURN,
          CONT, ARMO, AMMO, LVLN, LVLC, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS,
          ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM, TXST, CHIP, IMOD])
  ]);

  wbRecord(DEBR, 'Debris', [
    wbEDIDReq,
    wbRStructs('模型', '模型', [
      wbStruct(DATA, '数据', [
        wbInteger('百分比', itU8),
        wbString('模型'),
        wbInteger('标志', itU8, wbFlags([
          '存在碰撞数据'
        ]))
      ], cpNormal, True),
      wbByteArray(MODT, '材质文件哈希值', 0, cpIgnore)
    ], [], cpNormal, True)
  ]);

  wbRecord(IMGS, 'Image Space', [
    wbEDIDReq,
    wbStruct(DNAM, '', [
      wbStruct('HDR', [
        {00} wbFloat('眼睛适应速度'),
        {04} wbFloat('模糊半径'),
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
        {60} wbFloat('模糊半径'),
        {64} wbFloat('Alpha Mult Interior'),
        {68} wbFloat('Alpha Mult Exterior')
      ]),
      wbStruct('Get Hit', [
        {72} wbFloat('模糊半径'),
        {76} wbFloat('Blur Damping Constant'),
        {80} wbFloat('Damping Constant')
      ]),
      wbStruct('夜视', [
        wbStruct('色调颜色', [
          {84} wbFloat('红', cpNormal, False, 255, 0),
          {88} wbFloat('绿', cpNormal, False, 255, 0),
          {92} wbFloat('蓝', cpNormal, False, 255, 0)
        ]),
      {96} wbFloat('亮度')
      ]),
      wbStruct('电影效果', [
        {100} wbFloat('饱和度'),
        wbStruct('对比度', [
          {104} wbFloat('Avg Lum Value'),
          {108} wbFloat('数值')
        ]),
        {112} wbFloat('电影效果 - Brightness - Value'),
        wbStruct('色调', [
          wbStruct('颜色', [
            {116} wbFloat('红', cpNormal, False, 255, 0),
            {120} wbFloat('绿', cpNormal, False, 255, 0),
            {124} wbFloat('蓝', cpNormal, False, 255, 0)
          ]),
        {128} wbFloat('数值')
        ])
      ]),
      wbByteArray('未使用', 4),
      wbByteArray('未使用', 4),
      wbByteArray('未使用', 4),
      wbByteArray('未使用', 4),
      wbInteger('标志', itU8, wbFlags([
        '饱和度',
        '对比度',
        '色调',
        '亮度'
      ], True)),
      wbByteArray('未使用', 3)
    ], cpNormal, True, nil, 5)
  ]);

  wbRecord(IMAD, 'Image Space Modifier', [
    wbEDID,
    wbUnknown(DNAM),
    wbUnknown(BNAM),
    wbUnknown(VNAM),
    wbUnknown(TNAM),
    wbUnknown(NAM3),
    wbUnknown(RNAM),
    wbUnknown(SNAM),
    wbUnknown(UNAM),
    wbUnknown(NAM1),
    wbUnknown(NAM2),
    wbUnknown(WNAM),
    wbUnknown(XNAM),
    wbUnknown(YNAM),
    wbUnknown(NAM4),
    wbUnknown(_00_IAD),
    wbUnknown(_40_IAD),
    wbUnknown(_01_IAD),
    wbUnknown(_41_IAD),
    wbUnknown(_02_IAD),
    wbUnknown(_42_IAD),
    wbUnknown(_03_IAD),
    wbUnknown(_43_IAD),
    wbUnknown(_04_IAD),
    wbUnknown(_44_IAD),
    wbUnknown(_05_IAD),
    wbUnknown(_45_IAD),
    wbUnknown(_06_IAD),
    wbUnknown(_46_IAD),
    wbUnknown(_07_IAD),
    wbUnknown(_47_IAD),
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
    wbUnknown(_11_IAD),
    wbUnknown(_51_IAD),
    wbUnknown(_12_IAD),
    wbUnknown(_52_IAD),
    wbUnknown(_13_IAD),
    wbUnknown(_53_IAD),
    wbUnknown(_14_IAD),
    wbUnknown(_54_IAD),
    wbFormIDCk(RDSD, 'Sound - Intro', [SOUN]),
    wbFormIDCk(RDSI, 'Sound - Outro', [SOUN])
  ]);

  wbRecord(FLST, 'FormID List', [
    wbString(EDID, '编辑器标识', 0, cpBenign, True, nil, wbFLSTEDIDAfterSet),
    wbRArrayS('表单序号', wbFormID(LNAM, '表单序号'), cpNormal, False, nil, nil, nil, wbFLSTLNAMIsSorted)
  ]);

  wbRecord(PERK, 'Perk', [
    wbEDIDReq,
    wbFULL,
    wbDESCReq,
    wbICON,
    wbCTDAs,
    wbStruct(DATA, '数据', [
      wbInteger('特征', itU8, wbEnum(['否', '是'])),
      wbInteger('最小等级', itU8),
      wbInteger('等级', itU8),
      wbInteger('玩家可用', itU8, wbEnum(['否', '是'])),
      wbInteger('隐藏', itU8, wbEnum(['否', '是']))
    ], cpNormal, True, nil, 4),
    wbRStructsSK('效果', '效果', [0, 1], [
      wbStructSK(PRKE, [1, 2, 0], '数据头', [
        wbInteger('类型', itU8, wbEnum([
          '任务 + 阶段',
          '能力',
          '记录点'
        ]), cpNormal, False, nil, wbPERKPRKETypeAfterSet),
        wbInteger('等级', itU8),
        wbInteger('优先级', itU8)
      ]),
      wbUnion(DATA, '效果数据', wbPerkDATADecider, [
        wbStructSK([0, 1], '任务 + 阶段', [
          wbFormIDCk('任务', [QUST]),
          wbInteger('任务阶段', itU8, wbPerkDATAQuestStageToStr, wbCTDAParam2QuestStageToInt),
          wbByteArray('未使用', 3)
        ]),
        wbFormIDCk('能力', [SPEL]),
        wbStructSK([0, 1], '记录点', [
          wbInteger('记录点', itU8, wbEnum([
           {00} '计算武器伤害',
           {01} '计算我的致命攻击概率',
           {02} '计算我的致命攻击伤害',
           {03} 'Calculate Weapon Attack AP Cost',
           {04} '计算地雷爆炸概率',
           {05} 'Adjust Range Penalty',
           {06} '调整肢体伤害',
           {07} 'Calculate Weapon Range',
           {08} 'Calculate To Hit Chance',
           {09} 'Adjust Experience Points',
           {10} 'Adjust Gained Skill Points',
           {11} '调整书籍技能点',
           {12} '修改生命恢复',
           {13} 'Calculate Inventory AP Cost',
           {14} 'Get Disposition',
           {15} '获取肩膀攻击',
           {16} 'Get Should Assist',
           {17} 'Calculate Buy Price',
           {18} 'Get Bad Karma',
           {19} 'Get Good Karma',
           {20} 'Ignore Locked Terminal',
           {21} '添加死亡等级列表',
           {22} '获取最大负重',
           {23} '修改上瘾概率',
           {24} '修改上瘾时长',
           {25} '修改主动化学时长',
           {26} 'Adjust Drinking Radiation',
           {27} '激活',
           {28} 'Mysterious Stranger',
           {29} 'Has Paralyzing Palm',
           {30} 'Hacking Science Bonus',
           {31} '侦测时忽略跑步',
           {32} '忽略损坏的锁',
           {33} 'Has Concentrated Fire',
           {34} 'Calculate Gun Spread',
           {35} 'Player Kill AP Reward',
           {36} '修改敌人致命攻击概率',
           {37} 'Reload Speed',
           {38} 'Equip Speed',
           {39} 'Action Point Regen',
           {40} 'Action Point Cost',
           {41} 'Miss Fortune',
           {42} 'Modify Run Speed',
           {43} 'Modify Attack Speed',
           {44} 'Modify Radiation Consumed',
           {45} 'Has Pip Hacker',
           {46} 'Has Meltdown',
           {47} 'See Enemy Health',
           {48} 'Has Jury Rigging',
           {49} 'Modify Threat Range',
           {50} 'Modify Thread',
           {51} 'Has Fast Travel Always',
           {52} 'Knockdown Chance',
           {53} 'Modify Weapon Strength Req',
           {54} 'Modify Aiming Move Speed',
           {55} 'Modify Light Items',
           {56} 'Modify Damage Threshold (defender)',
           {57} 'Modify Chance for Ammo Item',
           {58} 'Modify Damage Threshold (attacker)',
           {59} 'Modify Throwing Velocity',
           {60} 'Chance for Item on Fire',
           {61} 'Has Unarmed Forward Power Attack',
           {62} 'Has Unarmed Back Power Attack',
           {63} 'Has Unarmed Crouched Power Attack',
           {64} 'Has Unarmed Counter Attack',
           {65} 'Has Unarmed Left Power Attack',
           {66} 'Has Unarmed Right Power Attack',
           {67} 'VATS HelperChance',
           {68} 'Modify Item Damage',
           {69} 'Has Improved Detection',
           {70} 'Has Improved Spotting',
           {71} 'Has Improved Item Detection',
           {72} 'Adjust Explosion Radius',
           {73} 'Reserved'
          ]), cpNormal, True, nil, wbPERKEntryPointAfterSet),
          wbInteger('函数', itU8, wbPerkDATAFunctionToStr, wbPerkDATAFunctionToInt, cpNormal, False, nil, wbPerkDATAFunctionAfterSet),
          wbInteger('天赋条件选项总数', itU8, nil, cpIgnore)
        ])
      ], cpNormal, True),
      wbRStructsSK('天赋条件', '天赋条件', [0], [
        wbInteger(PRKC, '运行于', itS8, wbPRKCToStr, wbPRKCToInt),
        wbCTDAsReq
      ], [], cpNormal, False, nil, nil, wbPERKPRKCDontShow),
      wbRStruct('记录点函数参数', [
        wbInteger(EPFT, '类型', itU8, wbPerkEPFTToStr, wbPerkEPFTToInt, cpIgnore, False, nil, wbPerkEPFTAfterSet),
        wbUnion(EPFD, '数据', wbEPFDDecider, [
          wbByteArray('未知'),
          wbFloat('浮点数'),
          wbStruct('浮点数, 浮点数', [
            wbFloat('浮点数 1'),
            wbFloat('浮点数 2')
          ]),
          wbFormIDCk('等级物品', [LVLI]),
          wbEmpty('None (Script)'),
          wbStruct('角色数值, 浮点数', [
            wbInteger('角色数值', itU32, wbEPFDActorValueToStr, wbEPFDActorValueToInt),
            wbFloat('浮点数')
          ])
        ], cpNormal, False, wbEPFDDontShow),
        wbString(EPF2, '按钮文本', 0, cpNormal, False, wbEPF2DontShow),
        wbInteger(EPF3, '脚本标志', itU16, wbFlags([
          '立即执行'
        ]), cpNormal, False, False, wbEPF2DontShow),
        wbEmbeddedScriptPerk
      ], [], cpNormal, False, wbPERKPRKCDontShow),
      wbEmpty(PRKF, '结束标记', cpIgnore, True)
    ], [])
  ]);

  wbRecord(BPTD, 'Body Part Data', [
    wbEDIDReq,
    wbMODLReq,
    wbRStructs('身体部分', '身体部分', [
      wbString(BPTN, '部分名称', 0, cpNormal, True),
      wbString(BPNN, '部分节点', 0, cpNormal, True),
      wbString(BPNT, '终结技目标', 0, cpNormal, True),
      wbString(BPNI, 'IK 数据 - 起始节点', 0, cpNormal, True),
      wbStruct(BPND, '', [
        {00} wbFloat('伤害加成'),
        {04} wbInteger('标志', itU8, wbFlags([
          '可断开',
          'IK 数据',
          'IK 数据 - 两足动物数据',
          '可爆炸',
          'IK 数据 - 是头部',
          'IK 数据 - 跟踪头部',
          '击中概率 - 绝对'
        ])),
        {05} wbInteger('部分类型', itU8, wbEnum([
               '躯干',
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
               '武器'
             ])),
        {06} wbInteger('生命百分比', itU8),
        {07} wbInteger('角色数值', itS8, wbActorValueEnum),
        {08} wbInteger('击中概率', itU8),
        {09} wbInteger('可爆炸 - 爆炸几率 %', itU8),
        {10} wbInteger('可爆炸 - 碎片数', itU16),
        {12} wbFormIDCk('可爆炸 - 碎片', [DEBR, NULL]),
        {16} wbFormIDCk('可爆炸 - 爆炸效果', [EXPL, NULL]),
        {20} wbFloat('跟踪最大角度'),
        {24} wbFloat('可爆炸 - 碎片大小'),
        {28} wbInteger('可断开 - 碎片数', itS32),
        {32} wbFormIDCk('可断开 - 碎片', [DEBR, NULL]),
        {36} wbFormIDCk('可断开 - 爆炸效果', [EXPL, NULL]),
        {40} wbFloat('可断开 - 碎片大小'),
        wbStruct('凝血效果位置', [
          wbStruct('平移', [
            {44} wbFloat('X'),
            {48} wbFloat('Y'),
            {52} wbFloat('Z')
          ]),
          wbStruct('角度', [
            {56} wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
            {60} wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
            {64} wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
          ])
        ]),
        {68} wbFormIDCk('可断开 - 冲击数据集', [IPDS, NULL]),
        {72} wbFormIDCk('可爆炸 - 冲击数据集', [IPDS, NULL]),
        {28} wbInteger('可断开 - 贴花数', itU8),
        {28} wbInteger('可爆炸 - 贴花数', itU8),
        {76} wbByteArray('未使用', 2),
        {80} wbFloat('肢体替换规模')
      ], cpNormal, True),
      wbString(NAM1, '肢体替换模型', 0, cpNormal, True),
      wbString(NAM4, '凝血效果 - 目标骨架', 0, cpNormal, True),
      wbByteArray(NAM5, '材质文件哈希值', 0, cpIgnore)
    ], [], cpNormal, True),
    wbFormIDCk(RAGA, 'Ragdoll', [RGDL])
  ]);

  wbRecord(ADDN, 'Addon Node', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODLReq,
    wbInteger(DATA, '节点索引', itS32, nil, cpNormal, True),
    wbFormIDCk(SNAM, '音效', [SOUN]),
    wbStruct(DNAM, '数据', [
      wbInteger('Master 体系系统限制', itU16),
      wbByteArray('未知', 2)
    ], cpNormal, True)
  ]);

  wbRecord(AVIF, 'ActorValue Information', [
    wbEDIDReq,
    wbFULL,
    wbDESCReq,
    wbICON,
    wbString(ANAM, '简称')
  ]);

  wbRecord(RADS, 'Radiation Stage', [
    wbEDIDReq,
    wbStruct(DATA, '', [
      wbInteger('Trigger Threshold', itU32),
      wbFormIDCk('魔法', [SPEL])
    ], cpNormal, True)
  ]);

  wbRecord(CAMS, 'Camera Shot', [
    wbEDIDReq,
    wbMODL,
    wbStruct(DATA, '数据', [
      {00} wbInteger('操作', itU32, wbEnum([
        '拍摄',
        '悬吊',
        '抓景',
        '变焦'
      ])),
      {04} wbInteger('位置', itU32, wbEnum([
        '攻击者',
        '抛射物',
        '目标'
      ])),
      {08} wbInteger('目标', itU32, wbEnum([
        '攻击者',
        '抛射物',
        '目标'
      ])),
      {12} wbInteger('标志', itU32, wbFlags([
        '方位跟踪位置',
        '角度跟踪目标',
        '不跟踪骨骼',
        '第一人称拍摄',
        '无示踪器',
        '零时开始'
      ])),
      wbStruct('时间加成', [
        {16} wbFloat('玩家'),
        {20} wbFloat('目标'),
        {24} wbFloat('全局')
      ]),
      {28} wbFloat('最长时间'),
      {32} wbFloat('最短时间'),
      {36} wbFloat('目标 % 与角色之间')
    ], cpNormal, True, nil, 7),
    wbFormIDCk(MNAM, '图像空间变换', [IMAD])
  ]);

  wbRecord(CPTH, 'Camera Path', [
    wbEDIDReq,
    wbCTDAs,
    wbArray(ANAM, '相关摄像机路径', wbFormIDCk('相关摄像机路径', [CPTH, NULL]), ['上一级', '上一个同级对象'], cpNormal, True),
    wbInteger(DATA, '摄像机焦距', itU8, wbEnum([
      '默认',
      '禁用',
      '拍摄列表'
    ]), cpNormal, True),
    wbRArray('摄像', wbFormIDCk(SNAM, '摄像', [CAMS]))
  ]);

  wbRecord(VTYP, 'Voice Type', [
    wbEDIDReq,
    wbInteger(DNAM, '标志', itU8, wbFlags([
      '允许默认对话',
      '女性'
    ]), cpNormal, False)
  ]);

  wbRecord(IPCT, 'Impact', [
    wbEDIDReq,
    wbMODL,
    wbStruct(DATA, '', [
      wbFloat('效果 - 持续时间'),
      wbInteger('效果 - 方向', itU32, wbEnum([
        '曲面法线',
        '抛射矢量',
        '抛射反射'
      ])),
      wbFloat('角度阈值'),
      wbFloat('放置半径'),
      wbInteger('音量级别', itU32, wbSoundLevelEnum),
      wbInteger('标志', itU32, wbFlags([
        '无贴花数据'
      ]))
    ], cpNormal, True),
    wbDODT,
    wbFormIDCk(DNAM, '材质集', [TXST]),
    wbFormIDCk(SNAM, '音效 1', [SOUN]),
    wbFormIDCk(NAM1, '音效 2', [SOUN])
  ]);

  wbRecord(IPDS, 'Impact DataSet', [
    wbEDIDReq,
    wbStruct(DATA, 'Impacts', [
      wbFormIDCk('Stone', [IPCT, NULL]),
      wbFormIDCk('Dirt', [IPCT, NULL]),
      wbFormIDCk('草地', [IPCT, NULL]),
      wbFormIDCk('Glass', [IPCT, NULL]),
      wbFormIDCk('Metal', [IPCT, NULL]),
      wbFormIDCk('Wood', [IPCT, NULL]),
      wbFormIDCk('Organic', [IPCT, NULL]),
      wbFormIDCk('Cloth', [IPCT, NULL]),
      wbFormIDCk('水源', [IPCT, NULL]),
      wbFormIDCk('Hollow Metal', [IPCT, NULL]),
      wbFormIDCk('Organic Bug', [IPCT, NULL]),
      wbFormIDCk('Organic Glow', [IPCT, NULL])
    ], cpNormal, True, nil, 9)
  ]);

  wbRecord(ECZN, 'Encounter Zone', [
    wbEDIDReq,
    wbStruct(DATA, '', [
      wbFormIDCkNoReach('所有者', [NPC_, FACT, NULL]),
      wbInteger('等级', itS8),
      wbInteger('Minimum Level', itS8),
      wbInteger('标志', itU8, wbFlags([
        '从不重置',
        '最小等级以下匹配玩家'
      ])),
      wbByteArray('未使用', 1)
    ], cpNormal, True)
  ]);

  wbRecord(MESG, 'Message', [
    wbEDIDReq,
    wbDESCReq,
    wbFULL,
    wbFormIDCk(INAM, '图标', [MICN, NULL], False, cpNormal, True),
    wbByteArray(NAM0, '未使用', 0, cpIgnore),
    wbByteArray(NAM1, '未使用', 0, cpIgnore),
    wbByteArray(NAM2, '未使用', 0, cpIgnore),
    wbByteArray(NAM3, '未使用', 0, cpIgnore),
    wbByteArray(NAM4, '未使用', 0, cpIgnore),
    wbByteArray(NAM5, '未使用', 0, cpIgnore),
    wbByteArray(NAM6, '未使用', 0, cpIgnore),
    wbByteArray(NAM7, '未使用', 0, cpIgnore),
    wbByteArray(NAM8, '未使用', 0, cpIgnore),
    wbByteArray(NAM9, '未使用', 0, cpIgnore),
    wbInteger(DNAM, '标志', itU32, wbFlags([
      '信息框',
      '自动显示'
    ]), cpNormal, True, False, nil, wbMESGDNAMAfterSet),
    wbInteger(TNAM, '显示时长', itU32, nil, cpNormal, False, False, wbMESGTNAMDontShow),
    wbRStructs('菜单按钮', '菜单按钮', [
      wbString(ITXT, '按钮文本'),
      wbCTDAs
    ], [])
  ], False, nil, cpNormal, False, wbMESGAfterLoad);

  wbRecord(RGDL, 'Ragdoll', [
    wbEDIDReq,
    wbInteger(NVER, '版本', itU32, nil, cpNormal, True),
    wbStruct(DATA, 'General Data', [
      wbInteger('Dynamic Bone Count', itU32),
      wbByteArray('未使用', 4),
      wbStruct('开启', [
        wbInteger('Feedback', itU8, wbEnum(['否', '是'])),
        wbInteger('Foot IK (broken, don''t use)', itU8, wbEnum(['否', '是'])),
        wbInteger('Look IK (broken, don''t use)', itU8, wbEnum(['否', '是'])),
        wbInteger('Grab IK (broken, don''t use)', itU8, wbEnum(['否', '是'])),
        wbInteger('姿势匹配', itU8, wbEnum(['否', '是']))
      ]),
      wbByteArray('未使用', 1)
    ], cpNormal, True),
    wbFormIDCk(XNAM, '角色基础', [CREA, NPC_], False, cpNormal, True),
    wbFormIDCk(TNAM, '身体部分数据', [BPTD], False, cpNormal, True),
    wbStruct(RAFD, 'Feedback Data', [
    {00} wbFloat('Dynamic/Keyframe Blend Amount'),
    {04} wbFloat('Hierarchy Gain'),
    {08} wbFloat('Position Gain'),
    {12} wbFloat('Velocity Gain'),
    {16} wbFloat('Acceleration Gain'),
    {20} wbFloat('Snap Gain'),
    {24} wbFloat('Velocity Damping'),
         wbStruct('Snap Max Settings', [
           {28} wbFloat('线速度'),
           {32} wbFloat('角速度'),
           {36} wbFloat('Linear Distance'),
           {40} wbFloat('Angular Distance')
         ]),
         wbStruct('Position Max Velocity', [
           {44} wbFloat('Linear'),
           {48} wbFloat('Angular')
         ]),
         wbStruct('Position Max Velocity', [
           {52} wbInteger('抛射物', itS32, wbDiv(1000)),
           {56} wbInteger('近战', itS32, wbDiv(1000))
         ])
    ], cpNormal, False),
    wbArray(RAFB, 'Feedback Dynamic Bones', wbInteger('Bone', itU16), 0, nil, nil, cpNormal, False),
    wbStruct(RAPS, 'Pose Matching Data', [
    {00} wbArray('Match Bones', wbInteger('Bone', itU16, wbHideFFFF), 3),
    {06} wbInteger('标志', itU8, wbFlags([
           'Disable On Move'
         ])),
    {07} wbByteArray('未使用', 1),
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
      'Stimpack',
      'SuperStimpack',
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
      'Drug Wears Off Image Space',
      'Doctor''s Bag',
      'Miss Fortune NPC',
      'Miss Fortune Faction',
      'Meltdown Explosion',
      'Unarmed Forward PA',
      'Unarmed Backward PA',
      'Unarmed Left PA',
      'Unarmed Right PA',
      'Unarmed Crouch PA',
      'Unarmed Counter PA',
      'Spotter Effect',
      'Item Detected Efect',
      'Cateye Mobile Effect (NYI)'
    ], cpNormal, True)
  ]);

  wbRecord(LGTM, 'Lighting Template', [
    wbEDIDReq,
    wbStruct(DATA, '光照', [
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
      wbFloat('指向淡出'),
      wbFloat('雾裁剪距离'),
      wbFloat('雾浓度')
    ], cpNormal, True)
  ]);

  wbRecord(MUSC, 'Music Type', [
    wbEDIDReq,
    wbString(FNAM, '文件'),
    wbFloat(ANAM, 'dB (positive = Loop)')
  ]);

  wbRecord(GRAS, 'Grass', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODLReq,
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
    wbEDIDReq,
    wbFULLReq,
    wbMODLReq,
    wbString(ICON, '材质', 0, cpNormal, True),
    wbInteger(DATA, '标志', itU8, wbFlags([
      '玩家可用',
      '非男性',
      '非女性',
      '固定'
    ]), cpNormal, True)
  ]);

  wbRecord(IDLE, 'Idle Animation', [
    wbEDID,
    wbMODLReq,
    wbCTDAs,
    wbArray(ANAM, '相关待机动作', wbFormIDCk('相关待机动作', [IDLE, NULL]), ['上一级', '上一个同级对象'], cpNormal, True),
    wbStruct(DATA, '', [
      wbInteger('动作群组分组', itU8, wbIdleAnam),
      wbStruct('循环', [
        wbInteger('最小值', itU8),
        wbInteger('最大值', itU8)
      ]),
      wbByteArray('未使用', 1),
      wbInteger('重播延迟', itS16),
      wbInteger('标志', itU8, wbFlags([
        '无攻击'
      ])),
      wbByteArray('未使用', 1)
    ], cpNormal, True, nil, 4)
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
        {6} '杂项',
        {7} 'Radio'
      ])),
      wbInteger('Next Speaker', itU8, wbEnum([
        {0} '目标',
        {1} '自身',
        {2} 'Either'
      ])),
      wbInteger('标志 1', itU8, wbFlags([
        {0x01} '再见',
        {0x02} '随机',
        {0x04} '说一次',
        {0x08} '立即执行',
        {0x10} '信息驳回',
        {0x20} '随机结束',
        {0x40} '传播流言',
        {0x80} '言语挑战'
      ])),
      wbInteger('标志 2', itU8, wbFlags([
        {0x01} '一天说一次',
        {0x02} '始终模糊',
        {0x04} '未知 2',
        {0x08} '未知 3',
        {0x10} '低级情报',
        {0x20} '高级情报'
      ]))
    ], cpNormal, True, nil, 3),
    wbFormIDCkNoReach(QSTI, '任务', [QUST], False, cpNormal, True),
    wbFormIDCk(TPIC, '话题', [DIAL]),
    wbFormIDCkNoReach(PNAM, '前一个情报', [INFO, NULL]),
    wbRArray('Add Topics', wbFormIDCk(NAME, '话题', [DIAL])),
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
            {6} '惊讶',
            {7} 'Pained'
          ])),
          wbInteger('表情数值', itS32),
          wbByteArray('未使用', 4),
          wbInteger('回复数', itU8),
          wbByteArray('未使用', 3),
          wbFormIDCk('音效', [SOUN, NULL]),
          wbInteger('标志', itU8, wbFlags([
            '使用表情动作'
          ])),
          wbByteArray('未使用', 3)
        ], cpNormal, False, nil, 5),
        wbString(NAM1, '回复文本', 0, cpTranslate, True),
        wbString(NAM2, '脚本注释', 0, cpTranslate, True),
        wbString(NAM3, '编辑'),
        wbFormIDCk(SNAM, 'Speaker Animation', [IDLE]),
        wbFormIDCk(LNAM, 'Listener Animation', [IDLE])
      ], [])
    ),
    wbCTDAs,
    wbRArray('Choices', wbFormIDCk(TCLT, 'Choice', [DIAL])),
    wbRArray('Link From', wbFormIDCk(TCLF, '话题', [DIAL])),
    wbRArray('未知', wbFormIDCk(TCFU, 'Info', [INFO] )),
    wbRStruct('Script (Begin)', [
      wbEmbeddedScriptReq
    ], [], cpNormal, True),
    wbRStruct('Script (End)', [
      wbEmpty(NEXT, '标记'),
      wbEmbeddedScriptReq
    ], [], cpNormal, True),
    wbFormIDCk(SNDD, '未使用', [SOUN]),
    wbString(RNAM, '提示'),
    wbFormIDCk(ANAM, '说话者', [CREA, NPC_]),
    wbFormIDCk(KNAM, 'ActorValue/Perk', [AVIF, PERK]),
    wbInteger(DNAM, '言语挑战', itU32, wbEnum([
      '---',
      '非常简单',
      '简单',
      '普通',
      '困难',
      '非常困难'
    ]))
  ], False, wbINFOAddInfo, cpNormal, False, wbINFOAfterLoad);

  wbRecord(INGR, 'Ingredient', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbETYPReq,
    wbFloat(DATA, '重量', cpNormal, True),
    wbStruct(ENIT, '效果数据', [
      wbInteger('价值', itS32),
      wbInteger('标志', itU8, wbFlags(['不自动计算', '食物'])),
      wbByteArray('未使用', 3)
    ], cpNormal, True),
    wbEffectsReq
  ]);

  wbRecord(KEYM, 'Key', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULLReq,
    wbMODL,
    wbICONReq,
    wbSCRI,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbStruct(DATA, '', [
      wbInteger('价值', itS32),
      wbFloat('重量')
    ], cpNormal, True),
    wbFormIDCk(RNAM, 'Sound - Random/Looping', [SOUN])
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
    wbEDIDReq,
    wbOBNDReq,
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
    ], cpNormal, True),
    wbFloat(FNAM, '淡化数值', cpNormal, True),
    wbFormIDCk(SNAM, '音效', [SOUN])
  ], False, nil, cpNormal, False, wbLIGHAfterLoad);

  wbRecord(LSCR, 'Load Screen', [
    wbEDIDReq,
    wbICONReq,
    wbDESCReq,
    wbRArrayS('Locations', wbStructSK(LNAM, [0, 1], '位置', [
      wbFormIDCk('Direct', [CELL, WRLD, NULL]),
      wbStructSK([0, 1], 'Indirect', [
        wbFormIDCk('World', [NULL, WRLD]),
        wbStructSK([0,1], '网格', [
          wbInteger('Y', itS16),
          wbInteger('X', itS16)
        ])
      ])
    ])),
    wbFormIDCk(WMI1, 'Load Screen Type', [LSCT])
  ]);

  wbRecord(LTEX, 'Landscape Texture', [
    wbEDIDReq,
    wbICON,
    wbFormIDCk(TNAM, '材质', [TXST], False, cpNormal, True),
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
      wbInteger('摩擦', itU8),
      wbInteger('弹力', itU8)
    ], cpNormal, True),
    wbInteger(SNAM, '纹理高光指数', itU8, nil, cpNormal, True),
    wbRArrayS('草地', wbFormIDCk(GNAM, '草地', [GRAS]))
  ]);

  wbRecord(LVLC, 'Leveled Creature', [
    wbEDIDReq,
    wbOBNDReq,
    wbInteger(LVLD, 'Chance none', itU8, nil, cpNormal, True),
    wbInteger(LVLF, '标志', itU8, wbFlags([
      {0x01} '计算自所有低于玩家等级的',
      {0x02} '计算每一个物品的数量'
    ]), cpNormal, True),
    wbRArrayS('等级列表记录',
      wbRStructExSK([0], [1], '等级列表记录', [
        wbStructExSK(LVLO , [0, 2], [3], '基础数据', [
          wbInteger('等级', itS16),
          wbByteArray('未使用', 2),
          wbFormIDCk('衍生', [CREA, LVLC]),
          wbInteger('数量', itS16),
          wbByteArray('未使用', 2)
        ]),
        wbCOED
      ], []),
    cpNormal, True),
    wbMODL
  ]);

  wbRecord(LVLN, 'Leveled NPC', [
    wbEDIDReq,
    wbOBNDReq,
    wbInteger(LVLD, 'Chance none', itU8, nil, cpNormal, True),
    wbInteger(LVLF, '标志', itU8, wbFlags([
      {0x01} '计算自所有低于玩家等级的',
      {0x02} '计算每一个物品的数量'
    ]), cpNormal, True),
    wbRArrayS('等级列表记录',
      wbRStructExSK([0], [1], '等级列表记录', [
        wbStructExSK(LVLO , [0, 2], [3], '基础数据', [
          wbInteger('等级', itS16),
          wbByteArray('未使用', 2),
          wbFormIDCk('衍生', [NPC_, LVLN]),
          wbInteger('数量', itS16),
          wbByteArray('未使用', 2)
        ]),
        wbCOED
      ], []),
    cpNormal, True),
    wbMODL
  ]);

   wbRecord(LVLI, 'Leveled Item', [
    wbEDIDReq,
    wbOBNDReq,
    wbInteger(LVLD, 'Chance none', itU8, nil, cpNormal, True),
    wbInteger(LVLF, '标志', itU8, wbFlags([
      {0x01} '计算自所有低于玩家等级的',
      {0x02} '计算每一个物品的数量',
      {0x04} '全部使用'
    ]), cpNormal, True),
    wbFormIDCk(LVLG, '全局', [GLOB]),
    wbRArrayS('等级列表记录',
      wbRStructExSK([0], [1], '等级列表记录', [
        wbStructExSK(LVLO , [0, 2], [3], '基础数据', [
          wbInteger('等级', itS16),
          wbByteArray('未使用', 2),
          wbFormIDCk('衍生', [ARMO, AMMO, MISC, WEAP, BOOK, LVLI, KEYM, ALCH, NOTE, IMOD, CMNY, CCRD, CHIP]),
          wbInteger('数量', itS16),
          wbByteArray('未使用', 2)
        ]),
        wbCOED
      ], [])
    )
  ]);

  wbRecord(MGEF, 'Base Effect', [
    wbEDIDReq,
    wbFULL,
    wbDESCReq,
    wbICON,
    wbMODL,
    wbStruct(DATA, '数据', [
      wbInteger('标志', itU32, wbFlags([
        {0x00000001} '敌对的',
        {0x00000002} '恢复',
        {0x00000004} '有害的',
        {0x00000008} '',
        {0x00000010} '自身',
        {0x00000020} '接触',
        {0x00000040} '目标',
        {0x00000080} '不持续',
        {0x00000100} '无量级',
        {0x00000200} '无范围',
        {0x00000400} '持续视觉特效',
        {0x00000800} '',
        {0x00001000} '血块外观',
        {0x00002000} '仅显示名称',
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
        {0x01000000} '不痛的',
        {0x02000000} 'Spray projectile type (or Fog if Bolt is specified as well)',
        {0x04000000} 'Bolt projectile type (or Fog if Spray is specified as well)',
        {0x08000000} '无命中效果',
        {0x10000000} '无死亡消除',
        {0x20000000} '????'
      ])),
      {04} wbFloat('Base cost (Unused)'),
      {08} wbUnion('关联道具', wbMGEFFAssocItemDecider, [
             wbFormID('未使用', cpIgnore),
             wbFormID('关联道具'),
             wbFormIDCk('Assoc. Script', [SCPT, NULL]), //Script
             wbFormIDCk('关联道具', [WEAP, ARMO, NULL]), //Bound Item
             wbFormIDCk('Assoc. Creature', [CREA]) //Summon Creature
           ], cpNormal, false, nil, wbMGEFFAssocItemAfterSet),
      {12} wbInteger('Magic School (Unused)', itS32, wbEnum([
      ], [
        -1, '无'
      ])),
      {16} wbInteger('Resistance Type', itS32, wbActorValueEnum),
      {20} wbInteger('未知', itU16),
      {22} wbByteArray('未使用', 2),
      {24} wbFormIDCk('光效', [LIGH, NULL]),
      {28} wbFloat('Projectile speed'),
      {32} wbFormIDCk('效果渲染', [EFSH, NULL]),
      {36} wbFormIDCk('Object Display Shader', [EFSH, NULL]),
      {40} wbFormIDCk('Effect sound', [NULL, SOUN]),
      {44} wbFormIDCk('Bolt sound', [NULL, SOUN]),
      {48} wbFormIDCk('Hit sound', [NULL, SOUN]),
      {52} wbFormIDCk('Area sound', [NULL, SOUN]),
      {56} wbFloat('Constant Effect enchantment factor  (Unused)'),
      {60} wbFloat('Constant Effect barter factor (Unused)'),
      {64} wbInteger('原型', itU32, wbEnum([
             {00} '数值调整',
             {01} '脚本',
             {02} '驱散',
             {03} '治愈疾病',
             {04} '',
             {05} '',
             {06} '',
             {07} '',
             {08} '',
             {09} '',
             {10} '',
             {11} '隐形',
             {12} 'Chameleon',
             {13} '光效',
             {14} '',
             {15} '',
             {16} '上锁',
             {17} '打开',
             {18} 'Bound Item',
             {19} '召唤生物',
             {20} '',
             {21} '',
             {22} '',
             {23} '',
             {24} '麻痹',
             {25} '',
             {26} '',
             {27} '',
             {28} '',
             {29} '',
             {30} '治愈麻痹',
             {31} '治愈上瘾',
             {32} '治愈中毒',
             {33} '震荡',
             {34} 'Value And Parts',
             {35} 'Limb Condition',
             {36} 'Turbo'
           ]), cpNormal, False, nil, wbMGEFArchtypeAfterSet),
      {68} wbActorValue
    ], cpNormal, True)
  ], False, nil, cpNormal, False, wbMGEFAfterLoad);

  wbRecord(MISC, 'Misc. Item', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbStruct(DATA, '', [
      wbInteger('价值', itS32),
      wbFloat('重量')
    ], cpNormal, True),
    wbFormIDCk(RNAM, 'Sound - Random/Looping', [SOUN])
  ]);

  wbRecord(COBJ, 'Constructible Object', [
    wbEDID,
    wbOBND,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbYNAM,
    wbZNAM,
    wbStruct(DATA, '', [
      wbInteger('价值', itS32),
      wbFloat('重量')
    ], cpNormal, True)
  ]);

  wbFaceGen := wbRStruct('脸部生成数据', [
    wbByteArray(FGGS, '脸部生成几何-对称', 0, cpNormal, True),
    wbByteArray(FGGA, '脸部生成几何-不对称', 0, cpNormal, True),
    wbByteArray(FGTS, '脸部生成材质-对称', 0, cpNormal, True)
  ], [], cpNormal, True);

  wbFaceGenNPC := wbRStruct('脸部生成数据', [
    wbByteArray(FGGS, '脸部生成几何-对称', 0, cpNormal, True),
    wbByteArray(FGGA, '脸部生成几何-不对称', 0, cpNormal, True),
    wbByteArray(FGTS, '脸部生成材质-对称', 0, cpNormal, True)
  ], [], cpNormal, True, wbActorTemplateUseModelAnimation);


  wbRecord(NPC_, 'Non-Player Character', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULLActor,
    wbMODLActor,
    wbStruct(ACBS, '构造', [
      {00} wbInteger('标志', itU32, wbFlags([
             {0x000001} '女性',
             {0x000002} '不死',
             {0x000004} '默认脸型',
             {0x000008} '重生',
             {0x000010} '自动计算属性',
             {0x000020} '',
             {0x000040} '',
             {0x000080} '玩家等级加成',
             {0x000100} '使用模版',
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
           {0x03000000} '无法击倒',
           {0x08000000} '不可推动',
           {0x10000000} '', {28}
           {0x20000000} '',
           {0x40000000} 'No Rotating To Head-track',
           {0x80000000} ''
           ], [
             {0x000001 Female} wbActorTemplateUseTraits,
             {0x000002 Essential} wbActorTemplateUseBaseData,
             {0x000004 默认脸型} nil,
             {0x000008 Respawn} wbActorTemplateUseBaseData,
             {0x000010 Auto-calc stats} wbActorTemplateUseStats,
             {0x000020 } nil,
             {0x000040 } nil,
             {0x000080 PC Level Mult} wbActorTemplateUseStats,
             {0x000100 使用模版} nil,
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
      {04} wbInteger('体力', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
      {06} wbInteger('Barter gold', itU16, nil, cpNormal, False, wbActorTemplateUseAIData),
      {08} wbUnion('等级', wbCreaLevelDecider, [
             wbInteger('等级', itS16, nil, cpNormal, True, wbActorTemplateUseStats),
             wbInteger('等级加成', itS16, wbDiv(1000), cpNormal, True, wbActorTemplateUseStats)
           ], cpNormal, True, wbActorTemplateUseStats),
      {10} wbInteger('Calc min', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
      {12} wbInteger('Calc max', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
      {14} wbInteger('速度加成', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
      {16} wbFloat('Karma (Alignment)', cpNormal, False, 1, -1, wbActorTemplateUseTraits),
      {20} wbInteger('基本性格', itS16, nil, cpNormal, False, wbActorTemplateUseTraits),
      {22} wbInteger('模版标志', itU16, wbFlags([
        '使用特征',
        '使用属性',
        '使用派系',
        'Use Actor Effect List',
        '使用AI数据',
        '使用AI包',
        'Use Model/Animation',
        '使用基本数据',
        '使用物品栏',
        '使用脚本'
      ]))
    ], cpNormal, True),
    wbRArrayS('派系',
      wbStructSK(SNAM, [0], '派系', [
        wbFormIDCk('派系', [FACT]),
        wbInteger('等级', itU8),
        wbByteArray('未使用', 3)
      ]),
    cpNormal, False, nil, nil, wbActorTemplateUseFactions),
    wbFormIDCk(INAM, '死亡物品', [LVLI], False, cpNormal, False, wbActorTemplateUseTraits),
    wbFormIDCk(VTCK, '语音', [VTYP], False, cpNormal, True, wbActorTemplateUseTraits),
    wbFormIDCk(TPLT, '模版', [LVLN, NPC_]),
    wbFormIDCk(RNAM, '种族', [RACE], False, cpNormal, True, wbActorTemplateUseTraits),
    wbSPLOs,
    wbFormIDCk(EITM, 'Unarmed Attack Effect', [ENCH, SPEL], False, cpNormal, False, wbActorTemplateUseActorEffectList),
    wbInteger(EAMT, 'Unarmed Attack Animation', itU16, wbAttackAnimationEnum, cpNormal, True, False, wbActorTemplateUseActorEffectList),
    wbDESTActor,
    wbSCRIActor,
    wbRArrayS('物品', wbCNTO, cpNormal, False, nil, nil, wbActorTemplateUseInventory),
    wbAIDT,
    wbRArray('AI包', wbFormIDCk(PKID, 'AI包', [PACK]), cpNormal, False, wbActorTemplateUseAIPackages),
    wbFormIDCk(CNAM, '职业', [CLAS], False, cpNormal, True, wbActorTemplateUseTraits),
    wbStruct(DATA, '', [
      {00} wbInteger('Base Health', itS32),
      {04} wbArray('Attributes', wbInteger('Attribute', itU8), [
            '力量',
            'Perception',
            '耐力',
            'Charisma',
            '智力',
            '敏捷',
            '运气'
          ], cpNormal, False, wbActorAutoCalcDontShow),
          wbByteArray('未使用'{, 14 - only present in old record versions})
    ], cpNormal, True, wbActorTemplateUseStats),
    wbStruct(DNAM, '', [
      {00} wbArray('技能值', wbInteger('技能', itU8), [
             'Barter',
             'Big Guns (obsolete)',
             'Energy Weapons',
             'Explosives',
             'Lockpick',
             '药物',
             'Melee Weapons',
             'Repair',
             'Science',
             'Guns',
             '潜行',
             '口才',
             'Survival',
             'Unarmed'
           ]),
      {14} wbArray('技能补偿', wbInteger('技能', itU8), [
             'Barter',
             'Big Guns (obsolete)',
             'Energy Weapons',
             'Explosives',
             'Lockpick',
             '药物',
             'Melee Weapons',
             'Repair',
             'Science',
             'Guns',
             '潜行',
             '口才',
             'Survival',
             'Unarmed'
           ])
    ], cpNormal, False, wbActorTemplateUseStatsAutoCalc),
    wbRArrayS('头部部分',
      wbFormIDCk(PNAM, '头部部分', [HDPT]),
    cpNormal, False, nil, nil, wbActorTemplateUseModelAnimation),
    wbFormIDCk(HNAM, '发型', [HAIR], False, cpNormal, False, wbActorTemplateUseModelAnimation),
    wbFloat(LNAM, 'Hair length', cpNormal, False, 1, -1, wbActorTemplateUseModelAnimation),
    wbFormIDCk(ENAM, '眼睛', [EYES], False, cpNormal, False, wbActorTemplateUseModelAnimation),
    wbStruct(HCLR, 'Hair color', [
      wbInteger('红', itU8),
      wbInteger('绿', itU8),
      wbInteger('蓝', itU8),
      wbByteArray('未使用', 1)
    ], cpNormal, True, wbActorTemplateUseModelAnimation),
    wbFormIDCk(ZNAM, '战斗风格', [CSTY], False, cpNormal, False, wbActorTemplateUseTraits),
    wbInteger(NAM4, 'Impact Material Type', itU32, wbImpactMaterialTypeEnum, cpNormal, True, False, wbActorTemplateUseModelAnimation),
    wbFaceGenNPC,
    wbInteger(NAM5, '未知', itU16, nil, cpNormal, True, False, nil, nil, 255),
    wbFloat(NAM6, '身高', cpNormal, True, 1, -1, wbActorTemplateUseTraits),
    wbFloat(NAM7, '重量', cpNormal, True, 1, -1, wbActorTemplateUseTraits)
  ], True, nil, cpNormal, False, wbNPCAfterLoad);

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
          {0x00800000} '拔出武器',
          {0x01000000} 'No idle anims',
          {0x02000000} 'Pretend In Combat',
          {0x04000000} 'Continue During Combat',
          {0x08000000} '无战斗警备',
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
          {13} '巡逻',
          {14} 'Guard',
          {15} '对话',
          {16} 'Use Weapon'
        ]);

  wbObjectTypeEnum := wbEnum([
          ' 无',
          '激活器',
          '盔甲',
          '书籍',
          '服装',
          '容器',
          '门',
          '材料',
          '光源',
          '杂项',
          '植被',
          '家具',
          '武器: 任意',
          '弹药',
          'NPCs',
          '生物',
          '钥匙',
          '炼金',
          '食物',
          ' 全部: 战斗可穿用',
          ' 全部: 可穿用',
          '武器: 远程',
          '武器: 近战',
          '武器: 无',
          '角色效果: 任意',
          '角色效果: 环绕目标',
          '角色效果: 环绕接触',
          '角色效果: 环绕自身',
//          '',
          '角色: 任意'
        ]);


  wbPKDTSpecificFlagsUnused := True;

  wbRecord(PACK, 'Package', [
    wbEDIDReq,
    wbStruct(PKDT, '常规', [
      wbInteger('一般标志', itU32, wbPKDTFlags),
      wbInteger('类型', itU8, wbPKDTType),
      wbByteArray('未使用', 1),
      wbInteger('Fallout Behavior Flags', itU16, wbFlags([
        {0x00000001}'Hellos To Player',
        {0x00000002}'Random Conversations',
        {0x00000004}'Observe Combat Behavior',
        {0x00000008}'未知 4',
        {0x00000010}'Reaction To Player Actions',
        {0x00000020}'Friendly Fire Comments',
        {0x00000040}'感应半径',
        {0x00000080}'允许空闲唠叨',
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
      wbByteArray('未使用', 2)
    ], cpNormal, True, nil, 2),
    wbRStruct('Locations', [
      wbStruct(PLDT, 'Location 1', [
        wbInteger('类型', itS32, wbEnum([
          {0} '接近衍生',
          {1} '在场景内',
          {2} '接近当前位置',
          {3} '接近编辑器位置',
          {4} '对象编号',
          {5} '对象类型',
          {6} '接近连接的衍生',
          {7} '在AI包位置'
        ])),
        wbUnion('位置', wbPxDTLocationDecider, [
          wbFormIDCkNoReach('衍生', [REFR, PGRE, PMIS, ACHR, ACRE, PLYR], True),
          wbFormIDCkNoReach('场景', [CELL]),
          wbByteArray('未使用', 4, cpIgnore),
          wbByteArray('未使用', 4, cpIgnore),
          wbFormIDCkNoReach('对象编号', [ACTI, DOOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, CHIP, IMOD]),
          wbInteger('对象类型', itU32, wbObjectTypeEnum),
          wbByteArray('未使用', 4, cpIgnore),
          wbByteArray('未使用', 4, cpIgnore)
        ]),
        wbInteger('半径', itS32)
      ]),
      wbStruct(PLD2, 'Location 2', [
        wbInteger('类型', itS32, wbEnum([
          {0} '接近衍生',
          {1} '在场景内',
          {2} '接近当前位置',
          {3} '接近编辑器位置',
          {4} '对象编号',
          {5} '对象类型',
          {6} '接近连接的衍生',
          {7} '在AI包位置'
        ])),
        wbUnion('位置', wbPxDTLocationDecider, [
          wbFormIDCkNoReach('衍生', [REFR, PGRE, PMIS, ACHR, ACRE, PLYR], True),
          wbFormIDCkNoReach('场景', [CELL]),
          wbByteArray('未使用', 4, cpIgnore),
          wbByteArray('未使用', 4, cpIgnore),
          wbFormIDCkNoReach('对象编号', [ACTI, DOOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, CHIP, IMOD]),
          wbInteger('对象类型', itU32, wbObjectTypeEnum),
          wbByteArray('未使用', 4, cpIgnore),
          wbByteArray('未使用', 4, cpIgnore)
        ]),
        wbInteger('半径', itS32)
      ])
    ], [], cpNormal, False, nil, True),
    wbStruct(PSDT, '时间表', [
      wbInteger('月份', itS8),
      wbInteger('星期', itS8, wbEnum([
        '星期天',
        '星期一',
        '星期二',
        '星期三',
        '星期四',
        '星期五',
        '星期六',
        '工作日',
        '周末',
        '星期一, 星期三, 星期五',
        '星期二, 星期四'
      ], [
        -1, '任意'
      ])),
      wbInteger('日', itU8),
      wbInteger('时间', itS8),
      wbInteger('持续时间', itS32)
    ], cpNormal, True),
    wbStruct(PTDT, 'Target 1', [
      wbInteger('类型', itS32, wbEnum([
        {0} '特定衍生',
        {1} '对象编号',
        {2} '对象类型',
        {3} '连接的衍生'
      ]), cpNormal, False, nil, nil, 2),
      wbUnion('目标', wbPxDTLocationDecider, [
        wbFormIDCkNoReach('衍生', [ACHR, ACRE, REFR, PGRE, PMIS, PLYR], True),
        wbFormIDCkNoReach('对象编号', [ACTI, DOOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, FACT, FLST, IDLM, CHIP, IMOD]),
        wbInteger('对象类型', itU32, wbObjectTypeEnum),
        wbByteArray('未使用', 4, cpIgnore)
      ]),
      wbInteger('数量 / 距离', itS32),
      wbFloat('未知')
    ], cpNormal, False, nil, 3),
    wbCTDAs,
    wbRStruct('待机动作', [
      wbInteger(IDLF, '标志', itU8, wbFlags([
        '按顺序运行',
        '',
        '运行一次'
      ]), cpNormal, True),
      wbStruct(IDLC, '', [
        wbInteger( '动作数量', itU8),
        wbByteArray('未使用', 3)
      ], cpNormal, True, nil, 1),
      wbFloat(IDLT, '动作计时器设定', cpNormal, True),
      wbArray(IDLA, '动作', wbFormIDCk('动作', [IDLE]), 0, nil, nil, cpNormal, True),
      wbByteArray(IDLB, '未使用', 4, cpIgnore)
    ], []),
    wbEmpty(PKED, 'Eat Marker'),
    wbInteger(PKE2, 'Escort Distance', itU32),
    wbFormIDCk(CNAM, '战斗风格', [CSTY]),
    wbFloat(PKFD, 'Follow - Start Location - Trigger Radius'),
    wbStruct(PKPT, 'Patrol Flags', [
      wbInteger('Repeatable', itU8, wbEnum(['否', '是']), cpNormal, False, nil, nil, 1),
      wbByteArray('未使用', 1)
    ], cpNormal, False, nil, 1),
    wbStruct(PKW3, 'Use Weapon Data', [
      wbInteger('标志', itU32, wbFlags([
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
        wbInteger('最小值', itU16),
        wbInteger('最大值', itU16)
      ]),
      wbStruct('Pause Between Volleys', [
        wbFloat('最小值'),
        wbFloat('最大值')
      ]),
      wbByteArray('未使用', 4)
    ]),
    wbStruct(PTD2, 'Target 2', [
      wbInteger('类型', itS32, wbEnum([
        {0} 'Specific reference',
        {1} '对象编号',
        {2} '对象类型',
        {3} '连接的衍生'
      ])),
      wbUnion('目标', wbPxDTLocationDecider, [
        wbFormIDCkNoReach('衍生', [ACHR, ACRE, REFR, PGRE, PMIS, PLYR], True),
        wbFormIDCkNoReach('对象编号', [ACTI, DOOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, FACT, FLST, CHIP, IMOD]),
        wbInteger('对象类型', itU32, wbObjectTypeEnum),
        wbByteArray('未使用', 4, cpIgnore)
      ]),
      wbInteger('数量 / 距离', itS32),
      wbFloat('未知')
    ], cpNormal, False, nil, 3),
    wbEmpty(PUID, 'Use Item Marker'),
    wbEmpty(PKAM, 'Ambush Marker'),
    wbStruct(PKDD, 'Dialogue Data', [
      wbFloat('视场'),
      wbFormIDCk('话题', [DIAL, NULL]),
      wbInteger('标志', itU32, wbFlags([
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
      wbByteArray('未使用', 4),
      wbInteger('Dialogue Type', itU32, wbEnum([
        '交谈',
        'Say To'
      ])),
      wbByteArray('未知', 4)
    ], cpNormal, False, nil, 3),
    wbStruct(PLD2, 'Location 2 (again??)', [
      wbInteger('类型', itS32, wbEnum([
        {0} '接近衍生',
        {1} '在场景内',
        {2} '接近当前位置',
        {3} '接近编辑器位置',
        {4} '对象编号',
        {5} '对象类型',
        {6} '接近连接的衍生',
        {7} '在AI包位置'
      ])),
      wbUnion('位置', wbPxDTLocationDecider, [
        wbFormIDCkNoReach('衍生', [REFR, PGRE, PMIS, ACHR, ACRE, PLYR], True),
        wbFormIDCkNoReach('场景', [CELL]),
        wbByteArray('未使用', 4, cpIgnore),
        wbByteArray('未使用', 4, cpIgnore),
        wbFormIDCkNoReach('对象编号', [ACTI, DOOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, CHIP, IMOD]),
        wbInteger('对象类型', itU32, wbObjectTypeEnum),
        wbByteArray('未使用', 4, cpIgnore),
        wbByteArray('未使用', 4, cpIgnore)
      ]),
      wbInteger('半径', itS32)
    ]),
    wbRStruct('开始', [
      wbEmpty(POBA, '开始标记', cpNormal, True),
      wbFormIDCk(INAM, '空闲动作', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, '话题', [DIAL, NULL], False, cpNormal, True)
    ], [], cpNormal, True),
    wbRStruct('结束', [
      wbEmpty(POEA, '结束标记', cpNormal, True),
      wbFormIDCk(INAM, '空闲动作', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, '话题', [DIAL, NULL], False, cpNormal, True)
    ], [], cpNormal, True),
    wbRStruct('改变', [
      wbEmpty(POCA, '改变标记', cpNormal, True),
      wbFormIDCk(INAM, '空闲动作', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, '话题', [DIAL, NULL], False, cpNormal, True)
    ], [], cpNormal, True)
  ], False, nil, cpNormal, False, wbPACKAfterLoad);

  wbRecord(QUST, 'Quest', [
    wbEDIDReq,
    wbSCRI,
    wbFULL,
    wbICON,
    wbStruct(DATA, '常规', [
      wbInteger('标志', itU8, wbFlags([
        {0x01} 'Start game enabled',
        {0x02} '',
        {0x04} 'Allow repeated conversation topics',
        {0x08} '允许重复的阶段',
        {0x10} '未知 4'
      ])),
      wbInteger('优先级', itU8),
      wbByteArray('未使用', 2),
      wbFloat('Quest Delay')
    ], cpNormal, True, nil, 3),
    wbCTDAs,
    wbRArrayS('阶段', wbRStructSK([0], '阶段', [
      wbInteger(INDX, '阶段索引', itS16),
      wbRArray('日志记录', wbRStruct('日志记录', [
        wbInteger(QSDT, '阶段标志', itU8, wbFlags([
          {0x01} '完成任务',
          {0x02} '任务失败'
        ])),
        wbCTDAs,
        wbString(CNAM, '日志记录', 0, cpTranslate),
        wbEmbeddedScriptReq,
        wbFormIDCk(NAM0, '下一个任务', [QUST])
      ], []))
    ], [])),
    wbRArray('目标', wbRStruct('目标', [
      wbInteger(QOBJ, '目标索引', itS32),
      wbString(NNAM, '描述', 0, cpNormal, True),
      wbRArray('目标', wbRStruct('目标', [
        wbStruct(QSTA, '目标', [
          wbFormIDCkNoReach('目标', [REFR, PGRE, PMIS, ACRE, ACHR], True),
          wbInteger('标志', itU8, wbFlags([
            {0x01} '指南标记忽略锁定'
          ])),
          wbByteArray('未使用', 3)
        ]),
        wbCTDAs
      ], []))
    ], []))
  ]);

  wbHeadPartIndexEnum := wbEnum([
    '头部',
    'Ears',
    '嘴巴',
    'Teeth Lower',
    'Teeth Upper',
    'Tongue',
    'Left Eye',
    'Right Eye'
  ]);

  wbBodyPartIndexEnum := wbEnum([
    '上身',
    '左手',
    '右手',
    '上身身体材质'
  ]);

  wbRecord(RACE, 'Race', [
    wbEDIDReq,
    wbFULLReq,
    wbDESCReq,
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
        '玩家可用',
        '',
        '小孩'
      ]))
    ], cpNormal, True),
    wbFormIDCk(ONAM, 'Older', [RACE]),
    wbFormIDCk(YNAM, 'Younger', [RACE]),
    wbEmpty(NAM2, 'Unknown Marker', cpNormal, True),
    wbArray(VTCK, '语音', wbFormIDCk('语音', [VTYP]), ['男性', '女性'], cpNormal, True),
    wbArray(DNAM, 'Default Hair Styles', wbFormIDCk('Default Hair Style', [HAIR]), ['男性', '女性'], cpNormal, True),
    wbArray(CNAM, '默认头发颜色', wbInteger('默认头发颜色', itU8, wbEnum([
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
    ])), ['男性', '女性'], cpNormal, True),
    wbFloat(PNAM, '脸部生成 - 主要钳位', cpNormal, True),
    wbFloat(UNAM, '脸部生成 - 脸部钳位', cpNormal, True),
    wbByteArray(ATTR, '未知', 0, cpNormal, True),
    wbRStruct('头部数据', [
      wbEmpty(NAM0, '头部数据标记', cpNormal, True),
      wbRStruct('男性头部数据', [
        wbEmpty(MNAM, '男性数据标记', cpNormal, True),
        wbRArrayS('部分', wbRStructSK([0], '部分', [
          wbInteger(INDX, '索引', itU32, wbHeadPartIndexEnum),
          wbMODLReq,
          wbICON
        ], []), cpNormal, True)
      ], [], cpNormal, True),
      wbRStruct('女性头部数据', [
        wbEmpty(FNAM, '女性数据标记', cpNormal, True),
        wbRArrayS('部分', wbRStructSK([0], '部分', [
          wbInteger(INDX, '索引', itU32, wbHeadPartIndexEnum),
          wbMODLReq,
          wbICON
        ], []), cpNormal, True)
      ], [], cpNormal, True)
    ], [], cpNormal, True),
    wbRStruct('身体数据', [
      wbEmpty(NAM1, '身体数据标记', cpNormal, True),
      wbRStruct('男性身体数据', [
        wbEmpty(MNAM, '男性数据标记'),
        wbRArrayS('部分', wbRStructSK([0], '部分', [
          wbInteger(INDX, '索引', itU32, wbBodyPartIndexEnum),
          wbICON,
          wbMODLReq
        ], []), cpNormal, True)
      ], [], cpNormal, True),
      wbRStruct('女性身体数据', [
        wbEmpty(FNAM, '女性数据标记', cpNormal, True),
        wbRArrayS('部分', wbRStructSK([0], '部分', [
          wbInteger(INDX, '索引', itU32, wbBodyPartIndexEnum),
          wbICON,
          wbMODLReq
        ], []), cpNormal, True)
      ], [], cpNormal, True)
    ], [], cpNormal, True),
    wbArrayS(HNAM, '发型', wbFormIDCk('发型', [HAIR]), 0, cpNormal, True),
    wbArrayS(ENAM, '眼睛', wbFormIDCk('眼睛', [EYES]),  0,  cpNormal, True),
    wbRStruct('脸部生成数据', [
      wbRStruct('男性脸部生成数据', [
        wbEmpty(MNAM, '男性数据标记', cpNormal, True),
        wbFaceGen,
        wbUnknown(SNAM, cpNormal, True)
      ], [], cpNormal, True),
      wbRStruct('女性脸部生成数据', [
        wbEmpty(FNAM, '女性数据标记', cpNormal, True),
        wbFaceGen,
        wbUnknown(SNAM, cpNormal, True)
      ], [], cpNormal, True)
    ], [], cpNormal, True)
  ]);

  wbRecord(REFR, 'Placed Object', [
    wbEDID,
    {
    wbStruct(RCLR, 'Linked Reference Color (Old Format?)', [
      wbStruct('连结起始颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbStruct('连结结束颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ])
    ], cpIgnore),}
    wbByteArray(RCLR, '未使用', 0, cpIgnore),
    wbFormIDCk(NAME, '基础', [TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, LVLN, LVLC,
                              MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, CHIP,
                              MSTT, NOTE, PWAT, SCOL, TACT, TERM, TXST, CCRD, IMOD], False, cpNormal, True),
    wbFormIDCk(XEZN, '遭遇区域', [ECZN]),

    {--- ?? ---}
    wbXRGD,
    wbXRGB,

    {--- Primitive ---}
    wbStruct(XPRM, '基元', [
      wbStruct('界限', [
        wbFloat('X', cpNormal, True, 2, 4),
        wbFloat('Y', cpNormal, True, 2, 4),
        wbFloat('Z', cpNormal, True, 2, 4)
      ]),
      wbStruct('颜色', [
        {84} wbFloat('红', cpNormal, False, 255, 0),
        {88} wbFloat('绿', cpNormal, False, 255, 0),
        {92} wbFloat('蓝', cpNormal, False, 255, 0)
      ]),
      wbFloat('未知'),
      wbInteger('类型', itU32, wbEnum([
        '无',
        '箱子',
        '球体',
        '传送箱'
      ]))
    ]),
    wbInteger(XTRI, '碰撞层', itU32, wbEnum([
      'Unidentified',
      'Static',
      'AnimStatic',
      'Transparent',
      'Clutter',
      '武器',
      '抛射物',
      '法术',
      'Biped',
      'Trees',
      'Props',
      '水源',
      'Trigger',
      'Terrain',
      'Trap',
      'Non Collidable',
      'Cloud Trap',
      'Ground',
      'Portal',
      'Debris Small',
      'Debris Large',
      'Acustic Space',
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
    wbEmpty(XMBP, '多限制基元标志'),

    {--- Bound Contents ---}

    {--- Bound Data ---}
    wbStruct(XMBO, '范围限制', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ]),

    {--- Teleport ---}
    wbStruct(XTEL, '传送目的地', [
      wbFormIDCk('门', [REFR], True),
      wbPosRot,
      wbInteger('标志', itU32, wbFlags([
        '无警报'
      ]))
    ]),

    {--- Map Data ---}
    wbRStruct('地图标记', [
      wbEmpty(XMRK, '地图标记起始标记'),
      wbInteger(FNAM, '标志', itU8, wbFlags([
        {0x01} '可见',
        {0x02} '可以旅行到'
      ]), cpNormal, True),
      wbFULLReq,
      wbStruct(TNAM, '', [
        wbInteger('类型', itU8, wbEnum([
          '无',
          '城市',
          '村落',
          'Encampment',
          '自然地标',
          '洞穴',
          'Factory',
          'Monument',
          'Military',
          'Office',
          '小镇废墟',
          'Urban Ruins',
          'Sewer Ruins',
          'Metro',
          'Vault'
        ])),
        wbByteArray('未使用', 1)
      ], cpNormal, True),
      wbFormIDCk(WMI1, 'Reputation', [REPU])
    ], []),

    {--- Audio Data ---}
    wbRStruct('Audio Data', [
      wbEmpty(MMRK, 'Audio Marker'),
      wbUnknown(FULL),
      wbFormIDCk(CNAM, 'Audio Location', [ALOC]),
      wbUnknown(BNAM),
      wbFloat(MNAM),
      wbFloat(NNAM)
    ], []),

    wbUnknown(XSRF),
    wbUnknown(XSRD),

    {--- X Target Data ---}
    wbFormIDCk(XTRG, '目标', [REFR, ACRE, ACHR, PGRE, PMIS], True),

    {--- Leveled Actor ----}
    wbXLCM,

    {--- Patrol Data ---}
    wbRStruct('巡逻数据', [
      wbFloat(XPRD, '空闲时间', cpNormal, True),
      wbEmpty(XPPA, '巡逻脚本标记', cpNormal, True),
      wbFormIDCk(INAM, '空闲动作', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, '话题', [DIAL, NULL], False, cpNormal, True)
    ], []),

    {--- Radio ---}
    wbStruct(XRDO, 'Radio Data', [
      wbFloat('Range Radius'),
      wbInteger('Broadcast Range Type', itU32, wbEnum([
        '半径',
        'Everywhere',
        'Worldspace and Linked Interiors',
        'Linked Interiors',
        'Current Cell Only'
      ])),
      wbFloat('Static Percentage'),
      wbFormIDCkNoReach('Position Reference', [REFR, ACRE, ACHR, PGRE, PMIS, NULL])
    ]),

    {--- Ownership ---}
    wbRStruct('所有权', [
      wbXOWN,
      wbInteger(XRNK, '派系等级', itS32)
    ], [XCMT, XCMO]),

    {--- Lock ---}
    wbStruct(XLOC, '锁数据', [
      wbInteger('等级', itU8),
      wbByteArray('未使用', 3),
      wbFormIDCkNoReach('钥匙', [KEYM, NULL]),
      wbInteger('标志', itU8, wbFlags(['', '', '等级锁'])),
      wbByteArray('未使用', 3),
      wbByteArray('未知', 8)
    ], cpNormal, False, nil, 5),

    {--- Extra ---}
    wbInteger(XCNT, '数量', itS32),
    wbFloat(XRDS, '半径'),
    wbFloat(XHLP, '生命'),
    wbFloat(XRAD, 'Radiation'),
    wbFloat(XCHG, '费用'),
    wbRStruct('Ammo', [
      wbFormIDCk(XAMT, '类型', [AMMO], False, cpNormal, True),
      wbInteger(XAMC, '数量', itS32, nil, cpNormal, True)
    ], []),

    {--- Reflected By / Refracted By ---}
    wbRArrayS('反射/折射',
      wbStructSK(XPWR, [0], '水源', [
        wbFormIDCk('衍生', [REFR]),
        wbInteger('类型', itU32, wbFlags([
          '反射',
          '折射'
        ]))
      ])
    ),

    {--- Lit Water ---}
    wbRArrayS('发光水源',
      wbFormIDCk(XLTW, '水源', [REFR])
    ),

    {--- Decals ---}
    wbRArrayS('Linked Decals',
      wbStructSK(XDCR, [0], 'Decal', [
        wbFormIDCk('衍生', [REFR]),
        wbUnknown
      ])
    ),

    {--- Linked Ref ---}
    wbFormIDCk(XLKR, '连接的衍生', [REFR, ACRE, ACHR, PGRE, PMIS]),
    wbStruct(XCLP, '连结衍生颜色', [
      wbStruct('连结起始颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ]),
      wbStruct('连结结束颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未使用', 1)
      ])
    ]),

    {--- Activate Parents ---}
    wbRStruct('激活根源', [
      wbInteger(XAPD, '标志', itU8, wbFlags([
        '仅激活根源'
      ], True)),
      wbRArrayS('激活根源衍生',
        wbStructSK(XAPR, [0], '激活根源衍生', [
          wbFormIDCk('衍生', [REFR, ACRE, ACHR, PGRE, PMIS]),
          wbFloat('推延')
        ])
      )
    ], []),

    wbString(XATO, '激活提示'),

    {--- Enable Parent ---}
    wbXESP,

    {--- Emittance ---}
    wbFormIDCk(XEMI, '辐射颜色', [LIGH, REGN]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, '多限制衍生', [REFR]),

    {--- Flags ---}
    wbInteger(XACT, '动作标记', itU32, wbFlags([
      '使用默认',
      '激活',
      '打开',
      '默认打开'
    ])),
    wbEmpty(ONAM, '默认打开'),
    wbEmpty(XIBS, '被沙盒忽略'),

    {--- Generated Data ---}
    wbStruct(XNDP, '导航门连接', [
      wbFormIDCk('导航模型', [NAVM]),
      wbInteger('未知', itU16),
      wbByteArray('未使用', 2)
    ]),

    wbArray(XPOD, '传送数据', wbFormIDCk('Room', [REFR, NULL]), 2),
    wbStruct(XPTL, '传送数据', [
      wbStruct('尺寸', [
        wbFloat('宽度', cpNormal, False, 2),
        wbFloat('高度', cpNormal, False, 2)
      ]),
      wbStruct('方位', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]),
      wbStruct('角度 (四元?)', [
        wbFloat('q1'),
        wbFloat('q2'),
        wbFloat('q3'),
        wbFloat('q4')
      ])
    ]),

    wbInteger(XSED, 'SpeedTree Seed', itU8),

    wbRStruct('Room Data', [
      wbStruct(XRMR, '数据头', [
        wbInteger('连接的空间数目', itU16),
        wbByteArray('未知', 2)
      ]),
      wbRArrayS('连接的空间',
        wbFormIDCk(XLRM, 'Linked Room', [REFR])
      )
    ], []),

    wbStruct(XOCP, '遮蔽空间数据', [
      wbStruct('尺寸', [
        wbFloat('宽度', cpNormal, False, 2),
        wbFloat('高度', cpNormal, False, 2)
      ]),
      wbStruct('方位', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]),
      wbStruct('角度 (四元?)', [
        wbFloat('q1'),
        wbFloat('q2'),
        wbFloat('q3'),
        wbFloat('q4')
      ])
    ]),
    wbArray(XORD, 'Linked Occlusion Planes', wbFormIDCk('Plane', [REFR, NULL]), [
      '右',
      '左',
      '底',
      '顶'
    ]),

    wbXLOD,

    {--- 3D Data ---}
    wbXSCL,
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
    wbFormIDCkNoReach(WNAM, '世界空间', [WRLD]),

    wbRArray('区域范围', wbRStruct('区域范围', [
      wbInteger(RPLI, '边缘衰减', itU32),
      wbArray(RPLD, '区域点数据', wbStruct('点', [
        wbFloat('X'),
        wbFloat('Y')
      ]), 0, wbRPLDAfterLoad)
    ], [])),

    wbRArrayS('边缘数据记录', wbRStructSK([0], '边缘数据记录', [
      {always starts with an RDAT}
      wbStructSK(RDAT, [0], '数据头', [
        wbInteger('类型', itU32, wbEnum([
          {0}'',
          {1}'',
          {2}'对象',
          {3}'天气',
          {4}'地图',
          {5}'土地',
          {6}'草地',
          {7}'音效',
          {8}'顶替',
          {9}''
        ])),
        wbInteger('标志', itU8, wbFlags([
          '覆盖'
        ])),
        wbInteger('优先级', itU8),
        wbByteArray('未使用')
      ], cpNormal, True),

      {followed by one of these: }

      {--- Objects ---}
      wbArray(RDOT, '对象', wbStruct('对象', [
        wbFormIDCk('对象', [TREE, STAT, LTEX]),
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
      ]), 0, nil, nil, cpNormal, False, wbREGNObjectsDontShow),

      {--- Map ---}
      wbString(RDMP, '地图名称', 0, cpTranslate, False, wbREGNMapDontShow),

      {--- Grass ---}
      wbArrayS(RDGS, '草地', wbStructSK([0], '草地', [
        wbFormIDCk('草地', [GRAS]),
        wbByteArray('未知',4)
      ]), 0, cpNormal, False, nil, nil, wbREGNGrassDontShow),

      {--- Sound ---}
      wbInteger(RDMD, '音乐类型', itU32, wbMusicEnum, cpIgnore, False, False, wbNeverShow),
      wbFormIDCk(RDMO, '音乐', [MUSC], False, cpNormal, False, wbREGNSoundDontShow),
      wbFormIDCk(RDSI, 'Incidental MediaSet', [MSET], False, cpNormal, False, wbREGNSoundDontShow),
      wbRArray('Battle MediaSets', wbFormIDCk(RDSB, 'Battle MediaSet', [MSET]), cpNormal, False, wbREGNSoundDontShow),
      wbArrayS(RDSD, '音效', wbStructSK([0], '音效', [
        wbFormIDCk('音效', [SOUN]),
        wbInteger('标志', itU32, wbFlags([
          '晴朗',
          '多云',
          '下雨',
          '下雪'
        ])),
        wbInteger('概率', itU32, wbScaledInt4ToStr, wbScaledInt4ToInt)
      ]), 0, cpNormal, False, nil, nil, wbREGNSoundDontShow),

      {--- Weather ---}
      wbArrayS(RDWT, '天气类型', wbStructSK([0], '天气类型', [
        wbFormIDCk('天气', [WTHR]),
        wbInteger('概率', itU32),
        wbFormIDCk('全局', [GLOB, NULL])
      ]), 0, cpNormal, False, nil, nil, wbREGNWeatherDontShow),

      {--- Imposter ---}
      wbArrayS(RDID, '顶替', wbFormIDCk('顶替', [REFR]), 0, cpNormal, False, nil, nil, wbREGNImposterDontShow)
    ], []))
  ], True);

  wbRecord(SOUN, 'Sound', [
    wbEDIDReq,
    wbOBNDReq,
    wbString(FNAM, 'Sound Filename'),
    wbInteger(RNAM, 'Random Chance %', itU8),
    wbRUnion('Sound Data', [
      wbStruct(SNDD, 'Sound Data', [
        wbInteger('Minimum Attentuation Distance', itU8, wbMul(5)),
        wbInteger('Maximum Attentuation Distance', itU8, wbMul(100)),
        wbInteger('频率调整 %', itS8),
        wbByteArray('未使用', 1),
        wbInteger('标志', itU32, wbFlags([
          {0x0001} '随机频移',
          {0x0002} 'Play At Random',
          {0x0004} 'Environment Ignored',
          {0x0008} 'Random Location',
          {0x0010} '循环',
          {0x0020} 'Menu Sound',
          {0x0040} '2D',
          {0x0080} '360 LFE',
          {0x0100} 'Dialogue Sound',
          {0x0200} '速封',
          {0x0400} '慢封',
          {0x0800} '2D Radius',
          {0x1000} '水中减弱',
          {0x2000} 'Start at Random Position'
        ])),
        wbInteger('Static attentuation cdB', itS16),
        wbInteger('Stop time ', itU8),
        wbInteger('起始时间 ', itU8),
        wbArray('衰减曲线', wbInteger('Point', itS16), 5),
        wbInteger('Reverb Attenuation Control', itS16),
        wbInteger('优先级', itS32),
//        wbByteArray('未知', 8)
        wbInteger('x', itS32),
        wbInteger('y', itS32)

      ], cpNormal, True),
      wbStruct(SNDX, 'Sound Data', [
        wbInteger('Minimum attentuation distance', itU8, wbMul(5)),
        wbInteger('Maximum attentuation distance', itU8, wbMul(100)),
        wbInteger('频率调整 %', itS8),
        wbByteArray('未使用', 1),
        wbInteger('标志', itU32, wbFlags([
          {0x0001} '随机频移',
          {0x0002} 'Play At Random',
          {0x0004} 'Environment Ignored',
          {0x0008} 'Random Location',
          {0x0010} '循环',
          {0x0020} 'Menu Sound',
          {0x0040} '2D',
          {0x0080} '360 LFE',
          {0x0100} 'Dialogue Sound',
          {0x0200} '速封',
          {0x0400} '慢封',
          {0x0800} '2D Radius',
          {0x1000} '水中减弱'
        ])),
        wbInteger('Static attentuation cdB', itS16),
        wbInteger('Stop time ', itU8),
        wbInteger('起始时间 ', itU8)
      ], cpNormal, True)
    ], [], cpNormal, True),
    wbArray(ANAM, '衰减曲线', wbInteger('Point', itS16), 5, nil, nil, cpNormal, False, wbNeverShow),
    wbInteger(GNAM, 'Reverb Attenuation Control', itS16, nil, cpNormal, False, False, wbNeverShow),
    wbInteger(HNAM, '优先级', itS32, nil, cpNormal, False, False, wbNeverShow)
  ], False, nil, cpNormal, False, wbSOUNAfterLoad);

  wbRecord(SPEL, 'Actor Effect', [
    wbEDIDReq,
    wbFULL,
    wbStruct(SPIT, '', [
      wbInteger('类型', itU32, wbEnum([
        {0} '魔法',
        {1} '疾病',
        {2} '威能',
        {3} '次级威能',
        {4} '能力',
        {5} '毒药',
        {6} '',
        {7} '',
        {8} '',
        {9} '',
       {10} '上瘾'
      ])),
      wbInteger('Cost (Unused)', itU32),
      wbInteger('Level (Unused)', itU32, wbEnum([
        {0} '未使用'
      ])),
      wbInteger('标志', itU8, wbFlags([
        {0x00000001} '不自动计算',
        {0x00000002} 'Immune to Silence 1?',
        {0x00000004} 'PC Start Effect',
        {0x00000008} 'Immune to Silence 2?',
        {0x00000010} '影响范围不受视角限制',
        {0x00000020} 'Script Effect Always Applies',
        {0x00000040} 'Disable Absorb/Reflect',
        {0x00000080} 'Force Touch Explode'
      ])),
      wbByteArray('未使用', 3)
    ], cpNormal, True),
    wbEffectsReq
  ]);

  wbRecord(STAT, 'Static', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODL,
    wbInteger(BRUS, 'Passthrough Sound', itS8, wbEnum([
      'BushA',
      'BushB',
      'BushC',
      'BushD',
      'BushE',
      'BushF',
      'BushG',
      'BushH',
      'BushI',
      'BushJ'
    ], [
      -1, 'NONE'
    ])),
    wbFormIDCk(RNAM, '音效 - 循环/随机', [SOUN])
  ]);

  wbRecord(TES4, 'Main File Header', [
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
    ], [ONAM])),
    wbArray(ONAM, '覆盖的表单', wbFormIDCk('表单', [REFR, ACHR, ACRE, PMIS, PGRE, LAND, NAVM]), 0, nil, nil, cpNormal, False, wbTES4ONAMDontShow),
    wbByteArray(SCRN, '截图')
  ], True, nil, cpNormal, True, wbRemoveOFST);

  wbRecord(TREE, 'Tree', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODLReq,
    wbICONReq,
    wbArrayS(SNAM, 'SpeedTree Seeds', wbInteger('SpeedTree Seed', itU32), 0, cpNormal, True),
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
end;

procedure DefineFNVf;
begin
  wbRecord(WATR, 'Water', [
    wbEDIDReq,
    wbFULL,
    wbString(NNAM, 'Noise Map', 0, cpNormal, True),
    wbInteger(ANAM, '透明度', itU8, nil, cpNormal, True),
    wbInteger(FNAM, '标志', itU8, wbFlags([
      {0}'造成伤害',
      {1}'Reflective'
    ]), cpNormal, True),
    wbString(MNAM, 'Material ID', 0, cpNormal, True),
    wbFormIDCk(SNAM, '音效', [SOUN]),
    wbFormIDCk(XNAM, '魔法', [SPEL]),
    wbInteger(DATA, '伤害', itU16, nil, cpNormal, True, True),
    wbRUnion('可视化数据', [
      wbStruct(DNAM, '可视化数据', [
        wbFloat('未知'),
        wbFloat('未知'),
        wbFloat('未知'),
        wbFloat('未知'),
        wbFloat('水面属性 - 阳光强度'),
        wbFloat('水面属性 - 反射指数'),
        wbFloat('水面属性 - 菲涅耳指数'),
        wbByteArray('未使用', 4),
        wbFloat('水雾属性 - 水上部分 - 水雾距离 - 接近地面'),
        wbFloat('水雾属性 - 水上部分 - 水雾距离 - 远离地面'),
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
        wbByteArray('未使用', 4),
        wbFloat('雨滴模拟器 - 推力'),
        wbFloat('雨滴模拟器 - 速度'),
        wbFloat('雨滴模拟器 - 衰减'),
        wbFloat('雨滴模拟器 - 阻尼'),
        wbFloat('水纹模拟器 - 起始尺寸'),
        wbFloat('水纹模拟器 - 推力'),
        wbFloat('水纹模拟器 - 速度'),
        wbFloat('水纹模拟器 - 衰减'),
        wbFloat('水纹模拟器 - 阻尼'),
        wbFloat('雨滴模拟器 - 起始尺寸'),
        wbFloat('噪波属性 - 法线 - 噪波规模'),
        wbFloat('噪波属性 - 噪波图层一 - 风向'),
        wbFloat('噪波属性 - 噪波图层二 - 风向'),
        wbFloat('噪波属性 - 噪波图层三 - 风向'),
        wbFloat('噪波属性 - 噪波图层一 - 风速'),
        wbFloat('噪波属性 - 噪波图层二 - 风速'),
        wbFloat('噪波属性 - 噪波图层三 - 风速'),
        wbFloat('噪波属性 - 法线 - Depth Falloff 起始'),
        wbFloat('噪波属性 - 法线 - Depth Falloff 结束'),
        wbFloat('水雾属性 - 水上部分 - 水雾数量'),
        wbFloat('噪波属性 - 法线 - UV 规模'),
        wbFloat('水雾属性 - 水下部分 - 水雾数量'),
        wbFloat('水雾属性 - 水下部分 - 水雾距离 - 接近地面'),
        wbFloat('水雾属性 - 水下部分 - 水雾距离 - 远离地面'),
        wbFloat('水面属性 - Distortion Amount'),
        wbFloat('水面属性 - Shininess'),
        wbFloat('水面属性 - Reflection HDR Multiplier'),
        wbFloat('水面属性 - Light Radius'),
        wbFloat('水面属性 - Light Brightness'),
        wbFloat('噪波属性 - 噪波图层一 - UV 规模'),
        wbFloat('噪波属性 - 噪波图层二 - UV 规模'),
        wbFloat('噪波属性 - 噪波图层三 - UV 规模'),
        wbFloat('噪波属性 - 噪波图层一 - 振幅规模'),
        wbFloat('噪波属性 - 噪波图层二 - 振幅规模'),
        wbFloat('噪波属性 - 噪波图层三 - 振幅规模')
      ], cpNormal, True, nil, 46),
      wbStruct(DATA, '可视化数据', [
        wbFloat('未知'),
        wbFloat('未知'),
        wbFloat('未知'),
        wbFloat('未知'),
        wbFloat('水面属性 - 阳光强度'),
        wbFloat('水面属性 - 反射指数'),
        wbFloat('水面属性 - 菲涅耳指数'),
        wbByteArray('未使用', 4),
        wbFloat('水雾属性 - 水上部分 - 水雾距离 - 接近地面'),
        wbFloat('水雾属性 - 水上部分 - 水雾距离 - 远离地面'),
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
        wbByteArray('未使用', 4),
        wbFloat('雨滴模拟器 - 推力'),
        wbFloat('雨滴模拟器 - 速度'),
        wbFloat('雨滴模拟器 - 衰减'),
        wbFloat('雨滴模拟器 - 阻尼'),
        wbFloat('水纹模拟器 - 起始尺寸'),
        wbFloat('水纹模拟器 - 推力'),
        wbFloat('水纹模拟器 - 速度'),
        wbFloat('水纹模拟器 - 衰减'),
        wbFloat('水纹模拟器 - 阻尼'),
        wbFloat('雨滴模拟器 - 起始尺寸'),
        wbFloat('噪波属性 - 法线 - 噪波规模'),
        wbFloat('噪波属性 - 噪波图层一 - 风向'),
        wbFloat('噪波属性 - 噪波图层二 - 风向'),
        wbFloat('噪波属性 - 噪波图层三 - 风向'),
        wbFloat('噪波属性 - 噪波图层一 - 风速'),
        wbFloat('噪波属性 - 噪波图层二 - 风速'),
        wbFloat('噪波属性 - 噪波图层三 - 风速'),
        wbFloat('噪波属性 - 法线 - Depth Falloff 起始'),
        wbFloat('噪波属性 - 法线 - Depth Falloff 结束'),
        wbFloat('水雾属性 - 水上部分 - 水雾数量'),
        wbFloat('噪波属性 - 法线 - UV 规模'),
        wbFloat('水雾属性 - 水下部分 - 水雾数量'),
        wbFloat('水雾属性 - 水下部分 - 水雾距离 - 接近地面'),
        wbFloat('水雾属性 - 水下部分 - 水雾距离 - 远离地面'),
        wbFloat('水面属性 - Distortion Amount'),
        wbFloat('水面属性 - Shininess'),
        wbFloat('水面属性 - Reflection HDR Multiplier'),
        wbFloat('水面属性 - Light Radius'),
        wbFloat('水面属性 - Light Brightness'),
        wbFloat('噪波属性 - 噪波图层一 - UV 规模'),
        wbFloat('噪波属性 - 噪波图层二 - UV 规模'),
        wbFloat('噪波属性 - 噪波图层三 - UV 规模'),
        wbEmpty('噪波属性 - 噪波图层一 - 振幅规模'),
        wbEmpty('噪波属性 - 噪波图层二 - 振幅规模'),
        wbEmpty('噪波属性 - 噪波图层三 - 振幅规模'),
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
    wbOBNDReq,
    wbFULL,
    wbMODL,
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
      wbString(MOD2, '模型'),
      wbByteArray(MO2T, '材质文件哈希值', 0, cpIgnore),
      wbMO2S
    ], []),
    wbRStruct('Scope Model', [
      wbString(MOD3, '模型'),
      wbByteArray(MO3T, '材质文件哈希值', 0, cpIgnore),
      wbMO3S
    ], []),
    wbFormIDCK(EFSD, 'Scope Effect', [EFSH]),
    wbRStruct('World Model', [
      wbString(MOD4, '模型'),
      wbByteArray(MO4T, '材质文件哈希值', 0, cpIgnore),
      wbMO4S
    ], []),
    wbRStruct('Model with Mods', [
      wbString(MWD1, 'Mod 1'),
      wbString(MWD2, 'Mod 2'),
      wbString(MWD3, 'Mod 1 and 2'),
      wbString(MWD4, 'Mod 3'),
      wbString(MWD5, 'Mod 1 and 3'),
      wbString(MWD6, 'Mod 2 and 3'),
      wbString(MWD7, 'Mod 1, 2 and 3')
    ], [], cpNormal, False, nil, True),

    wbString(VANM, 'VATS Attack Name'),
    wbString(NNAM, '捆绑武器节点'),

    wbFormIDCk(INAM, 'Impact DataSet', [IPDS]),
    wbFormIDCk(WNAM, '1st Person Model', [STAT]),
    wbRStruct('1st Person Models with Mods', [
      wbFormIDCk(WNM1, 'Mod 1', [STAT]),
      wbFormIDCk(WNM2, 'Mod 2', [STAT]),
      wbFormIDCk(WNM3, 'Mod 1 and 2', [STAT]),
      wbFormIDCk(WNM4, 'Mod 3', [STAT]),
      wbFormIDCk(WNM5, 'Mod 1 and 3', [STAT]),
      wbFormIDCk(WNM6, 'Mod 2 and 3', [STAT]),
      wbFormIDCk(WNM7, 'Mod 1, 2 and 3', [STAT])
    ], [], cpNormal, False, nil, True),
    wbRStruct('Weapon Mods', [
      wbFormIDCk(WMI1, 'Mod 1', [IMOD]),
      wbFormIDCk(WMI2, 'Mod 2', [IMOD]),
      wbFormIDCk(WMI3, 'Mod 3', [IMOD])
    ], [], cpNormal, False, nil, True),
    wbFormIDCk(SNAM, 'Sound - Gun - Shoot 3D', [SOUN]),
    wbFormIDCk(SNAM, 'Sound - Gun - Shoot Dist', [SOUN]),
    wbFormIDCk(XNAM, 'Sound - Gun - Shoot 2D', [SOUN]),
    wbFormIDCk(NAM7, 'Sound - Gun - Shoot 3D Looping', [SOUN]),
    wbFormIDCk(TNAM, 'Sound - Melee - Swing / Gun - No Ammo', [SOUN]),
    wbFormIDCk(NAM6, 'Sound - Block', [SOUN]),
    wbFormIDCk(UNAM, 'Sound - Idle', [SOUN]),
    wbFormIDCk(NAM9, 'Sound - Equip', [SOUN]),
    wbFormIDCk(NAM8, 'Sound - Unequip', [SOUN]),
    wbFormIDCk(WMS1, 'Sound - Mod 1 - Shoot 3D', [SOUN]),
    wbFormIDCk(WMS1, 'Sound - Mod 1 - Shoot Dist', [SOUN]),
    wbFormIDCk(WMS2, 'Sound - Mod 1 - Shoot 2D', [SOUN]),
    wbStruct(DATA, '', [
      wbInteger('价值', itS32),
      wbInteger('生命', itS32),
      wbFloat('重量'),
      wbInteger('Base Damage', itS16),
      wbInteger('Clip Size', itU8)
    ], cpNormal, True),
    wbStruct(DNAM, '', [
      {00} wbInteger('动作类型', itU32, wbWeaponAnimTypeEnum),
      {04} wbFloat('动作加成'),
      {08} wbFloat('范围'),
      {12} wbInteger('标志 1', itU8, wbFlags([
        '无视普通武器抗性',
        '自动',
        '子弹视角',
        '无法丢弃',
        '隐藏背包',
        '捆绑的武器',
        '子弹视角',
        '玩家不可用'
      ])),
      {13} wbInteger('Grip Animation', itU8, wbEnum([
      ], [
        230, 'HandGrip1',
        231, 'HandGrip2',
        232, 'HandGrip3',
        233, 'HandGrip4',
        234, 'HandGrip5',
        235, 'HandGrip6',
        255, ' DEFAULT'
      ])),
      {14} wbInteger('Ammo Use', itU8),
      {15} wbInteger('Reload Animation', itU8, wbReloadAnimEnum),
      {16} wbFloat('Min Spread'),
      {20} wbFloat('Spread'),
      {24} wbFloat('未知'),
      {28} wbFloat('视场'),
      {32} wbFloat,
      {36} wbFormIDCk('抛射物', [PROJ, NULL]),
      {40} wbInteger('基本终结技击中概率', itU8),
      {41} wbInteger('攻击动作', itU8, wbEnum([
           ], [
             26, 'AttackLeft',
             32, 'AttackRight',
             38, 'Attack3',
             44, 'Attack4',
             50, 'Attack5',
             56, 'Attack6',
             62, 'Attack7',
             68, 'Attack8',
            144, 'Attack9',
             74, 'AttackLoop',
             80, 'AttackSpin',
             86, 'AttackSpin2',
            114, 'AttackThrow',
            120, 'AttackThrow2',
            126, 'AttackThrow3',
            132, 'AttackThrow4',
            138, 'AttackThrow5',
            150, 'AttackThrow6',
            156, 'AttackThrow7',
            162, 'AttackThrow8',
            102, 'PlaceMine',
            108, 'PlaceMine2',
            255, ' DEFAULT'
           ])),
      {42} wbInteger('Projectile Count', itU8),
      {43} wbInteger('捆绑武器 - 角色数值', itU8, wbEnum([
        {00} 'Perception',
        {01} '耐力',
        {02} 'Left Attack',
        {03} 'Right Attack',
        {04} 'Left Mobility',
        {05} 'Right Mobilty',
        {06} 'Brain'
      ])),
      {44} wbFloat('Min Range'),
      {48} wbFloat('Max Range'),
      {52} wbInteger('击中', itU32, wbEnum([
        '正常',
        '仅肢解',
        '仅爆炸',
        '无肢解/爆炸'
      ])),
      {56} wbInteger('标志 2', itU32, wbFlags([
        {0x00000001}'仅玩家可用',
        {0x00000002}'NPC会使用',
        {0x00000004}'再装备不拥挤',
        {0x00000008}'Override - Action Points',
        {0x00000010}'轻罪',
        {0x00000020}'范围 - 修复',
        {0x00000040}'一般战斗不使用',
        {0x00000080}'Override - Damage to Weapon Mult',
        {0x00000100}'第三人称不使用子弹视角',
        {0x00000200}'Short Burst',
        {0x00000400}'震动替换物',
        {0x00000800}'Long Burst',
        {0x00001000}'Scope has NightVision',
        {0x00002000}'Scope from Mod'
      ])),
      {60} wbFloat('动作攻击加成'),
      {64} wbFloat('Fire Rate'),
      {68} wbFloat('Override - Action Points'),
      {72} wbFloat('震动 - 左马达强度'),
      {76} wbFloat('震动 - 右马达强度'),
      {80} wbFloat('震动 - 持续时间'),
      {84} wbFloat('Override - Damage to Weapon Mult'),
      {88} wbFloat('Attack Shots/Sec'),
      {92} wbFloat('Reload Time'),
      {96} wbFloat('Jam Time'),
     {100} wbFloat('Aim Arc'),
     {104} wbInteger('技能', itS32, wbActorValueEnum),
     {108} wbInteger('震动 - Pattern', itU32, wbEnum([
       'Constant',
       'Square',
       '三角',
       'Sawtooth'
     ])),
     {112} wbFloat('震动 - Wavelength'),
     {116} wbFloat('Limb Dmg Mult'),
     {120} wbInteger('Resist Type', itS32, wbActorValueEnum),
     {124} wbFloat('Sight Usage'),
     {128} wbFloat('Semi-Automatic Fire Delay Min'),
     {132} wbFloat('Semi-Automatic Fire Delay Max'),
     wbFloat,
     wbInteger('Effect - Mod 1', itU32, wbModEffectEnum),
     wbInteger('Effect - Mod 2', itU32, wbModEffectEnum),
     wbInteger('Effect - Mod 3', itU32, wbModEffectEnum),
     wbFloat('Value A - Mod 1'),
     wbFloat('Value A - Mod 2'),
     wbFloat('Value A - Mod 3'),
     wbInteger('Power Attack Animation Override', itU32, wbEnum([
     ], [
        0, '0?',
       97, 'AttackCustom1Power',
       98, 'AttackCustom2Power',
       99, 'AttackCustom3Power',
      100, 'AttackCustom4Power',
      101, 'AttackCustom5Power',
      255, ' DEFAULT'
     ])),
     wbInteger('Strength Req', itU32),
     wbByteArray('未知', 1),
     wbInteger('Reload Animation - Mod', itU8, wbReloadAnimEnum),
     wbByteArray('未知', 2),
     wbFloat('Regen Rate'),
     wbFloat('Kill Impulse'),
     wbFloat('Value B - Mod 1'),
     wbFloat('Value B - Mod 2'),
     wbFloat('Value B - Mod 3'),
     wbFloat('Impulse Dist'),
     wbInteger('Skill Req', itU32)
    ], cpNormal, True, nil, 36),

   wbStruct(CRDT, '临界数据', [
      {00} wbInteger('致命伤害', itU16),
      {09} wbByteArray('未使用', 2),
      {04} wbFloat('致命 % 加成'),
      {08} wbInteger('标志', itU8, wbFlags([
        '死亡时'
      ])),
      {09} wbByteArray('未使用', 3),
      {12} wbFormIDCk('效果', [SPEL, NULL])
    ], cpNormal, True),
    wbStruct(VATS, 'VATS', [
     wbFormIDCk('效果',[SPEL, NULL]),
     wbFloat('技能'),
     wbFloat('Dam. Mult'),
     wbFloat('AP'),
     wbInteger('细声', itU8, wbEnum(['否', '是'])),
     wbInteger('Mod Required', itU8, wbEnum(['否', '是'])),
     wbByteArray('未使用', 2)
    ]),
    wbInteger(VNAM, '音量级别', itU32, wbSoundLevelEnum, cpNormal, True)
  ], False, nil, cpNormal, False, wbWEAPAfterLoad);

  wbRecord(WRLD, 'Worldspace', [
    wbEDIDReq,
    wbFULL,
    wbFormIDCk(XEZN, '遭遇区域', [ECZN]),
    wbRStruct('父系', [
      wbFormIDCk(WNAM, '世界空间', [WRLD]),
      wbStruct(PNAM, '', [
        wbInteger('标志', itU8, wbFlags([
          {0x00000001}'使用土地数据',
          {0x00000002}'使用LOD数据',
          {0x00000004}'Use Map Data',
          {0x00000008}'使用水源数据',
          {0x00000010}'使用气候数据',
          {0x00000020}'Use Image Space Data'
        ], True)),
        wbByteArray('未知', 1)
      ], cpNormal, True)
    ], []),
    wbFormIDCk(CNAM, '气候', [CLMT]),
    wbFormIDCk(NAM2, '水源', [WATR]),
    wbFormIDCk(NAM3, 'LOD 水源类型', [WATR]),
    wbFloat(NAM4, 'LOD 水源高度'),
    wbStruct(DNAM, '土地数据', [
      wbFloat('默认土地高度'),
      wbFloat('默认水源高度')
    ]),
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
    wbStruct(ONAM, '世界地图补偿数据', [
      wbFloat('世界地图规模'),
      wbFloat('场景 X 偏移'),
      wbFloat('场景 Y 偏移')
    ], cpNormal, True),
    wbFormIDCk(INAM, '图像空间', [IMGS]),
    wbInteger(DATA, '标志', itU8, wbFlags([
      {0x01} '小世界',
      {0x02} '无法快速旅行',
      {0x04} '',
      {0x08} '',
      {0x10} '无LOD水',
      {0x20} 'No LOD Noise',
      {0x40} 'Don''t Allow NPC Fall Damage',
      {0x80} 'Needs Water Adjustment'
    ]), cpNormal, True),
    wbRStruct('物体方位', [
      wbStruct(NAM0, '最小值', [
        wbFloat('X'),
        wbFloat('Y')
      ], cpNormal, True),
      wbStruct(NAM9, '最大值', [
        wbFloat('X'),
        wbFloat('Y')
      ], cpNormal, True)
    ], [], cpNormal, True),
    wbFormIDCk(ZNAM, '音乐', [MUSC]),
    wbString(NNAM, '树冠阴影', 0, cpNormal, True),
    wbString(XNAM, '水面噪波纹理', 0, cpNormal, True),
    wbRArrayS('Swapped Impacts', wbStructExSK(IMPS, [0, 1], [2], 'Swapped Impact', [
      wbInteger('材料类型', itU32, wbImpactMaterialTypeEnum),
      wbFormIDCkNoReach('Old', [IPCT]),
      wbFormIDCk('New', [IPCT, NULL])
    ])),
    wbArray(IMPF, 'Footstep Materials', wbString('未知', 30), [
      'ConcSolid',
      'ConcBroken',
      'MetalSolid',
      'MetalHollow',
      'MetalSheet',
      'Wood',
      'Sand',
      'Dirt',
      '草地',
      '水源'
    ]),
    wbByteArray(OFST, '未知')
  ], False, nil, cpNormal, False, wbRemoveOFST);

  wbRecord(WTHR, 'Weather', [
    wbEDIDReq,
    wbFormIDCk(_0_IAD, '日出 Image Space Modifier', [IMAD]),
    wbFormIDCk(_1_IAD, 'Day Image Space Modifier', [IMAD]),
    wbFormIDCk(_2_IAD, '日落 Image Space Modifier', [IMAD]),
    wbFormIDCk(_3_IAD, 'Night Image Space Modifier', [IMAD]),
    wbFormIDCk(_4_IAD, '未知', [IMAD]),
    wbFormIDCk(_5_IAD, '未知', [IMAD]),
    wbString(DNAM, '云层材质 - 图层 0', 0, cpNormal, True),
    wbString(CNAM, '云层材质 - 图层 1', 0, cpNormal, True),
    wbString(ANAM, '云层材质 - 图层 2', 0, cpNormal, True),
    wbString(BNAM, '云层材质 - 图层 3', 0, cpNormal, True),
    wbMODL,
    wbByteArray(LNAM, '未知', 4, cpNormal, True),
    wbArray(ONAM, '云层速度', wbInteger('图层', itU8{, wbDiv(2550)}), 4, nil, nil, cpNormal, True),
    wbArray(PNAM, '云层图层颜色',
      wbArray('图层',
        wbStruct('颜色', [
          wbInteger('红', itU8),
          wbInteger('绿', itU8),
          wbInteger('蓝', itU8),
          wbByteArray('未使用', 1)
        ]),
        ['日出', '白天', '日落', '夜晚', 'High Noon', 'Midnight']
      ),
    4),
    wbArray(NAM0, 'Colors by Types/Times',
      wbArray('类型',
        wbStruct('时间', [
          wbInteger('红', itU8),
          wbInteger('绿', itU8),
          wbInteger('蓝', itU8),
          wbByteArray('未使用', 1)
        ]),
        ['日出', '白天', '日落', '夜晚', 'High Noon', 'Midnight']
      ),
      ['天空高层','Fog','Unused','环境','日光','太阳','星星','天空低层','地平线','Unused']
    , cpNormal, True),
    wbStruct(FNAM, '水雾距离', [
      wbFloat('白天 - 接近'),
      wbFloat('白天 - 远离'),
      wbFloat('夜晚 - 接近'),
      wbFloat('夜晚 - 远离'),
      wbFloat('白天 - 倍率'),
      wbFloat('夜晚 - Fower')
    ], cpNormal, True),
    wbByteArray(INAM, '未使用', 304, cpIgnore, True),
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

  wbRecord(IMOD, 'Item Mod', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbDESC,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbStruct(DATA, '数据', [
      wbInteger('价值', itU32),
      wbFloat('重量')
    ])
  ]);

  wbRecord(ALOC, 'Media Location Controller', [
    wbEDIDReq,
    wbFULL,
    wbByteArray(NAM1, 'Flags and Enums, messily combined'),
    wbUnknown(NAM2),
    wbUnknown(NAM3),
    wbFloat(NAM4, 'Location Delay'),
    wbInteger(NAM5, 'Day 起始', itU32, wbAlocTime),
    wbInteger(NAM6, 'Night 起始', itU32, wbAlocTime),
    wbFloat(NAM7, 'Retrigger Delay'),
    wbRArrayS('Neutral Sets',
      wbFormIDCk(HNAM, 'Media Set', [MSET])
    ),
    wbRArrayS('Ally Sets',
      wbFormIDCk(ZNAM, 'Media Set', [MSET])
    ),
    wbRArrayS('Friend Sets',
      wbFormIDCk(XNAM, 'Media Set', [MSET])
    ),
    wbRArrayS('Enemy Sets',
      wbFormIDCk(YNAM, 'Media Set', [MSET])
    ),
    wbRArrayS('Location Sets',
      wbFormIDCk(LNAM, 'Media Set', [MSET])
    ),
    wbRArrayS('Battle Sets',
      wbFormIDCk(GNAM, 'Media Set', [MSET])
    ),
    wbFormIDCk(RNAM, 'Conditional Faction', [FACT]),
    wbUnknown(FNAM)
  ]);

  wbRecord(MSET, 'Media Set', [
    wbEDIDReq,
    wbFULL,
    wbInteger(NAM1, '类型', itU32, wbEnum([
      'Battle Set',
      'Location Set',
      'Dungeon Set',
      'Incidential Set'
    ], [
      -1, 'No Set'
    ])),
    wbString(NAM2, 'Loop (B) / Battle (D) / Day Outer (L)'),
    wbString(NAM3, 'Explore (D) / Day Middle (L)'),
    wbString(NAM4, 'Suspense (D) / Day Inner (L)'),
    wbString(NAM5, 'Night Outer (L)'),
    wbString(NAM6, 'Night Middle (L)'),
    wbString(NAM7, 'Night Inner (L)'),
    wbFloat(NAM8, 'Loop dB (B) / Battle dB (D) / Day Outer dB (L)'),
    wbFloat(NAM9, 'Explore dB (D) / Day Middle dB (L)'),
    wbFloat(NAM0, 'Suspense dB (D) / Day Inner dB (L)'),
    wbFloat(ANAM, 'Night Outer dB (L)'),
    wbFloat(BNAM, 'Night Middle dB (L)'),
    wbFloat(CNAM, 'Night Inner dB (L)'),
    wbFloat(JNAM, 'Day Outer Boundary % (L)'),
    wbFloat(KNAM, 'Day Middle Boundary % (L)'),
    wbFloat(LNAM, 'Day Inner Boundary % (L)'),
    wbFloat(MNAM, 'Night Outer Boundary % (L)'),
    wbFloat(NNAM, 'Night Middle Boundary % (L)'),
    wbFloat(ONAM, 'Night Inner Boundary % (L)'),
    wbInteger(PNAM, 'Enable Flags', itU8, wbFlags([
      {0x01} 'Day Outer',
      {0x02} 'Day Middle',
      {0x04} 'Day Inner',
      {0x08} 'Night Outer',
      {0x10} 'Night Middle',
      {0x20} 'Night Inner'
    ])),
    wbFloat(DNAM, 'Wait Time (B) / Minimum Time On (D,L) / Daytime Min (I)'),
    wbFloat(ENAM, 'Loop Fade Out (B) / Looping/Random Crossfade Overlap (D,L) / Nighttime Min (I)'),
    wbFloat(FNAM, '恢复时间 (B) / Layer Crossfade Time (D,L) / Daytime Max (I)'),
    wbFloat(GNAM, 'Nighttime Max (I)'),
    wbFormIDCk(HNAM, 'Intro (B,D) / Daytime (I)', [SOUN]),
    wbFormIDCk(INAM, 'Outro (B,D) / Nighttime (I)', [SOUN]),
    wbUnknown(DATA)
  ]);

  wbRecord(AMEF, 'Ammo Effect', [
    wbEDIDReq,
    wbFULL,
    wbStruct(DATA, '数据', [
      wbInteger('类型', itU32, wbEnum([
        'Damage Mod',
        'DR Mod',
        'DT Mod',
        'Spread Mod',
        'Weapon Condition Mod',
        'Fatigue Mod'
      ])),
      wbInteger('Operation', itU32, wbEnum([
        '增加',
        '翻倍',
        '减少'
      ])),
      wbFloat('数值')
    ])
  ]);

  wbRecord(CCRD, 'Caravan Card', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbYNAM,
    wbZNAM,
    wbRStruct('High Res Image', [
      wbString(TX00, 'Face'),
      wbString(TX01, 'Back')
    ], []),
    wbRStruct('Card', [
      wbInteger(INTV, 'Suit', itU32, wbEnum([
        '',
        'Hearts',
        'Spades',
        'Diamonds',
        'Clubs',
        'Joker'
      ])),
      wbInteger(INTV, '数值', itU32, wbEnum([
        '',
        'Ace',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '',
        'Jack',
        'Queen',
        'King',
        'Joker'
      ]))
    ], []),
    wbInteger(DATA, '价值', itU32)
  ]);

  wbRecord(CDCK, 'Caravan Deck', [
    wbEDIDReq,
    wbFULL,
    wbRArrayS('Cards',
      wbFormIDCk(CARD, 'Card', [CCRD])
    ),
    wbInteger(DATA, 'Count (broken)', itU32)
  ]);

  wbRecord(CHAL, 'Challenge', [
    wbEDIDReq,
    wbFULL,
    wbSCRI,
    wbDESC,
    wbStruct(DATA, '数据', [
      wbInteger('类型', itU32, wbEnum([
        {00} 'Kill from a Form List',
        {01} 'Kill a specific FormID',
        {02} 'Kill any in a category',
        {03} 'Hit an Enemy',
        {04} 'Discover a Map Marker',
        {05} 'Use an Item',
        {06} 'Acquire an Item',
        {07} 'Use a Skill',
        {08} 'Do Damage',
        {09} 'Use an Item from a List',
        {10} 'Acquire an Item from a List',
        {11} 'Miscellaneous Stat',
        {12} 'Craft Using an Item',
        {13} 'Scripted Challenge'
      ])),
      wbInteger('Threshold', itU32),
      wbInteger('标志', itU32, wbFlags([
        'Start Disabled',
        'Recurring',
        'Show Zero Progress'
      ])),
      wbInteger('Interval', itU32),
      wbByteArray('(depends on type)', 2),
      wbByteArray('(depends on type)', 2),
      wbByteArray('(depends on type)', 4)
    ]),
    wbFormID(SNAM, '(depends on type)'),
    wbFormID(XNAM, '(depends on type)')
  ]);

  wbRecord(CHIP, 'Casino Chip', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbDEST,
    wbYNAM,
    wbZNAM
  ]);

  wbRecord(CMNY, 'Caravan Money', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbYNAM,
    wbZNAM,
    wbInteger(DATA, '绝对值', itU32)
  ]);

  wbRecord(CSNO, 'Casino', [
    wbEDIDReq,
    wbFULL,
    wbStruct(DATA, '数据', [
      wbFloat('Decks % Before Shuffle'),
      wbFloat('BlackJack Payout Ratio'),
      wbArray('Slot Reel Stops', wbInteger('Reel', itU32),[
        'Symbol 1',
        'Symbol 2',
        'Symbol 3',
        'Symbol 4',
        'Symbol 5',
        'Symbol 6',
        'Symbol W'
      ]),
      wbInteger('Number of Decks', itU32),
      wbInteger('Max Winnings', itU32),
      wbFormIDCk('Currency', [CHIP]),
      wbFormIDCk('Casino Winnings Quest', [QUST]),
      wbInteger('标志', itU32, wbFlags([
        'Dealer Stay on Soft 17'
      ]))
    ]),
    wbRStruct('Casino Chip Models', [
      wbString(MODL, '$1 Chip'),
      wbString(MODL, '$5 Chip'),
      wbString(MODL, '$10 Chip'),
      wbString(MODL, '$25 Chip'),
      wbString(MODL, '$100 Chip'),
      wbString(MODL, '$500 Chip'),
      wbString(MODL, 'Roulette Chip')
    ], []),
    wbString(MODL, 'Slot Machine Model'),
    wbString(MOD2, 'Slot Machine Model (again?)'),
    wbString(MOD3, 'BlackJack Table Model'),
    wbString(MOD4, 'Roulette Table Model'),
    wbRStruct('Slot Reel Textures', [
      wbString(ICON, 'Symbol 1'),
      wbString(ICON, 'Symbol 2'),
      wbString(ICON, 'Symbol 3'),
      wbString(ICON, 'Symbol 4'),
      wbString(ICON, 'Symbol 5'),
      wbString(ICON, 'Symbol 6'),
      wbString(ICON, 'Symbol W')
    ], []),
      wbRStruct('BlackJack Decks', [
      wbString(ICO2, 'Deck 1'),
      wbString(ICO2, 'Deck 2'),
      wbString(ICO2, 'Deck 3'),
      wbString(ICO2, 'Deck 4')
    ], [])
  ]);

  wbRecord(DEHY, 'Dehydration Stage', [
    wbEDIDReq,
    wbStruct(DATA, '', [
      wbInteger('Trigger Threshold', itU32),
      wbFormIDCk('魔法', [SPEL])
    ], cpNormal, True)
  ]);

  wbRecord(HUNG, 'Hunger Stage', [
    wbEDIDReq,
    wbStruct(DATA, '', [
      wbInteger('Trigger Threshold', itU32),
      wbFormIDCk('魔法', [SPEL])
    ], cpNormal, True)
  ]);

  wbRecord(LSCT, 'Load Screen Type', [
    wbEDIDReq,
    wbStruct(DATA, '数据', [
      wbInteger('类型', itU32, wbEnum([
        '无',
        'XP Progress',
        '目标',
        'Tip',
        'Stats'
      ])),
      wbStruct('Data 1', [
        wbInteger('X', itU32),
        wbInteger('Y', itU32),
        wbInteger('宽度', itU32),
        wbInteger('高度', itU32),
        wbFloat('Orientation', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbInteger('Font', itU32, wbEnum([
          '',
          '2',
          '3',
          '4',
          '5',
          '6',
          '7',
          '8'
        ])),
        wbStruct('Font Color', [
          wbFloat('R'),
          wbFloat('G'),
          wbFloat('B')
        ]),
        wbInteger('Font', itU32, wbEnum([
          '',
          '左',
          '中间',
          '',
          '右'
        ]))
      ]),
      wbByteArray('未知', 20),
      wbStruct('Data 2', [
        wbInteger('Font', itU32, wbEnum([
          '',
          '2',
          '3',
          '4',
          '5',
          '6',
          '7',
          '8'
        ])),
        wbStruct('Font Color', [
          wbFloat('R'),
          wbFloat('G'),
          wbFloat('B')
        ]),
        wbByteArray('', 4),
        wbInteger('Stats', itU32, wbEnum([
          '',
          '2',
          '3',
          '4',
          '5',
          '6',
          '7',
          '8'
        ]))
      ])
    ])
  ]);

  wbRecord(RCCT, 'Recipe Category', [
    wbEDIDReq,
    wbFULL,
    wbInteger(DATA, '标志', itU8, wbFlags([
      'Subcategory?',
      '',
      '',
      '',
      '',
      '',
      '',
      ''
    ]))
  ]);

  wbRecord(RCPE, 'Recipe', [
    wbEDIDReq,
    wbFULL,
    wbCTDAs,
    wbStruct(DATA, '数据', [
      wbInteger('技能', itS32, wbActorValueEnum),
      wbInteger('等级', itU32),
      wbFormIDCk('分类', [RCCT]),
      wbFormIDCk('Sub-Category', [RCCT])
    ]),
    wbRStructs('Ingredients', '原料', [
      wbFormIDCk(RCIL, '物品', [ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, NOTE, IMOD, CMNY, CCRD, CHIP, LIGH], False, cpNormal, True),
      wbInteger(RCQY, 'Quantity', itU32, nil, cpNormal, True)
    ], []),
    wbRStructs('Outputs', 'Output', [
      wbFormIDCk(RCOD, '物品', [ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, NOTE, IMOD, CMNY, CCRD, CHIP, LIGH], False, cpNormal, True),
      wbInteger(RCQY, 'Quantity', itU32, nil, cpNormal, True)
    ], [])
  ]);

  wbRecord(REPU, 'Reputation', [
    wbEDIDReq,
    wbFULL,
    wbICON,
    wbFloat(DATA, '数值')
  ]);

  wbRecord(SLPD, 'Sleep Deprivation Stage', [
    wbEDIDReq,
    wbStruct(DATA, '', [
      wbInteger('Trigger Threshold', itU32),
      wbFormIDCk('魔法', [SPEL])
    ], cpNormal, True)
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
  wbAddGroupOrder(CREA);
  wbAddGroupOrder(LVLC);
  wbAddGroupOrder(LVLN);
  wbAddGroupOrder(KEYM);
  wbAddGroupOrder(ALCH);
  wbAddGroupOrder(IDLM);
  wbAddGroupOrder(NOTE);
  wbAddGroupOrder(COBJ);
  wbAddGroupOrder(PROJ);
  wbAddGroupOrder(LVLI);
  wbAddGroupOrder(WTHR);
  wbAddGroupOrder(CLMT);
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
  wbAddGroupOrder(IMOD);
  wbAddGroupOrder(REPU);
  wbAddGroupOrder(RCPE);
  wbAddGroupOrder(RCCT);
  wbAddGroupOrder(CHIP);
  wbAddGroupOrder(CSNO);
  wbAddGroupOrder(LSCT);
  wbAddGroupOrder(MSET);
  wbAddGroupOrder(ALOC);
  wbAddGroupOrder(CHAL);
  wbAddGroupOrder(AMEF);
  wbAddGroupOrder(CCRD);
  wbAddGroupOrder(CMNY);
  wbAddGroupOrder(CDCK);
  wbAddGroupOrder(DEHY);
  wbAddGroupOrder(HUNG);
  wbAddGroupOrder(SLPD);
end;

procedure DefineFNV;
begin
  DefineFNVa;
  DefineFNVb;
  DefineFNVc;
  DefineFNVd;
  DefineFNVe;
  DefineFNVf;
end;

initialization
end.
