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

unit wbDefinitionsTES5;

interface

procedure DefineTES5;

implementation

uses
  Types, Classes, SysUtils, Math, Variants,
  wbInterface,
  wbLocalization,
  wbTES5ScriptDef;

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

//----------------------------------------------------------------------
// TES5-Team Place new entries in alphabetical order as much as possible
//----------------------------------------------------------------------

{00TX} _00_0TX: TwbSignature = #$30'0TX';
{10TX} _10_0TX: TwbSignature = #$31'0TX';
{20TX} _20_0TX: TwbSignature = #$32'0TX';
{30TX} _30_0TX: TwbSignature = #$33'0TX';
{40TX} _40_0TX: TwbSignature = #$34'0TX';
{50TX} _50_0TX: TwbSignature = #$35'0TX';
{60TX} _60_0TX: TwbSignature = #$36'0TX';
{70TX} _70_0TX: TwbSignature = #$37'0TX';
{80TX} _80_0TX: TwbSignature = #$38'0TX';
{90TX} _90_0TX: TwbSignature = #$39'0TX';
{:0TX} _3A_0TX: TwbSignature = #$3A'0TX';
{;0TX} _3B_0TX: TwbSignature = #$3B'0TX';
{<0TX} _3C_0TX: TwbSignature = #$3C'0TX';
{=0TX} _3D_0TX: TwbSignature = #$3D'0TX';
{>0TX} _3E_0TX: TwbSignature = #$3E'0TX';
{?0TX} _3F_0TX: TwbSignature = #$3F'0TX';
{@0TX} _40h_0TX: TwbSignature = #$40'0TX';
{A0TX} A0TX: TwbSignature = 'A0TX';
{B0TX} B0TX: TwbSignature = 'B0TX';
{C0TX} C0TX: TwbSignature = 'C0TX';
{D0TX} D0TX: TwbSignature = 'D0TX';
{E0TX} E0TX: TwbSignature = 'E0TX';
{F0TX} F0TX: TwbSignature = 'F0TX';
{G0TX} G0TX: TwbSignature = 'G0TX';
{H0TX} H0TX: TwbSignature = 'H0TX';
{I0TX} I0TX: TwbSignature = 'I0TX';
{J0TX} J0TX: TwbSignature = 'J0TX';
{K0TX} K0TX: TwbSignature = 'K0TX';
{L0TX} L0TX: TwbSignature = 'L0TX';

  AACT : TwbSignature = 'AACT';
  ACBS : TwbSignature = 'ACBS';
  ACEC : TwbSignature = 'ACEC'; { New To Dawnguard }
  ACEP : TwbSignature = 'ACEP'; { New To Dawnguard }
  ACHR : TwbSignature = 'ACHR';
  ACID : TwbSignature = 'ACID'; { New To Dawnguard }
  ACPR : TwbSignature = 'ACPR'; { New To Skyrim }
  ACRE : TwbSignature = 'ACRE';
  ACSR : TwbSignature = 'ACSR'; { New To Dawnguard }
  ACTI : TwbSignature = 'ACTI';
  ACUN : TwbSignature = 'ACUN'; { New To Dawnguard }
  ADDN : TwbSignature = 'ADDN';
  AHCF : TwbSignature = 'AHCF'; { New To Skyrim }
  AHCM : TwbSignature = 'AHCM'; { New To Skyrim }
  AIDT : TwbSignature = 'AIDT';
  ALCA : TwbSignature = 'ALCA'; { New To Skyrim }
  ALCH : TwbSignature = 'ALCH';
  ALCL : TwbSignature = 'ALCL'; { New To Skyrim }
  ALCO : TwbSignature = 'ALCO'; { New To Skyrim }
  ALDN : TwbSignature = 'ALDN'; { New To Skyrim }
  ALEA : TwbSignature = 'ALEA'; { New To Skyrim }
  ALED : TwbSignature = 'ALED'; { New To Skyrim }
  ALEQ : TwbSignature = 'ALEQ'; { New To Skyrim }
  ALFA : TwbSignature = 'ALFA'; { New To Skyrim }
  ALFC : TwbSignature = 'ALFC'; { New To Skyrim }
  ALFD : TwbSignature = 'ALFD'; { New To Skyrim }
  ALFE : TwbSignature = 'ALFE'; { New To Skyrim }
  ALFI : TwbSignature = 'ALFI'; { New To Skyrim }
  ALFL : TwbSignature = 'ALFL'; { New To Skyrim }
  ALFR : TwbSignature = 'ALFR'; { New To Skyrim }
  ALID : TwbSignature = 'ALID'; { New To Skyrim }
  ALLS : TwbSignature = 'ALLS'; { New To Skyrim }
  ALNA : TwbSignature = 'ALNA'; { New To Skyrim }
  ALNT : TwbSignature = 'ALNT'; { New To Skyrim }
  ALOC : TwbSignature = 'ALOC';
  ALPC : TwbSignature = 'ALPC'; { New To Skyrim }
  ALRT : TwbSignature = 'ALRT'; { New To Skyrim }
  ALSP : TwbSignature = 'ALSP'; { New To Skyrim }
  ALST : TwbSignature = 'ALST'; { New To Skyrim }
  ALUA : TwbSignature = 'ALUA'; { New To Skyrim }
  AMEF : TwbSignature = 'AMEF';
  AMMO : TwbSignature = 'AMMO';
  ANAM : TwbSignature = 'ANAM';
  ANIO : TwbSignature = 'ANIO';
  APPA : TwbSignature = 'APPA';
  ARMA : TwbSignature = 'ARMA';
  ARMO : TwbSignature = 'ARMO';
  ARTO : TwbSignature = 'ARTO';
  ASPC : TwbSignature = 'ASPC';
  ASTP : TwbSignature = 'ASTP';
  ATKD : TwbSignature = 'ATKD'; { New to Skyrim }
  ATKE : TwbSignature = 'ATKE'; { New to Skyrim }
  ATKR : TwbSignature = 'ATKR'; { New to Skyrim }
  ATTR : TwbSignature = 'ATTR';
  ATXT : TwbSignature = 'ATXT';
  AVIF : TwbSignature = 'AVIF';
  AVSK : TwbSignature = 'AVSK'; { New to Skyrim }
  BAMT : TwbSignature = 'BAMT'; { New to Skyrim }
  BIDS : TwbSignature = 'BIDS'; { New to Skyrim }
  BIPL : TwbSignature = 'BIPL';
  BMCT : TwbSignature = 'BMCT';
  BNAM : TwbSignature = 'BNAM';
  BODT : TwbSignature = 'BODT'; { New to Skyrim }
  BOOK : TwbSignature = 'BOOK';
  BPND : TwbSignature = 'BPND';
  BPNI : TwbSignature = 'BPNI';
  BPNN : TwbSignature = 'BPNN';
  BPNT : TwbSignature = 'BPNT';
  BPTD : TwbSignature = 'BPTD';
  BPTN : TwbSignature = 'BPTN';
  BRUS : TwbSignature = 'BRUS';
  BTXT : TwbSignature = 'BTXT';
  CAMS : TwbSignature = 'CAMS';
  CARD : TwbSignature = 'CARD';
  CCRD : TwbSignature = 'CCRD';
  CDCK : TwbSignature = 'CDCK';
  CELL : TwbSignature = 'CELL';
  CHAL : TwbSignature = 'CHAL';
  CHIP : TwbSignature = 'CHIP';
  CIS1 : TwbSignature = 'CIS1'; { New to Skyrim }
  CIS2 : TwbSignature = 'CIS2'; { New to Skyrim }
  CITC : TwbSignature = 'CITC'; { New to Skyrim }
  CLAS : TwbSignature = 'CLAS';
  CLDC : TwbSignature = 'CLDC'; { New to Skyrim }
  CLFM : TwbSignature = 'CLFM';
  CLMT : TwbSignature = 'CLMT';
  CMNY : TwbSignature = 'CMNY';
  CNAM : TwbSignature = 'CNAM';
  CNTO : TwbSignature = 'CNTO';
  COBJ : TwbSignature = 'COBJ';
  COCT : TwbSignature = 'COCT'; { New to Skyrim 'Count'}
  COED : TwbSignature = 'COED';
  COLL : TwbSignature = 'COLL';
  CONT : TwbSignature = 'CONT';
  CPTH : TwbSignature = 'CPTH';
  CRDT : TwbSignature = 'CRDT';
  CRGR : TwbSignature = 'CRGR'; { New to Skyrim }
  CRIF : TwbSignature = 'CRIF'; { New to Skyrim }
  CRVA : TwbSignature = 'CRVA'; { New to Skyrim }
  CSAD : TwbSignature = 'CSAD';
  CSCR : TwbSignature = 'CSCR';
  CSDC : TwbSignature = 'CSDC';
  CSDI : TwbSignature = 'CSDI';
  CSDT : TwbSignature = 'CSDT';
  CSFL : TwbSignature = 'CSFL'; { New to Skyrim }
  CSGD : TwbSignature = 'CSGD'; { New to Skyrim }
  CSLR : TwbSignature = 'CSLR'; { New to Skyrim }
  CSMD : TwbSignature = 'CSMD'; { New to Skyrim }
  CSME : TwbSignature = 'CSME'; { New to Skyrim }
  CSNO : TwbSignature = 'CSNO';
  CSSD : TwbSignature = 'CSSD';
  CSTD : TwbSignature = 'CSTD';
  CSTY : TwbSignature = 'CSTY';
  CTDA : TwbSignature = 'CTDA';
  DALC : TwbSignature = 'DALC'; { New to Skyrim }
  DAT2 : TwbSignature = 'DAT2';
  DATA : TwbSignature = 'DATA';
  DEBR : TwbSignature = 'DEBR';
  DEHY : TwbSignature = 'DEHY';
  DELE : TwbSignature = 'DELE';
  DEMO : TwbSignature = 'DEMO'; { New to Skyrim }
  DESC : TwbSignature = 'DESC';
  DEST : TwbSignature = 'DEST';
  DEVA : TwbSignature = 'DEVA'; { New to Skyrim }
  DFTF : TwbSignature = 'DFTF'; { New To Skyrim }
  DFTM : TwbSignature = 'DFTM'; { New To Skyrim }
  DIAL : TwbSignature = 'DIAL';
  DLBR : TwbSignature = 'DLBR';
  DLVW : TwbSignature = 'DLVW';
  DMAX : TwbSignature = 'DMAX'; { New to Skyrim }
  DMDL : TwbSignature = 'DMDL';
  DMDS : TwbSignature = 'DMDS'; { New to Skyrim }
  DMDT : TwbSignature = 'DMDT';
  DMIN : TwbSignature = 'DMIN'; { New to Skyrim }
  DNAM : TwbSignature = 'DNAM';
  DOBJ : TwbSignature = 'DOBJ';
  DODT : TwbSignature = 'DODT';
  DOFT : TwbSignature = 'DOFT'; { New to Skyrim }
  DOOR : TwbSignature = 'DOOR';
  DPLT : TwbSignature = 'DPLT'; { New to Skyrim }
  DSTD : TwbSignature = 'DSTD';
  DSTF : TwbSignature = 'DSTF';
  DUAL : TwbSignature = 'DUAL';
  EAMT : TwbSignature = 'EAMT';
  ECOR : TwbSignature = 'ECOR'; { New to Skyrim }
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
  EQUP : TwbSignature = 'EQUP';
  ESCE : TwbSignature = 'ESCE';
  ETYP : TwbSignature = 'ETYP';
  EXPL : TwbSignature = 'EXPL';
  EYES : TwbSignature = 'EYES';
  FACT : TwbSignature = 'FACT';
  FCHT : TwbSignature = 'FCHT'; { New to Skyrim }
  FGGA : TwbSignature = 'FGGA';
  FGGS : TwbSignature = 'FGGS';
  FGTS : TwbSignature = 'FGTS';
  FLMV : TwbSignature = 'FLMV'; { New to Skyrim }
  FLOR : TwbSignature = 'FLOR';
  FLST : TwbSignature = 'FLST';
  FLTR : TwbSignature = 'FLTR'; { New to Skyrim }
  FLTV : TwbSignature = 'FLTV';
  FNAM : TwbSignature = 'FNAM';
  FNMK : TwbSignature = 'FNMK'; { New to Skyrim }
  FNPR : TwbSignature = 'FNPR'; { New to Skyrim }
  FPRT : TwbSignature = 'FPRT'; { New to Skyrim }
  FSTP : TwbSignature = 'FSTP';
  FSTS : TwbSignature = 'FSTS';
  FTSF : TwbSignature = 'FTSF'; { New to Skyrim }
  FTSM : TwbSignature = 'FTSM'; { New to Skyrim }
  FTST : TwbSignature = 'FTST'; { New to Skyrim }
  FULL : TwbSignature = 'FULL';
  FURN : TwbSignature = 'FURN';
  GLOB : TwbSignature = 'GLOB';
  GMST : TwbSignature = 'GMST';
  GNAM : TwbSignature = 'GNAM';
  GRAS : TwbSignature = 'GRAS';
  GWOR : TwbSignature = 'GWOR'; { New to Skyrim }
  HAIR : TwbSignature = 'HAIR';
  HAZD : TwbSignature = 'HAZD';
  HCLF : TwbSignature = 'HCLF'; { New to Skyrim }
  HCLR : TwbSignature = 'HCLR';
  HDPT : TwbSignature = 'HDPT';
  HEAD : TwbSignature = 'HEAD'; { New to Skyrim }
  HEDR : TwbSignature = 'HEDR';
  HNAM : TwbSignature = 'HNAM';
  HTID : TwbSignature = 'HTID'; { New to Skyrim }
  HUNG : TwbSignature = 'HUNG';
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
  IMOD : TwbSignature = 'IMOD';
  IMPF : TwbSignature = 'IMPF';
  IMPS : TwbSignature = 'IMPS';
  IMSP : TwbSignature = 'IMSP'; { New to Skyrim }
  INAM : TwbSignature = 'INAM';
  INCC : TwbSignature = 'INCC'; { New to Skyrim }
  INDX : TwbSignature = 'INDX';
  INFC : TwbSignature = 'INFC';
  INFO : TwbSignature = 'INFO';
  INFX : TwbSignature = 'INFX';
  INGR : TwbSignature = 'INGR';
  INTV : TwbSignature = 'INTV';
  IPCT : TwbSignature = 'IPCT';
  IPDS : TwbSignature = 'IPDS';
  ITXT : TwbSignature = 'ITXT';
  JAIL : TwbSignature = 'JAIL'; { New To Skyrim }
  JNAM : TwbSignature = 'JNAM';
  JOUT : TwbSignature = 'JOUT'; { New To Skyrim }
  KEYM : TwbSignature = 'KEYM';
  KFFZ : TwbSignature = 'KFFZ';
  KNAM : TwbSignature = 'KNAM';
  KSIZ : TwbSignature = 'KSIZ';
  KWDA : TwbSignature = 'KWDA';
  KYWD : TwbSignature = 'KYWD';
  LAND : TwbSignature = 'LAND';
  LCEC : TwbSignature = 'LCEC'; { New to Skyrim }
  LCEP : TwbSignature = 'LCEP'; { New to Skyrim }
  LCID : TwbSignature = 'LCID'; { New to Skyrim }
  LCPR : TwbSignature = 'LCPR'; { New to Skyrim }
  LCRT : TwbSignature = 'LCRT';
  LCSR : TwbSignature = 'LCSR'; { New to Skyrim }
  LCTN : TwbSignature = 'LCTN';
  LCUN : TwbSignature = 'LCUN'; { New to Skyrim }
  LGTM : TwbSignature = 'LGTM';
  LIGH : TwbSignature = 'LIGH';
  LLCT : TwbSignature = 'LLCT'; {New to Skyrim, part of LVLI 'Count'}
  LNAM : TwbSignature = 'LNAM';
  LSCR : TwbSignature = 'LSCR';
  LSCT : TwbSignature = 'LSCT';
  LTEX : TwbSignature = 'LTEX';
  LTMP : TwbSignature = 'LTMP';
  LVLC : TwbSignature = 'LVLC';
  LVLD : TwbSignature = 'LVLD';
  LVLF : TwbSignature = 'LVLF';
  LVLG : TwbSignature = 'LVLG';
  LVLI : TwbSignature = 'LVLI';
  LVLN : TwbSignature = 'LVLN';
  LVLO : TwbSignature = 'LVLO';
  LVSP : TwbSignature = 'LVSP';
  MAST : TwbSignature = 'MAST';
  MATO : TwbSignature = 'MATO';
  MATT : TwbSignature = 'MATT';
  MCHT : TwbSignature = 'MCHT'; { New to Skyrim }
  MDOB : TwbSignature = 'MDOB';
  MESG : TwbSignature = 'MESG';
  MGEF : TwbSignature = 'MGEF';
  MHDT : TwbSignature = 'MHDT'; { New to Skyrim }
  MIC2 : TwbSignature = 'MIC2';
  MICN : TwbSignature = 'MICN';
  MICO : TwbSignature = 'MICO';
  MISC : TwbSignature = 'MISC';
  MMRK : TwbSignature = 'MMRK';
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
  MO5S : TwbSignature = 'MO5S'; { New to Skyrim }
  MO5T : TwbSignature = 'MO5T'; { New to Skyrim }
  MOD2 : TwbSignature = 'MOD2';
  MOD3 : TwbSignature = 'MOD3';
  MOD4 : TwbSignature = 'MOD4';
  MOD5 : TwbSignature = 'MOD5'; { New to Skyrim }
  MODB : TwbSignature = 'MODB';
  MODD : TwbSignature = 'MODD';
  MODL : TwbSignature = 'MODL';
  MODS : TwbSignature = 'MODS';
  MODT : TwbSignature = 'MODT';
  MOSD : TwbSignature = 'MOSD';
  MOVT : TwbSignature = 'MOVT';
  MPAI : TwbSignature = 'MPAI'; { New To Skyrim }
  MPAV : TwbSignature = 'MPAV'; { New To Skyrim }
  MPRT : TwbSignature = 'MPRT'; { New to Skyrim }
  MSET : TwbSignature = 'MSET';
  MSTT : TwbSignature = 'MSTT';
  MTNM : TwbSignature = 'MTNM'; { New to Skyrim }
  MTYP : TwbSignature = 'MTYP'; { New To Skyrim }
  MUSC : TwbSignature = 'MUSC';
  MUST : TwbSignature = 'MUST';
  MWD1 : TwbSignature = 'MWD1';
  MWD2 : TwbSignature = 'MWD2';
  MWD3 : TwbSignature = 'MWD3';
  MWD4 : TwbSignature = 'MWD4';
  MWD5 : TwbSignature = 'MWD5';
  MWD6 : TwbSignature = 'MWD6';
  MWD7 : TwbSignature = 'MWD7';
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
  NAMA : TwbSignature = 'NAMA'; { New to Skyrim }
  NAME : TwbSignature = 'NAME';
  NAVI : TwbSignature = 'NAVI';
  NAVM : TwbSignature = 'NAVM';
  NEXT : TwbSignature = 'NEXT';
  NIFT : TwbSignature = 'NIFT';
  NIFZ : TwbSignature = 'NIFZ';
  NNAM : TwbSignature = 'NNAM';
  NPC_ : TwbSignature = 'NPC_';
  NULL : TwbSignature = 'NULL';
  NVCA : TwbSignature = 'NVCA';
  NVCI : TwbSignature = 'NVCI';
  NVDP : TwbSignature = 'NVDP';
  NVER : TwbSignature = 'NVER';
  NVEX : TwbSignature = 'NVEX';
  NVGD : TwbSignature = 'NVGD';
  NVMI : TwbSignature = 'NVMI';
  NVNM : TwbSignature = 'NVNM'; { New to Skyrim }
  NVPP : TwbSignature = 'NVPP'; { New to Skyrim }
  NVSI : TwbSignature = 'NVSI'; { New to Dawnguard }
  NVTR : TwbSignature = 'NVTR';
  NVVX : TwbSignature = 'NVVX';
  OBND : TwbSignature = 'OBND';
  OCOR : TwbSignature = 'OCOR'; { New to Skyrim }
  OFST : TwbSignature = 'OFST';
  ONAM : TwbSignature = 'ONAM';
  OTFT : TwbSignature = 'OTFT';
  PACK : TwbSignature = 'PACK';
  PARW : TwbSignature = 'PARW'; { New to Skyrim }
  PCON : TwbSignature = 'PCON'; { New to Skyrim }
  PDTO : TwbSignature = 'PDTO'; { New to Skyrim }
  PERK : TwbSignature = 'PERK';
  PFIG : TwbSignature = 'PFIG';
  PFO2 : TwbSignature = 'PFO2'; { New to Skyrim }
  PFOR : TwbSignature = 'PFOR'; { New to Skyrim }
  PFPC : TwbSignature = 'PFPC';
  PGAG : TwbSignature = 'PGAG';
  PGRE : TwbSignature = 'PGRE';
  PGRI : TwbSignature = 'PGRI';
  PGRL : TwbSignature = 'PGRL';
  PGRP : TwbSignature = 'PGRP';
  PGRR : TwbSignature = 'PGRR';
  PHTN : TwbSignature = 'PHTN'; { New to Skyrim }
  PHWT : TwbSignature = 'PHWT'; { New to Skyrim }
  PHZD : TwbSignature = 'PHZD';
  PKC2 : TwbSignature = 'PKC2'; { New to Skyrim }
  PKCU : TwbSignature = 'PKCU'; { New to Skyrim }
  PKDT : TwbSignature = 'PKDT';
  PKID : TwbSignature = 'PKID';
  PLCN : TwbSignature = 'PLCN'; { New to Skyrim }
  PLDT : TwbSignature = 'PLDT';
  PLVD : TwbSignature = 'PLVD'; { New to Skyrim }
  PLYR : TwbSignature = 'PLYR';
  PMIS : TwbSignature = 'PMIS';
  PNAM : TwbSignature = 'PNAM';
  POBA : TwbSignature = 'POBA';
  POCA : TwbSignature = 'POCA';
  POEA : TwbSignature = 'POEA';
  PRCB : TwbSignature = 'PRCB'; { New to Skyrim }
  PRKC : TwbSignature = 'PRKC';
  PRKE : TwbSignature = 'PRKE';
  PRKF : TwbSignature = 'PRKF';
  PRKR : TwbSignature = 'PRKR'; { New to Skyrim }
  PRKZ : TwbSignature = 'PRKZ'; { New to Skyrim }
  PROJ : TwbSignature = 'PROJ';
  PSDT : TwbSignature = 'PSDT';
  PTDA : TwbSignature = 'PTDA'; { New to Skyrim }
  PTDT : TwbSignature = 'PTDT';
  PWAT : TwbSignature = 'PWAT';
  QNAM : TwbSignature = 'QNAM';
  QOBJ : TwbSignature = 'QOBJ';
  QSDT : TwbSignature = 'QSDT';
  QSTA : TwbSignature = 'QSTA';
  QSTI : TwbSignature = 'QSTI';
  QSTR : TwbSignature = 'QSTR';
  QTGL : TwbSignature = 'QTGL'; { New To Skyrim }
  QUAL : TwbSignature = 'QUAL'; { New To Skyrim }
  QUST : TwbSignature = 'QUST';
  RACE : TwbSignature = 'RACE';
  RADS : TwbSignature = 'RADS';
  RAFB : TwbSignature = 'RAFB';
  RAFD : TwbSignature = 'RAFD';
  RAGA : TwbSignature = 'RAGA';
  RAPS : TwbSignature = 'RAPS';
  RCCT : TwbSignature = 'RCCT';
  RCIL : TwbSignature = 'RCIL';
  RCLR : TwbSignature = 'RCLR';
  RCOD : TwbSignature = 'RCOD';
  RCPE : TwbSignature = 'RCPE';
  RCPR : TwbSignature = 'RCPR'; { New to Dawnguard }
  RCQY : TwbSignature = 'RCQY';
  RDAT : TwbSignature = 'RDAT';
  RDGS : TwbSignature = 'RDGS';
  RDID : TwbSignature = 'RDID';
  RDMD : TwbSignature = 'RDMD';
  RDMO : TwbSignature = 'RDMO';
  RDMP : TwbSignature = 'RDMP';
  RDOT : TwbSignature = 'RDOT';
  RDSA : TwbSignature = 'RDSA'; { New to Skyrim }
  RDSB : TwbSignature = 'RDSB';
  RDSD : TwbSignature = 'RDSD';
  RDSI : TwbSignature = 'RDSI';
  RDWT : TwbSignature = 'RDWT';
  REFR : TwbSignature = 'REFR';
  REGN : TwbSignature = 'REGN';
  RELA : TwbSignature = 'RELA';
  REPL : TwbSignature = 'REPL';
  REPU : TwbSignature = 'REPU';
  REVB : TwbSignature = 'REVB';
  RFCT : TwbSignature = 'RFCT';
  RGDL : TwbSignature = 'RGDL';
  RNAM : TwbSignature = 'RNAM';
  RNMV : TwbSignature = 'RNMV'; { New to Skyrim }
  RPLD : TwbSignature = 'RPLD';
  RPLI : TwbSignature = 'RPLI';
  RPRF : TwbSignature = 'RPRF'; { New To Skyrim }
  RPRM : TwbSignature = 'RPRM'; { New To Skyrim }
  SCDA : TwbSignature = 'SCDA';
  SCEN : TwbSignature = 'SCEN';
  SCHR : TwbSignature = 'SCHR';
  SCOL : TwbSignature = 'SCOL';
  SCPT : TwbSignature = 'SCPT';
  SCRI : TwbSignature = 'SCRI';
  SCRL : TwbSignature = 'SCRL';
  SCRN : TwbSignature = 'SCRN';
  SCRO : TwbSignature = 'SCRO';
  SCRV : TwbSignature = 'SCRV';
  SCTX : TwbSignature = 'SCTX';
  SCVR : TwbSignature = 'SCVR';
  SDSC : TwbSignature = 'SDSC'; { New to Skyrim }
  SHOU : TwbSignature = 'SHOU';
  SHRT : TwbSignature = 'SHRT'; { New to Skyrim }
  SLCP : TwbSignature = 'SLCP';
  SLGM : TwbSignature = 'SLGM';
  SLPD : TwbSignature = 'SLPD';
  SLSD : TwbSignature = 'SLSD';
  SMBN : TwbSignature = 'SMBN';
  SMEN : TwbSignature = 'SMEN';
  SMQN : TwbSignature = 'SMQN';
  SNAM : TwbSignature = 'SNAM';
  SNCT : TwbSignature = 'SNCT';
  SNDD : TwbSignature = 'SNDD';
  SNDR : TwbSignature = 'SNDR';
  SNDX : TwbSignature = 'SNDX';
  SNMV : TwbSignature = 'SNMV'; { New to Skyrim }
  SOFT : TwbSignature = 'SOFT'; { New to Skyrim }
  SOPM : TwbSignature = 'SOPM';
  SOUL : TwbSignature = 'SOUL';
  SOUN : TwbSignature = 'SOUN';
  SPCT : TwbSignature = 'SPCT'; { New to Skyrim }
  SPED : TwbSignature = 'SPED'; { New To Skyrim }
  SPEL : TwbSignature = 'SPEL';
  SPGD : TwbSignature = 'SPGD';
  SPIT : TwbSignature = 'SPIT';
  SPLO : TwbSignature = 'SPLO';
  SPMV : TwbSignature = 'SPMV'; { New To Skyrim }
  SPOR : TwbSignature = 'SPOR'; { New to Skyrim }
  STAT : TwbSignature = 'STAT';
  STOL : TwbSignature = 'STOL'; { New to Skyrim }
  SWMV : TwbSignature = 'SWMV'; { New to Skyrim }
  TACT : TwbSignature = 'TACT';
  TCFU : TwbSignature = 'TCFU';
  TCLF : TwbSignature = 'TCLF';
  TCLT : TwbSignature = 'TCLT';
  TDUM : TwbSignature = 'TDUM';
  TES4 : TwbSignature = 'TES4';
  TIAS : TwbSignature = 'TIAS'; { New to Skyrim }
  TIFC : TwbSignature = 'TIFC'; { New To Skyrim }
  TINC : TwbSignature = 'TINC'; { New to Skyrim }
  TIND : TwbSignature = 'TIND'; { New to Skyrim }
  TINI : TwbSignature = 'TINI'; { New to Skyrim }
  TINL : TwbSignature = 'TINL'; { New to Skyrim }
  TINP : TwbSignature = 'TINP'; { New to Skyrim }
  TINT : TwbSignature = 'TINT'; { New to Skyrim }
  TINV : TwbSignature = 'TINV'; { New to Skyrim }
  TIRS : TwbSignature = 'TIRS'; { New to Skyrim }
  TNAM : TwbSignature = 'TNAM';
  TPIC : TwbSignature = 'TPIC';
  TPLT : TwbSignature = 'TPLT';
  TRDT : TwbSignature = 'TRDT';
  TREE : TwbSignature = 'TREE';
  TRGT : TwbSignature = 'TRGT';
  TVDT : TwbSignature = 'TVDT'; { New To Skyrim }
  TWAT : TwbSignature = 'TWAT'; { New To Skyrim }
  TX00 : TwbSignature = 'TX00';
  TX01 : TwbSignature = 'TX01';
  TX02 : TwbSignature = 'TX02';
  TX03 : TwbSignature = 'TX03';
  TX04 : TwbSignature = 'TX04';
  TX05 : TwbSignature = 'TX05';
  TX06 : TwbSignature = 'TX06'; { New To Skyrim }
  TX07 : TwbSignature = 'TX07'; { New To Skyrim }
  TXST : TwbSignature = 'TXST';
  UNAM : TwbSignature = 'UNAM';
  UNES : TwbSignature = 'UNES'; { New To Skyrim }
  VANM : TwbSignature = 'VANM';
  VATS : TwbSignature = 'VATS';
  VCLR : TwbSignature = 'VCLR';
  VENC : TwbSignature = 'VENC'; { New To Skyrim }
  VEND : TwbSignature = 'VEND'; { New To Skyrim }
  VENV : TwbSignature = 'VENV'; { New To Skyrim }
  VHGT : TwbSignature = 'VHGT';
  VMAD : TwbSignature = 'VMAD';
  VNAM : TwbSignature = 'VNAM';
  VNML : TwbSignature = 'VNML';
  VTCK : TwbSignature = 'VTCK';
  VTEX : TwbSignature = 'VTEX';
  VTXT : TwbSignature = 'VTXT';
  VTYP : TwbSignature = 'VTYP';
  WAIT : TwbSignature = 'WAIT'; { New To Skyrim }
  WATR : TwbSignature = 'WATR';
  WBDT : TwbSignature = 'WBDT'; { New to Skyrim }
  WCTR : TwbSignature = 'WCTR'; { New To Skyrim }
  WEAP : TwbSignature = 'WEAP';
  WKMV : TwbSignature = 'WKMV'; { New to Skyrim }
  WLST : TwbSignature = 'WLST';
  WMI1 : TwbSignature = 'WMI1';
  WMI2 : TwbSignature = 'WMI2';
  WMI3 : TwbSignature = 'WMI3';
  WMS1 : TwbSignature = 'WMS1';
  WMS2 : TwbSignature = 'WMS2';
  WNAM : TwbSignature = 'WNAM';
  WNM1 : TwbSignature = 'WNM1';
  WNM2 : TwbSignature = 'WNM2';
  WNM3 : TwbSignature = 'WNM3';
  WNM4 : TwbSignature = 'WNM4';
  WNM5 : TwbSignature = 'WNM5';
  WNM6 : TwbSignature = 'WNM6';
  WNM7 : TwbSignature = 'WNM7';
  WOOP : TwbSignature = 'WOOP';
  WRLD : TwbSignature = 'WRLD';
  WTHR : TwbSignature = 'WTHR';
  XACT : TwbSignature = 'XACT';
  XALP : TwbSignature = 'XALP'; { New To Skyrim }
  XAMC : TwbSignature = 'XAMC';
  XAMT : TwbSignature = 'XAMT';
  XAPD : TwbSignature = 'XAPD';
  XAPR : TwbSignature = 'XAPR';
  XATO : TwbSignature = 'XATO';
  XATR : TwbSignature = 'XATR'; { New To Dawnguard }
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
  XCVL : TwbSignature = 'XCVL'; { New To Skyrim }
  XCWT : TwbSignature = 'XCWT';
  XCZA : TwbSignature = 'XCZA'; { New To Skyrim }
  XCZC : TwbSignature = 'XCZC'; { New To Skyrim }
  XDCR : TwbSignature = 'XDCR';
  XEMI : TwbSignature = 'XEMI';
  XESP : TwbSignature = 'XESP';
  XEZN : TwbSignature = 'XEZN';
  XFVC : TwbSignature = 'XFVC'; { New To Skyrim }
  XGLB : TwbSignature = 'XGLB';
  XHLP : TwbSignature = 'XHLP';
  XHLT : TwbSignature = 'XHLT';
  XHOR : TwbSignature = 'XHOR'; { New To Skyrim }
  XHTW : TwbSignature = 'XHTW'; { New To Skyrim }
  XIBS : TwbSignature = 'XIBS';
  XILL : TwbSignature = 'XILL'; { New To Skyrim }
  XIS2 : TwbSignature = 'XIS2'; { New To Skyrim }
  XLCM : TwbSignature = 'XLCM';
  XLCN : TwbSignature = 'XLCN'; { New To Skyrim }
  XLIB : TwbSignature = 'XLIB'; { New To Skyrim }
  XLIG : TwbSignature = 'XLIG'; { New To Skyrim }
  XLKR : TwbSignature = 'XLKR';
  XLOC : TwbSignature = 'XLOC';
  XLOD : TwbSignature = 'XLOD';
  XLRL : TwbSignature = 'XLRL'; { New To Skyrim }
  XLRM : TwbSignature = 'XLRM';
  XLRT : TwbSignature = 'XLRT'; { New To Skyrim }
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
  XPPA : TwbSignature = 'XPPA';
  XPRD : TwbSignature = 'XPRD';
  XPRM : TwbSignature = 'XPRM';
  XPTL : TwbSignature = 'XPTL';
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
  XSPC : TwbSignature = 'XSPC'; { New To Skyrim }
  XSRD : TwbSignature = 'XSRD';
  XSRF : TwbSignature = 'XSRF';
  XTEL : TwbSignature = 'XTEL';
  XTNM : TwbSignature = 'XTNM'; { New To Skyrim }
  XTRG : TwbSignature = 'XTRG';
  XTRI : TwbSignature = 'XTRI';
  XWEM : TwbSignature = 'XWEM'; { New To Skyrim }
  XWCN : TwbSignature = 'XWCN'; { New To Skyrim }
  XWCS : TwbSignature = 'XWCS'; { New To Skyrim }
  XWCU : TwbSignature = 'XWCU'; { New To Skyrim }
  XXXX : TwbSignature = 'XXXX';
  YNAM : TwbSignature = 'YNAM';
  ZNAM : TwbSignature = 'ZNAM';

var
  wbPKDTSpecificFlagsUnused : Boolean;
  wbEDID: IwbSubRecordDef;
  wbEDIDReq: IwbSubRecordDef;
  wbSoulGemEnum: IwbEnumDef;
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
  wbSCHRReq: IwbSubRecordDef;
  wbCTDA: IwbSubRecordStructDef;
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
  wbICO2: IwbSubRecordStructDef;
  wbSounds: IwbSubRecordStructDef;
  wbActorValue: IwbIntegerDef;
  wbModEffectEnum: IwbEnumDef;
  wbCrimeTypeEnum: IwbEnumDef;
  wbVatsValueFunctionEnum: IwbEnumDef;
  wbSkillEnum: IwbEnumDef;
  wbETYP: IwbSubRecordDef;
  wbETYPReq: IwbSubRecordDef;
  wbFormTypeEnum: IwbEnumDef;
  wbMenuModeEnum: IwbEnumDef;
  wbMiscStatEnum: IwbEnumDef;
  wbAdvanceActionEnum: IwbEnumDef;
  wbAlignmentEnum: IwbEnumDef;
  wbAxisEnum: IwbEnumDef;
  wbCastingSourceEnum: IwbEnumDef;
  wbCriticalStageEnum: IwbEnumDef;
  wbSexEnum: IwbEnumDef;
  wbServiceFlags: IwbFlagsDef;
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
//-----------------------------------------------------------------------------
// New
  wbBoolU8: IwbIntegerDef;
  wbBoolU16: IwbIntegerDef;
  wbBoolU32: IwbIntegerDef;
  wbBODT: IwbSubRecordDef;
  wbFULLFact: IwbSubRecordDef;
  wbScriptEntry: IwbStructDef;
  wbPropTypeEnum: IwbEnumDef;
  wbScriptObject: IwbStructDef;
  wbScriptFragments: IwbStructDef;
  wbEntryPointsEnum: IwbEnumDef;
  wbLocationEnum: IwbEnumDef;
  wbLocationData: IwbStructDef;
  wbTargetData: IwbStructDef;
  wbAttackData: IwbSubRecordStructDef; {Attack Data}
  wbLLCT: IwbSubRecordDef;
  wbLVLD: IwbSubRecordDef;
  wbVMAD: IwbSubRecordDef;
  wbCOCT: IwbSubRecordStructDef;
  wbCOCTReq: IwbSubRecordStructDef;
  wbKeywords: IwbSubRecordStructDef;
  wbCNAM: IwbSubRecordDef;
  wbCNAMReq: IwbSubRecordDef;
  wbCITC: IwbSubRecordDef; {Associated with CTDA}
  wbPRKR: IwbSubRecordDef; {Perk Array Record}
  wbDNAMActor: IwbSubRecordStructDef;
  wbMGEFData: IwbSubRecordStructDef;
  wbMGEFType: IwbStructDef;
  wbCastEnum: IwbEnumDef;
  wbTargetEnum: IwbEnumDef;
  wbRNAM: IwbSubRecordDef;
  wbSNAM: IwbSubRecordDef;
  wbQNAM: IwbSubRecordDef;
  wbMDOB: IwbSubRecordDef;
  wbSPIT: IwbSubRecordDef;
  wbSOPM_ONAM: IwbSubRecordStructDef;
  wbSNDD: IwbSubRecordUnionDef;
  wbDMDSs: IwbSubRecordDef;
  wbMO5S: IwbSubRecordDef;
  wbDMDL: IwbSubRecordDef;
  wbSizeIndexEnum: IwbEnumDef;
  wbSPCT: IwbSubRecordDef;
  wbTintMasks: IwbSubRecordArrayDef;
  wbMODT: IwbSubRecordDef;
  wbDMDT: IwbSubRecordDef;
  wbOwnership: IwbSubRecordStructDef;
  wbCELLDATAFlags: IwbFlagsDef;
  wbBipedObjectEnum: IwbEnumDef;
  wbArmorTypeEnum: IwbEnumDef;
  wbRACE_VNAMFlags: IwbIntegerDef;
  wbRACE_DATAFlags01: IwbIntegerDef;
  wbRACE_DATAFlags02: IwbIntegerDef;
  wbPhonemeTargets: IwbSubRecordDef;
  wbNoseMorphFlags: IwbIntegerDef;
  wbBrowMorphFlags: IwbIntegerDef;
  wbEyesMorphFlags01: IwbIntegerDef;
  wbEyesMorphFlags02: IwbIntegerDef;
  wbLipMorphFlags: IwbIntegerDef;
  wbPHWT: IwbSubRecordStructDef;
  wbMorphs: IwbSubRecordStructDef;
  wbSpells: IwbSubRecordStructDef;
  wbHeadPart: IwbSubRecordStructDef;
  wbTintMaskTypeEnum: IwbEnumDef;
  wbBODTOld: IwbSubRecordDef;
// --- Pack ---
  wbPKDTFlags: IwbFlagsDef;
  wbPKDTInterruptFlags: IwbFlagsDef;
  wbPKDT: IwbSubRecordDef;
  wbPSDT: IwbSubRecordDef;
  wbIDLF: IwbSubRecordStructDef;
  wbINAM: IwbSubRecordDef;
  wbPDTO: IwbSubRecordDef;
  wbPDTOs: IwbSubRecordArrayDef;
  wbUNAMs: IwbSubRecordArrayDef;

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
      ctToStr: begin
        Result := IntToStr(aInt);
        if Container.ElementExists['..\..\..\..\NVEX\Connection #' + IntToStr(aInt)] then
          Result := Result + ' (Triangle #' +
            Container.ElementValues['..\..\..\..\NVEX\Connection #' + IntToStr(aInt) + '\Triangle'] + ' in ' +
            Container.ElementValues['..\..\..\..\NVEX\Connection #' + IntToStr(aInt) + '\Navigation Mesh'] + ')'
        else
          Result := Result + ' <Error: NVEX\Connection #' + IntToStr(aInt) + ' is missing>';
      end;
      ctToSortKey:
        if Container.ElementExists['..\..\..\..\NVEX\Connection #' + IntToStr(aInt)] then
          Result :=
            Container.ElementSortKeys['..\..\..\..\NVEX\Connection #' + IntToStr(aInt) + '\Navigation Mesh', True] + '|' +
            Container.ElementSortKeys['..\..\..\..\NVEX\Connection #' + IntToStr(aInt) + '\Triangle', True];
      ctCheck:
        if Container.ElementExists['..\..\..\..\NVEX\Connection #' + IntToStr(aInt)] then
          Result := ''
        else
          Result := 'NVEX\Connection #' + IntToStr(aInt) + ' is missing';
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
    ctToStr: Result := IntToStr(aInt) + ' <Warning: Could not resolve Parameter 1>';
    ctToEditValue: Result := IntToStr(aInt);
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Parameter 1>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not Assigned(aElement) then
    Exit;

  if aElement.ElementType = etValue then
    Supports(aElement.Container, IwbContainerElementRef, Container)
  else
    Supports(aElement, IwbContainerElementRef, Container);

  if not Assigned(Container) then
    Exit;

  Param1 := Container.ElementByName['Parameter #1'];

  if not Assigned(Param1) then
    Exit;

  MainRecord := nil;
  if not Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
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
          j := LocalVar.ElementNativeValues['SLSD\Index'];
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

  if aElement.ElementType = etValue then
    Supports(aElement.Container, IwbContainerElementRef, Container)
  else
    Supports(aElement, IwbContainerElementRef, Container);

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
    ctToStr: Result := IntToStr(aInt) + ' <Warning: Could not resolve Parameter 1>';
    ctToEditValue: Result := IntToStr(aInt);
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Parameter 1>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not Assigned(aElement) then
    Exit;

  if aElement.ElementType = etValue then
    Supports(aElement.Container, IwbContainerElementRef, Container)
  else
    Supports(aElement, IwbContainerElementRef, Container);

  if not Assigned(Container) then
    Exit;

  Param1 := Container.ElementByName['Parameter #1'];

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

{>>> Needs revision for Skyrim <<<}
//function wbPerkDATAQuestStageToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
//var
//  Container  : IwbContainerElementRef;
//  Param1     : IwbElement;
//  MainRecord : IwbMainRecord;
//  EditInfos  : TStringList;
//  Stages     : IwbContainerElementRef;
//  Stage      : IwbContainerElementRef;
//  i, j       : Integer;
//  s, t       : string;
//begin
//  case aType of
//    ctToStr: Result := IntToStr(aInt) + ' <Warning: Could not resolve Quest>';
//    ctToEditValue: Result := IntToStr(aInt);
//    ctToSortKey: begin
//      Result := IntToHex64(aInt, 8);
//      Exit;
//    end;
//    ctCheck: Result := '<Warning: Could not resolve Quest>';
//    ctEditType: Result := '';
//    ctEditInfo: Result := '';
//  end;
//
//  if not Assigned(aElement) then
//    Exit;
//
//  if aElement.ElementType = etValue then
//    Supports(aElement.Container, IwbContainerElementRef, Container)
//  else
//    Supports(aElement, IwbContainerElementRef, Container);
//
//  if not Assigned(Container) then
//    Exit;
//
//  Param1 := Container.ElementByName['Quest'];
//
//  if not Assigned(Param1) then
//    Exit;
//
//  if not Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
//    Exit;
//
//  if MainRecord.Signature <> QUST then begin
//    case aType of
//      ctToStr: Result := IntToStr(aInt) + ' <Warning: "'+MainRecord.ShortName+'" is not a Quest record>';
//      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" is not a Quest record>';
//    end;
//    Exit;
//  end;
//
//  case aType of
//    ctEditType: begin
//      Result := 'ComboBox';
//      Exit;
//    end;
//    ctEditInfo:
//      EditInfos := TStringList.Create;
//  else
//    EditInfos := nil;
//  end;
//  try
//    if Supports(MainRecord.ElementByName['Stages'], IwbContainerElementRef, Stages) then begin
//      for i := 0 to Pred(Stages.ElementCount) do
//        if Supports(Stages.Elements[i], IwbContainerElementRef, Stage) then begin
//          j := Stage.ElementNativeValues['INDX\Stage Index'];
//          s := Trim(Stage.ElementValues['Log Entries\Log Entry\CNAM']);
//          t := IntToStr(j);
//          while Length(t) < 3 do
//            t := '0' + t;
//          if s <> '' then
//            t := t + ' ' + s;
//          if Assigned(EditInfos) then
//            EditInfos.AddObject(t, TObject(j))
//          else if j = aInt then begin
//            case aType of
//              ctToStr, ctToEditValue: Result := t;
//              ctCheck: Result := '';
//            end;
//            Exit;
//          end;
//        end;
//    end;
//
//    case aType of
//      ctToStr: Result := IntToStr(aInt) + ' <Warning: Quest Stage not found in "' + MainRecord.Name + '">';
//      ctCheck: Result := '<Warning: Quest Stage not found in "' + MainRecord.Name + '">';
//      ctEditInfo: begin
//        EditInfos.Sort;
//        Result := EditInfos.CommaText;
//      end;
//    end;
//  finally
//    FreeAndNil(EditInfos);
//  end;
//end;

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
    ctToStr: Result := IntToStr(aInt) + ' <Warning: Could not resolve Parameter 1>';
    ctToEditValue: Result := IntToStr(aInt);
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Parameter 1>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not Assigned(aElement) then
    Exit;

  if aElement.ElementType = etValue then
    Supports(aElement.Container, IwbContainerElementRef, Container)
  else
    Supports(aElement, IwbContainerElementRef, Container);

  if not Assigned(Container) then
    Exit;

  Param1 := Container.ElementByName['Parameter #1'];

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

  if not Assigned(wbCtdaTypeFlags) then
    wbCtdaTypeFlags := wbFlags([
      {0x01} 'Or',
      {0x02} 'Use aliases',
      {0x04} 'Use global',
      {0x08} 'Use packdata',
      {0x10} 'Swap Subject and Target'
    ]);

  case aType of
    ctEditType:
      Result := 'CheckComboBox';
    ctEditInfo: {>>> Needs revision for Skyrim <<<}
      Result := 'Equal,Greater,Lesser,Or,"Use Global","Run on Target"';
    ctToEditValue: begin  {>>> Needs revision for Skyrim <<<}
      Result := '000000';
      case aInt shr 5 of
        0 : Result[1] := '1';
        1 : Result[2] := '1';
        2 : begin
              Result[1] := '1';
              Result[2] := '1';
            end;
        3 : Result[3] := '1';
        4 : begin
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
      case aInt shr 5 of
        0 : Result := 'Equal to';
        1 : Result := 'Not equal to';
        2 : Result := 'Greater than';
        3 : Result := 'Greater than or equal to';
        4 : Result := 'Less than';
        5 : Result := 'Less than or equal to';
      else
        Result := '<Unknown Compare operator>'
      end;

      s := wbCtdaTypeFlags.ToString(aInt and $1F, aElement);
      if s <> '' then
        Result := Result + ' / ' + s;
    end;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2);
      Exit;
    end;
    ctCheck: begin
      case aInt shr 5 of
        0, 1, 2, 3, 4, 5 : Result := '';
      else
        Result := '<Unknown Compare operator>'
      end;

      s := wbCtdaTypeFlags.ToString(aInt and $1F, aElement);
      if s <> '' then
        Result := Result + ' / ' + s;
    end;
  end;
end;

{>>> Needs revision for Skyrim <<<}
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
      Container.RemoveElement('FormIDs');
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
    Container.ElementNativeValues['..\Comparison Value'] := 0;

  if aNewValue and $02 then begin
    Container.ElementNativeValues['..\Run On'] := 1;
    if Integer(Container.ElementNativeValues['..\Run On']) = 1 then
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

{>>> Needs revision for Skyrim <<<}
function wbIdleAnam(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '<Unknown: '+IntToStr(aInt)+'>';
//  Result := '';
//  case aType of
//    ctToStr: begin
//      case aInt and not $C0 of
//        0: Result := 'Idle';
//        1: Result := 'Movement';
//        2: Result := 'Left Arm';
//        3: Result := 'Left Hand';
//        4: Result := 'Weapon';
//        5: Result := 'Weapon Up';
//        6: Result := 'Weapon Down';
//        7: Result := 'Special Idle';
//       20: Result := 'Whole Body';
//       21: Result := 'Upper Body';
//      else
//        Result := '<Unknown: '+IntToStr(aInt and not $C0)+'>';
//      end;
//
//      if (aInt and $80) = 0 then
//        Result := Result + ', Must return a file';
//      if (aInt and $40) = 1 then
//        Result := Result + ', Unknown Flag';
//    end;
//    ctToSortKey: begin
//      Result := IntToHex64(aInt, 2);
//    end;
//    ctCheck: begin
//      case aInt and not $C0 of
//        0..7, 20, 21: Result := '';
//      else
//        Result := '<Unknown: '+IntToStr(aInt and not $C0)+'>';
//      end;
//    end;
//  end;
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
      Result := 'None'
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
      Result := '<Out of range: '+IntToStr(aInt)+'>'
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
        Ord('s'): Result := 'Short';
        Ord('l'): Result := 'Long';
        Ord('f'): Result := 'Float';
        Ord('b'): Result := 'Boolean';
      else
        Result := '<Unknown: '+IntToStr(aInt)+'>';
      end;
    end;
    ctToSortKey: Result := Chr(aInt);
    ctCheck: begin
      case aInt of
        Ord('s'), Ord('l'), Ord('f'), Ord('b'): Result := '';
      else
        Result := '<Unknown: '+IntToStr(aInt)+'>';
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
      Result := 'places ' + s;
  end;

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
end;

{>>>Needs Revision for Skyrim<<<}
//function wbINFOAddInfo(const aMainRecord: IwbMainRecord): string;
//var
//  Container: IwbContainer;
//  s: string;
//begin
//  Result := Trim(aMainRecord.ElementValues['Responses\Response\NAM1']);
//  if Result <> '' then
//    Result := '''' + Result + '''';
//
//  Container := aMainRecord.Container;
//  while Assigned(Container) and (Container.ElementType <> etGroupRecord) do
//    Container := Container.Container;
//
//  if Assigned(Container) then begin
//    s := Trim(Container.Name);
//    if s <> '' then begin
//      if Result <> '' then
//        Result := Result + ' ';
//      Result := Result + 'in ' + s;
//    end;
//  end;
//
//  s := Trim(aMainRecord.ElementValues['QSTI']);
//  if s <> '' then begin
//    if Result <> '' then
//      Result := Result + ' ';
//    Result := Result + 'for ' + s;
//  end;
//end;

function wbNAVMAddInfo(const aMainRecord: IwbMainRecord): string;
var
  Rec        : IwbRecord;
  Element    : IwbElement;
  s          : string;
begin
  Result := '';

  Rec := aMainRecord.RecordBySignature['DATA'];
  if Assigned(Rec) then begin
    Element := Rec.ElementByName['Cell'];
    if Assigned(Element) then
      Element := Element.LinksTo;
    if Assigned(Element) then
      s := Trim(Element.Name);
    if s <> '' then
      Result := 'for ' + s;
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
      Result := 'at ' + Rec.Elements[0].Value + ',' + Rec.Elements[1].Value;

  Container := aMainRecord.Container;
  while Assigned(Container) and not
    (Supports(Container, IwbGroupRecord, GroupRecord) and (GroupRecord.GroupType = 1))  do
    Container := Container.Container;

  if Assigned(Container) then begin
    s := wbFormID.ToString(GroupRecord.GroupLabel, aMainRecord);
    if s <> '' then begin
      if Result <> '' then
        s := s + ' ';
      Result := 'in ' + s + Result;
    end;
  end;
end;

function wbWthrDataClassification(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr: begin
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
    Assert(DataContainer.Name = 'Data');
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
    Assert(DataContainer.Name = 'Data');
    Result := PWord(Cardinal(DataContainer.DataBasePtr) + 3*3*4 + 2)^;
  end;
end;

procedure wbCTDARunOnAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  if aOldValue <> aNewValue then
    if aNewValue <> 2 then
      aElement.Container.ElementNativeValues['Reference'] := 0;
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
        Container.RemoveElement('Perk Conditions');
        Container.RemoveElement('Entry Point Function Parameters');
        if aNewValue = 2 then begin
          Container.Add('EPFT', True);
          Container.ElementNativeValues['DATA\Entry Point\Function'] := 2;
        end;
      end;
    end;
end;

function wbPHWTDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 2;
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;
  if Container.DateSize = 64 then Result := 0
  else if Container.DateSize = 32 then Result := 1
end;

function wbMGEFFAssocItemDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
  Archtype      : Variant;

begin
  Result := 0;
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;

  if not Assigned(Container) then
    Exit;

  ArchType := Container.ElementNativeValues['Archtype'];
  if VarIsEmpty(ArchType) then begin
    aBasePtr := Pointer(Cardinal(aBasePtr) + 56);
    if Cardinal(aEndPtr) >= (Cardinal(aBasePtr) + 4) then
      ArchType := PCardinal(aBasePtr)^;
  end;

  if VarIsEmpty(ArchType) then
    Result := 1
  else
(*
    1  wbFormIDCk('Assoc. Item', [LIGH]),
    2  wbFormIDCk('Assoc. Item', [WEAP, ARMO, NULL]),
    3  wbFormIDCk('Assoc. Item', [NPC_]),
    4  wbFormIDCk('Assoc. Item', [HAZD]),
    5  wbFormIDCk('Assoc. Item', [SPEL]),
    6  wbFormIDCk('Assoc. Item', [RACE]),
    7  wbFormIDCk('Assoc. Item', [ENCH])
    8  wbFormIDCk('Assoc. Item', [KYWD, NULL])
*)
    case Integer(ArchType) of
      12: Result := 1; // Light
      17: Result := 2; // Bound Item
      18: Result := 3; // Summon Creature
      25: Result := 4; // Guide
      34: Result := 8; // Peak Mod
      35: Result := 5; // Cloak
      36: Result := 6; // Werewolf
      39: Result := 7; // Enhance Weapon
      40: Result := 4; // Spawn Hazard
      46: Result := 6; // Vampire Lord
    end;
end;

{ Nees revision for Skyrim }
//procedure wbMGEFArchtypeAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
//var
//  Container: IwbContainerElementRef;
//begin
//  if VarSameValue(aOldValue, aNewValue) then
//    Exit;
//  if not Supports(aElement, IwbContainerElementRef, Container) then
//    Exit;
//  Container.ElementNativeValues['..\Assoc. Item'] := 0;
//  case Integer(aNewValue) of
//    11: Container.ElementNativeValues['..\Actor Value'] := 48;//Invisibility
//    12: Container.ElementNativeValues['..\Actor Value'] := 49;//Chameleon
//    24: Container.ElementNativeValues['..\Actor Value'] := 47;//Paralysis
//    36: Container.ElementNativeValues['..\Actor Value'] := 51;//Turbo
//  else
//    Container.ElementNativeValues['..\Actor Value'] := -1;
//  end;
//end;

function wbCTDAReferenceDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then
    Exit;

  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;

  if not Assigned(Container) then
    Exit;

  if Integer(Container.ElementNativeValues['Run On']) = 2 then
    Result := 1;
end;

function wbNAVINVMIDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
begin
  Result := 0;
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;

  if not Assigned(Container) then
    Exit;

  case Integer(Container.ElementNativeValues['Type']) of
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
  if not Assigned(aElement) then
    Exit;

  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;
  if Supports(Container.Container, IwbDataContainer, DataContainer) then begin
    if DataContainer.DateSize in [132, 148] then
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
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;

  LinksTo := Container.ElementByName['Owner'].LinksTo;

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
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;
  i := Container.ElementByName['Flags'].NativeValue;
  if i and $00000080 = 0 then
    Result := 0
  else
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
        's': Result := 0; {String} {>>> Localization Strings <<<}
        'i': Result := 1; {intS32}
        'f': Result := 2; {Float}
        'b': Result := 3; {Boolean}
      end;
  end;
end;

function wbCELLDATADecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 1;
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;
  if Container.DateSize = 1 then
    Result := 0;
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
  Result := True;
  rEDID := aContainer.RecordBySignature[EDID];
  if Assigned(rEDID) then begin
    s := rEDID.Value;
    if Length(s) > Length(OrderedList) then
      Delete(s, 1, Length(s)-Length(OrderedList));
    if SameText(s, OrderedList) then
      Result := False;
  end;
//  if Result then begin
//    MainRecord := aContainer.ContainingMainRecord;
//    if not Assigned(MainRecord) then
//      Exit;
//    MainRecord := MainRecord.MasterOrSelf;
//    if not Assigned(MainRecord) then
//      Exit;
//    _File := MainRecord._File;
//    if not Assigned(_File) then
//      Exit;
//    if not SameText(_File.FileName, 'WeaponModKits.esp') then
//      Exit;
//    case (MainRecord.FormID and $FFFFFF) of
//      $0130EB, $0130ED, $01522D, $01522E, $0158D5, $0158D6, $0158D7, $0158D8, $0158D9, $0158DA, $0158DC, $0158DD, $018E20:
//        Result := False;
//    end;
//  end;
end;

function wbPerkDATADecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  rPRKE: IwbRecord;
  eType: IwbElement;
begin
  Result := 0;
  rPRKE := aElement.Container.RecordBySignature[PRKE];
  if Assigned(rPRKE) then begin
    eType := rPRKE.ElementByName['Type'];
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
    case Integer(Container.ElementNativeValues['..\DATA\Entry Point\Function']) of
      5, 12, 13, 14: Result := 8;
    end;
end;

function wbScriptPropertyDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
begin
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;

  if not Assigned(Container) then Exit;

  Result := 0;
  case Integer(Container.ElementNativeValues['propertyType']) of
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

function wbScriptFragmentDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;
end;

function wbScriptFragmentsCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
begin
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;

  if not Assigned(Container) then Exit;

  Result := Integer(Container.ElementNativeValues['fragmentCount']);
end;

function wbBOOKTeachesDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
  i: Int64;
begin
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;
  i := Container.ElementByName['Flags'].NativeValue;
  if i and $00000004 <> 0 then Result := 1
    else Result := 0;
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
    ptInventoryObject,    //ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, ARMA
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
    ptCasino,             //CSNO
    ptKeyword,            //KYWD
    ptAdvanceAction,      // ?? Enum
    ptCastingSource,      // ?? Enum
    ptShout,              //SHOU
    ptLocation,           //LCTN
    ptRefType,            //LCRT
    ptAlias,              // ??
    ptFloat,              // float
    ptRelationship        // ASTP
  );

  PCTDAFunction = ^TCTDAFunction;
  TCTDAFunction = record
    Index: Integer;
    Name: string;
    ParamType1: TCTDAFunctionParamType;
    ParamType2: TCTDAFunctionParamType;
    ParamType3: TCTDAFunctionParamType;
  end;

const
  {>> N means New, V means verified that the name has not changed <<<}
  // last checked HasAssociationType
  wbCTDAFunctions : array[0..336] of TCTDAFunction = (
{N} (Index:   0; Name: 'GetWantBlocking'),
{V} (Index:   1; Name: 'GetDistance'; ParamType1: ptObjectReference),
{V} (Index:   5; Name: 'GetLocked'),
{V} (Index:   6; Name: 'GetPos'; ParamType1: ptAxis),
{V} (Index:   8; Name: 'GetAngle'; ParamType1: ptAxis),
{V} (Index:  10; Name: 'GetStartingPos'; ParamType1: ptAxis),
{V} (Index:  11; Name: 'GetStartingAngle'; ParamType1: ptAxis),
{V} (Index:  12; Name: 'GetSecondsPassed'),
{V} (Index:  14; Name: 'GetActorValue'; ParamType1: ptActorValue),
{V} (Index:  18; Name: 'GetCurrentTime'),
{V} (Index:  24; Name: 'GetScale'),
    (Index:  25; Name: 'IsMoving'),
    (Index:  26; Name: 'IsTurning'),
{V} (Index:  27; Name: 'GetLineOfSight'; ParamType1: ptObjectReference),
{V} (Index:  32; Name: 'GetInSameCell'; ParamType1: ptObjectReference),
{V} (Index:  35; Name: 'GetDisabled'),
    (Index:  36; Name: 'MenuMode'; ParamType1: ptMenuMode),
{V} (Index:  39; Name: 'GetDisease'),
    (Index:  40; Name: 'GetVampire'),
{V} (Index:  41; Name: 'GetClothingValue'),
    (Index:  42; Name: 'SameFaction'; ParamType1: ptActor),
    (Index:  43; Name: 'SameRace'; ParamType1: ptActor),
    (Index:  44; Name: 'SameSex'; ParamType1: ptActor),
{V} (Index:  45; Name: 'GetDetected'; ParamType1: ptActor),
{V} (Index:  46; Name: 'GetDead'),
{V} (Index:  47; Name: 'GetItemCount'; ParamType1: ptInventoryObject),
{V} (Index:  48; Name: 'GetGold'),
{V} (Index:  49; Name: 'GetSleeping'),
{V} (Index:  50; Name: 'GetTalkedToPC'),
{V} (Index:  53; Name: 'GetScriptVariable'; ParamType1: ptObjectReference; ParamType2: ptVariableName),
{V} (Index:  56; Name: 'GetQuestRunning'; ParamType1: ptQuest),
{V} (Index:  58; Name: 'GetStage'; ParamType1: ptQuest),
{V} (Index:  59; Name: 'GetStageDone'; ParamType1: ptQuest; ParamType2: ptQuestStage),
{V} (Index:  60; Name: 'GetFactionRankDifference'; ParamType1: ptFaction; ParamType2: ptActor),
{V} (Index:  61; Name: 'GetAlarmed'),
    (Index:  62; Name: 'IsRaining'),
{V} (Index:  63; Name: 'GetAttacked'),
{V} (Index:  64; Name: 'GetIsCreature'),
{V} (Index:  65; Name: 'GetLockLevel'),
{V} (Index:  66; Name: 'GetShouldAttack'; ParamType1: ptActor),
{V} (Index:  67; Name: 'GetInCell'; ParamType1: ptCell),
{V} (Index:  68; Name: 'GetIsClass'; ParamType1: ptClass),
{V} (Index:  69; Name: 'GetIsRace'; ParamType1: ptRace),
{V} (Index:  70; Name: 'GetIsSex'; ParamType1: ptSex), // needs more work on ptSex
{V} (Index:  71; Name: 'GetInFaction'; ParamType1: ptFaction),
{V} (Index:  72; Name: 'GetIsID'; ParamType1: ptReferencableObject),
{V} (Index:  73; Name: 'GetFactionRank'; ParamType1: ptFaction),
{V} (Index:  74; Name: 'GetGlobalValue'; ParamType1: ptGlobal),
    (Index:  75; Name: 'IsSnowing'),
    (Index:  76; Name: 'GetDisposition'; ParamType1: ptActor),
{V} (Index:  77; Name: 'GetRandomPercent'),
{V} (Index:  79; Name: 'GetQuestVariable'; ParamType1: ptQuest; ParamType2: ptVariableName),
{V} (Index:  80; Name: 'GetLevel'),
    (Index:  81; Name: 'GetArmorRating'),
{V} (Index:  84; Name: 'GetDeadCount'; ParamType1: ptActorBase),
{V} (Index:  91; Name: 'GetIsAlerted'),
{V} (Index:  98; Name: 'GetPlayerControlsDisabled'; ParamType1: ptInteger; ParamType2: ptInteger{; ParamType3: ptInteger; ParamType4: ptInteger; ParamType5: ptInteger; ParamType6: ptInteger; ParamType7: ptInteger}),
{V} (Index:  99; Name: 'GetHeadingAngle'; ParamType1: ptObjectReference),
    (Index: 101; Name: 'IsWeaponOut'),
    (Index: 102; Name: 'IsTorchOut'),
    (Index: 103; Name: 'IsShieldOut'),
    (Index: 106; Name: 'IsFacingUp'),
{V} (Index: 107; Name: 'GetKnockedState'),
{V} (Index: 108; Name: 'GetWeaponAnimType'),
    (Index: 109; Name: 'IsWeaponSkillType'; ParamType1: ptActorValue),
{V} (Index: 110; Name: 'GetCurrentAIPackage'),
    (Index: 111; Name: 'IsWaiting'),
    (Index: 112; Name: 'IsIdlePlaying'),
    (Index: 116; Name: 'GetMinorCrimeCount'),
    (Index: 117; Name: 'GetMajorCrimeCount'),
{V} (Index: 118; Name: 'GetActorAggroRadiusViolated'),
{V} (Index: 122; Name: 'GetCrime'; ParamType1: ptActor; ParamType2: ptCrimeType),
    (Index: 123; Name: 'IsGreetingPlayer'),
    (Index: 125; Name: 'IsGuard'),
    (Index: 127; Name: 'HasBeenEaten'),
{V} (Index: 128; Name: 'GetStaminaPercentage'),
{V} (Index: 129; Name: 'GetPCIsClass'; ParamType1: ptClass),
{V} (Index: 130; Name: 'GetPCIsRace'; ParamType1: ptRace),
{V} (Index: 131; Name: 'GetPCIsSex'; ParamType1: ptSex),
{V} (Index: 132; Name: 'GetPCInFaction'; ParamType1: ptFaction),
    (Index: 133; Name: 'SameFactionAsPC'),
    (Index: 134; Name: 'SameRaceAsPC'),
    (Index: 135; Name: 'SameSexAsPC'),
{V} (Index: 136; Name: 'GetIsReference'; ParamType1: ptObjectReference),
    (Index: 141; Name: 'IsTalking'),
{V} (Index: 142; Name: 'GetWalkSpeed'),
{V} (Index: 143; Name: 'GetCurrentAIProcedure'),
{V} (Index: 144; Name: 'GetTrespassWarningLevel'),
    (Index: 145; Name: 'IsTrespassing'),
    (Index: 146; Name: 'IsInMyOwnedCell'),
{V} (Index: 147; Name: 'GetWindSpeed'),
{V} (Index: 148; Name: 'GetCurrentWeatherPercent'),
{V} (Index: 149; Name: 'GetIsCurrentWeather'; ParamType1: ptWeather),
    (Index: 150; Name: 'IsContinuingPackagePCNear'),
{N} (Index: 152; Name: 'GetIsCrimeFaction'; ParamType1: ptFaction),
{V} (Index: 153; Name: 'CanHaveFlames'),
    (Index: 154; Name: 'HasFlames'),
{V} (Index: 157; Name: 'GetOpenState'),
{V} (Index: 159; Name: 'GetSitting'),
    (Index: 160; Name: 'GetFurnitureMarkerID'),
{V} (Index: 161; Name: 'GetIsCurrentPackage'; ParamType1: ptPackage),
    (Index: 162; Name: 'IsCurrentFurnitureRef'; ParamType1: ptObjectReference),
    (Index: 163; Name: 'IsCurrentFurnitureObj'; ParamType1: ptFurniture),
{V} (Index: 170; Name: 'GetDayOfWeek'),
{V} (Index: 172; Name: 'GetTalkedToPCParam'; ParamType1: ptActor),
    (Index: 175; Name: 'IsPCSleeping'),
    (Index: 176; Name: 'IsPCAMurderer'),
    (Index: 180; Name: 'GetDetectionLevel'; ParamType1: ptActor),
{V} (Index: 182; Name: 'GetEquipped'; ParamType1: ptInventoryObject),
    (Index: 185; Name: 'IsSwimming'),
{V} (Index: 190; Name: 'GetAmountSoldStolen'),
{V} (Index: 192; Name: 'GetIgnoreCrime'),
{V} (Index: 193; Name: 'GetPCExpelled'; ParamType1: ptFaction),
{V} (Index: 195; Name: 'GetPCFactionMurder'; ParamType1: ptFaction),
{V} (Index: 197; Name: 'GetPCEnemyofFaction'; ParamType1: ptFaction),
{V} (Index: 199; Name: 'GetPCFactionAttack'; ParamType1: ptFaction),
{V} (Index: 203; Name: 'GetDestroyed'),
    (Index: 214; Name: 'HasMagicEffect'; ParamType1: ptMagicEffect),
{V} (Index: 215; Name: 'GetDefaultOpen'),
{V} (Index: 219; Name: 'GetAnimAction'),
    (Index: 223; Name: 'IsSpellTarget'; ParamType1: ptMagicItem),
{V} (Index: 224; Name: 'GetVATSMode'),
{V} (Index: 225; Name: 'GetPersuasionNumber'),
{V} (Index: 226; Name: 'GetVampireFeed'),
{V} (Index: 227; Name: 'GetCannibal'),
{V} (Index: 228; Name: 'GetIsClassDefault'; ParamType1: ptClass),
{V} (Index: 229; Name: 'GetClassDefaultMatch'),
{V} (Index: 230; Name: 'GetInCellParam'; ParamType1: ptCell; ParamType2: ptObjectReference),
{V} (Index: 235; Name: 'GetVatsTargetHeight'),
{V} (Index: 237; Name: 'GetIsGhost'),
{V} (Index: 242; Name: 'GetUnconscious'),
{V} (Index: 244; Name: 'GetRestrained'),
{V} (Index: 246; Name: 'GetIsUsedItem'; ParamType1: ptReferencableObject),
{V} (Index: 247; Name: 'GetIsUsedItemType'; ParamType1: ptFormType), // needs more work
{N} (Index: 250; Name: 'GetLocationCleared'; ParamType1: ptLocation),
{V} (Index: 254; Name: 'GetIsPlayableRace'),
{V} (Index: 255; Name: 'GetOffersServicesNow'),
{N} (Index: 258; Name: 'HasAssociationType'; ParamType1: ptActor; ParamType2: ptRelationship),
    (Index: 259; Name: 'GetUsedItemActivate'),
    (Index: 264; Name: 'GetBarterGold'),
    (Index: 265; Name: 'IsTimePassing'),
    (Index: 266; Name: 'IsPleasant'),
    (Index: 267; Name: 'IsCloudy'),
    (Index: 274; Name: 'GetArmorRatingUpperBody'),
{V} (Index: 277; Name: 'GetBaseActorValue'; ParamType1: ptActorValue),
    (Index: 278; Name: 'IsOwner'; ParamType1: ptOwner),
    (Index: 280; Name: 'IsCellOwner'; ParamType1: ptCell; ParamType2: ptOwner),
    (Index: 282; Name: 'IsHorseStolen'),
    (Index: 285; Name: 'IsLeftUp'),
    (Index: 286; Name: 'IsSneaking'),
    (Index: 287; Name: 'IsRunning'),
{V} (Index: 288; Name: 'GetFriendHit'),
    (Index: 289; Name: 'IsInCombat'),
    (Index: 300; Name: 'IsInInterior'),
    (Index: 304; Name: 'IsWaterObject'),
{N} (Index: 305; Name: 'GetPlayerAction'),
    (Index: 306; Name: 'IsActorUsingATorch'),
    (Index: 309; Name: 'IsXBox'),
{V} (Index: 310; Name: 'GetInWorldspace'; ParamType1: ptWorldSpace),
{V} (Index: 312; Name: 'GetPCMiscStat'; ParamType1: ptMiscStat),
{N} (Index: 313; Name: 'GetPairedAnimation'),
    (Index: 314; Name: 'IsActorAVictim'),
{V} (Index: 315; Name: 'GetTotalPersuasionNumber'),
{V} (Index: 318; Name: 'GetIdleDoneOnce'),
{V} (Index: 320; Name: 'GetNoRumors'),
{N} (Index: 323; Name: 'GetCombatState'),
{N} (Index: 325; Name: 'GetWithinPackageLocation'; ParamType1: ptPackage),
    (Index: 327; Name: 'IsRidingHorse'),
    (Index: 332; Name: 'IsInDangerousWater'),
{V} (Index: 338; Name: 'GetIgnoreFriendlyHits'),
    (Index: 339; Name: 'IsPlayersLastRiddenHorse'),
    (Index: 353; Name: 'IsActor'),
    (Index: 354; Name: 'IsEssential'),
    (Index: 358; Name: 'IsPlayerMovingIntoNewSpace'),
{N} (Index: 359; Name: 'GetInCurrentLoc'; ParamType1: ptLocation),
{N} (Index: 360; Name: 'GetInCurrentLocAlias'; ParamType1: ptAlias), // needs more work
{V} (Index: 361; Name: 'GetTimeDead'),
    (Index: 362; Name: 'GetPlayerHasLastRiddenHorse'),
    (Index: 365; Name: 'IsChild'),
{N} (Index: 366; Name: 'GetStolenItemValueNoCrime'; ParamType1: ptFaction),
{V} (Index: 367; Name: 'GetLastPlayerAction'),
    (Index: 368; Name: 'IsPlayerActionActive'; ParamType1: ptPlayerAction),
    (Index: 370; Name: 'IsTalkingActivatorActor'; ParamType1: ptActor),
    (Index: 372; Name: 'IsInList'; ParamType1: ptFormList),
{N} (Index: 373; Name: 'GetStolenItemValue'; ParamType1: ptFaction),
{N} (Index: 375; Name: 'GetCrimeGoldViolent'),
{N} (Index: 376; Name: 'GetCrimeGoldNonviolent'),
{V} (Index: 381; Name: 'GetHasNote'; ParamType1: ptNote),
{V} (Index: 390; Name: 'GetHitLocation'),
    (Index: 392; Name: 'IsPC1stPerson'),
{V} (Index: 396; Name: 'GetCauseofDeath'),
    (Index: 398; Name: 'IsLimbGone'; ParamType1: ptBodyLocation),
    (Index: 399; Name: 'IsWeaponInList'; ParamType1: ptFormList),
{V} (Index: 403; Name: 'GetRelationshipRank'; ParamType1: ptObjectReference),
{V} (Index: 407; Name: 'GetVATSValue'; ParamType1: ptVATSValueFunction; ParamType2: ptVATSValueParam),
    (Index: 409; Name: 'IsKiller'; ParamType1: ptActor),
//    (Index: 410; Name: 'IsKillerObject'; ParamType1: ptFormList),
{V} (Index: 410; Name: 'GetFactionCombatReaction'; ParamType1: ptFaction; ParamType2: ptFaction),
{V} (Index: 414; Name: 'Exists'; ParamType1: ptObjectReference),
{V} (Index: 415; Name: 'GetGroupMemberCount'),
{V} (Index: 416; Name: 'GetGroupTargetCount'),
    (Index: 420; Name: 'GetObjectiveCompleted'; ParamType1: ptQuest; ParamType2: ptQuestObjective),
    (Index: 421; Name: 'GetObjectiveDisplayed'; ParamType1: ptQuest; ParamType2: ptQuestObjective),
{V} (Index: 426; Name: 'GetIsVoiceType'; ParamType1: ptVoiceType),
{V} (Index: 427; Name: 'GetPlantedExplosive'),
    (Index: 429; Name: 'IsActorTalkingThroughActivator'),
{V} (Index: 430; Name: 'GetHealthPercentage'),
{V} (Index: 432; Name: 'GetIsObjectType'; ParamType1: ptFormType), // needs more work on formtype
{V} (Index: 434; Name: 'GetDialogueEmotion'),
{V} (Index: 436; Name: 'GetDialogueEmotionValue'),
{V} (Index: 437; Name: 'GetIsCreatureType'; ParamType1: ptInteger),
{N} (Index: 444; Name: 'GetInCurrentLocFormList'; ParamType1: ptFormList),
{V} (Index: 445; Name: 'GetInZone'; ParamType1: ptEncounterZone),
{N} (Index: 446; Name: 'GetVelocity'; ParamType1: ptAxis),
{N} (Index: 447; Name: 'GetGraphVariableFloat'; ParamType1: ptVariableName),
    (Index: 448; Name: 'HasPerk'; ParamType1: ptPerk; ParamType2: ptInteger{Alt?}),
{V} (Index: 449; Name: 'GetFactionRelation'; ParamType1: ptActor),
    (Index: 451; Name: 'IsLastIdlePlayed'; ParamType1: ptIdleForm),
{V} (Index: 453; Name: 'GetPlayerTeammate'),
{V} (Index: 454; Name: 'GetPlayerTeammateCount'),
{V} (Index: 458; Name: 'GetActorCrimePlayerEnemy'),
{V} (Index: 459; Name: 'GetCrimeGold'),
    (Index: 460; Name: 'GetActorFactionPlayerEnemy'),
    (Index: 462; Name: 'IsPlayerTagSkill'; ParamType1: ptActorValue),
    (Index: 464; Name: 'IsPlayerGrabbedRef'; ParamType1: ptObjectReference),
{N} (Index: 465; Name: 'GetKeywordItemCount'; ParamType1: ptKeyword),
{V} (Index: 470; Name: 'GetDestructionStage'),
{V} (Index: 473; Name: 'GetIsAlignment'; ParamType1: ptAlignment),
{V} (Index: 477; Name: 'GetThreatRatio'; ParamType1: ptActor),
{V} (Index: 479; Name: 'GetIsUsedItemEquipType'; ParamType1: ptEquipType),
{V} (Index: 488; Name: 'GetConcussed'),
{V} (Index: 491; Name: 'GetMapMarkerVisible'),
{V} (Index: 494; Name: 'GetPermanentActorValue'; ParamType1: ptActorValue),
{V} (Index: 495; Name: 'GetKillingBlowLimb'),
{N} (Index: 497; Name: 'CanPayCrimeGold'),
{N} (Index: 499; Name: 'GetDaysInJail'),
{N} (Index: 500; Name: 'EPAlchemyGetMakingPoison'),
{N} (Index: 501; Name: 'EPAlchemyEffectHasKeyword'; ParamType1: ptKeyword),
{N} (Index: 503; Name: 'GetAllowWorldInteractions'),
{V} (Index: 508; Name: 'GetLastHitCritical'),
{V} (Index: 515; Name: 'GetVATSRightAreaFree'; ParamType1: ptObjectReference),
{V} (Index: 516; Name: 'GetVATSLeftAreaFree'; ParamType1: ptObjectReference),
{V} (Index: 517; Name: 'GetVATSBackAreaFree'; ParamType1: ptObjectReference),
{V} (Index: 518; Name: 'GetVATSFrontAreaFree'; ParamType1: ptObjectReference),
{N} (Index: 519; Name: 'GetLockIsBroken'),
    (Index: 521; Name: 'IsCombatTarget'; ParamType1: ptActor),
{V} (Index: 522; Name: 'GetVATSRightTargetVisible'; ParamType1: ptObjectReference),
{V} (Index: 523; Name: 'GetVATSLeftTargetVisible'; ParamType1: ptObjectReference),
{V} (Index: 524; Name: 'GetVATSBackTargetVisible'; ParamType1: ptObjectReference),
{V} (Index: 525; Name: 'GetVATSFrontTargetVisible'; ParamType1: ptObjectReference),
    (Index: 526; Name: 'IsPS3'),
    (Index: 527; Name: 'CTDA1'; ParamType1: ptObjectReference),
    (Index: 528; Name: 'GetIsLockBroken'),
{N} (Index: 530; Name: 'GetXPForNextLevel'),
    (Index: 531; Name: 'IsInCriticalStage'; ParamType1: ptCriticalStage),
{N} (Index: 533; Name: 'GetInfamy'),
{N} (Index: 534; Name: 'GetInfamyViolent'),
{N} (Index: 535; Name: 'GetInfamyNonViolent'),
{V} (Index: 543; Name: 'GetQuestCompleted'; ParamType1: ptQuest),
    (Index: 550; Name: 'IsGoreDisabled'),
{V} (Index: 552; Name: 'GetSpellUsageNum'; ParamType1: ptMagicItem),
{N} (Index: 554; Name: 'GetActorInHigh'),
    (Index: 557; Name: 'GetActorsInHigh'),
    (Index: 558; Name: 'HasLoaded3D'),
{N} (Index: 565; Name: 'GetIsEditorLocation'; ParamType1: ptLocation),
{N} (Index: 566; Name: 'GetIsAliasRef'; ParamType1: ptAlias), // needs more work
{N} (Index: 567; Name: 'GetIsEditorLocAlias'; ParamType1: ptAlias), // needs more work
{N} (Index: 571; Name: 'GetCurrentCastingType'; ParamType1: ptCastingSource),
{N} (Index: 572; Name: 'GetCurrentDeliveryType'; ParamType1: ptCastingSource),
    (Index: 573; Name: 'GetReputation'; ParamType1: ptReputation; ParamType2: ptInteger),
{N} (Index: 574; Name: 'GetAttackState'),
    (Index: 575; Name: 'GetReputationThreshold'; ParamType1: ptReputation; ParamType2: ptInteger),
{N} (Index: 576; Name: 'GetEventData'; ParamType1: ptNone; ParamType2: ptNone; ParamType3: ptNone), // needs more work
{N} (Index: 579; Name: 'GetEquippedShout'; ParamType1: ptShout),
{N} (Index: 584; Name: 'GetRelativeAngle'; ParamType1: ptObjectReference; ParamType2: ptAxis),
    (Index: 586; Name: 'IsHardcore'),
{N} (Index: 589; Name: 'GetMovementDirection'),
{N} (Index: 591; Name: 'GetRefTypeDeadCount'; ParamType1: ptLocation; ParamType2: ptRefType),
{N} (Index: 592; Name: 'GetRefTypeAliveCount'; ParamType1: ptLocation; ParamType2: ptRefType),
{N} (Index: 594; Name: 'GetIsFlying'),
{N} (Index: 597; Name: 'GetEquippedItemType'; ParamType1: ptCastingSource),
{N} (Index: 598; Name: 'GetLocationAliasCleared'; ParamType1: ptAlias),
{N} (Index: 600; Name: 'GetLocAliasRefTypeDeadCount'; ParamType1: ptAlias; ParamType2: ptRefType),
{N} (Index: 601; Name: 'GetLocAliasRefTypeAliveCount'; ParamType1: ptAlias; ParamType2: ptRefType),
{N} (Index: 606; Name: 'GetKeywordDataForLocation'; ParamType1: ptLocation; ParamType2: ptkeyword),
    (Index: 607; Name: 'ChallengeLocked'; ParamType1: ptChallenge),
{N} (Index: 608; Name: 'GetKeywordDataForAlias'; ParamType1: ptAlias; ParamType2: ptKeyword),
    (Index: 610; Name: 'GetCasinoWinningStage'; ParamType1: ptCasino),
{N} (Index: 612; Name: 'GetNumericPackageData'; ParamType1: ptPackage),
    (Index: 614; Name: 'GetChallengeCompleted'; ParamType1: ptChallenge),
{N} (Index: 615; Name: 'GetHighestRelationshipRank'),
{N} (Index: 616; Name: 'GetLowestRelationshipRank'),
{N} (Index: 619; Name: 'GetPathingTargetOffset'; ParamType1: ptAxis),
{N} (Index: 620; Name: 'GetPathingTargetAngleOffset'; ParamType1: ptAxis),
{N} (Index: 621; Name: 'GetPathingTargetSpeed'),
{N} (Index: 622; Name: 'GetPathingTargetSpeedAngle'; ParamType1: ptAxis),
{N} (Index: 623; Name: 'GetMovementSpeed'),
{N} (Index: 624; Name: 'GetInContainer'; ParamType1: ptInventoryObject),
{N} (Index: 629; Name: 'GetVMQuestVariable'; ParamType1: ptQuest; ParamType2: ptVariableName),
{N} (Index: 630; Name: 'GetVMScriptVariable'; ParamType1: ptObjectReference; ParamType2: ptVariableName),
{N} (Index: 633; Name: 'GetFlyingState'),
{N} (Index: 639; Name: 'GetWithinDistance'; ParamType1: ptObjectReference; ParamType2: ptFloat),
{N} (Index: 640; Name: 'GetActorValuePercent'; ParamType1: ptActorValue),
{N} (Index: 642; Name: 'GetLastBumpDirection'),
{N} (Index: 645; Name: 'GetIsInjured'),
{N} (Index: 646; Name: 'GetIsCrashLandRequest'),
{N} (Index: 647; Name: 'GetIsHastyLandRequest'),
{N} (Index: 651; Name: 'GetKeywordDataForCurrentLocation'; ParamType1: ptLocation),
{N} (Index: 652; Name: 'GetInSharedCrimeFaction'; ParamType1: ptObjectReference),
{N} (Index: 654; Name: 'GetBribeSuccess'),
{N} (Index: 655; Name: 'GetIntimidateSuccess'),
{N} (Index: 656; Name: 'GetArrestedState'),
{N} (Index: 657; Name: 'GetArrestingActor'),
{N} (Index: 659; Name: 'EPTemperingItemIsEnchanted'),
{N} (Index: 660; Name: 'EPTemperingItemHasKeyword'; ParamType1: ptKeyword),
{N} (Index: 664; Name: 'GetReplacedItemType'; ParamType1: ptCastingSource),
{N} (Index: 675; Name: 'GetGraphVariableInt'; ParamType1: ptVariableName),
{N} (Index: 676; Name: 'GetCurrentShoutVariation'),
{N} (Index: 680; Name: 'GetActivatorHeight'),
{N} (Index: 681; Name: 'EPMagic_IsAdvanceSkill'; ParamType1: ptActorValue),
{N} (Index: 683; Name: 'GetPathingCurrentSpeed'),
{N} (Index: 684; Name: 'GetPathingCurrentSpeedAngle'; ParamType1: ptAxis),
{N} (Index: 691; Name: 'EPModSkillUsage_AdvanceObjectHasKeyword'; ParamType1: ptKeyword),
{N} (Index: 692; Name: 'EPModSkillUsage_IsAdvanceAction'; ParamType1: ptAdvanceAction),
{N} (Index: 693; Name: 'EPMagic_SpellHasKeyword'; ParamType1: ptKeyword),
{N} (Index: 694; Name: 'GetNoBleedoutRecovery'),
{N} (Index: 696; Name: 'EPMagic_SpellHasSkill'; ParamType1: ptActorValue),
{N} (Index: 705; Name: 'GetShouldHelp'; ParamType1: ptActor),
{N} (Index: 707; Name: 'GetCombatTargetHasKeyword'; ParamType1: ptKeyword),
{N} (Index: 709; Name: 'GetCombatGroupMemberCount'),
{N} (Index: 711; Name: 'GetLightLevel'),
{N} (Index: 716; Name: 'GetRealHoursPassed'),
{N} (Index: 720; Name: 'GetTargetHeight'; ParamType1: ptObjectReference),
{N} (Index: 723; Name: 'GetItemHealthPercent'),
{N} (Index: 724; Name: 'EffectWasDualCast'),
{N} (Index: 725; Name: 'GetKnockedStateEnum'),
{N} (Index: 726; Name: 'DoesNotExist'),
{N} (Index: 731; Name: 'CanFlyHere')
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
//  Result := 0;
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;
  if Integer(Container.ElementByName['Type'].NativeValue) and $04 = 0 then
    Result := 0
  else
    Result := 1;
end;

function wbCTDAParam1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Desc: PCTDAFunction;
  Container: IwbContainer;
begin
  Result := 0;
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;
  Desc := wbCTDAParamDescFromIndex(Container.ElementByName['Function'].NativeValue);
  if Assigned(Desc) then
    Result := Succ(Integer(Desc.ParamType1));
end;

function wbCTDAParam2VATSValueParam(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container : IwbContainer;
begin
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;
  Result := Container.ElementByName['Parameter #1'].NativeValue;
end;

function wbCTDAParam2Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Desc: PCTDAFunction;
  Container: IwbContainer;
begin
  Result := 0;
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;
  Desc := wbCTDAParamDescFromIndex(Container.ElementByName['Function'].NativeValue);
  if Assigned(Desc) then
    Result := Succ(Integer(Desc.ParamType2));
end;

function wbCTDAParam3Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Desc: PCTDAFunction;
  Container: IwbContainer;
begin
  Result := 0;
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;
  Desc := wbCTDAParamDescFromIndex(Container.ElementByName['Function'].NativeValue);
  if Assigned(Desc) then
    Result := Succ(Integer(Desc.ParamType3));
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
        Result := '<Unknown: '+IntToStr(aInt)+'>';
    end;
    ctToSortKey: Result := IntToHex(aInt, 8);
    ctCheck: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := ''
      else
        Result := '<Unknown: '+IntToStr(aInt)+'>';
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

{>>> Needs revision for Skyrim <<<}
//type
//  TPERKEntryPointConditionType = (
//    epcDefault,
//    epcItem,
//    epcWeapon,
//    epcWeaponTarget,
//    epcTarget,
//    epcAttacker,
//    epcAttackerAttackee,
//    epcAttackerAttackerWeapon
//  );
//
//  TPERKEntryPointFunctionType = (
//    epfFloat,
//    epfLeveledItem,
//    epfScript,
//    epfUnknown
//  );
//
//  TPERKEntryPointFunctionParamType = (
//    epfpNone,
//    epfpFloat,
//    epfpFloatFloat,
//    epfpLeveledItem,
//    epfpScript
//  );
//
//  PPERKEntryPoint = ^TPERKEntryPoint;
//  TPERKEntryPoint = record
//    Name         : string;
//    Condition   : TPERKEntryPointConditionType;
//    FunctionType : TPERKEntryPointFunctionType;
//  end;
//
//  PPERKCondition = ^TPERKCondition;
//  TPERKCondition = record
//    Count    : Integer;
//    Caption1 : string;
//    Caption2 : string;
//    Caption3 : string;
//  end;
//
//  PPERKFunction = ^TPERKFunction;
//  TPERKFunction = record
//    Name         : string;
//    FunctionType : TPERKEntryPointFunctionType;
//    ParamType    : TPERKEntryPointFunctionParamType;
//  end;
//
//const
//  wbPERKCondition : array[TPERKEntryPointConditionType] of TPERKCondition = (
//    (Count: 1; Caption1: 'Perk Owner'),
//    (Count: 2; Caption1: 'Perk Owner'; Caption2: 'Item'),
//    (Count: 2; Caption1: 'Perk Owner'; Caption2: 'Weapon'),
//    (Count: 3; Caption1: 'Perk Owner'; Caption2: 'Weapon'; Caption3: 'Target'),
//    (Count: 2; Caption1: 'Perk Owner'; Caption2: 'Target'),
//    (Count: 2; Caption1: 'Perk Owner'; Caption2: 'Attacker'),
//    (Count: 3; Caption1: 'Perk Owner'; Caption2: 'Attacker'; Caption3: 'Attackee'),
//    (Count: 3; Caption1: 'Perk Owner'; Caption2: 'Attacker'; Caption3: 'Attacker Weapon')
//  );
//
//  wbPERKFunctions : array[0..9] of TPERKFunction = (
//    (Name: ''; FunctionType: epfUnknown; ParamType: epfpNone),
//    (Name: 'Set Value'; FunctionType: epfFloat; ParamType: epfpFloat),
//    (Name: 'Add Value'; FunctionType: epfFloat; ParamType: epfpFloat),
//    (Name: 'Multiply Value'; FunctionType: epfFloat; ParamType: epfpFloat),
//    (Name: 'Add Range To Value'; FunctionType: epfFloat; ParamType: epfpFloatFloat),
//    (Name: 'Add Actor Value Mult'; FunctionType: epfFloat; ParamType: epfpFloatFloat),
//    (Name: 'Absolute Value'; FunctionType: epfFloat; ParamType: epfpNone),
//    (Name: 'Negative Absolute Value'; FunctionType: epfFloat; ParamType: epfpNone),
//    (Name: 'Add Leveled List'; FunctionType: epfLeveledItem; ParamType: epfpLeveledItem),
//    (Name: 'Add Activate Choice'; FunctionType: epfScript; ParamType: epfpScript)
//  );
//
//  wbPERKEntryPoints : array[0..73] of TPERKEntryPoint = (
//    (Name: 'Calculate Weapon Damage'; Condition: epcWeaponTarget),
//    (Name: 'Calculate My Critical Hit Chance'; Condition: epcWeaponTarget),
//    (Name: 'Calculate My Critical Hit Damage'; Condition: epcWeaponTarget),
//    (Name: 'Calculate Weapon Attack AP Cost'; Condition: epcWeapon),
//    (Name: 'Calculate Mine Explode Chance'; Condition: epcItem),
//    (Name: 'Adjust Range Penalty'; Condition: epcWeapon),
//    (Name: 'Adjust Limb Damage'; Condition: epcAttackerAttackerWeapon),
//    (Name: 'Calculate Weapon Range'; Condition: epcWeapon),
//    (Name: 'Calculate To Hit Chance'; Condition: epcWeaponTarget),
//    (Name: 'Adjust Experience Points'),
//    (Name: 'Adjust Gained Skill Points'),
//    (Name: 'Adjust Book Skill Points'),
//    (Name: 'Modify Recovered Health'),
//    (Name: 'Calculate Inventory AP Cost'),
//    (Name: 'Get Disposition'; Condition: epcTarget),
//    (Name: 'Get Should Attack'; Condition: epcAttacker),
//    (Name: 'Get Should Assist'; Condition: epcAttackerAttackee),
//    (Name: 'Calculate Buy Price'; Condition: epcItem),
//    (Name: 'Get Bad Karma'),
//    (Name: 'Get Good Karma'),
//    (Name: 'Ignore Locked Terminal'),
//    (Name: 'Add Leveled List On Death'; Condition: epcTarget; FunctionType: epfLeveledItem),
//    (Name: 'Get Max Carry Weight'),
//    (Name: 'Modify Addiction Chance'),
//    (Name: 'Modify Addiction Duration'),
//    (Name: 'Modify Positive Chem Duration'),
//    (Name: 'Adjust Drinking Radiation'),
//    (Name: 'Activate'; Condition: epcTarget; FunctionType: epfScript),
//    (Name: 'Mysterious Stranger'),
//    (Name: 'Has Paralyzing Palm'),
//    (Name: 'Hacking Science Bonus'),
//    (Name: 'Ignore Running During Detection'),
//    (Name: 'Ignore Broken Lock'),
//    (Name: 'Has Concentrated Fire'),
//    (Name: 'Calculate Gun Spread'; Condition: epcWeapon),
//    (Name: 'Player Kill AP Reward'; Condition: epcWeaponTarget),
//{36}(Name: 'Modify Enemy Critical Hit Chance'; Condition: epcWeaponTarget),
//{37}(Name: 'Reload Speed'; Condition: epcWeapon),
//{38}(Name: 'Equip Speed'; Condition: epcWeapon),
//{39}(Name: 'Action Point Regen'; Condition: epcWeapon),
//{40}(Name: 'Action Point Cost'; Condition: epcWeapon),
//{41}(Name: 'Miss Fortune'; Condition: epcDefault),
//{42}(Name: 'Modify Run Speed'; Condition: epcDefault),
//{43}(Name: 'Modify Attack Speed'; Condition: epcWeapon),
//{44}(Name: 'Modify Radiation Consumed'; Condition: epcDefault),
//{45}(Name: 'Has Pip Hacker'; Condition: epcDefault),
//{46}(Name: 'Has Meltdown'; Condition: epcDefault),
//{47}(Name: 'See Enemy Health'; Condition: epcDefault),
//{48}(Name: 'Has Jury Rigging'; Condition: epcDefault),
//{49}(Name: 'Modify Threat Range'; Condition: epcWeapon),
//{50}(Name: 'Modify Thread'; Condition: epcWeapon),
//{51}(Name: 'Has Fast Travel Always'; Condition: epcDefault),
//{52}(Name: 'Knockdown Chance'; Condition: epcWeapon),
//{53}(Name: 'Modify Weapon Strength Req'; Condition: epcWeapon),
//{54}(Name: 'Modify Aiming Move Speed'; Condition: epcWeapon),
//{55}(Name: 'Modify Light Items'; Condition: epcDefault),
//{56}(Name: 'Modify Damage Threshold (defender)'; Condition: epcWeaponTarget),
//{57}(Name: 'Modify Chance for Ammo Item'; Condition: epcWeapon),
//{58}(Name: 'Modify Damage Threshold (attacker)'; Condition: epcWeaponTarget),
//{59}(Name: 'Modify Throwing Velocity'; Condition: epcWeapon),
//{60}(Name: 'Chance for Item on Fire'; Condition: epcWeapon),
//{61}(Name: 'Has Unarmed Forward Power Attack'; Condition: epcDefault),
//{62}(Name: 'Has Unarmed Back Power Attack'; Condition: epcWeaponTarget),
//{63}(Name: 'Has Unarmed Crouched Power Attack'; Condition: epcDefault),
//{64}(Name: 'Has Unarmed Counter Attack'; Condition: epcWeaponTarget),
//{65}(Name: 'Has Unarmed Left Power Attack'; Condition: epcDefault),
//{66}(Name: 'Has Unarmed Right Power Attack'; Condition: epcDefault),
//{67}(Name: 'VATS HelperChance'; Condition: epcDefault),
//{68}(Name: 'Modify Item Damage'; Condition: epcDefault),
//{69}(Name: 'Has Improved Detection'; Condition: epcDefault),
//{70}(Name: 'Has Improved Spotting'; Condition: epcDefault),
//{71}(Name: 'Has Improved Item Detection'; Condition: epcDefault),
//{72}(Name: 'Adjust Explosion Radius'; Condition: epcWeapon),
//{73}(Name: 'Reserved'; Condition: epcWeapon)
//  );
//
//  wbPERKFunctionParams: array[TPERKEntryPointFunctionParamType] of string = (
//    'None',
//    'Float',
//    'Float, Float',
//    'Leveled Item',
//    'Script'
//  );
//
//procedure wbPERKEntryPointAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
//var
//  OldEntryPoint   : PPERKEntryPoint;
//  NewEntryPoint   : PPERKEntryPoint;
//  OldCondition    : PPERKCondition;
//  NewCondition    : PPERKCondition;
//  OldFunction     : PPERKFunction;
//  EntryPoint      : IwbContainerElementRef;
//  Effect          : IwbContainerElementRef;
//  PerkConditions  : IwbContainerElementRef;
//  PerkCondition   : IwbContainerElementRef;
//  Container       : IwbContainerElementRef;
//  i               : Integer;
//begin
//  if aOldValue <> aNewValue then begin
//    OldEntryPoint := @wbPERKEntryPoints[Integer(aOldValue)];
//    NewEntryPoint := @wbPERKEntryPoints[Integer(aNewValue)];
//    OldCondition := @wbPERKCondition[OldEntryPoint.Condition];
//    NewCondition := @wbPERKCondition[NewEntryPoint.Condition];
//    if not Assigned(aElement) then
//      Exit;
//    if not Supports(aElement.Container, IwbContainerElementRef, EntryPoint) then
//      Exit;
//    i := EntryPoint.ElementNativeValues['Function'];
//    if (i >= Low(wbPERKFunctions)) and (i <= High(wbPERKFunctions)) then
//      OldFunction := @wbPERKFunctions[i]
//    else
//      OldFunction := nil;
//    if not Assigned(OldFunction) or (OldFunction.FunctionType <> NewEntryPoint.FunctionType) then
//      for i := Low(wbPERKFunctions) to High(wbPERKFunctions) do
//        with wbPERKFunctions[i] do
//          if FunctionType = NewEntryPoint.FunctionType then begin
//            EntryPoint.ElementNativeValues['Function'] := i;
//            Break;
//          end;
//    EntryPoint.ElementNativeValues['Perk Condition Tab Count'] := NewCondition.Count;
//
//    if not Supports(EntryPoint.Container, IwbContainerElementRef, Container) then
//      Exit;
//    if not Supports(Container.Container, IwbContainerElementRef, Effect) then
//      Exit;
//
//    if not Supports(Effect.ElementByName['Perk Conditions'], IwbContainerElementRef, PerkConditions) then
//      Exit;
//
//    for i := Pred(PerkConditions.ElementCount) downto 0 do
//      if Supports(PerkConditions.Elements[i], IwbContainerElementRef, PerkCondition) then
//        if Integer(PerkCondition.ElementNativeValues['PRKC']) >= NewCondition.Count then
//          PerkCondition.Remove
//        else
//          case Integer(PerkCondition.ElementNativeValues['PRKC']) of
//            2: if OldCondition.Caption2 <> NewCondition.Caption2 then
//                 PerkCondition.Remove;
//            3: if OldCondition.Caption3 <> NewCondition.Caption3 then
//                 PerkCondition.Remove;
//          end;
//  end;
//end;
//
//function wbPRKCToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
//var
//  Container     : IwbContainerElementRef;
//  EntryPointVar : Variant;
//  EntryPoint    : Integer;
//begin
//  case aType of
//    ctToStr: Result := IntToStr(aInt) + ' <Warning: Could not resolve Entry Point>';
//    ctToEditValue: Result := IntToStr(aInt);
//    ctToSortKey: begin
//      Result := IntToHex64(aInt, 2);
//      Exit;
//    end;
//    ctCheck: Result := '<Warning: Could not resolve Entry Point>';
//    ctEditType: Result := '';
//    ctEditInfo: Result := '';
//  end;
//
//  if not Supports(aElement, IwbContainerElementRef, Container) then
//    Exit;
//  EntryPointVar := Container.ElementNativeValues['..\..\..\DATA\Entry Point\Entry Point'];
//  if VarIsNull(EntryPointVar) or VarIsClear(EntryPointVar) then
//    Exit;
//  EntryPoint := EntryPointVar;
//  if (EntryPoint < Low(wbPERKEntryPoints)) or (EntryPoint > High(wbPERKEntryPoints)) then begin
//    case aType of
//      ctToStr: Result := IntToStr(aInt) + ' <Warning: Unknown Entry Point #'+IntToStr(EntryPoint)+'>';
//      ctCheck: Result := '<Warning: Unknown Entry Point #'+IntToStr(EntryPoint)+'>';
//    end;
//    Exit;
//  end;
//
//  with wbPERKEntryPoints[EntryPoint] do begin
//    with wbPERKCondition[Condition] do begin
//      case aType of
//        ctEditType: Result := 'ComboBox';
//        ctEditInfo: with TStringList.Create do try
//          if Caption1 <> '' then
//            Add(Caption1);
//          if Caption2 <> '' then
//            Add(Caption2);
//          if Caption3 <> '' then
//            Add(Caption3);
//          Sort;
//          Result := CommaText;
//        finally
//          Free;
//        end;
//      else
//        if (aInt < 0) or (aInt >= Count) then
//          case aType of
//            ctToStr: Result := IntToStr(aInt) + ' <Warning: Value out of Bounds for this Entry Point>';
//            ctCheck: Result := '<Warning: Value out of Bounds for this Entry Point>';
//          end
//        else
//          case aType of
//            ctToStr, ctToEditValue: case Integer(aInt) of
//              0: Result := Caption1;
//              1: Result := Caption2;
//              2: Result := Caption3;
//            end;
//            ctCheck: Result := '';
//          end;
//      end;
//    end;
//  end;
//end;
//
//function wbPRKCToInt(const aString: string; const aElement: IwbElement): Int64;
//var
//  Container     : IwbContainerElementRef;
//  EntryPointVar : Variant;
//  EntryPoint    : Integer;
//  s             : string;
//begin
//  s := Trim(aString);
//
//  Result := StrToInt64Def(s, Low(Integer));
//  if Result <> Low(Integer) then
//    Exit;
//  if s = '' then begin
//    Result := 0;
//    Exit;
//  end;
//
//  if not Supports(aElement, IwbContainerElementRef, Container) then
//    raise Exception.Create('Could not resolve Entry Point');
//  EntryPointVar := Container.ElementNativeValues['..\..\..\DATA\Entry Point\Entry Point'];
//  if VarIsNull(EntryPointVar) or VarIsClear(EntryPointVar) then
//    raise Exception.Create('Could not resolve Entry Point');
//
//  EntryPoint := EntryPointVar;
//  if (EntryPoint < Low(wbPERKEntryPoints)) or (EntryPoint > High(wbPERKEntryPoints)) then
//    raise Exception.Create('Unknown Entry Point #'+IntToStr(EntryPoint));
//
//  with wbPERKEntryPoints[EntryPoint] do
//    with wbPERKCondition[Condition] do
//      if SameText(aString, Caption1) then
//        Result := 0
//      else if SameText(aString, Caption2) then
//        Result := 1
//      else if SameText(aString, Caption3) then
//        Result := 2
//      else
//        raise Exception.Create('"'+s+'" is not valid for this Entry Point');
//end;

function wbNeverShow(const aElement: IwbElement): Boolean;
begin
  Result := True;
end;

function GetREGNType(aElement: IwbElement): Integer;
var
  Container: IwbContainerElementRef;
begin
  Result := -1;
  if not Assigned(aElement) then
    Exit;
  while aElement.Name <> 'Region Data Entry' do begin
    aElement := aElement.Container;
    if not Assigned(aElement) then
      Exit;
  end;
  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;
  Result := Container.ElementNativeValues['RDAT\Type'];
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

{>>> Needs revision for Skyrim <<<}
//function wbPERKPRKCDontShow(const aElement: IwbElement): Boolean;
//var
//  Container: IwbContainerElementRef;
//begin
//  Result := False;
//  if aElement.Name <> 'Effect' then
//    Exit;
//  if not Supports(aElement, IwbContainerElementRef, Container) then
//    Exit;
//  if Integer(Container.ElementNativeValues['PRKE\Type']) <> 2 then
//    Result := True;
//end;

{>>> Needs revision for Skyrim <<<}
//function wbPerkDATAFunctionToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
//var
//  Container     : IwbContainerElementRef;
//  EntryPointVar : Variant;
//  EntryPoint    : Integer;
//  i             : Integer;
//begin
//  case aType of
//    ctToStr: Result := IntToStr(aInt) + ' <Warning: Could not resolve Entry Point>';
//    ctToEditValue: Result := IntToStr(aInt);
//    ctToSortKey: begin
//      Result := IntToHex64(aInt, 2);
//      Exit;
//    end;
//    ctCheck: Result := '<Warning: Could not resolve Entry Point>';
//    ctEditType: Result := '';
//    ctEditInfo: Result := '';
//  end;
//
//  if not Supports(aElement, IwbContainerElementRef, Container) then
//    Exit;
//  EntryPointVar := Container.ElementNativeValues['..\Entry Point'];
//  if VarIsNull(EntryPointVar) or VarIsClear(EntryPointVar) then
//    Exit;
//  EntryPoint := EntryPointVar;
//  if (EntryPoint < Low(wbPERKEntryPoints)) or (EntryPoint > High(wbPERKEntryPoints)) then begin
//    case aType of
//      ctToStr: Result := IntToStr(aInt) + ' <Warning: Unknown Entry Point #'+IntToStr(EntryPoint)+'>';
//      ctCheck: Result := '<Warning: Unknown Entry Point #'+IntToStr(EntryPoint)+'>';
//    end;
//    Exit;
//  end;
//
//  with wbPERKEntryPoints[EntryPoint] do begin
//    case aType of
//      ctEditType: Result := 'ComboBox';
//      ctEditInfo: with TStringList.Create do try
//        for i := Low(wbPERKFunctions) to High(wbPERKFunctions) do
//          if wbPERKFunctions[i].FunctionType = FunctionType then
//            if (wbPERKFunctions[i].Name <> '') then
//              Add(wbPERKFunctions[i].Name);
//        Sort;
//        Result := CommaText;
//      finally
//        Free;
//      end;
//    else
//      if (aInt < Low(wbPERKFunctions)) or (aInt > High(wbPERKFunctions)) then
//        case aType of
//          ctToStr: Result := IntToStr(aInt) + ' <Warning: Unknown Function>';
//          ctCheck: Result := '<Warning: Unknown Function>';
//        end
//      else
//        case aType of
//          ctToStr, ctToEditValue: begin
//            Result := wbPERKFunctions[Integer(aInt)].Name;
//            if (aType = ctToStr) and (wbPERKFunctions[Integer(aInt)].FunctionType <> FunctionType) then
//              Result := Result + ' <Warning: Value out of Bounds for this Entry Point>';
//          end;
//          ctCheck:
//            if wbPERKFunctions[Integer(aInt)].FunctionType <> FunctionType then
//              Result := '<Warning: Value out of Bounds for this Entry Point>'
//            else
//              Result := '';
//        end;
//    end;
//  end;
//end;

{>>> Needs revision for Skyrim <<<}
//function wbPerkDATAFunctionToInt(const aString: string; const aElement: IwbElement): Int64;
//var
//  Container     : IwbContainerElementRef;
//  EntryPointVar : Variant;
//  EntryPoint    : Integer;
//  s             : string;
//  i             : Integer;
//begin
//  s := Trim(aString);
//
//  Result := StrToInt64Def(s, Low(Integer));
//  if Result <> Low(Integer) then
//    Exit;
//  if s = '' then
//    raise Exception.Create('"" is not a valid value for this field');
//
//  if not Supports(aElement, IwbContainerElementRef, Container) then
//    raise Exception.Create('Could not resolve Entry Point');
//  EntryPointVar := Container.ElementNativeValues['..\Entry Point'];
//  if VarIsNull(EntryPointVar) or VarIsClear(EntryPointVar) then
//    raise Exception.Create('Could not resolve Entry Point');
//
//  EntryPoint := EntryPointVar;
//  if (EntryPoint < Low(wbPERKEntryPoints)) or (EntryPoint > High(wbPERKEntryPoints)) then
//    raise Exception.Create('Unknown Entry Point #'+IntToStr(EntryPoint));
//
//  with wbPERKEntryPoints[EntryPoint] do
//    for i := Low(wbPERKFunctions) to High(wbPERKFunctions) do
//      if wbPERKFunctions[i].FunctionType = FunctionType then
//        if SameText(s, wbPERKFunctions[i].Name) then begin
//          Result := i;
//          Exit;
//        end;
//
//  raise Exception.Create('"'+s+'" is not valid for this Entry Point');
//end;

{>>> Needs revision for Skyrim <<<}
//procedure wbPerkDATAFunctionAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
//var
//  NewFunction : Integer;
//  Container   : IwbContainerElementRef;
//  OldParamType: Integer;
//  NewParamType: Integer;
//begin
//  NewFunction := aNewValue;
//  if (NewFunction < Low(wbPERKFunctions)) or (NewFunction > High(wbPERKFunctions)) then
//    Exit;
//  if not Supports(aElement, IwbContainerElementRef, Container) then
//    Exit;
//  OldParamType := Container.ElementNativeValues['..\..\..\Entry Point Function Parameters\EPFT'];
//  NewParamType := Ord(wbPERKFunctions[NewFunction].ParamType);
//  if (OldParamType = NewParamType) and not VarSameValue(aOldValue, aNewValue) and (NewFunction in [4,5]) then
//    Container.ElementNativeValues['..\..\..\Entry Point Function Parameters\EPFT'] := 0;
//  Container.ElementNativeValues['..\..\..\Entry Point Function Parameters\EPFT'] := NewParamType;
//end;
//
//function wbPerkEPFTToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
//var
//  Container       : IwbContainerElementRef;
//  FunctionTypeVar : Variant;
//  FunctionType    : Integer;
////  i               : Integer;
//begin
//  case aType of
//    ctToStr: Result := IntToStr(aInt) + ' <Warning: Could not resolve Function>';
//    ctToEditValue: Result := IntToStr(aInt);
//    ctToSortKey: begin
//      Result := IntToHex64(aInt, 2);
//      Exit;
//    end;
//    ctCheck: Result := '<Warning: Could not resolve Function>';
//    ctEditType: Result := '';
//    ctEditInfo: Result := '';
//  end;
//
//  if not Supports(aElement, IwbContainerElementRef, Container) then
//    Exit;
//  FunctionTypeVar := Container.ElementNativeValues['..\..\DATA\Entry Point\Function'];
//  if VarIsNull(FunctionTypeVar) or VarIsClear(FunctionTypeVar) then
//    Exit;
//  FunctionType := FunctionTypeVar;
//  if (FunctionType < Low(wbPERKFunctions)) or (FunctionType > High(wbPERKFunctions)) then begin
//    case aType of
//      ctToStr: Result := IntToStr(aInt) + ' <Warning: Unknown Function #'+IntToStr(FunctionType)+'>';
//      ctCheck: Result := '<Warning: Unknown Function #'+IntToStr(FunctionType)+'>';
//    end;
//    Exit;
//  end;
//
//  with wbPERKFunctions[FunctionType] do begin
//    case aType of
//      ctEditType: Result := 'ComboBox';
//      ctEditInfo: Result := '"' + wbPERKFunctionParams[ParamType] + '"';
//    else
//      if (aInt < Ord(Low(wbPERKFunctionParams))) or (aInt > Ord(High(wbPERKFunctionParams))) then
//        case aType of
//          ctToStr: Result := IntToStr(aInt) + ' <Warning: Unknown Function Param Type>';
//          ctCheck: Result := '<Warning: Unknown Function Param Type>';
//        end
//      else
//        case aType of
//          ctToStr, ctToEditValue: begin
//            Result := wbPERKFunctionParams[TPERKEntryPointFunctionParamType(aInt)];
//            if (aType = ctToStr) and (TPERKEntryPointFunctionParamType(aInt) <> ParamType) then
//              Result := Result + ' <Warning: Value out of Bounds for this Function>';
//          end;
//          ctCheck:
//            if TPERKEntryPointFunctionParamType(aInt) <> ParamType then
//              Result := Result + ' <Warning: Value out of Bounds for this Function>'
//            else
//              Result := '';
//        end;
//    end;
//  end;
//end;

{>>> Needs revision for Skyrim <<<}
//function wbPerkEPFTToInt(const aString: string; const aElement: IwbElement): Int64;
//var
//  Container       : IwbContainerElementRef;
//  FunctionTypeVar : Variant;
//  FunctionType    : Integer;
//  s               : string;
////  i               : Integer;
//  j               : TPERKEntryPointFunctionParamType;
//begin
//  s := Trim(aString);
//
//  Result := StrToInt64Def(s, Low(Integer));
//  if Result <> Low(Integer) then
//    Exit;
//  if s = '' then
//    raise Exception.Create('"" is not a valid value for this field');
//
//  if not Supports(aElement, IwbContainerElementRef, Container) then
//    raise Exception.Create('Could not resolve Function');
//  FunctionTypeVar := Container.ElementNativeValues['..\..\DATA\Entry Point\Function'];
//  if VarIsNull(FunctionTypeVar) or VarIsClear(FunctionTypeVar) then
//    raise Exception.Create('Could not resolve Function');
//
//  FunctionType := FunctionTypeVar;
//  if (FunctionType < Low(wbPERKFunctions)) or (FunctionType > High(wbPERKFunctions)) then
//    raise Exception.Create('Unknown Function #'+IntToStr(FunctionType));
//
//  with wbPERKFunctions[FunctionType] do begin
//    for j := Low(wbPERKFunctionParams) to High(wbPERKFunctionParams) do
//      if SameText(s, wbPERKFunctionParams[j]) then begin
//        if j <> ParamType then
//          raise Exception.Create('"'+s+'" is not a valid Parameter Type for Function "'+Name+'"');
//        Result := Ord(j);
//        Exit;
//      end;
//  end;
//
//  raise Exception.Create('"'+s+'" is not a valid Parameter Type');
//end;

{>>> Needs revision for Skyrim <<<}
//procedure wbPerkEPFTAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
//var
//  i: Integer;
//  Container: IwbContainerElementRef;
//begin
//  if VarSameValue(aOldValue, aNewValue) then
//    Exit;
//  i := aNewValue;
//  if (i < Ord(Low(wbPERKFunctionParams))) or (i> Ord(High(wbPERKFunctionParams))) then
//    Exit;
//  if not Supports(aElement.Container, IwbContainerElementRef, Container) then
//    Exit;
//  Container.RemoveElement('EPFD');
//  Container.RemoveElement('EPF2');
//  Container.RemoveElement('EPF3');
//  Container.RemoveElement('Embedded Script');
//  case TPERKEntryPointFunctionParamType(i) of
//    epfpFloat, epfpFloatFloat, epfpLeveledItem:
//      Container.Add('EPFD', True);
//    epfpScript: begin
//      Container.Add('EPF2', True);
//      Container.Add('EPF3', True);
//      Container.Add('SCHR', True);
//    end;
//  end;
//end;

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
  Element := aElement;
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
  Element := aElement;
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
  Element := aElement;
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
  Element := aElement;
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
  Element := aElement;
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
  Element := aElement;
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
  Element := aElement;
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
  Element := aElement;
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
  Element := aElement;
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
      if Container.DateSize = 20 then
        Container.DateSize := 28;
      Container.ElementNativeValues['Type'] := TypeFlags and not $02;
      Container.ElementEditValues['Run On'] := 'Target';
    end;
  finally
    wbEndInternalEdit;
  end;
end;

{ Needs revision for Skyrim }
//procedure wbMGEFAfterLoad(const aElement: IwbElement);
//var
//  Container     : IwbContainerElementRef;
//  MainRecord    : IwbMainRecord;
//  OldActorValue : Integer;
//  NewActorValue : Integer;
//begin
//  if wbBeginInternalEdit then try
//    if not Supports(aElement, IwbContainerElementRef, Container) then
//      Exit;
//
//    if Container.ElementCount < 1 then
//      Exit;
//
//    if not Supports(aElement, IwbMainRecord, MainRecord) then
//      Exit;
//
//    if MainRecord.IsDeleted then
//      Exit;
//
//    OldActorValue := Container.ElementNativeValues['DATA - Data\Actor Value'];
//    NewActorValue := OldActorValue;
//    case Integer(Container.ElementNativeValues['DATA - Data\Archtype']) of
//      01, //Script
//      02, //Dispel
//      03, //Cure Disease
//      13, //Light
//      16, //Lock
//      17, //Open
//      18, //Bound Item
//      19, //Summon Creature
//      30, //Cure Paralysis
//      31, //Cure Addiction
//      32, //Cure Poison
//      33, //Concussion
//      35: //Limb Condition
//        NewActorValue := -1;
//      11: //Invisibility
//        NewActorValue := 48; //Invisibility
//      12: //Chameleon
//        NewActorValue := 49; //Chameleon
//      24: //Paralysis
//        NewActorValue := 47; //Paralysis
//      36: //Turbo
//        NewActorValue := 51; //Turbo
//    end;
//    if OldActorValue <> NewActorValue then
//      Container.ElementNativeValues['DATA - Data\Actor Value'] := NewActorValue;
//  finally
//    wbEndInternalEdit;
//  end;
//end;

{ Needs revision for Skyrim }
//procedure wbPACKAfterLoad(const aElement: IwbElement);
//var
//  Container     : IwbContainerElementRef;
//  MainRecord    : IwbMainRecord;
//  OldContainer  : IwbContainerElementRef;
//  NewContainer  : IwbContainerElementRef;
//  //NewContainer2 : IwbContainerElementRef;
//begin
//  if wbBeginInternalEdit then try
//    if not Supports(aElement, IwbContainerElementRef, Container) then
//      Exit;
//
//    if Container.ElementCount < 1 then
//      Exit;
//
//    if not Supports(aElement, IwbMainRecord, MainRecord) then
//      Exit;
//
//    if MainRecord.IsDeleted then
//      Exit;
//
//    case Integer(Container.ElementNativeValues['PKDT - General\Type']) of
//       0: begin {Find}
//         Container.Add('PTDT');
//       end;
//       1: begin {Follow}
//         Container.Add('PKFD');
//       end;
//       2: begin {Escort}
//       end;
//       3: begin {Eat}
//         Container.Add('PTDT');
//         Container.Add('PKED');
//       end;
//       4: begin {Sleep}
//         if not Container.ElementExists['Locations'] then
//           if Supports(Container.Add('Locations'), IwbContainerElementRef, NewContainer) then
//             NewContainer.ElementEditValues['PLDT - Location 1\Type'] := 'Near editor location';
//       end;
//       5: begin {Wander}
//       end;
//       6: begin {Travel}
//       end;
//       7: begin {Accompany}
//       end;
//       8: begin {Use Item At}
//       end;
//       9: begin {Ambush}
//       end;
//      10: begin {Flee Not Combat}
//      end;
//      12: begin {Sandbox}
//      end;
//      13: begin {Patrol}
//         if not Container.ElementExists['Locations'] then
//           if Supports(Container.Add('Locations'), IwbContainerElementRef, NewContainer) then
//             NewContainer.ElementEditValues['PLDT - Location 1\Type'] := 'Near linked reference';
//        Container.Add('PKPT');
//      end;
//      14: begin {Guard}
//      end;
//      15: begin {Dialogue}
//      end;
//      16: begin {Use Weapon}
//      end;
//    end;
//
//    if Supports(Container.RemoveElement('PLD2'), IwbContainerElementRef, OldContainer) then begin
//      if not Supports(Container.Add('Locations'), IwbContainerElementRef, NewContainer) then
//        Assert(False);
//      NewContainer.RemoveElement('PLD2');
//      NewContainer.AddElement(OldContainer);
//    end;
//  finally
//    wbEndInternalEdit;
//  end;
//end;

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

{>>>Needs Revision for Skyrim<<<}
//procedure wbINFOAfterLoad(const aElement: IwbElement);
//var
//  Container  : IwbContainerElementRef;
//  MainRecord : IwbMainRecord;
//begin
//  if wbBeginInternalEdit then try
//    if not Supports(aElement, IwbContainerElementRef, Container) then
//      Exit;
//
//    if Container.ElementCount < 1 then
//      Exit;
//
//    if not Supports(aElement, IwbMainRecord, MainRecord) then
//      Exit;
//
//    if MainRecord.IsDeleted then
//      Exit;
//
//    if (Integer(Container.ElementNativeValues['DATA\Flags 1']) and $80) = 0 then
//      Container.RemoveElement('DNAM');
//
//    Container.RemoveElement('SNDD');
//
//    if Container.ElementNativeValues['DATA\Type'] = 3 {Persuasion} then
//      Container.ElementNativeValues['DATA\Type'] := 0 {Topic};
//  finally
//    wbEndInternalEdit;
//  end;
//end;

procedure wbCELLAfterLoad(const aElement: IwbElement);
var
  Container    : IwbContainerElementRef;
  Container2   : IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
  i            : Integer;
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
      Container.ElementEditValues['XCLW'] := 'Default';
    end;

    if (not Container.ElementExists['XNAM']) and ((Integer(Container.ElementNativeValues['DATA']) and $02) <> 0) then
      Container.Add('XNAM', True);

    if Supports(Container.ElementBySignature[XCLR], IwbContainerElementRef, Container2) then begin
      for i:= Pred(Container2.ElementCount) downto 0 do
        if not Supports(Container2.Elements[i].LinksTo, IwbMainRecord, MainRecord) or (MainRecord.Signature <> 'REGN') then
          Container2.RemoveElement(i);
      if Container2.ElementCount < 1 then
        Container2.Remove;
    end;
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


{ Updated, but not called for Skyrim }
{ Why is it required to fix particle counts? Because 1 pass = 79 particles?}
//procedure wbEFSHAfterLoad(const aElement: IwbElement);
//var
//  Container: IwbContainerElementRef;
//  MainRecord   : IwbMainRecord;
//  FullParticleBirthRatio : Extended;
//  PersistantParticleCount : Extended;
//begin
//  if wbBeginInternalEdit then try
//    if not Supports(aElement, IwbContainerElementRef, Container) then
//      Exit;
//
//    if Container.ElementCount < 1 then
//      Exit;
//
//    if not Supports(aElement, IwbMainRecord, MainRecord) then
//      Exit;
//
//    if MainRecord.IsDeleted then
//      Exit;
//
//    if not Container.ElementExists['DATA'] then
//      Exit;
//
//    FullParticleBirthRatio := Container.ElementNativeValues['DATA\Particle Shader - Full Particle Birth Ratio'];
//    PersistantParticleCount := Container.ElementNativeValues['DATA\Particle Shader - Persistant Particle Count'];
//
//    if ((FullParticleBirthRatio <> 0) and (FullParticleBirthRatio <= 1)) then begin
//      FullParticleBirthRatio := FullParticleBirthRatio * 78.0;
//      Container.ElementNativeValues['DATA\Particle Shader - Full Particle Birth Ratio'] := FullParticleBirthRatio;
//    end;
//
//    if ((PersistantParticleCount <> 0) and (PersistantParticleCount <= 1)) then begin
//      PersistantParticleCount := PersistantParticleCount * 78.0;
//      Container.ElementNativeValues['DATA\Particle Shader - Persistant Particle Count'] := PersistantParticleCount;
//    end;
//
//  finally
//    wbEndInternalEdit;
//  end;
//end;

{ Not used is Skyrim }
//procedure wbFACTAfterLoad(const aElement: IwbElement);
//var
//  Container: IwbContainerElementRef;
//  MainRecord   : IwbMainRecord;
//begin
//  if wbBeginInternalEdit then try
//    if not Supports(aElement, IwbContainerElementRef, Container) then
//      Exit;
//
//    if Container.ElementCount < 1 then
//      Exit;
//
//    if not Container.ElementExists['CNAM'] then
//      Exit;
//
//    if not Supports(aElement, IwbMainRecord, MainRecord) then
//      Exit;
//
//    if MainRecord.IsDeleted then
//      Exit;
//
//    Container.RemoveElement('CNAM');
//  finally
//    wbEndInternalEdit;
//  end;
//end;

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
    if not Assigned(Element) then
      Exit;
    if not Supports(Element.LinksTo, IwbMainRecord, MainRecord) then
      Exit;
    if MainRecord.Signature <> 'MGEF' then
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
end;

function wbPubPackCNAMDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  rANAM: IwbRecord;
  ctype: string;
begin
  Result := 0;
  rANAM := aElement.Container.RecordBySignature[ANAM];
  if Assigned(rANAM) then begin
    ctype := rANAM.NativeValue;
    if ctype = 'Bool' then Result := 1 else
    if ctype = 'Int' then Result := 2 else
    if ctype = 'Float' then Result := 3 else
    if ctype = 'ObjectList' then Result := 3;
  end;
end;

function wbTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;
  Result := Container.ElementByName['Type'].NativeValue;
end;


procedure DefineTES5a;
begin
//-----------------------------------------------------------------
// New Routines
//-----------------------------------------------------------------
  wbBoolU8 := wbInteger('Boolean', itU8, wbEnum(['False', 'True']));
  wbBoolU16 := wbInteger('Boolean', itU16, wbEnum(['False', 'True']));
  wbBoolU32 := wbInteger('Boolean', itU32, wbEnum(['False', 'True']));
  wbLLCT := wbInteger(LLCT, 'Count', itU8);
  wbCITC := wbInteger(CITC, 'Count', itU32);
  wbLVLD := wbInteger(LVLD, 'Chance None', itU8, nil, cpNormal, True);

  wbKeywords := wbRStruct('Keywords', [
    wbInteger(KSIZ, 'Count', itU32), {>>> Needs Count Updated <<<}
    wbArrayS(KWDA, '', wbFormIDCk('Keyword', [KYWD]), 0, cpNormal, True)
  ], []);

  wbArmorTypeEnum := wbEnum([
    'Light Armor',
    'Heavy Armor',
    'Clothing'
  ]);

  {>>> When Set to None this Equals FF FF FF FF <<<}
  {>>> When NAME is user defined these will be incorrect <<<}
  wbBipedObjectEnum := wbEnum([
    'Head',
    'Hair',
    'Body',
    'Hands',
    'Forearms',
    'Amulet',
    'Ring',
    'Feet',
    'Calves',
    'Shield',
    'Body AddOn 1',
    'Long Hair',
    'Circlet',
    'Body AddOn 2',
    'Body AddOn 3',
    'Body AddOn 4',
    'Body AddOn 5',
    'Body AddOn 6',
    'Body AddOn 7',
    'Body AddOn 8',
    'Decapate Head',
    'Decapate',
    'Body AddOn 9',
    'Body AddOn 10',
    'Body AddOn 11',
    'Body AddOn 12',
    'Body AddOn 13',
    'Body AddOn 14',
    'Body AddOn 15',
    'Body AddOn 16',
    'Body AddOn 17',
    'FX01'
    ], [
    -1, 'None'{>>> itS32 and -1 was used instead of $FFFFFFFF and itU32 <<<}
  ]);

  wbBODT := wbStruct(BODT, 'Body Template', [
    wbInteger('First Person Flags', itU32, wbFlags([
        {0x00000001} 'Head',
        {0x00000002} 'Hair',
        {0x00000004} 'Body',
        {0x00000008} 'Hands',
        {0x00000010} 'Forearms',
        {0x00000020} 'Amulet',
        {0x00000040} 'Ring',
        {0x00000080} 'Feet',
        {0x00000100} 'Calves',
        {0x00000200} 'Shield',
        {0x00000400} 'Body AddOn 1',
        {0x00000800} 'Long Hair',
        {0x00001000} 'Circlet',
        {0x00002000} 'Body AddOn 2',
        {0x00004000} 'Body AddOn 3',
        {0x00008000} 'Body AddOn 4',
        {0x00010000} 'Body AddOn 5',
        {0x00020000} 'Body AddOn 6',
        {0x00040000} 'Body AddOn 7',
        {0x00080000} 'Body AddOn 8',
        {0x00100000} 'Decapate Head',
        {0x00200000} 'Decapate',
        {0x00400000} 'Body AddOn 9',
        {0x00800000} 'Body AddOn 10',
        {0x01000000} 'Body AddOn 11',
        {0x02000000} 'Body AddOn 12',
        {0x03000000} 'Body AddOn 13',
        {0x08000000} 'Body AddOn 14',
        {0x10000000} 'Body AddOn 15',
        {0x20000000} 'Body AddOn 16',
        {0x40000000} 'Body AddOn 17',
        {0x80000000} 'FX01'
    ], True)),
    wbInteger('General Flags', itU32, wbFlags([
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
    ], True)),
    wbInteger('Armor Type', itU32, wbArmorTypeEnum)
  ], cpNormal, True);

  wbBODTOld := wbStruct(BODT, 'Unknown', [
    wbbyteArray('Unknown', 4),
    wbbyteArray('Unknown', 4),
    wbbyteArray('Unknown', 4)
  ]);

  wbCOED := wbStructExSK(COED, [2], [0, 1], 'Extra Data', [
    {00} wbFormIDCkNoReach('Owner', [NPC_, FACT, NULL]),
    {04} wbUnion('Global Variable / Required Rank', wbCOEDOwnerDecider, [
           wbByteArray('Unknown', 4, cpIgnore),
           wbFormIDCk('Global Variable', [GLOB, NULL]),
           wbInteger('Required Rank', itS32)
         ]),
    {08} wbFloat('Item Condition')
  ]);

  wbCNTO :=
    wbRStructExSK([0], [1], 'Item', [
      wbStructExSK(CNTO, [0], [1], 'Item', [
        wbFormIDCk('Item', [ARMO, AMMO, MISC, WEAP, BOOK, LVLI, KEYM, ALCH, IMOD, CMNY, CCRD, LIGH{, MSTT{?}{, STAT{?}]),
        wbInteger('Count', itS32)
      ]),
      wbCOED
    ], []);

  wbCNTOs := wbRArrayS('Items', wbCNTO);

  wbCOCT := wbRStruct('Items', [
    wbInteger(COCT, 'Count', itU32),
    wbCNTOs
  ], []);

  wbCOCTReq := wbRStruct('Items', [
    wbInteger(COCT, 'Count', itU32, nil, cpNormal, True),
    wbCNTOs
  ], [], cpNormal, True);

  wbDMDL := wbString(DMDL, 'Model Filename');
  wbSNAM := wbFormIDCk(SNAM, 'Sound - Open', [SOUN]);
  wbQNAM := wbFormIDCk(QNAM, 'Sound - Close', [SOUN]);
  wbMDOB := wbFormID(MDOB, 'Menu Display Object', cpNormal, False);
  wbCNAM := wbStruct(CNAM, 'ColorID', [
              wbStruct('Color Name', [
                wbInteger('Red', itU8),
                wbInteger('Green', itU8),
                wbInteger('Blue', itU8),
                wbByteArray('Unknown', 1)
              ])
            ]);

  wbCNAMReq := wbStruct(CNAM, 'ColorID', [
              wbStruct('Color Name', [
                wbInteger('Red', itU8),
                wbInteger('Green', itU8),
                wbInteger('Blue', itU8),
                wbByteArray('Unknown', 1)
              ])
            ]);

	wbMODT := wbStruct(MODT, 'Texture Files Hashes', [
							wbByteArray('Not Shown', 0, cpIgnore, False, wbNeverShow)
						], cpIgnore, False, wbNeverShow);
	wbDMDT := wbStruct(DMDT, 'Texture Files Hashes', [
							wbByteArray('Not Shown', 0, cpIgnore, False, wbNeverShow)
						], cpIgnore, False, wbNeverShow);

//------------------------------------------------------------------------------
// Begin New DODT
//------------------------------------------------------------------------------
// Sample DODT
// DODT - Unknown:
// {00}            00 00 00 41 1 Min Width
// {05}            00 00 00 42 2 Max Width
// {09}            00 00 00 41 3 Min Height
// {13}            00 00 00 42 4 Max Height
// {17}            00 00 00 42 5 Depth
// {21}            00 00 80 40 6 Shininess
//                 ------------Parallax-----
// {25}            00 00 80 3F 7 Scale
// {29}            04            Passes  {This can't be higher than 30}
//                 -------------------------
// {30}               00         Flags
//                       32 30 <-- Not Sure
// {31}            FF FF FF 00   Color
//------------------------------------------------------------------------------
  wbDODT := wbStruct(DODT, 'Decal Data', [
   {00}       wbFloat('Min Width'),
   {05}       wbFloat('Max Width'),
   {09}       wbFloat('Min Height'),
   {13}       wbFloat('Max Height'),
   {17}       wbFloat('Depth'),
   {21}       wbFloat('Shininess'),
              wbStruct('Parallax', [
   {25}         wbFloat('Scale'),
   {29}         wbInteger('Passes', itU8) {This can't be higher than 30}
              ]),
   {30}       wbInteger('Flags', itU8, wbFlags([
                {0x00000001}'Parallax',
                {0x00000002}'Alpha - Blending',
                {0x00000004}'Alpha - Testing',
                {0x00000008}'No Subtextures',
                {0x00000010}'DODT Unknown 5',
                {0x00000020}'DODT Unknown 6',
                {0x00000040}'DODT Unknown 7',
                {0x00000080}'DODT Unknown 8'
               ], True)),
   {31}       wbByteArray('Unknown', 2),
   {33}       wbStruct('Color', [
                wbInteger('Red', itU8),
                wbInteger('Green', itU8),
                wbInteger('Blue', itU8),
                wbByteArray('Unknown', 1)
              ])
            ]);
//------------------------------------------------------------------------------
// Begin Old DODT
//------------------------------------------------------------------------------
//  wbDODT := wbStruct(DODT, 'Decal Data', [
//              wbFloat('Min Width'),
//              wbFloat('Max Width'),
//              wbFloat('Min Height'),
//              wbFloat('Max Height'),
//              wbFloat('Depth'),
//              wbFloat('Shininess'),
//              wbStruct('Parallax', [
//                wbFloat('Scale'),
//                wbInteger('Passes', itU8)
//              ]),
//              wbInteger('Flags', itU8, wbFlags([
//                'Parallax',
//                'Alpha - Blending',
//                'Alpha - Testing'
//              ], True)),
//              wbByteArray('Unused', 2),
//              wbStruct('Color', [
//                wbInteger('Red', itU8),
//                wbInteger('Green', itU8),
//                wbInteger('Blue', itU8),
//                wbByteArray('Unused', 1)
//              ])
//            ]);
//------------------------------------------------------------------------------
// End Old wbDODT
//------------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//
// wbDNAMActor - Unknown:
//                 14 19 0F 14 Skill Values
//                 14 0F 14 0F
//                 0F 0F 0F 14
//                 0F 0F 0F 0F
//                 0F 0F
//                       00 00 Skill Offsets
//                 00 00 00 00
//                 00 00 00 00
//                 00 00 00 00
//                 00 00 00 00
//                 23 00 4B 00 Remaining
//                 32 00 10 00
//                 00 00 00 00
//                 00 7E 54 00
      wbDNAMActor := wbRStruct('Player Skills', [
        wbStruct(DNAM, 'Player Skills', [
		 {00} wbArray('Skill Values', wbInteger('Skill', itU8), [
						'OneHanded',
						'TwoHanded',
						'Marksman',
						'Block',
						'Smithing',
						'HeavyArmor',
						'LightArmor',
						'Pickpocket',
						'Lockpicking',
						'Sneak',
						'Alchemy',
						'Speechcraft',
						'Alteration',
						'Conjuration',
						'Destruction',
						'Illusion',
						'Restoration',
						'Enchanting'
					]),
		 {14} wbArray('Skill Offsets', wbInteger('Skill', itU8), [
						'OneHanded',
						'TwoHanded',
						'Marksman',
						'Block',
						'Smithing',
						'HeavyArmor',
						'LightArmor',
						'Pickpocket',
						'Lockpicking',
						'Sneak',
						'Alchemy',
						'Speechcraft',
						'Alteration',
						'Conjuration',
						'Destruction',
						'Illusion',
						'Restoration',
						'Enchanting'
					]),
					wbByteArray('Unknown', 4),
					wbByteArray('Unknown', 4),
					//wbByteArray('Unknown', 4),
          wbFloat('Far away model distance'),
          wbInteger('Geared up weapons', itU8),
					wbByteArray('Unknown', 3)
				])
			], [], cpNormal, False, wbActorTemplateUseStatsAutoCalc);
//-----------------------------------------------------------------
// End New Routines
//-----------------------------------------------------------------

  wbRecordFlags := wbInteger('Record Flags', itU32, wbFlags([
    {>>> 0x00000000 ACTI: Collision Geometry (default) <<<}
    {0x00000001}'ESM',
    {0x00000002}'Unknown 2',
    {0x00000004}'Unknown 3',
    {0x00000008}'Unknown 4',
    {0x00000010}'Unknown 5',
    {0x00000020}'Deleted',
    {>>> 0x00000040 ACTI: Has Tree LOD <<<}
    {0x00000040}'Constant / (REFR) Hidden From Local Map',
    {>>> 0x00000080 PHZD: Turn Off Fire <<<}
    {0x00000080}'(TES4)Localized / Is Perch / (PHZD) Turn off fire',
    {>>> 0x00000100 ACTI: Must Update Anims <<<}
    {>>> 0x00020000 REFR light: Doesn't light water <<<}
    {0x00000100}'Must Update Anims / (REFR) Inaccessible',
    {>>> 0x00000200 ACTI: Local Map - Turns Flag Off, therefore it is Hidden <<<}
    {0x00000200}'Hidden from local map / Starts dead /(REFR) MotionBlurCastsShadows',
    {0x00000400}'Quest item / Persistent reference / (LSCR) Displays in Main Menu',
    {0x00000800}'Initialy disabled',
    {0x00001000}'Ignored',
    {0x00002000}'Unknown 14',
    {0x00004000}'Unknown 15',
    {0x00008000}'VWD',
    {>>> 0x00010000 ACTI: Random Animation Start <<<}
    {>>> 0x00020000 REFR light: Never fades <<<}
    {0x00010000}'Random Animation Start',
    {>>> 0x00020000 ACTI: Dangerous <<<}
    {>>> 0x00020000 REFR light: Doesn't light landscape <<<}
    {0x00020000}'Dangerous / Off limits',
    {0x00040000}'Compressed',
    {0x00080000}'Can''t wait',
    {>>> 0x00100000 ACTI: Ignore Object Interaction <<<}
    {0x00100000}'Ignore Object Interaction',
    {0x00200000}'Unknown 22',
    {0x00400000}'Unknown 23',
    {>>> 0x00800000 ACTI: Is Marker <<<}
    {0x00800000}'Is Marker',
    {0x01000000}'Unknown 25',
    {>>> 0x02000000 ACTI: Obstacle <<<}
    {0x02000000}'Obstacle / (REFR) No AI Acquire',
    {>>> 0x03000000 ACTI: Filter <<<}
    {0x03000000}'NavMesh Gen - Filter',
    {>>> 0x08000000 ACTI: Bounding Box <<<}
    {0x08000000}'NavMesh Gen - Bounding Box',
    {0x10000000}'Must Exit to Talk',
    {>>> 0x20000000 ACTI: Child Can Use <<<}
    {0x20000000}'Child Can Use / (REFR) Don''t Havok Settle',
    {>>> 0x40000000 ACTI: GROUND <<<}
    {0x40000000}'NavMesh Gen - Ground / (REFR) NoRespawn',
    {0x80000000}'(REFR) MultiBound'
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
    wbFormID('FormID', cpFormID),
    wbByteArray('Version Control Info 1', 4, cpIgnore),
    wbInteger('Form Version', itU16, nil, cpIgnore),
    wbByteArray('Version Control Info 2', 2, cpIgnore)
  ]);

  wbSizeOfMainRecordStruct := 24;

  wbIgnoreRecords.Add(XXXX);

  wbXRGD := wbByteArray(XRGD, 'Ragdoll Data');
  wbXRGB := wbByteArray(XRGB, 'Ragdoll Biped Data');

  wbMusicEnum := wbEnum(['Default', 'Public', 'Dungeon']);
  wbSoundLevelEnum := wbEnum([
     'Loud',
     'Normal',
     'Silent',
     'Very Loud'
    ]);

  wbEntryPointsEnum := wbEnum([
    { 0} 'Calculate Weapon Damage',
    { 1} 'Calculate My Critical Hit Chance',
    { 2} 'Calculate My Critical Hit Damage',
    { 3} 'Calculate Mine Explode Chance',
    { 4} 'Adjust Limb Damage',
    { 5} 'Adjust Book Skill Points',
    { 6} 'Mod Recovered Health',
    { 7} 'Get Should Attack',
    { 8} 'Mod Buy Prices',
    { 9} 'Add Leveled List On Death',
    {10} 'Get Max Carry Weight',
    {11} 'Mod Addiction Chance',
    {12} 'Mod Addiction Duration',
    {13} 'Mod Positive Chem Duration',
    {14} 'Activate',
    {15} 'Ignore Running During Detection',
    {16} 'Ignore Broken Lock',
    {17} 'Mod Enemy Critical Hit Chance',
    {18} 'Mod Sneak Attack Mult',
    {19} 'Mod Max Placeable Mines',
    {20} 'Mod Bow Zoom',
    {21} 'Mod Recover Arrow Chance',
    {22} 'Mod Skill Use',
    {23} 'Mod Telekinesis Distance',
    {24} 'Mod Telekinesis Damage Mult',
    {25} 'Mod Telekinesis Damage',
    {26} 'Mod Bashing Damage',
    {27} 'Mod Power Attack Stamina',
    {28} 'Mod Power Attack Damage',
    {29} 'Mod Spell Magnitude',
    {30} 'Mod Spell Duration',
    {31} 'Mod Secondary Value Weight',
    {32} 'Mod Armor Weight',
    {33} 'Mod Incoming Stagger',
    {34} 'Mod Target Stagger',
    {35} 'Mod Attack Damage',
    {36} 'Mod Incoming Damage',
    {37} 'Mod Target Damage Resistance',
    {38} 'Mod Spell Cost',
    {39} 'Mod Percent Blocked',
    {40} 'Mod Shield Deflect Arrow Chance',
    {41} 'Mod Incoming Spell Magnitude',
    {42} 'Mod Incoming Spell Duration',
    {43} 'Mod Player Intimidation',
    {44} 'Mod Player Reputation',
    {45} 'Mod Favor Points',
    {46} 'Mod Bribe Amount',
    {47} 'Mod Detection Light',
    {48} 'Mod Detection Movement',
    {49} 'Mod Soul Gem Recharge',
    {50} 'Set Sweep Attack',
    {51} 'Apply Combat Hit Spell',
    {52} 'Apply Bashing Spell',
    {53} 'Apply Reanimate Spell',
    {54} 'Set Boolean Graph Variable',
    {55} 'Mod Spell Casting Sound Event',
    {56} 'Mod Pickpocket Chance',
    {57} 'Mod Detection Sneak Skill',
    {58} 'Mod Falling Damage',
    {59} 'Mod Lockpick Sweet Spot',
    {60} 'Mod Sell Prices',
    {61} 'Can Pickpocket Equipped Item',
    {62} 'Mod Lockpick Level Allowed',
    {63} 'Set Lockpick Starting Arc',
    {64} 'Set Progression Picking',
    {65} 'Make Lockpicks Unbreakable',
    {66} 'Mod Alchemy Effectiveness',
    {67} 'Apply Weapon Swing Spell',
    {68} 'Mod Commanded Actor Limit',
    {69} 'Apply Sneaking Spell',
    {70} 'Mod Player Magic Slowdown',
    {71} 'Mod Ward Magicka Absorption Pct',
    {72} 'Mod Initial Ingredient Effects Learned',
    {73} 'Purify Alchemy Ingredients',
    {74} 'Filter Activation',
    {75} 'Can Dual Cast Spell',
    {76} 'Mod Tempering Health',
    {77} 'Mod Enchantment Power',
    {78} 'Mod Soul Pct Captured to Weapon',
    {79} 'Mod Soul Gem Enchanting',
    {80} 'Mod # Applied Enchantments Allowed',
    {81} 'Set Activate Label',
    {82} 'Mod Shout OK',
    {83} 'Mod Poison Dose Count',
    {84} 'Should Apply Placed Item',
    {85} 'Mod Armor Rating',
    {86} 'Mod Lockpicking Crime Chance',
    {87} 'Mod Ingredients Harvested',
    {88} 'Mod Spell Range (Target Loc.)',
    {89} 'Mod Potions Created',
    {90} 'Mod Lockpicking Key Reward Chance'
  ]);

  wbLocationEnum := wbEnum([
    {0} 'Near reference',
    {1} 'In cell',
    {2} 'Near package start location',
    {3} 'Near editor location',
    {4} 'Object ID',
    {5} 'Object Type',
    {6} 'Near linked reference',
    {7} 'At package location',
    {8} 'Alias (reference)',
    {9} 'Alias (location)',
   {10} 'Unknown 10',
   {11} 'Unknown 11',
   {12} 'Near self'
  ]);

  wbWeaponAnimTypeEnum := wbEnum([
    {0} 'HandToHandMelee',
    {1} 'OneHandSword',
    {2} 'OneHandDagger',
    {3} 'OneHandAxe',
    {4} 'OneHandMace',
    {5} 'TwoHandSword',
    {6} 'TwoHandAxe',
    {7} 'Bow',
    {8} 'Staff',
    {9} 'Crossbow'
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

  wbEDID := wbString(EDID, 'Editor ID', 0, cpBenign);
  wbEDIDReq := wbString(EDID, 'Editor ID', 0, cpBenign, True);
  wbFULL := wbLString(FULL, 'Name', 0, cpTranslate);
  wbFULLActor := wbLString(FULL, 'Name', 0, cpTranslate, False, wbActorTemplateUseBaseData);
  wbFULLReq := wbLString(FULL, 'Name', 0, cpNormal, True);
  wbDESC := wbLString(DESC, 'Description', 0, cpTranslate);
  wbDESCReq := wbLString(DESC, 'Description', 0, cpTranslate, True);
  wbXSCL := wbFloat(XSCL, 'Scale');

  wbOBND := wbStruct(OBND, 'Object Bounds', [
    wbInteger('X1', itS16),
    wbInteger('Y1', itS16),
    wbInteger('Z1', itS16),
    wbInteger('X2', itS16),
    wbInteger('Y2', itS16),
    wbInteger('Z2', itS16)
  ]);

  wbOBNDReq := wbStruct(OBND, 'Object Bounds', [
    wbInteger('X1', itS16),
    wbInteger('Y1', itS16),
    wbInteger('Z1', itS16),
    wbInteger('X2', itS16),
    wbInteger('Y2', itS16),
    wbInteger('Z2', itS16)
  ], cpNormal, True);

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

  wbScriptObject := wbStruct('Object', [
    wbInteger('Unknown', itU16),
    wbInteger('AliasID', itU16),
    wbFormID('FormID')
  ]);

  wbScriptEntry := wbStruct('Script', [
    wbLenString('scriptName', 2),
    wbInteger('Unknown', itU8),
    //wbInteger('propertyCount', itU16),
    wbArray('Properties', wbStruct('Property', [
      wbLenString('propertyName', 2),
      wbInteger('propertyType', itU8, wbPropTypeEnum),
      wbInteger('Unknown', itU8),
      wbUnion('Value', wbScriptPropertyDecider, [
        {00} wbByteArray('Unknown', 0, cpIgnore),
        {01} wbByteArray('Object', 8), {wbScriptObject,}
        {02} wbLenString('String', 2),
        {03} wbInteger('Int32', itU32),
        {04} wbFloat('Float'),
        {05} wbInteger('Bool', itU8, wbEnum(['False', 'True'])),
        {11} wbArray('Array of Object', wbByteArray('Element', 8), -1),
        {12} wbArray('Array of String', wbLenString('Element', 2), -1),
        {13} wbArray('Array of Int32', wbInteger('Element', itU32), -1),
        {14} wbArray('Array of Float', wbFloat('Element'), -1),
        {15} wbArray('Array of Bool', wbInteger('Element', itU8, wbEnum(['False', 'True'])), -1)
      ])
    ]), -2)
  ]);

  wbScriptFragments := wbStruct('Script Fragments', [
    wbUnknown
// records have different fragments format, needs union
//    wbInteger('Unknown', itS8),
//    wbInteger('fragmentCount', itU16),
//    wbLenString('fileName', 2),
//    wbArray('Fragments', wbStruct('fragment', [
//      wbInteger('Quest Stage Index', itU16),
//      wbInteger('Unknown', itS16),
//      wbInteger('Unknown', itS32),
//      wbInteger('Unknown', itS8),
//      wbLenString('scriptName', 2),
//      wbLenString('fragmentName', 2)
//    ]), [], wbScriptFragmentsCounter),
//    wbArray('Aliases', wbStruct('Alias', [
//      wbInteger('Unknown', itS16),
//      wbInteger('AliasID', itU16),
//      wbInteger('Unknown', itS32),
//      wbInteger('Unknown', itS16),
//      wbInteger('objFormat', itS16),
//      wbArray('Scripts', wbScriptEntry, -2)
//    ]), -2)
  ]);

  wbVMAD := wbStruct(VMAD, 'Papyrus Script Data', [
    wbInteger('version', itS16),
    wbInteger('objFormat', itS16),
    wbInteger('scriptCount', itU16),
    {>>> For some reason in rare cases when one of the properties type is String <<<}
    {>>> and VMAD has fragments section, wbScriptEntry gets bugged on that property <<<}
    {>>> Example: Quest [00091F1A] <dunLabyrinthian> "Labyrinthian" <<< }
    {>>> Scripts parsing replaced with bytearray for better times <<<}
    wbByteArray('Scripts')
    //wbArray('Scripts', wbScriptEntry, -2), // comment out scriptCount when -2
    //wbScriptFragments
  ], cpNormal, False, nil, -1);

  wbAttackData := wbRStruct('Attack Data', [
    wbStruct(ATKD, 'Attack Data', [
      wbFloat('Damage Mult'),
      wbFloat('Attack Chance'),
      wbFormIDCk('Attack Spell', [SPEL, SHOU, NULL]),
      wbInteger('Attack Flags', itU32, wbFlags([
        {0x00000001}'Ignore Weapon',
        {0x00000002}'Bash Attack',
        {0x00000004}'Power Attack',
        {0x00000008}'Left Attack',
        {0x00000010}'Rotating Attack',
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
        {0x00008000}'Unknown 16'
      ], True)),
      wbFloat('Attack Angle'),
      wbFloat('Strike Angle'),
      wbFloat('Stagger'),
      wbFormIDCk('Attack Type', [KYWD, NULL]),
      wbFloat('Knockdown'),
      wbFloat('Recovery Time'),
      wbFloat('Stamina Mult')
    ]),
    wbString(ATKE, 'Attack Event')
  ], []);

  wbLocationData := wbStruct('Location Data', [
    wbInteger('Type', itS32, wbLocationEnum),
    wbUnion('Location Value', wbTypeDecider, [
      {0} wbFormIDCkNoReach('Reference', [REFR, PGRE, ACHR], True),
      {1} wbFormIDCkNoReach('Cell', [CELL]),
      {2} wbByteArray('Near Package Start Location', 4, cpIgnore),
      {3} wbByteArray('Near Editor Location', 4, cpIgnore),
      {4} wbFormIDCkNoReach('Object ID', [ACTI, DOOR, STAT, FURN, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH]),
      {5} wbInteger('Object Type', itU32, wbObjectTypeEnum),
      {6} wbFormIDCk('Keyword', [KYWD]),
      {7} wbByteArray('Unknown', 4, cpIgnore),
      {8} wbByteArray('Alias ID', 4),
      {9} wbFormIDCkNoReach('Reference', [REFR, PGRE, ACHR], True),
     {10} wbByteArray('Unknown', 4, cpIgnore),
     {11} wbByteArray('Unknown', 4, cpIgnore),
     {12} wbByteArray('Unknown', 4, cpIgnore)
    ]),
    wbInteger('Radius', itS32)
  ]);

  wbTargetData := wbStruct('Target Data', [
    wbInteger('Type', itS32, wbEnum([
      {0} 'Specific Reference',
      {1} 'Object ID',
      {2} 'Object Type',
      {3} 'Linked Reference',
      {4} 'Ref Alias',
      {5} 'Unknown 5',
      {6} 'Self'
    ]), cpNormal, False, nil, nil, 2),
    wbUnion('Target', wbTypeDecider, [
      {0} wbFormIDCkNoReach('Reference', [ACHR, REFR, PGRE], True),
      {1} wbFormIDCkNoReach('Object ID', [ACTI, DOOR, STAT, FURN, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, FACT, FLST, IDLM]),
      {2} wbInteger('Object Type', itU32, wbObjectTypeEnum),
      {3} wbFormID('Reference'),
      {4} wbByteArray('Alias ID', 4),
      {5} wbByteArray('Unknown', 4, cpIgnore),
      {6} wbByteArray('Unknown', 4, cpIgnore)
    ]),
    wbInteger('Count / Distance', itS32)
  ]);

  wbPRKR := wbStruct(PRKR, 'Perk Record', [
    wbFormIDCk('Perk', [PERK]),
    wbFloat
  ]);

  wbREPL := wbFormIDCkNoReach(REPL, 'Repair List', [FLST]);
  wbEITM := wbFormIDCk(EITM, 'Object Effect', [ENCH, SPEL]);
  wbBIPL := wbFormIDCk(BIPL, 'Biped Model List', [FLST]);

  wbPosRot :=
    wbStruct('Position/Rotation', [
      wbStruct('Position', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]),
      wbStruct('Rotation', [
        wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
      ])
    ]);

  wbDATAPosRot :=
    wbStruct(DATA, 'Position/Rotation', [
      wbStruct('Position', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]),
      wbStruct('Rotation', [
        wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
      ])
    ], cpNormal, True);

  wbMO2S :=
    wbArrayS(MO2S, 'Alternate Textures',
      wbStructSK([0, 2], 'Alternate Texture', [
        wbLenString('3D Name'),
        wbFormIDCk('New Texture', [TXST]),
        wbInteger('3D Index', itS32)
      ]),
    -1);
  wbMO3S :=
    wbArrayS(MO3S, 'Alternate Textures',
      wbStructSK([0, 2], 'Alternate Texture', [
        wbLenString('3D Name'),
        wbFormIDCk('New Texture', [TXST]),
        wbInteger('3D Index', itS32)
      ]),
    -1);
  wbMO4S :=
    wbArrayS(MO4S, 'Alternate Textures',
      wbStructSK([0, 2], 'Alternate Texture', [
        wbLenString('3D Name'),
        wbFormIDCk('New Texture', [TXST]),
        wbInteger('3D Index', itS32)
      ]),
    -1);
  wbMO5S :=
    wbArrayS(MO5S, 'Alternate Textures',
      wbStructSK([0, 2], 'Alternate Texture', [
        wbLenString('3D Name'),
        wbFormIDCk('New Texture', [TXST]),
        wbInteger('3D Index', itS32)
      ]),
    -1);

  wbMOSD :=
    wbInteger(MOSD, 'FaceGen Model Flags', itU8, wbFlags([
      'Head',
      'Torso',
      'Right Hand',
      'Left Hand'
    ]));

  wbMODS :=
    wbArrayS(MODS, 'Alternate Textures',
      wbStructSK([0, 2], 'Alternate Texture', [
        wbLenString('3D Name'),
        wbFormIDCk('New Texture', [TXST]),
        wbInteger('3D Index', itS32)
      ]),
    -1);

  wbMODD :=
    wbInteger(MODD, 'FaceGen Model Flags', itU8, wbFlags([
      'Head',
      'Torso',
      'Right Hand',
      'Left Hand'
    ]));

//------------------------------------------------------------------------------
// wbMODL MODL, MODB, MODT, MODS, MODD
//------------------------------------------------------------------------------
  wbMODL :=
    wbRStructSK([0], 'Model', [
      wbString(MODL, 'Model Filename'),
      wbByteArray(MODB, 'Unknown', 4, cpIgnore),
      wbMODT,
      wbMODS,
      wbMODD
    ], [], cpNormal, False, nil, True);

  wbMODLActor :=
    wbRStructSK([0], 'Model', [
      wbString(MODL, 'Model Filename'),
      wbByteArray(MODB, 'Unknown', 4, cpIgnore),
      wbByteArray(MODT, 'Texture Files Hashes', 0, cpIgnore),
      wbMODT,
      wbMODS,
      wbMODD
    ], [], cpNormal, False, wbActorTemplateUseModelAnimation, True);

  wbMODLReq :=
    wbRStructSK([0], 'Model', [
      wbString(MODL, 'Model Filename'),
      wbByteArray(MODB, 'Unknown', 4, cpIgnore),
      wbByteArray(MODT, 'Texture Files Hashes', 0, cpIgnore),
      wbMODT,
      wbMODS,
      wbMODD
    ], [], cpNormal, True, nil, True);

  wbDMDSs := wbArrayS(DMDS, 'Alternate Textures',
    wbStructSK([0, 2], 'Alternate Texture', [
      wbLenString('3D Name'),
      wbFormIDCk('New Texture', [TXST]),
      wbInteger('3D Index', itS32)
    ]),
  -1);

//------------------------------------------------------------------------------
// wbDEST DEST, DSTD, DMDL, DMDT, DMDS, DSTF
//------------------------------------------------------------------------------
  wbDEST := wbRStruct('Destructable', [
    wbStruct(DEST, 'Header', [
      wbInteger('Health', itS32),
      wbInteger('DEST Count', itU8),
      wbInteger('VATS Targetable', itU8, wbEnum(['False', 'True'])),
      wbByteArray('Unknown', 2)
    ]),
    wbRArray('Stages',  // Begin Stage Array
      wbRStruct('Stage', [ // Begin Stage RStruct
        wbStruct(DSTD, 'Destruction Stage Data', [ // Begin DSTD
          wbInteger('Health %', itU8),
          wbInteger('Index', itU8),
          wbInteger('Model Damage Stage', itU8),
          wbInteger('Flags', itU8, wbFlags([
            'Cap Damage',
            'Disable',
            'Destroy',
            'Ignore External Dmg'
          ])),
          wbInteger('Self Damage per Second', itS32),
          wbFormIDCk('Explosion', [EXPL, NULL]),
          wbFormIDCk('Debris', [DEBR, NULL]),
          wbInteger('Debris Count', itS32)
        ], cpNormal, True), // End DSTD
        wbRStructSK([0], 'Model', [ // Begin DMDL
          wbString(DMDL, 'Model Filename'),
          wbDMDT,
          wbDMDSs
        ], [], cpNormal, False, nil), // End DMDL
        wbEmpty(DSTF, 'End Marker', cpNormal, True)
      ], [], cpNormal, False, nil) // Begin Stage RStruct
    ) // End Stage Array
  ], [], cpNormal, False, nil);

  wbDESTActor := wbRStruct('Destructable', [
    wbStruct(DEST, 'Header', [
      wbInteger('Health', itS32),
      wbInteger('Count', itU8),
      wbInteger('VATS Targetable', itU8, wbEnum(['False', 'True'])),
      wbByteArray('Unknown', 2)
    ]),
    wbRArray('Stages',  // Begin Stage Array
      wbRStruct('Stage', [ // Begin Stage RStruct
        wbStruct(DSTD, 'Destruction Stage Data', [ // Begin DSTD
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
        ], cpNormal, True), // End DSTD
        wbRStructSK([0], 'Model', [ // Begin DMDL
          wbString(DMDL, 'Model Filename')
        ], []), // End DMDL
        wbDMDT,
        wbDMDSs,
        wbEmpty(DSTF, 'End Marker', cpNormal, True)
      ], []) // Begin Stage RStruct
    ) // End Stage Array
  ], [], cpNormal, False, wbActorTemplateUseModelAnimation);

  wbSCRI := wbFormIDCk(SCRI, 'Script', [SCPT]);
  wbSCRIActor := wbFormIDCk(SCRI, 'Script', [SCPT], False, cpNormal, False, wbActorTemplateUseScript);
  wbENAM := wbFormIDCk(ENAM, 'Object Effect', [ENCH]);

  wbXLOD := wbArray(XLOD, 'Distant LOD Data', wbFloat('Unknown'), 3);

  wbXESP := wbStruct(XESP, 'Enable Parent', [
    wbFormIDCk('Reference', [REFR, ACHR, PGRE]),
    wbInteger('Flags', itU8, wbFlags([
      'Set Enable State to Opposite of Parent',
      'Pop In'
    ])),
    wbByteArray('Unknown', 3)
  ]);

  wbSCHRReq := wbStruct(SCHR, 'Basic Script Data', [
    wbByteArray('Unknown', 4),
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
        wbFormIDCk(SCRO, 'Global Reference',
          [ACTI, DOOR, STAT, FURN, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, IMAD,
           BOOK, KEYM, ALCH, LIGH, QUST, PLYR, PACK, LVLI, ECZN, EXPL, FLST, IDLM, PMIS,
           FACT, ACHR, REFR, ACRE, GLOB, DIAL, CELL, SOUN, MGEF, WTHR, CLAS, EFSH, RACE,
           LVLC, CSTY, WRLD, SCPT, IMGS, MESG, MSTT, MUSC, PERK, PGRE, PROJ, LVLN,
           WATR, ENCH, TREE, REPU, REGN, CSNO, CHAL, IMOD, RCCT, CMNY, CDCK, CHIP, CCRD,
           NULL]),
        wbInteger(SCRV, 'Local Variable', itU32)
      ], [])
    );

  wbSLSD := wbStructSK(SLSD, [0], 'Local Variable Data', [
    wbInteger('Index', itU32),
    wbByteArray('Unknown', 12),
    wbInteger('Flags', itU8, wbFlags(['IsLongOrShort']), cpCritical),
    wbByteArray('Unknown', 7)
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
  ], [], cpNormal, False, nil, False, wbEmbeddedScriptAfterLoad);

  wbEmbeddedScriptPerk := wbRStruct('Embedded Script', [
    wbSCHRReq,
    wbByteArray(SCDA, 'Compiled Embedded Script', 0, cpNormal, True),
    wbStringScript(SCTX, 'Embedded Script Source', 0, cpNormal, True),
    wbRArrayS('Local Variables', wbRStructSK([0], 'Local Variable', [
      wbSLSD,
      wbString(SCVR, 'Name', 0, cpCritical, True)
    ], [])),
    wbSCROs
  ], [], cpNormal, False, wbEPF2DontShow, False, wbEmbeddedScriptAfterLoad);

  wbPDTO :=
    wbStruct(PDTO, 'Topic Data', [
      wbInteger('Type', itU32, wbEnum([
        'Topic Ref',
        'Topic Subtype'
      ])),
      wbUnion('Data', wbTypeDecider, [
        wbFormIDCk('Topic', [DIAL, NULL]),
        wbString('Subtype', 4)
      ])
    ]);

  wbPDTOs := wbRArray('Topic', wbPDTO, cpNormal, False, nil);

  wbEmbeddedScriptReq := wbRStruct('Embedded Script', [
    wbSCHRReq,
    wbByteArray(SCDA, 'Compiled Embedded Script', 0, cpNormal{, True}),
    wbStringScript(SCTX, 'Embedded Script Source', 0, cpNormal{, True}),
    wbRArrayS('Local Variables', wbRStructSK([0], 'Local Variable', [
      wbSLSD,
      wbString(SCVR, 'Name', 0, cpCritical, True)
    ], [])),
    wbSCROs
  ], [], cpNormal, True, nil, False, wbEmbeddedScriptAfterLoad);

  wbXLCM := wbInteger(XLCM, 'Level Modifier', itS32, wbEnum([
    'Easy',
    'Medium',
    'Hard',
    'Very Hard'
  ]));

  wbOwnership := wbRStruct('Ownership', [
    wbFormIDCkNoReach(XOWN, 'Owner', [FACT, ACHR, NPC_]),
    wbInteger(XRNK, 'Faction rank', itS32)
  ], []);

  wbXGLB := wbFormIDCk(XGLB, 'Global variable', [GLOB]);

end;

procedure DefineTES5b;
begin

  wbRecord(ACHR, 'Placed NPC', [
    wbEDID,
    wbVMAD,
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
      wbPDTOs,
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

    wbRArray('Linked References', wbStruct(XLKR, 'Linked Reference', [
      wbFormIDCk('Keyword', [KYWD, NULL]),
      wbFormIDCk('Ref', [REFR, ACRE, ACHR, PGRE])
    ])),

    {--- Activate Parents ---}
    wbRStruct('Activate Parents', [
      wbInteger(XAPD, 'Flags', itU8, wbFlags([
        'Parent Activate Only'
      ], True)),
      wbRArrayS('Activate Parent Refs',
        wbStructSK(XAPR, [0], 'Activate Parent Ref', [
          wbFormIDCk('Reference', [REFR, ACRE, ACHR, PGRE]),
          wbFloat('Delay')
        ])
      )
    ], []),

    {--- Linked Ref ---}
    wbStruct(XCLP, 'Linked Reference Color', [
      wbStruct('Link Start Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unknown', 1)
      ]),
      wbStruct('Link End Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unknown', 1)
      ])
    ]),

    wbFormIDCk(XLCN, 'Persistent Location', [LCTN]),
    wbFormIDCk(XLRL, 'Location Reference', [LCRT, NULL]),
    wbEmpty(XIS2, 'Ignored by Sandbox'),
    wbArray(XLRT, 'Location Ref Type', wbFormIDCk('Ref', [LCRT, NULL])),
		wbFormIDCk(XHOR, 'Horse', [ACHR]),
    wbFloat(XHTW, 'Head-Tracking Weight'),
    wbFloat(XFVC, 'Favor Cost'),

    {--- Enable Parent ---}
    wbXESP,

    {--- Ownership ---}
    wbOwnership,

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


  {>>> wbRecordFlags: 0x00000000 ACTI: Collision Geometry (default) <<<}
  wbRecord(ACTI, 'Activator', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbDEST,
    wbKeywords,
    wbStruct(PNAM, 'Marker Color', [
      wbInteger('Red', itU8),
      wbInteger('Green', itU8),
      wbInteger('Blue', itU8),
      wbInteger('Unused', itU8)
    ]),
    wbFormIDCk(SNAM, 'Sound - Looping', [SNDR]),
    wbFormIDCk(VNAM, 'Sound - Activation', [SNDR]),
    wbFormIDCk(WNAM, 'Water Type', [WATR]),
    wbLString(RNAM, 'Activate Text Override'),
    wbInteger(FNAM, 'Flags', itU16, wbFlags([
      'No Displacement',
      'Ignored by Sandbox'
    ])),
    wbFormIDCk(KNAM, 'Interaction Keyword', [KYWD])
  ]);

  wbRecord(TACT, 'Talking Activator', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL, // wbMODL MODL, MODB, MODT, MODS, MODD
    wbDEST, // wbDEST DEST, DSTD, DMDL, DMDT, DSTF
    wbKeywords,
    wbUnknown(PNAM, cpNormal, True),
    wbUnknown(FNAM, cpNormal, True),
    wbFormIDCk(VNAM, 'Sound - Activation', [SNDR])
  ]);

  wbICON := wbRStruct('Icon', [
    wbString(ICON, 'Large Icon filename'),
    wbString(MICO, 'Small Icon filename')
  ], [], cpNormal, False, nil, True);

  wbICONReq := wbRStruct('Icon', [
    wbString(ICON, 'Large Icon filename'),
    wbString(MICO, 'Small Icon filename')
  ], [], cpNormal, True, nil, True);

  wbICO2 := wbRStruct('Icon 2 (female)', [
    wbString(ICO2, 'Large Icon filename'),
    wbString(MIC2, 'Small Icon filename')
  ], [], cpNormal, False, nil, True);

  wbSounds := wbRStruct('Sound', [
    wbFormIDCk(YNAM, 'Pick Up', [SOUN]),
    wbFormIDCk(ZNAM, 'Drop', [SOUN])
  ], [], cpNormal, False, nil, True);

  wbVatsValueFunctionEnum :=
    wbEnum([
      { 0} 'Weapon Is',
      { 1} 'Weapon In List',
      { 2} 'Target Is',
      { 3} 'Target In List',
      { 4} 'Target Distance',
      { 5} 'Target Part',
      { 6} 'VATS Action',
      { 7} 'Is Success',
      { 8} 'Is Critical',
      { 9} 'Critical Effect Is',
      {10} 'Critical Effect In List',
      {11} 'Is Fatal',
      {12} 'Explode Part',
      {13} 'Dismember Part',
      {14} 'Cripple Part',
      {15} 'Weapon Type Is',
      {16} 'Is Stranger',
      {17} 'Is Paralyzing Palm',
      {18} 'Projectile Type Is',
      {19} 'Delivery Type Is',
      {20} 'Casting Type Is'
    ]);

  wbActorValueEnum :=
    wbEnum([
    {00} 'Aggresion',
    {01} 'Confidence',
    {02} 'Energy',
    {03} 'Morality',
    {04} 'Mood',
    {05} 'Assistance',
    {06} 'One-Handed',
    {07} 'Two-Handed',
    {08} 'Archery',
    {09} 'Block',
    {10} 'Smithing',
    {11} 'Heavy Armor',
    {12} 'Light Armor',
    {13} 'Pickpocket',
    {14} 'Lockpicking',
    {15} 'Sneak',
    {16} 'Alchemy',
    {17} 'Speech',
    {18} 'Alteration',
    {19} 'Conjuration',
    {20} 'Destruction',
    {21} 'Illusion',
    {22} 'Restoration',
    {23} 'Enchanting',
    {24} 'Health',
    {25} 'Magicka',
    {26} 'Stamina',
    {27} 'Heal Rate',
    {28} 'Magicka Rate',
    {29} 'Stamina Rate',
    {30} 'Speed Mult',
    {31} 'Inventory Weight',
    {32} 'Carry Weight',
    {33} 'Critical Chance',
    {34} 'Melee Damage',
    {35} 'Unarmed Damage',
    {36} 'Mass',
    {37} 'Voice Points',
    {38} 'Voice Rate',
    {39} 'Damage Resist',
    {40} 'Poison Resist',
    {41} 'Resist Fire',
    {42} 'Resist Shock',
    {43} 'Resist Frost',
    {44} 'Resist Magic',
    {45} 'Resist Disease',
    {46} 'Unknown 46',
    {47} 'Unknown 47',
    {48} 'Unknown 48',
    {49} 'Unknown 49',
    {50} 'Unknown 50',
    {51} 'Unknown 51',
    {52} 'Unknown 52',
    {53} 'Paralysis',
    {54} 'Invisibility',
    {55} 'Night Eye',
    {56} 'Detect Life Range',
    {57} 'Water Breathing',
    {58} 'Water Walking',
    {59} 'Unknown 59',
    {60} 'Fame',
    {61} 'Infamy',
    {62} 'Jumping Bonus',
    {63} 'Ward Power',
    {64} 'Right Item Charge',
    {65} 'Armor Perks',
    {66} 'Shield Perks',
    {67} 'Ward Deflection',
    {68} 'Variable01',
    {69} 'Variable02',
    {70} 'Variable03',
    {71} 'Variable04',
    {72} 'Variable05',
    {73} 'Variable06',
    {74} 'Variable07',
    {75} 'Variable08',
    {76} 'Variable09',
    {77} 'Variable10',
    {78} 'Bow Speed Bonus',
    {79} 'Favor Active',
    {80} 'Favors Per Day',
    {81} 'Favors Per Day Timer',
    {82} 'Left Item Charge',
    {83} 'Absorb Chance',
    {84} 'Blindness',
    {85} 'Weapon Speed Mult',
    {86} 'Shout Recovery Mult',
    {87} 'Bow Stagger Bonus',
    {88} 'Telekinesis',
    {89} 'Favor Points Bonus',
    {90} 'Last Bribed Intimidated',
    {91} 'Last Flattered',
    {92} 'Movement Noise Mult',
    {93} 'Bypass Vendor Stolen Check',
    {94} 'Bypass Vendor Keyword Check',
    {95} 'Waiting For Player',
    {96} 'One-Handed Modifier',
    {97} 'Two-Handed Modifier',
    {98} 'Marksman Modifier',
    {99} 'Block Modifier',
   {100} 'Smithing Modifier',
   {101} 'Heavy Armor Modifier',
   {102} 'Light Armor Modifier',
   {103} 'Pickpocket Modifier',
   {104} 'Lockpicking Modifier',
   {105} 'Sneaking Modifier',
   {106} 'Alchemy Modifier',
   {107} 'Speechcraft Modifier',
   {108} 'Alteration Modifier',
   {109} 'Conjuration Modifier',
   {110} 'Destruction Modifier',
   {111} 'Illusion Modifier',
   {112} 'Restoration Modifier',
   {113} 'Enchanting Modifier',
   {114} 'One-Handed Skill Advance',
   {115} 'Two-Handed Skill Advance',
   {116} 'Marksman Skill Advance',
   {117} 'Block Skill Advance',
   {118} 'Smithing Skill Advance',
   {119} 'Heavy Armor Skill Advance',
   {120} 'Light Armor Skill Advance',
   {121} 'Pickpocket Skill Advance',
   {122} 'Lockpicking Skill Advance',
   {123} 'Sneaking Skill Advance',
   {124} 'Alchemy Skill Advance',
   {125} 'Speechcraft Skill Advance',
   {126} 'Alteration Skill Advance',
   {127} 'Conjuration Skill Advance',
   {128} 'Destruction Skill Advance',
   {129} 'Illusion Skill Advance',
   {130} 'Restoration Skill Advance',
   {131} 'Enchanting Skill Advance',
   {132} 'Left Weapon Speed Multiply',
   {133} 'Dragon Souls',
   {134} 'Combat Health Regen Multiply',
   {135} 'One-Handed Power Modifier',
   {136} 'Two-Handed Power Modifier',
   {137} 'Marksman Power Modifier',
   {138} 'Block Power Modifier',
   {139} 'Smithing Power Modifier',
   {140} 'Heavy Armor Power Modifier',
   {141} 'Light Armor Power Modifier',
   {142} 'Pickpocket Power Modifier',
   {143} 'Lockpicking Power Modifier',
   {144} 'Sneaking Power Modifier',
   {145} 'Alchemy Power Modifier',
   {146} 'Speechcraft Power Modifier',
   {147} 'Alteration Power Modifier',
   {148} 'Conjuration Power Modifier',
   {149} 'Destruction Power Modifier',
   {150} 'Illusion Power Modifier',
   {151} 'Restoration Power Modifier',
   {152} 'Enchanting Power Modifier',
   {153} 'Dragon Rend',
   {154} 'Attack Damage Mult',
   {155} 'Heal Rate Mult',
   {156} 'Magicka Rate Mult',
   {157} 'Stamina Rate Mult',
   {158} 'Werewolf Perks',
   {159} 'Vampire Perks',
   {160} 'Grab Actor Offset',
   {161} 'Grabbed',
   {162} 'Unknown 162',
   {163} 'Reflect Damage'
      ], [
        -1, 'None'
      ]);

  wbModEffectEnum :=
    wbEnum([
      {00} 'None',
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
      'Unknown 1',
      'Unknown 2',
      'Unknown 3',
      'Unknown 4',
      'Unknown 5',
      'Unknown 6',
      'One Handed',
      'Two Handed',
      'Archery',
      'Block',
      'Smithing',
      'Heavy Armor',
      'Light Armor',
      'Pickpocket',
      'Lockpicking',
      'Sneak',
      'Alchemy',
      'Speech',
      'Alteration',
      'Conjuration',
      'Destruction',
      'Illusion',
      'Restoration',
      'Enchanting'
    ], [
    -1, 'None'
    ]);

  wbCastEnum := wbEnum([
    {0} 'Constant Effect',
    {1} 'Fire and Forget',
    {2} 'Concentration',
    {3} 'Scroll'
  ]);

  wbTargetEnum := wbEnum([
    {0} 'Self',
    {1} 'Touch',
    {2} 'Aimed',
    {3} 'Target Actor',
    {4} 'Target Location'
  ]);

  wbCrimeTypeEnum :=
    wbEnum([
      'Steal',
      'Pickpocket',
      'Trespass',
      'Attack',
      'Murder',
      'Escape Jail',
      'Werewolf Transformation'
    ], [
      -1, 'None'
    ]);

  wbActorValue := wbInteger('Actor Value', itS32, wbActorValueEnum);

  wbETYP := wbFormIDCk(ETYP, 'Equiptment Type', [EQUP, NULL]);
  wbETYPReq := wbFormIDCk(ETYP, 'Equiptment Type', [EQUP, NULL], False, cpNormal, True);

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

		wbMiscStatEnum :=
    wbEnum([], [
      Int64($FCDD5011), 'Animals Killed',
      Int64($366D84CF), 'Armor Improved',
      Int64($023497E6), 'Armor Made',
      Int64($8E20D7C9), 'Assaults',
      Int64($579FFA75), 'Automations Killed',
      Int64($B9B50725), 'Backstabs',
      Int64($ED6A0EF2), 'Barters',
      Int64($CCB952CE), 'Books Read',
      Int64($317E8B4C), 'Brawls Won',
      Int64($1D79006B), 'Bribes',
      Int64($3602DE8F), 'Bunnies Slaughtered',
      Int64($53D9E9B5), 'Chests Looted',
      Int64($683C1980), 'Civil War Quests Completed',
      Int64($66CCC50A), 'College of Winterhold Quests Completed',
      Int64($40B11EFE), 'Creatures Killed',
      Int64($22D5BA38), 'Critical Strikes',
      Int64($A930980F), 'Daedra Killed',
      Int64($3558374B), 'Daedric Quests Completed',
      Int64($37A76425), 'Dawnguard Quests Completed',
      Int64($2BDAC36F), 'Days as a Vampire',
      Int64($6E684590), 'Days as a Werewolf',
      Int64($B6F118DB), 'Days Jailed',
      Int64($3C626A90), 'Days Passed',
      Int64($8556AD88), 'Diseases Contracted',
      Int64($46D6FBBC), 'Dragon Souls Collected',
      Int64($AA444695), 'Dungeons Cleared',
      Int64($1A37F336), 'Eastmarch Bounty',
      Int64($5AC3A8ED), 'Falkreath Bounty',
      Int64($87B12ECC), 'Favorite School',
      Int64($518BBC4E), 'Favorite Shout',
      Int64($41DD77A6), 'Favorite Spell',
      Int64($171C5391), 'Favorite Weapon',
      Int64($4F041AA2), 'Fines Paid',
      Int64($9311B22B), 'Food Eaten',
      Int64($57C089F7), 'Gold Found',
      Int64($D20EDA4F), 'Haafingar Bounty',
      Int64($516C486D), 'Hjaalmarch Bounty',
      Int64($B0A1E32E), 'Horses Owned',
      Int64($EBAE35E8), 'Horses Stolen',
      Int64($FA024018), 'Hours Slept',
      Int64($CAD2ECA1), 'Hours Waiting',
      Int64($527DF857), 'Houses Owned',
      Int64($47B4A015), 'Ingredients Eaten',
      Int64($CE842356), 'Ingredients Harvested',
      Int64($7D2E57C0), 'Intimidations',
      Int64($C21702B5), 'Items Pickpocketed',
      Int64($82F190C2), 'Items Stolen',
      Int64($6627464B), 'Jail Escapes',
      Int64($3520E710), 'Largest Bounty',
      Int64($8A24FDE2), 'Locations Discovered',
      Int64($5829CC2E), 'Locks Picked',
      Int64($88089979), 'Magic Items Maid',
      Int64($7EA26C2D), 'Main Quests Completed',
      Int64($7187A208), 'Mauls',
      Int64($98EE55DC), 'Misc Objectives Completed',
      Int64($FA06230B), 'Most Gold Carried',
      Int64($D37C6909), 'Murders',
      Int64($22C2CBD0), 'Necks Bitten',
      Int64($BEEBCC87), 'Nirnroots Found',
      Int64($56CCFC54), 'NumVampirePerks',
      Int64($76A1A5C0), 'NumWerewolfPerks',
      Int64($F22A8133), 'People Killed',
      Int64($47A78467), 'Persuasions',
      Int64($F2BAC234), 'Pockets Picked',
      Int64($17C64668), 'Poisons Mixed',
      Int64($7D8F2EA6), 'Poisons Used',
      Int64($4228DE85), 'Potions Mixed',
      Int64($9631EC11), 'Potions Used',
      Int64($DE6C73FE), 'Questlines Completed',
      Int64($0D7B8B16), 'Quests Completed',
      Int64($BB39399E), 'Shouts Learned',
      Int64($731B5333), 'Shouts Mastered',
      Int64($F921D8BA), 'Shouts Unlocked',
      Int64($B1AE4792), 'Side Quests Completed',
      Int64($ACE470D7), 'Skill Books Read',
      Int64($F33130CE), 'Skill Increases',
      Int64($B556CC52), 'Sneak Attacks',
      Int64($A74CBE83), 'Soul Gems Used',
      Int64($C2C9E233), 'Souls Trapped',
      Int64($5EC89F1A), 'Spells Learned',
      Int64($B251A346), 'Standing Stones Found',
      Int64($05D45702), 'Stores Invested In',
      Int64($D0FE7031), 'The Companions Quests Completed',
      Int64($52BA68CB), 'The Dark Brotherhood Quests Completed',
      Int64($3E267D77), 'The Pale Bounty',
      Int64($69B48177), 'The Reach Bounty',
      Int64($50A23F69), 'The Rift Bounty',
      Int64($62B2E95D), 'Thieves'' Guild Quests Completed',
      Int64($944CEA93), 'Times Jailed',
      Int64($50AAB633), 'Times Shouted',
      Int64($99BB86D8), 'Total Lifetime Bounty',
      Int64($4C252391), 'Training Sessions',
      Int64($7AEA9C2B), 'Trespasses',
      Int64($A67626F4), 'Tribal Orcs Bounty',
      Int64($41D4BC0F), 'Undead Killed',
      Int64($F39260A1), 'Vampirism Cures',
      Int64($61A5C5A9), 'Weapons Disarmed',
      Int64($1D3BA844), 'Weapons Improved',
      Int64($25F1EA25), 'Weapons Made',
      Int64($38A2DD66), 'Werewolf Transformations',
      Int64($4231FA4F), 'Whiterun Bounty',
      Int64($92565767), 'Wings Plucked',
      Int64($C7FC518D), 'Winterhold Bounty',
      Int64($949FA7BC), 'Words of Power Learned',
      Int64($2C6E3FC0), 'Words of Power Unlocked'
    ]);

  wbAdvanceActionEnum := wbEnum([
    'Normal Usage',
    'Power Attack',
    'Bash',
    'Lockpick Success',
    'Lockpick Broken'
  ]);

  wbAlignmentEnum :=
    wbEnum([
      'Good',
      'Neutral',
      'Evil',
      'Very Good',
      'Very Evil'
    ]);

  wbAxisEnum :=
    wbEnum([], [
      88, 'X',
      89, 'Y',
      90, 'Z'
    ]);

  wbCastingSourceEnum := wbEnum([
    'Left',
    'Right',
    'Voice',
    'Instant'
  ]);

  wbCriticalStageEnum :=
    wbEnum([
      'None',
      'Goo Start',
      'Goo End',
      'Disintegrate Start',
      'Disintegrate End'
    ]);

  wbSexEnum :=
    wbEnum(['Male','Female']);

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
      wbFloat('Magnitude', cpNormal, True),
      wbInteger('Area', itU32),
      wbInteger('Duration', itU32)
    ], cpNormal, True, nil, -1, wbEFITAfterLoad);

  wbCTDA := wbRStruct('Conditions', [
    wbStruct(CTDA, 'Condition', [
      wbInteger('Type', itU8, wbCtdaTypeToStr, wbCtdaTypeToInt, cpNormal, False, nil, wbCtdaTypeAfterSet),
      wbByteArray('Unknown', 3),
      wbUnion('Comparison Value', wbCTDACompValueDecider, [
        wbFloat('Comparison Value - Float'),
        wbFormIDCk('Comparison Value - Global', [GLOB])
      ]),
      wbInteger('Function', itU16, wbCTDAFunctionToStr, wbCTDAFunctionToInt),
      wbByteArray('Unknown', 2),
      wbUnion('Parameter #1', wbCTDAParam1Decider, [
        {00} wbByteArray('Unknown', 4),
        {01} wbByteArray('None', 4, cpIgnore),
        {02} wbInteger('Integer', itS32),
        {03} wbInteger('Variable Name (INVALID)', itS32),
        {04} wbInteger('Sex', itU32, wbSexEnum),
        {05} wbInteger('Actor Value', itS32, wbActorValueEnum),
        {06} wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
        {07} wbInteger('Axis', itU32, wbAxisEnum),
        {08} wbInteger('Quest Stage (INVALID)', itS32),
        {09} wbInteger('Misc Stat', itU32, wbMiscStatEnum),
        {10} wbInteger('Alignment', itU32, wbAlignmentEnum),
        {11} wbFormIDCkNoReach('Equip Type', [EQUP]),
        {12} wbInteger('Form Type', itU32, wbFormTypeEnum),
        {13} wbInteger('Critical Stage', itU32, wbCriticalStageEnum),
        {14} wbFormIDCkNoReach('Object Reference', [PLYR, REFR, ACHR, ACRE, PGRE, PMIS, TRGT], True),
        {16} wbFormIDCkNoReach('Inventory Object', [ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, FLST, CHIP, CMNY]),
        {17} wbFormIDCkNoReach('Actor', [PLYR, ACHR, ACRE, TRGT], True),
        {18} wbFormIDCkNoReach('Voice Type', [VTYP, FLST]),
        {19} wbFormIDCkNoReach('Idle', [IDLE]),
        {20} wbFormIDCkNoReach('Form List', [FLST]),
        {21} wbFormIDCkNoReach('Note', [NULL]),
        {22} wbFormIDCkNoReach('Quest', [QUST]),
        {23} wbFormIDCkNoReach('Faction', [FACT]),
        {24} wbFormIDCkNoReach('Weapon', [WEAP]),
        {25} wbFormIDCkNoReach('Cell', [CELL]),
        {26} wbFormIDCkNoReach('Class', [CLAS]),
        {27} wbFormIDCkNoReach('Race', [RACE]),
        {28} wbFormIDCkNoReach('Actor Base', [NPC_, ACTI, TACT]),
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
        {40} wbInteger('VATS Value Param (INVALID)', itU32),
        {41} wbInteger('Creature Type', itU32, wbCreatureTypeEnum),
        {42} wbInteger('Menu Mode', itU32, wbMenuModeEnum),
        {43} wbInteger('Player Action', itU32, wbPlayerActionEnum),
        {44} wbInteger('Body Location', itS32, wbBodyLocationEnum),
        {45} wbFormIDCkNoReach('Referenceable Object', [NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, PWAT, SCOL, TACT, FLST], [NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, PWAT, SCOL, TACT, IMOD, CMNY, CCRD, CHIP]),
        {46} wbInteger('Quest Objective (INVALID)', itS32),
        {47} wbFormIDCkNoReach('Reputation', [REPU]),
        {48} wbFormIDCkNoReach('Region', [REGN]),
        {49} wbFormIDCkNoReach('Challenge', [CHAL]),
        {50} wbFormIDCkNoReach('Casino', [CSNO]),
        {51} wbFormIDCkNoReach('Keyword', [KYWD]),
        {52} wbInteger('Player Action', itU32, wbAdvanceActionEnum),
        {53} wbInteger('Casting Type', itU32, wbCastingSourceEnum),
        {54} wbFormIDCkNoReach('Shout', [SHOU]),
        {55} wbFormIDCkNoReach('Location', [LCTN]),
        {56} wbFormIDCkNoReach('Ref Type', [LCRT]),
        {57} wbInteger('Alias ID', itU32),
        {58} wbFloat('Float'),
        {59} wbFormIDCk('Relationship', [ASTP])
      ]),
      wbUnion('Parameter #2', wbCTDAParam2Decider, [
        {00} wbByteArray('Unknown', 4),
        {01} wbByteArray('None', 4, cpIgnore),
        {02} wbInteger('Integer', itS32),
        {03} wbInteger('Variable Name (INVALID)', itS32),
        {04} wbInteger('Sex', itU32, wbSexEnum),
        {05} wbInteger('Actor Value', itS32, wbActorValueEnum),
        {06} wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
        {07} wbInteger('Axis', itU32, wbAxisEnum),
        {08} wbInteger('Quest Stage (INVALID)', itS32),
        {09} wbInteger('Misc Stat', itU32, wbMiscStatEnum),
        {10} wbInteger('Alignment', itU32, wbAlignmentEnum),
        {11} wbFormIDCkNoReach('Equip Type', [EQUP]),
        {12} wbInteger('Form Type', itU32, wbFormTypeEnum),
        {13} wbInteger('Critical Stage', itU32, wbCriticalStageEnum),
        {14} wbFormIDCkNoReach('Object Reference', [PLYR, REFR, ACHR, ACRE, PGRE, PMIS, TRGT], True),
        {16} wbFormIDCkNoReach('Inventory Object', [ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, FLST]),
        {17} wbFormIDCkNoReach('Actor', [PLYR, ACHR, ACRE, TRGT], True),
        {18} wbFormIDCkNoReach('Voice Type', [VTYP, FLST]),
        {19} wbFormIDCkNoReach('Idle', [IDLE]),
        {20} wbFormIDCkNoReach('Form List', [FLST]),
        {21} wbFormIDCkNoReach('Note', [NULL]),
        {22} wbFormIDCkNoReach('Quest', [QUST]),
        {23} wbFormIDCkNoReach('Faction', [FACT]),
        {24} wbFormIDCkNoReach('Weapon', [WEAP]),
        {25} wbFormIDCkNoReach('Cell', [CELL]),
        {26} wbFormIDCkNoReach('Class', [CLAS]),
        {27} wbFormIDCkNoReach('Race', [RACE]),
        {28} wbFormIDCkNoReach('Actor Base', [NPC_, ACTI, TACT]),
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
        {40} wbUnion('VATS Value Param', wbCTDAParam2VATSValueParam, [
             { 0} wbFormIDCkNoReach('Weapon', [WEAP]),
             { 1} wbFormIDCkNoReach('Weapon List', [FLST], [WEAP]),
             { 2} wbFormIDCkNoReach('Target', [NPC_]),
             { 3} wbFormIDCkNoReach('Target List', [FLST], [NPC_]),
             { 4} wbByteArray('Unknown', 4, cpIgnore),
             { 5} wbInteger('Target Part', itS32, wbActorValueEnum),
             { 6} wbInteger('VATS Action', itU32, wbEnum([
                'Unarmed Attack',
                'One Hand Melee Attack',
                'Two Hand Melee Attack',
                'Magic Attack',
                'Ranged Attack',
                'Reload',
                'Crouch',
                'Stand',
                'Switch Weapon',
                'Toggle Weapon Drawn',
                'Heal',
                'Player Death'
              ])),
             { 7} wbByteArray('Unknown', 4, cpIgnore),
             { 8} wbByteArray('Unknown', 4, cpIgnore),
             { 9} wbFormIDCkNoReach('Critical Effect', [SPEL]),
             {10} wbFormIDCkNoReach('Critical Effect List', [FLST], [SPEL]),
             {11} wbByteArray('Unknown', 4, cpIgnore),
             {12} wbByteArray('Unknown', 4, cpIgnore),
             {13} wbByteArray('Unknown', 4, cpIgnore),
             {14} wbByteArray('Unknown', 4, cpIgnore),
             {15} wbInteger('Weapon Type', itU32, wbWeaponAnimTypeEnum),
             {16} wbByteArray('Unknown', 4, cpIgnore),
             {17} wbByteArray('Unknown', 4, cpIgnore),
             {18} wbInteger('Projectile Type', itU32, wbEnum([
                'Missile',
                'Lobber',
                'Beam',
                'Flame',
                'Cone',
                'Barrier',
                'Arrow'
                  ])),
             {19} wbInteger('Delivery Type', itU32, wbTargetEnum),
             {20} wbInteger('Casting Type', itU32, wbCastEnum)
            ]),
        {41} wbInteger('Creature Type', itU32, wbCreatureTypeEnum),
        {42} wbInteger('Menu Mode', itU32, wbMenuModeEnum),
        {43} wbInteger('Player Action', itU32, wbPlayerActionEnum),
        {44} wbInteger('Body Location', itS32, wbBodyLocationEnum),
        {45} wbFormIDCkNoReach('Referenceable Object', [NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, PWAT, SCOL, TACT, FLST], [NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, PWAT, SCOL, TACT, IMOD, CMNY, CCRD, CHIP]),
        {46} wbInteger('Quest Objective (INVALID)', itS32),
        {47} wbFormIDCkNoReach('Reputation', [REPU]),
        {48} wbFormIDCkNoReach('Region', [REGN]),
        {49} wbFormIDCkNoReach('Challenge', [CHAL]),
        {50} wbFormIDCkNoReach('Casino', [CSNO]),
        {51} wbFormIDCkNoReach('Keyword', [KYWD]),
        {52} wbInteger('Player Action', itU32, wbAdvanceActionEnum),
        {53} wbInteger('Casting Type', itU32, wbCastingSourceEnum),
        {54} wbFormIDCkNoReach('Shout', [SHOU]),
        {55} wbFormIDCkNoReach('Location', [LCTN]),
        {56} wbFormIDCkNoReach('Ref Type', [LCRT]),
        {57} wbInteger('Alias ID', itU32),
        {58} wbFloat('Float'),
        {59} wbFormIDCk('Relationship', [ASTP])
      ]),
      wbInteger('Run On', itU32, wbEnum([
        {0} 'Subject',
        {1} 'Target',
        {2} 'Reference',
        {3} 'Combat Target',
        {4} 'Linked Reference',
        {5} 'Quest Alias',
        {6} 'Package Data',
        {7} 'Event Data'
      ]), cpNormal, False, nil, wbCTDARunOnAfterSet),
      wbUnion('Reference', wbCTDAReferenceDecider, [
        wbInteger('Unknown', itU32, nil, cpIgnore),
        wbFormIDCkNoReach('Reference', [ACHR, REFR, PGRE], True)
      ]),
      wbByteArray('Parameter #3', 4)
    ], cpNormal, False{, nil, 0, wbCTDAAfterLoad}),
    wbString(CIS1, 'Parameter #1'),
    wbString(CIS2, 'Parameter #2')
  ], [], cpNormal);

  wbCTDAs := wbRArray('Conditions', wbCTDA, cpNormal, False);
  wbCTDAsReq := wbRArray('Conditions', wbCTDA, cpNormal, True);

//------------------------------------------------------------------------------
// Begin wbCTDAOld
//------------------------------------------------------------------------------
// 32 Bytes -- 8 itU32
// Vender Conditions
//      CTDA - Condition Flags
//        {Byte   1-4} Flags, Include Comparison type -- 'Equal to', 'Not equal to', 'Greater than', 'Greater than or equal to',
//                     'Less than', 'Less than or equal to'
//                     Also includes 'Use OR', 'Parameters - Use Aliases', 'Parameters - Use Pack Data', 'Swap Subject and Target',
//        {Byte   5-8} Float: 25.000000
//        {Byte  9-12} Unknown 3: 2F 00 00 00
//        {Byte 13-16} Unknown: ALCH - Ingestible [0010D666] <FoodGourd> "Z"
//        {Byte 17-20} Unknown 5: 00 00 00 00
//        {Byte 21-24} Unknown 6: 00 00 00 00
//        {Byte 25-28} Unknown 7: 00 00 00 00
//        {Byte 29-32} Unknown 8: FF FF FF FF
// Old routine used 28 Bytes, new routine needs to use 32.
// CITC is not used here since it Can be 0
//  wbCTDAOld := wbRStruct('Conditions', [
//					wbStruct(CTDA, 'Condition', [
//{Byte  1}		wbInteger('Type', itU8, wbCtdaTypeToStr, wbCtdaTypeToInt, cpNormal, False, nil, wbCtdaTypeAfterSet),
//{Byte  2} 	wbByteArray('Unknown', 3),
//{Byte  5}		wbUnion('Comparison Value', wbCTDACompValueDecider, [
//              wbFloat('Comparison Value - Float'),
//              wbFormIDCk('Comparison Value - Global', [GLOB])
//            ]),
//{Byte  9}		wbInteger('Function', itU32, wbCTDAFunctionToStr, wbCTDAFunctionToInt),
//{Byte 13}		wbUnion('Parameter #1', wbCTDAParam1Decider, [
//				 {00} wbByteArray('Unknown', 4),
//		  	 {01} wbByteArray('None', 4, cpIgnore),
//		  	 {02} wbInteger('Integer', itS32),
//		  	 {03} wbInteger('Variable Name (INVALID)', itS32),
//		  	 {04} wbInteger('Sex', itU32, wbSexEnum),
//		  	 {05} wbInteger('Actor Value', itS32, wbActorValueEnum),
//  			 {06} wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
//  			 {07} wbInteger('Axis', itU32, wbAxisEnum),
//  			 {08} wbInteger('Quest Stage (INVALID)', itS32),
//  			 {09} wbInteger('Misc Stat', itU32, wbMiscStatEnum),
//  			 {10} wbInteger('Alignment', itU32, wbAlignmentEnum),
//  			 {11} wbInteger('Equip Type', itU32),
//  			 {12} wbInteger('Form Type', itU32, wbFormTypeEnum),
//  			 {13} wbInteger('Critical Stage', itU32, wbCriticalStageEnum),
//  			 {14} wbFormIDCkNoReach('Object Reference', [PLYR, REFR, ACHR, ACRE, PGRE, PMIS, TRGT], True),
//  			 {16} wbFormIDCkNoReach('Inventory Object', [ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, NOTE, FLST, CHIP, CMNY]),
//  			 {17} wbFormIDCkNoReach('Actor', [PLYR, ACHR, ACRE, TRGT], True),
//  			 {18} wbFormIDCkNoReach('Voice Type', [VTYP]),
//  			 {19} wbFormIDCkNoReach('Idle', [IDLE]),
//  			 {20} wbFormIDCkNoReach('Form List', [FLST]),
//  			 {21} wbFormIDCkNoReach('Note', [NOTE]),
//  			 {22} wbFormIDCkNoReach('Quest', [QUST]),
//  			 {23} wbFormIDCkNoReach('Faction', [FACT]),
//  			 {24} wbFormIDCkNoReach('Weapon', [WEAP]),
//  			 {25} wbFormIDCkNoReach('Cell', [CELL]),
//  			 {26} wbFormIDCkNoReach('Class', [CLAS]),
//  			 {27} wbFormIDCkNoReach('Race', [RACE]),
//  			 {28} wbFormIDCkNoReach('Actor Base', [NPC_, CREA, ACTI, TACT]),
//  			 {29} wbFormIDCkNoReach('Global', [GLOB]),
//  			 {30} wbFormIDCkNoReach('Weather', [WTHR]),
//  			 {31} wbFormIDCkNoReach('Package', [PACK]),
//  			 {32} wbFormIDCkNoReach('Encounter Zone', [ECZN]),
//  			 {33} wbFormIDCkNoReach('Perk', [PERK]),
//  			 {34} wbFormIDCkNoReach('Owner', [FACT, NPC_]),
//  			 {35} wbFormIDCkNoReach('Furniture', [FURN, FLST]),
//  			 {36} wbFormIDCkNoReach('Effect Item', [SPEL, ENCH, ALCH, INGR]),
//  			 {37} wbFormIDCkNoReach('Base Effect', [MGEF]),
//  			 {38} wbFormIDCkNoReach('Worldspace', [WRLD]),
//  			 {39} wbInteger('VATS Value Function', itU32, wbVATSValueFunctionEnum),
//  			 {40} wbInteger('VATS Value Param (INVALID)', itU32),
//  			 {41} wbInteger('Creature Type', itU32, wbCreatureTypeEnum),
//  			 {42} wbInteger('Menu Mode', itU32, wbMenuModeEnum),
//  			 {43} wbInteger('Player Action', itU32, wbPlayerActionEnum),
//  			 {44} wbInteger('Body Location', itS32, wbBodyLocationEnum),
//  			 {45} wbFormIDCkNoReach('Referenceable Object', [CREA, NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM, FLST, CHIP], [CREA, NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM, IMOD, CMNY, CCRD, CHIP]),
//  			 {46} wbInteger('Quest Objective (INVALID)', itS32),
//  			 {47} wbFormIDCkNoReach('Reputation', [REPU]),
//  			 {48} wbFormIDCkNoReach('Region', [REGN]),
//  			 {49} wbFormIDCkNoReach('Challenge', [CHAL]),
//  			 {50} wbFormIDCkNoReach('Casino', [CSNO])
//						]),
//{Byte 17}		wbUnion('Parameter #2', wbCTDAParam2Decider, [
//         {00} wbByteArray('Unknown', 4),
//         {01} wbByteArray('None', 4, cpIgnore),
//         {02} wbInteger('Integer', itS32),
//         {03} wbInteger('Variable Name', itS32, wbCTDAParam2VariableNameToStr, wbCTDAParam2VariableNameToInt),
//         {04} wbInteger('Sex', itU32, wbSexEnum),
//         {05} wbInteger('Actor Value', itS32, wbActorValueEnum),
//         {06} wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
//         {07} wbInteger('Axis', itU32, wbAxisEnum),
//         {08} wbInteger('Quest Stage', itS32, wbCTDAParam2QuestStageToStr, wbCTDAParam2QuestStageToInt),
//         {09} wbInteger('Misc Stat', itU32, wbMiscStatEnum),
//         {10} wbInteger('Alignment', itU32, wbAlignmentEnum),
//         {11} wbInteger('Equip Type', itU32),
//         {12} wbInteger('Form Type', itU32, wbFormTypeEnum),
//         {13} wbInteger('Critical Stage', itU32, wbCriticalStageEnum),
//         {14} wbFormIDCkNoReach('Object Reference', [PLYR, REFR, PMIS, ACHR, ACRE, PGRE, TRGT], True),
//         {16} wbFormIDCkNoReach('Inventory Object', [ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, NOTE, FLST, CHIP, CMNY]),
//         {17} wbFormIDCkNoReach('Actor', [PLYR, ACHR, ACRE, TRGT], True),
//         {18} wbFormIDCkNoReach('Voice Type', [VTYP]),
//         {19} wbFormIDCkNoReach('Idle', [IDLE]),
//         {20} wbFormIDCkNoReach('Form List', [FLST]),
//         {21} wbFormIDCkNoReach('Note', [NOTE]),
//         {22} wbFormIDCkNoReach('Quest', [QUST]),
//         {23} wbFormIDCkNoReach('Faction', [FACT]),
//         {24} wbFormIDCkNoReach('Weapon', [WEAP]),
//         {25} wbFormIDCkNoReach('Cell', [CELL]),
//         {26} wbFormIDCkNoReach('Class', [CLAS]),
//         {27} wbFormIDCkNoReach('Race', [RACE]),
//         {28} wbFormIDCkNoReach('Actor Base', [NPC_, CREA, ACTI, TACT]),
//         {29} wbFormIDCkNoReach('Global', [GLOB]),
//         {30} wbFormIDCkNoReach('Weather', [WTHR]),
//         {31} wbFormIDCkNoReach('Package', [PACK]),
//         {32} wbFormIDCkNoReach('Encounter Zone', [ECZN]),
//         {33} wbFormIDCkNoReach('Perk', [PERK]),
//         {34} wbFormIDCkNoReach('Owner', [FACT, NPC_]),
//         {35} wbFormIDCkNoReach('Furniture', [FURN, FLST]),
//         {36} wbFormIDCkNoReach('Effect Item', [SPEL, ENCH, ALCH, INGR]),
//         {37} wbFormIDCkNoReach('Base Effect', [MGEF]),
//         {38} wbFormIDCkNoReach('Worldspace', [WRLD]),
//         {39} wbInteger('VATS Value Function (INVALID)', itU32),
//         {40} wbUnion('VATS Value Param', wbCTDAParam2VATSValueParam, [
//                wbFormIDCkNoReach('Weapon', [WEAP]),
//                wbFormIDCkNoReach('Weapon List', [FLST], [WEAP]),
//                wbFormIDCkNoReach('Target', [NPC_, CREA]),
//                wbFormIDCkNoReach('Target List', [FLST], [NPC_, CREA]),
//                wbByteArray('Unknown', 4, cpIgnore),
//                wbInteger('Target Part', itS32, wbActorValueEnum),
//                wbInteger('VATS Action', itU32, wbEnum([
//                  'Unarmed Attack',
//                  'One Hand Melee Attack',
//                  'Two Hand Melee Attack',
//                  'Fire Pistol',
//                  'Fire Rifle',
//                  'Fire Handle Weapon',
//                  'Fire Launcher',
//                  'Throw Grenade',
//                  'Place Mine',
//                  'Reload',
//                  'Crouch',
//                  'Stand',
//                  'Switch Weapon',
//                  'Toggle Weapon Drawn',
//                  'Heal',
//                  'Player Death',
//                  'Special Weapon Attack',
//                  'Special Unarmed Attack',
//                  'Kill Camera Shot',
//                  'Throw Weapon'
//								])),
//                wbByteArray('Unknown', 4, cpIgnore),
//                wbByteArray('Unknown', 4, cpIgnore),
//                wbFormIDCkNoReach('Critical Effect', [SPEL]),
//                wbFormIDCkNoReach('Critical Effect List', [FLST], [SPEL]),
//                wbByteArray('Unknown', 4, cpIgnore),
//                wbByteArray('Unknown', 4, cpIgnore),
//                wbByteArray('Unknown', 4, cpIgnore),
//                wbByteArray('Unknown', 4, cpIgnore),
//                wbInteger('Weapon Type', itU32, wbWeaponAnimTypeEnum),
//                wbByteArray('Unknown', 4, cpIgnore),
//                wbByteArray('Unknown', 4, cpIgnore)
//							]),
//         {41} wbInteger('Creature Type', itU32, wbCreatureTypeEnum),
//         {42} wbInteger('Menu Mode', itU32, wbMenuModeEnum),
//         {43} wbInteger('Player Action', itU32, wbPlayerActionEnum),
//         {44} wbInteger('Body Location', itS32, wbBodyLocationEnum),
//         {45} wbFormIDCkNoReach('Referenceable Object', [CREA, NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM, FLST, CHIP], [CREA, NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM, IMOD, CMNY, CCRD, CHIP]),
//         {46} wbInteger('Quest Objective', itS32, wbCTDAParam2QuestObjectiveToStr, wbCTDAParam2QuestObjectiveToInt),
//         {47} wbFormIDCkNoReach('Reputation', [REPU]),
//         {48} wbFormIDCkNoReach('Region', [REGN]),
//         {49} wbFormIDCkNoReach('Challenge', [CHAL]),
//         {50} wbFormIDCkNoReach('Casino', [CSNO])
//						]),
//{Byte 21}	  wbInteger('Run On', itU32, wbEnum([
//						  'Subject',
//						  'Target',
//						  'Reference',
//						  'Combat Target',
//						  'Linked Reference'
//					  ]), cpNormal, False, nil, wbCTDARunOnAfterSet),
//{Byte 25}	  wbUnion('Reference', wbCTDAReferenceDecider, [
//						  wbInteger('Unknown', itU32, nil, cpIgnore),
//						  wbFormIDCkNoReach('Reference', [PLYR, ACHR, ACRE, REFR, PMIS, PGRE], True)
//						]),
//{Byte 29}   wbByteArray('Unknown', 4)
//          ], cpNormal, False, nil, 6, wbCTDAAfterLoad),
//				wbString(CIS1, 'Unknown'),
//				wbString(CIS2, 'Unknown')
//    ], [], cpNormal);
//------------------------------------------------------------------------------
// End wbCTDAOld
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// wbEffects - EFID, EFIT, CTDA
//------------------------------------------------------------------------------
  wbEffects :=
    wbRStructs('Effects','Effect', [
      wbEFID,
      wbEFIT,
      wbCTDAs
    ], []);

  wbEffectsReq :=
    wbRStructs('Effects','Effect', [
      wbEFID,
      wbEFIT,
      wbCTDAs
    ], [], cpNormal, True);

  wbRecord(ALCH, 'Ingestible', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULLReq,
    wbKeywords,
    wbDESCReq,
    wbMODL,
    wbICON,
    wbSounds,
    wbETYP,
    wbFloat(DATA, 'Weight', cpNormal, True),
    wbStruct(ENIT, 'Effect Data', [
      wbInteger('Value', itS32),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'No Auto-Calc (Unused)',
        {0x00000002} 'Food Item',
        {0x00000004} 'Unknown 3',
        {0x00000008} 'Unknown 4',
        {0x00000010} 'Unknown 5',
				{0x00000020} 'Unknown 6',
				{0x00000040} 'Unknown 7',
				{0x00000080} 'Unknown 8',
				{0x00000100} 'Unknown 9',
				{0x00000200} 'Unknown 10',
				{0x00000400} 'Unknown 11',
				{0x00000800} 'Unknown 12',
				{0x00001000} 'Unknown 13',
				{0x00002000} 'Unknown 14',
				{0x00004000} 'Unknown 15',
				{0x00008000} 'Unknown 16',
				{0x00010000} 'Medicine',
				{0x00020000} 'Poison'
      ])),
      wbFormID('Addiction'),
      wbFloat('Addiction Chance'),
      wbFormIDCk('Sound - Consume', [SNDR, NULL])
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
    wbSounds,
    wbDESC,
    wbKeywords,
    wbStruct(DATA, 'Data', [
      wbFormIDCk('Projectile', [PROJ, NULL]),
        wbInteger('Flags', itU32, wbFlags([
          'Ignores Normal Weapon Resistance',
          'Non-Playable',
          'Non-Bolt'
        ])),
      wbFloat('Damage'),
      wbInteger('Value', itU32)
    ], cpNormal, True),
    wbString(ONAM, 'Short Name')
  ]);

  wbRecord(ANIO, 'Animated Object', [
    wbEDIDReq,
    wbMODLReq,
    wbString(BNAM, 'Type')
  ]);

  wbRecord(ARMO, 'Armor', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbSCRI,
    wbEITM,
    wbRStruct('Male biped model', [
      wbString(MODL, 'Model Filename'),
      wbByteArray(MODT, 'Texture Files Hashes', 0, cpIgnore),
      wbMODS,
      wbMODD
    ], [], cpNormal, False, nil, True),
    wbRStruct('Male world model', [
      wbString(MOD2, 'Model Filename'),
      wbByteArray(MO2T, 'Texture Files Hashes', 0, cpIgnore),
      wbMO2S
    ], []),
    wbICON,
    wbRStruct('Female world model', [
      wbString(MOD4, 'Model Filename'),
      wbByteArray(MO4T, 'Texture Files Hashes', 0, cpIgnore),
      wbMO4S
    ], []),
    wbICO2,
    wbBODT,
    wbDEST,
    wbSounds,
    wbString(BMCT, 'Ragdoll Constraint Template'),
    wbETYP,
    //wbREPL,
    //wbBIPL,
    wbFormIDCk(BIDS, 'Bash Impact Data Set', [IPDS]),
    wbFormIDCk(BAMT, 'Bash Material', [MATT]),
    wbFormIDCk(RNAM, 'Race', [RACE]),
    wbKeywords,
    wbDESCReq,
    wbRArray('Armature', wbFormIDCK(MODL, 'Model Filename', [ARMA, NULL])),
    wbStruct(DATA, 'Data', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True),
    wbInteger(DNAM, 'Armor Rating', itS32, wbDiv(100), cpNormal, True),
    wbFormIDCk(TNAM, 'Template Armor', [ARMO])
  ]);

  wbRecord(ARMA, 'Armor Addon', [
    wbEDIDReq,
    wbBODT,
    wbFormIDCk(RNAM, 'Race', [RACE]),
    wbStruct(DNAM, 'Data', [
      wbInteger('Male Priority', itU8),
      wbInteger('Female Priority', itU8),
      wbByteArray('Unknown', 4),
      wbInteger('Detection Sound Value', itU8),
      wbByteArray('Unknown', 1),
      wbFloat('Weapon Adjust')
    ], cpNormal, True),
    wbRStruct('Male world model', [
      wbString(MOD2, 'Model Filename'),
      wbByteArray(MO2T, 'Texture Files Hashes', 0, cpIgnore),
      wbMO2S
    ], [], cpNormal, True),
    wbRStruct('Female world model', [
      wbString(MOD3, 'Model Filename'),
      wbByteArray(MO3T, 'Texture Files Hashes', 0, cpIgnore),
      wbMO3S
    ], []),
    wbRStruct('Male 1st Person', [
      wbString(MOD4, 'Model Filename'),
      wbByteArray(MO4T, 'Texture Files Hashes', 0, cpIgnore),
      wbMO4S
    ], []),
    wbRStruct('Female 1st Person', [
      wbString(MOD5, 'Model Filename'),
      wbByteArray(MO5T, 'Texture Files Hashes', 0, cpIgnore),
      wbMO5S
    ], []),
    wbFormIDCK(NAM0, 'Male Skin Texture', [TXST, NULL]),
    wbFormIDCK(NAM1, 'Female Skin texture', [TXST, NULL]),
    wbFormIDCK(NAM2, 'Male Skin Texture Swap List', [FLST, NULL]),
    wbFormIDCK(NAM3, 'Female Skin Texture Swap List', [FLST, NULL]),
    wbRArray('Additional Races', wbFormIDCK(MODL, 'Race', [RACE, NULL])),
    wbFormIDCk(SNDD, 'Footstep Sound', [FSTS, NULL]),
    wbFormIDCk(ONAM, 'Art Object', [ARTO])
  ]);

  wbRecord(BOOK, 'Book', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbLString(DESC, 'Book Text', 0, cpNormal, True),
    wbDEST,
    wbSounds,
    wbKeywords,
    wbStruct(DATA, 'Data', [
      wbInteger('Flags', itU8, wbFlags([
       {0x01} 'Teaches Skill',
       {0x02} 'Can''t be Taken',
       {0x04} 'Teaches Spell',
       {0x08} 'Unknown 4',
       {0x10} 'Unknown 5',
       {0x20} 'Unknown 6',
       {0x40} 'Unknown 7',
       {0x80} 'Unknown 8'
      ])),
      wbInteger('Type', itU8, wbEnum([], [
        0, 'Book/Tome', 255, 'Note/Scroll'
      ])),
      wbByteArray('Unused', 2),
      wbUnion('Teaches', wbBOOKTeachesDecider, [
        wbInteger('Skill', itS32, wbSkillEnum),
        wbFormIDCk('Spell', [SPEL])
      ]),
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ], cpNormal, True),
    wbFormIDCk(INAM, 'Inventory Art', [STAT]),
    wbString(CNAM, 'Description')
  ]);

  wbSPCT := wbInteger(SPCT, 'Spell Count', itU32);
  wbSPLO := wbFormIDCk(SPLO, 'Actor Effect', [SPEL]);
  wbSPLOs := wbRArrayS('Actor Effects', wbSPLO, cpNormal, False, nil, nil, wbActorTemplateUseActorEffectList);

  wbSpells := wbRstruct('Spells', [
    wbSPCT,
    wbSPLOs
  ], []);

  wbCELLDATAFlags := wbFlags([
	  {0x00000001} 'Is Interior Cell',
		{0x00000002} 'Has water',
		{0x00000004} 'Invert Fast Travel behavior',
		{0x00000008} 'Force hide land (exterior cell) / Oblivion interior (interior cell)',
		{0x00000010} 'Unknown 5',
		{0x00000020} 'Public place',
		{0x00000040} 'Hand changed',
		{0x00000080} 'Behave like exterior',
		{0x00000100} 'Unknown 9',
		{0x00000200} 'Unknown 10',
		{0x00000400} 'Unknown 11',
		{0x00000800} 'Unknown 12',
		{0x00001000} 'Unknown 13',
		{0x00002000} 'Unknown 14',
		{0x00004000} 'Unknown 15',
    {0x00008000} 'Unknown 16',
    {0x00010000} 'Unknown 17',
    {0x00020000} 'Unknown 18',
    {0x00040000} 'Unknown 19',
    {0x00080000} 'Unknown 20',
    {0x00100000} 'Unknown 21',
    {0x00200000} 'Unknown 22',
    {0x00400000} 'Unknown 23',
    {0x00800000} 'Unknown 24',
    {0x01000000} 'Unknown 25',
    {0x02000000} 'Unknown 26',
    {0x04000000} 'Unknown 27',
    {0x08000000} 'Unknown 28',
    {0x10000000} 'Unknown 29',
    {0x20000000} 'Unknown 30',
    {0x40000000} 'Unknown 31',
    {0x80000000} 'Unknown 32'
  ]);
end;

procedure DefineTES5c;
begin

  wbRecord(CELL, 'Cell', [
    wbEDID,
    wbFULL,
    wbUnion(DATA, 'General', wbCELLDATADecider, [
      wbStruct('General itU8', [
        wbInteger('Flags', itU8, wbCELLDATAFlags)
      ]),
      wbStruct('General itU16', [
        wbInteger('Flags', itU16, wbCELLDATAFlags)
      ])
    ]),
    wbStruct(XCLC, 'Grid', [
      wbInteger('X', itS32),
      wbInteger('Y', itS32),
      wbInteger('Force Hide Land', itU32, wbFlags([
        'Quad 1',
        'Quad 2',
        'Quad 3',
        'Quad 4'
      ], True))
    ], cpNormal, False, nil, 2),
    wbStruct(XCLL, 'Lighting', [
      wbByteArray('Unknown', 8),
      wbStruct('Ambient Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unknown', 1)
      ]),
      wbStruct('Directional Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unknown', 1)
      ]),
      wbStruct('Fog Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unknown', 1)
      ]),
      wbFloat('Fog Near'),
      wbFloat('Fog Far'),
      wbInteger('Directional Rotation XY', itS32),
      wbInteger('Directional Rotation Z', itS32),
      wbFloat('Directional Fade'),
      wbFloat('Fog Clip Dist'),
      wbFloat('Fog Power'),
			wbByteArray('Unknown', 0)
    ], cpNormal, False),
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
		wbUnknown(TVDT),
		wbUnknown(MHDT),
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
    wbFormID(XLCN, 'Unknown'),
    wbUnknown(XWCS),
    wbUnknown(XWCN),
    wbUnknown(XWCU),
		wbRUnion('Union', [
      wbRStruct('XCIM XCMO', [
        wbFormIDCk(XCIM, 'Image Space', [IMGS]),
        wbFormIDCk(XCMO, 'Music Type', [MUSC])
      ], []),
      wbRStruct('XCMO XCIM', [
        wbFormIDCk(XCMO, 'Music Type', [MUSC]),
        wbFormIDCk(XCIM, 'Image Space', [IMGS])
      ], [])
    ], []),
    wbFormIDCk(XCWT, 'Water', [WATR]),

    {--- Ownership ---}
    wbOwnership,

    wbRStruct('XEZN XCMO XCAS', [
      wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),
      wbFormIDCk(XCMO, 'Music Type', [MUSC]),
      wbFormIDCk(XCAS, 'Acoustic Space', [ASPC])
    ], []),

    wbFormIDCk(XCCM, 'Climate', [CLMT]),
		wbFormID(XILL, 'Unknown'),
		wbRUnion('Union', [
      wbRStruct('XCAS XEZN XCMO XWEM', [
        wbFormIDCk(XCAS, 'Acoustic Space', [ASPC]),
        wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),
        wbFormIDCk(XCMO, 'Music Type', [MUSC]),
        wbUnknown(XWEM)
      ], []),
      wbRStruct('XWEM XEZN XCAS', [
        wbUnknown(XWEM),
        wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),
        wbFormIDCk(XCAS, 'Acoustic Space', [ASPC])
      ], [])
    ], [])
  ], True, wbCellAddInfo, cpNormal, False, wbCELLAfterLoad);
//------------------------------------------------------------------------------
// End CELL
//------------------------------------------------------------------------------

  {>>> Used for arrows <<<}
  wbRecord(PARW, 'Placed Projectile', [
    wbVMAD,
    wbFormIDCk(NAME, 'Arrow', [PROJ]),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),
    wbOwnership,
    wbFloat(XHTW, 'Head-Tracking Weight'),
    wbFloat(XFVC, 'Favor Cost'),
    wbRArrayS('Reflected/Refracted By',
      wbStructSK(XPWR, [0], 'Water', [
        wbFormIDCk('Reference', [REFR]),
        wbInteger('Type', itU32, wbFlags([
          'Reflection',
          'Refraction'
        ]))
      ], cpNormal, False, nil, 1)
    ),
    wbRArray('Linked References', wbStruct(XLKR, 'Linked Reference', [
      wbFormIDCk('Keyword', [KYWD, NULL]),
      wbFormIDCk('Ref', [REFR, ACHR, PARW, PHZD, PGRE])
    ])),
    wbRStruct('Activate Parents', [
      wbInteger(XAPD, 'Flags', itU8, wbFlags([
        'Parent Activate Only'
      ], True)),
      wbRArrayS('Activate Parent Refs',
        wbStructSK(XAPR, [0], 'Activate Parent Ref', [
          wbFormIDCk('Reference', [REFR, ACHR, PARW, PHZD, PGRE]),
          wbFloat('Delay')
        ])
      )
    ], []),
    wbXESP,
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),
    wbEmpty(XIS2, 'Ignored by Sandbox'),
    wbArray(XLRT, 'Location Ref Type', wbFormIDCk('Ref', [LCRT, NULL])),
    wbFormIDCk(XLRL, 'Location Reference', [LCRT, NULL]),
    wbXSCL,
    wbDataPosRot
  ], True, wbPlacedAddInfo);

  {>>> Used for voice <<<}
  wbRecord(PCON, 'Placed Projectile', [
    wbVMAD,
    wbFormIDCk(NAME, 'Arrow', [PROJ]),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),
    wbOwnership,
    wbFloat(XHTW, 'Head-Tracking Weight'),
    wbFloat(XFVC, 'Favor Cost'),
    wbRArrayS('Reflected/Refracted By',
      wbStructSK(XPWR, [0], 'Water', [
        wbFormIDCk('Reference', [REFR]),
        wbInteger('Type', itU32, wbFlags([
          'Reflection',
          'Refraction'
        ]))
      ], cpNormal, False, nil, 1)
    ),
    wbRArray('Linked References', wbStruct(XLKR, 'Linked Reference', [
      wbFormIDCk('Keyword', [KYWD, NULL]),
      wbFormIDCk('Ref', [REFR, ACHR, PARW, PHZD, PGRE])
    ])),
    wbRStruct('Activate Parents', [
      wbInteger(XAPD, 'Flags', itU8, wbFlags([
        'Parent Activate Only'
      ], True)),
      wbRArrayS('Activate Parent Refs',
        wbStructSK(XAPR, [0], 'Activate Parent Ref', [
          wbFormIDCk('Reference', [REFR, ACHR, PARW, PHZD, PGRE]),
          wbFloat('Delay')
        ])
      )
    ], []),
    wbXESP,
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),
    wbEmpty(XIS2, 'Ignored by Sandbox'),
    wbArray(XLRT, 'Location Ref Type', wbFormIDCk('Ref', [LCRT, NULL])),
    wbFormIDCk(XLRL, 'Location Reference', [LCRT, NULL]),
    wbXSCL,
    wbDataPosRot
  ], True, wbPlacedAddInfo);

  {>>> Used for traps <<<}
  wbRecord(PGRE, 'Placed Projectile', [
    wbVMAD,
    wbFormIDCk(NAME, 'Projectile', [PROJ]),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),
    wbOwnership,
    wbFloat(XHTW, 'Head-Tracking Weight'),
    wbFloat(XFVC, 'Favor Cost'),
    wbRArrayS('Reflected/Refracted By',
      wbStructSK(XPWR, [0], 'Water', [
        wbFormIDCk('Reference', [REFR]),
        wbInteger('Type', itU32, wbFlags([
          'Reflection',
          'Refraction'
        ]))
      ], cpNormal, False, nil, 1)
    ),
    wbRArray('Linked References', wbStruct(XLKR, 'Linked Reference', [
      wbFormIDCk('Keyword', [KYWD, NULL]),
      wbFormIDCk('Ref', [REFR, ACRE, ACHR, PGRE, PHZD])
    ])),
    wbRStruct('Activate Parents', [
      wbInteger(XAPD, 'Flags', itU8, wbFlags([
        'Parent Activate Only'
      ], True)),
      wbRArrayS('Activate Parent Refs',
        wbStructSK(XAPR, [0], 'Activate Parent Ref', [
          wbFormIDCk('Reference', [REFR, ACRE, ACHR, PGRE]),
          wbFloat('Delay')
        ])
      )
    ], []),
    wbXESP,
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),
    wbEmpty(XIS2, 'Ignored by Sandbox'),
    wbArray(XLRT, 'Location Ref Type', wbFormIDCk('Ref', [LCRT, NULL])),
    wbFormIDCk(XLRL, 'Location Reference', [LCRT, NULL]),
    wbXSCL,
    wbDataPosRot
  ], True, wbPlacedAddInfo);

  {>>> Used for hazards <<<}
  wbRecord(PHZD, 'Placed Hazard', [
    wbVMAD,
    wbFormIDCk(NAME, 'Hazard', [HAZD]),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),
    wbOwnership,
    wbFloat(XHTW, 'Head-Tracking Weight'),
    wbFloat(XFVC, 'Favor Cost'),
    wbRArrayS('Reflected/Refracted By',
      wbStructSK(XPWR, [0], 'Water', [
        wbFormIDCk('Reference', [REFR]),
        wbInteger('Type', itU32, wbFlags([
          'Reflection',
          'Refraction'
        ]))
      ], cpNormal, False, nil, 1)
    ),
    wbRArray('Linked References', wbStruct(XLKR, 'Linked Reference', [
      wbFormIDCk('Keyword', [KYWD, NULL]),
      wbFormIDCk('Ref', [REFR, ACRE, ACHR, PGRE, PHZD])
    ])),
    wbRStruct('Activate Parents', [
      wbInteger(XAPD, 'Flags', itU8, wbFlags([
        'Parent Activate Only'
      ], True)),
      wbRArrayS('Activate Parent Refs',
        wbStructSK(XAPR, [0], 'Activate Parent Ref', [
          wbFormIDCk('Reference', [REFR, ACRE, ACHR, PGRE]),
          wbFloat('Delay')
        ])
      )
    ], []),
    wbXESP,
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),
    wbEmpty(XIS2, 'Ignored by Sandbox'),
    wbArray(XLRT, 'Location Ref Type', wbFormIDCk('Ref', [LCRT, NULL])),
    wbFormIDCk(XLRL, 'Location Reference', [LCRT, NULL]),
    wbXSCL,
    wbDataPosRot
  ], True, wbPlacedAddInfo);

  wbServiceFlags :=
    wbFlags([
      {0x00000001} 'Weapons',
      {0x00000002} 'Armor',
      {0x00000004} 'Clothing',
      {0x00000008} 'Books',
      {0x00000010} 'Food',
      {0x00000020} 'Chems',
      {0x00000040} 'Stimpacks',
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
      wbByteArray('Unknown', 4),
      wbInteger('Teaches', itS8, wbEnum([
        'One Handed',
        'Two Handed',
        'Archery',
        'Block',
        'Smithing',
        'Heavy Armor',
        'Light Armor',
        'Pickpocket',
        'Lockpicking',
        'Sneak',
        'Alchemy',
        'Speech',
        'Alteration',
        'Conjuration',
        'Destruction',
        'Illusion',
        'Restoration',
        'Enchanting'
      ])),
      wbInteger('Maximum training level', itU8),
      wbArray('Skill Weights', wbInteger('Weight', itU8), [
        'One Handed',
        'Two Handed',
        'Archery',
        'Block',
        'Smithing',
        'Heavy Armor',
        'Light Armor',
        'Pickpocket',
        'Lockpicking',
        'Sneak',
        'Alchemy',
        'Speech',
        'Alteration',
        'Conjuration',
        'Destruction',
        'Illusion',
        'Restoration',
        'Enchanting'
      ]),
      wbFloat('Bleedout Default'),
      wbInteger('Voice Points', itU32),
      wbArray('Attribute Weights', wbInteger('Weight', itU8), [
        'Health',
        'Magicka',
        'Stamina',
        'Unknown'
      ])
    ], cpNormal, True)
  ]);

	
  wbRecord(CLDC, 'CLDC', [
    wbEDIDReq
  ]);

  wbRecord(CLMT, 'Climate', [
    wbEDIDReq,
    wbArrayS(WLST, 'Weather Types', wbStructSK([0], 'Weather Type', [
      wbFormIDCk('Weather', [WTHR, NULL]),
      wbInteger('Chance', itS32),
      wbFormIDCk('Global', [GLOB, NULL])
    ])),
    wbString(FNAM, 'Sun Texture'),
    wbString(GNAM, 'Sun Glare Texture'),
    wbMODL,
    wbStruct(TNAM, 'Timing', [
      wbStruct('Sunrise', [
        wbInteger('Begin', itU8, wbClmtTime),
        wbInteger('End', itU8, wbClmtTime)
      ]),
      wbStruct('Sunset', [
        wbInteger('Begin', itU8, wbClmtTime),
        wbInteger('End', itU8, wbClmtTime)
      ]),
      wbInteger('Volatility', itU8),
      wbInteger('Moons / Phase Length', itU8, wbClmtMoonsPhaseLength)
    ], cpNormal, True)
  ]);

  wbRecord(SPGD, 'SPGD', [
    wbEDIDReq,
    wbUnknown(DATA),
    wbString(ICON, 'File Name')
  ]);

  wbRecord(RFCT, 'RFCT', [
    wbEDIDReq,
    wbStruct(DATA, 'Effect Data', [
			wbFormIDCK('Effect Art', [ARTO, NULL]),
      wbFormIDCK('Shader', [EFSH, NULL]),
      wbInteger('Flags', itU32, wbFlags([
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
      ]))
    ], cpNormal, True)
  ]);

  wbRecord(CONT, 'Container', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbCOCT,
    wbDEST,
    wbStruct(DATA, '', [
      wbInteger('Flags', itU8, wbFlags([
        {0x01} 'Allow Sounds When Animation',
        {0x02} 'Respawns',
        {0x04} 'Show Owner'
      ])),
      wbFloat('Weight')
    ], cpNormal, True),
    wbSNAM,
    wbQNAM
  ], True);

  wbCSDT := wbRStructSK([0], 'Sound Type', [
    wbInteger(CSDT, 'Type', itU32,wbEnum([
      {00} 'Left Foot',
      {01} 'Right Foot',
      {02} 'Left Back Foot',
      {03} 'Right Back Foot',
      {04} 'Idle',
      {05} 'Aware',
      {06} 'Attack',
      {07} 'Hit',
      {08} 'Death',
      {09} 'Weapon',
      {10} 'Movement Loop',
      {11} 'Conscious Loop',
      {12} 'Auxiliary 1',
      {13} 'Auxiliary 2',
      {14} 'Auxiliary 3',
      {15} 'Auxiliary 4',
      {16} 'Auxiliary 5',
      {17} 'Auxiliary 6',
      {18} 'Auxiliary 7',
      {19} 'Auxiliary 8',
      {19} 'Auxiliary 8',
      {20} 'Jump',
      {21} 'PlayRandom/Loop'
    ])),
    wbRArrayS('Sounds', wbRStructSK([0], 'Sound', [
      wbFormIDCk(CSDI, 'Sound', [SOUN, NULL], False, cpNormal, True),
      wbInteger(CSDC, 'Sound Chance', itU8, nil, cpNormal, True)
    ], []), cpNormal, True)
  ], []);

  wbCSDTs := wbRArrayS('Sound Types', wbCSDT, cpNormal, False, nil, nil, wbActorTemplateUseModelAnimation);

  wbAIDT :=
    wbStruct(AIDT, 'AI Data', [
     {00} wbInteger('Aggression', itU8, wbEnum([
            'Unaggressive',
            'Aggressive',
            'Very Aggressive',
            'Frenzied'
          ])),
     {01} wbInteger('Confidence', itU8, wbEnum([
            'Cowardly',
            'Cautious',
            'Average',
            'Brave',
            'Foolhardy'
          ])),
     {02} wbInteger('Energy Level', itU8),
     {03} wbInteger('Responsibility', itU8, wbEnum([
            'Any crime',
            'Violence against enemies',
            'Property crime only',
            'No crime'
          ])),
     {04} wbInteger('Mood', itU8, wbEnum([
            'Neutral',
            'Afraid',
            'Annoyed',
            'Cocky',
            'Drugged',
            'Pleasant',
            'Angry',
            'Sad'
          ])),
//          wbByteArray('Unused', 3),
//          wbInteger('Buys/Sells and Services', itU32, wbServiceFlags),
//          wbInteger('Teaches', itS8, wbSkillEnum),
//          wbInteger('Maximum training level', itU8),
          wbInteger('Assistance', itU8, wbEnum([
            'Helps Nobody',
            'Helps Allies',
            'Helps Friends and Allies'
          ])),
          wbStruct('Aggro', [
            wbInteger('Aggro Radius Behavior', itU8, wbEnum(['False', 'True'])),
            wbInteger('Unknown', itU8),
            wbInteger('Warn', itU32),
            wbInteger('Warn/Attack', itU32),
            wbInteger('Attack', itU32)
          ])
          //wbInteger('Buys/Sells and Services', itU32, wbServiceFlags),
          //wbInteger('Teaches', itS8, wbSkillEnum),
          //wbInteger('Maximum training level', itU8),
          //wbInteger('Aggro Radius', itS32)
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

  wbRecord(CSTY, 'Combat Style', [
    wbEDIDReq,
    wbStruct(CSGD, 'General', [
      wbFloat('Offensive Mult'),
      wbFloat('Defensive Mult'),
      wbFloat('Group Offensive Mult'),
      // keep as separate floats, some elements can be omitted!
      wbFloat('Equipment Score Mult - Melee'),
      wbFloat('Equipment Score Mult - Magic'),
      wbFloat('Equipment Score Mult - Ranged'),
      wbFloat('Equipment Score Mult - Shout'),
      wbFloat('Equipment Score Mult - Unarmed'),
      wbFloat('Equipment Score Mult - Staff'),
//      wbArray('Equipment Score Mults', wbFloat('Mult'), [
//        'Melee',
//        'Magic',
//        'Ranged',
//        'Shout',
//        'Unarmed',
//        'Staff'
//      ]),
      wbFloat('Avoid Threat Chance')
    ], cpNormal, True, nil, 0),
    wbUnknown(CSMD),
    wbStruct(CSME, 'Melee', [
      wbFloat('Attack Staggered Mult'),
      wbFloat('Power Attack Staggered Mult'),
      wbFloat('Power Attack Blocking Mult'),
      wbFloat('Bash Mult'),
      wbFloat('Bash Recoil Mult'),
      wbFloat('Bash Attack Mult'),
      wbFloat('Bash Power Attack Mult'),
      wbFloat('Special Attack Mult')
    ], cpNormal, True, nil, 0),
    wbStruct(CSCR, 'Close Range', [
      wbFloat('Circle Mult'),
      wbFloat('Fallback Mult'),
      wbFloat('Flank Distance'),
      wbFloat('Stalk Time')
    ], cpNormal, True, nil, 0),
    wbStruct(CSLR, 'Long Range', [
      wbFloat('Strafe Mult')
    ], cpNormal, True),
    wbStruct(CSFL, 'Flight', [
      wbFloat('Hover Chance'),
      wbFloat('Dive Bomb Chance'),
      wbFloat('Ground Attack Chance'),
      wbFloat('Hover Time'),
      wbFloat('Ground Attack Time'),
      wbFloat('Perch Attack Chance'),
      wbFloat('Perch Attack Time'),
      wbFloat('Flying Attack Chance')
    ], cpNormal, True, nil, 0),
    wbInteger(DATA, 'Flags', itU32, wbFlags([
      {0x01} 'Dueling',
      {0x02} 'Flanking',
      {0x04} 'Allow Dual Wielding'
    ]), cpNormal, True)
  ]);
end;

procedure DefineTES5d;
begin
  wbRecord(DIAL, 'Dialog Topic', [
    wbEDID,
    wbFULL,
    wbFloat(PNAM, 'Priority', cpNormal, True, 1, -1, nil, nil, 50.0),
    wbFormIDCk(BNAM, 'Branch', [DLBR, NULL]),
    wbFormIDCk(QNAM, 'Quest', [QUST, NULL], False, cpNormal, False),
    wbString(SNAM, 'Subtype Name', 4),
    wbStruct(DATA, 'Data', [
      wbInteger('Flags', itU8, wbFlags([
        'Do All Before Repeating'
      ]), cpNormal, True),
      wbByteArray('Unknown', 1),
      wbInteger('Subtype', itU16, wbEnum([], [
         0, 'Custom',
         1, 'ForceGreet',
         2, 'Rumors',
        14, 'Scene',
        15, 'Show',
        16, 'Agree',
        17, 'Refuse',
        18, 'ExitFavorState',
        19, 'MoreRefusal',
        20, 'Attack',
        21, 'PowerAttack',
        22, 'Bash',
        23, 'Hit',
        24, 'Flee',
        25, 'Bleedout',
        26, 'AvoidThreat',
        27, 'Death',
        28, 'GroupStrategy',
        29, 'Block',
        30, 'Taunt',
        31, 'AllyKilled',
        32, 'Steal',
        33, 'Yield',
        34, 'AcceptYield',
        35, 'PickpocketCombat',
        36, 'Assault',
        37, 'Murder',
        38, 'AssaultNC',
        39, 'MurderNC',
        40, 'PickpocketNC',
        41, 'StealFromNC',
        42, 'TrespassAgainstNC',
        43, 'Trespass',
        44, 'WereTransformCrime',
        45, 'VoicePowerStartShort',
        46, 'VoicePowerStartLong',
        47, 'VoicePowerEndShort',
        48, 'VoicePowerEndLong',
        49, 'AlertIdle',
        50, 'LostIdle',
        51, 'NormalToAlert',
        52, 'AlertToCombat',
        53, 'NormalToCombat',
        54, 'AlertToNormal',
        55, 'CombatToNormal',
        56, 'CombatToLost',
        57, 'LostToNormal',
        58, 'LostToCombat',
        59, 'DetectFriendDie',
        60, 'ServiceRefusal',
        61, 'Repair',
        62, 'Travel',
        63, 'Training',
        64, 'BarterExit',
        65, 'RepairExit',
        66, 'Recharge',
        67, 'RechargeExit',
        68, 'TrainingExit',
        69, 'ObserveCombat',
        70, 'NoticeCorpse',
        71, 'TimeToGo',
        72, 'GoodBye',
        73, 'Hello',
        74, 'SwingMeleeWeapon',
        75, 'ShootBow',
        76, 'ZKeyObject',
        77, 'Jump',
        78, 'KnockOverObject',
        79, 'DestroyObject',
        80, 'StandonFurniture',
        81, 'LockedObject',
        82, 'PickpocketTopic',
        83, 'PursueIdleTopic',
        84, 'SharedInfo',
        85, 'PlayerCastProjectileSpell',
        86, 'PlayerCastSelfSpell',
        87, 'PlayerShout',
        88, 'Idle',
        89, 'EnterSprintBreath',
        90, 'EnterBowZoomBreath',
        91, 'ExitBowZoomBreath',
        92, 'ActorCollidewithActor',
        93, 'PlayerinIronSights',
        94, 'OutofBreath',
        95, 'CombatGrunt',
        96, 'LeaveWaterBreath'
      ]))
    ]),
    wbInteger(TIFC, 'Info Count', itU32)
  ], True);

  wbRecord(DOOR, 'Door', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODLReq,
    wbDEST,
    wbRStruct('Sound', [
      wbFormIDCk(SNAM, 'Open', [SOUN]),
      wbFormIDCk(ANAM, 'Close', [SOUN]),
      wbFormIDCk(BNAM, 'Loop', [SOUN])
    ], [], cpNormal, False, nil, True),
    wbInteger(FNAM, 'Flags', itU8, wbFlags([
      '',
      'Automatic',
      'Hidden',
      'Minimal Use',
      'Sliding',
      'Do Not Open in Combat Search'
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
    'Reverse Subrtact',
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
    'Greater Than or Equal To',
    'Always Show'
  ]);

  wbRecord(EFSH, 'Effect Shader', [
    wbEDID,
    wbString(ICON, 'Fill Texture'),
    wbString(ICO2, 'Particle Shader Texture'),
    wbString(NAM7, 'Holes Texture'),
    wbString(NAM8, 'Membrane Palette Texture'),
    wbString(NAM9, 'Particle Palette Texture'),
    wbStruct(DATA, '', [
      wbByteArray('Unknown', 4),
      wbInteger('Membrane Shader - Source Blend Mode', itU32, wbBlendModeEnum),
      wbInteger('Membrane Shader - Blend Operation', itU32, wbBlendOpEnum),
      wbInteger('Membrane Shader - Z Test Function', itU32, wbZTestFuncEnum),
      wbStruct('Fill/Texture Effect - Color Key 1', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unknown', 1)
      ]),
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
        wbByteArray('Unknown', 1)
      ]),
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
      wbFloat('Particle Shader - Persistant Particle Count'),
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
        wbByteArray('Unknown', 1)
      ]),
      wbStruct('Color Key 2 - Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unknown', 1)
      ]),
      wbStruct('Color Key 3 - Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unknown', 1)
      ]),
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
        wbByteArray('Unknown', 1)
      ]),
      wbFloat('Explosion Wind Speed'),
      wbInteger('Texture Count U', itU32),
      wbInteger('Texture Count V', itU32),
      wbFloat('Addon Models - Fade In Time'),
      wbFloat('Addon Models - Fade Out Time'),
      wbFloat('Addon Models - Scale Start'),
      wbFloat('Addon Models - Scale End'),
      wbFloat('Addon Models - Scale In Time'),
      wbFloat('Addon Models - Scale Out Time'),
      wbFormIDCk('Ambient Sound', [SNDR, NULL]),
      wbStruct('Fill/Texture Effect - Color Key 2', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unknown', 1)
      ]),
      wbStruct('Fill/Texture Effect - Color Key 3', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unknown', 1)
      ]),
      wbStruct('Fill/Texture Effect - Color Key Scale/Time', [
        wbFloat('Color Key 1 - Scale'),
        wbFloat('Color Key 2 - Scale'),
        wbFloat('Color Key 3 - Scale'),
        wbFloat('Color Key 1 - Time'),
        wbFloat('Color Key 2 - Time'),
        wbFloat('Color Key 3 - Time')
      ]),
      wbFloat('Color Scale'),
      wbFloat('Birth Position Offset'),
      wbFloat('Birth Position Offset Range +/-'),
      wbStruct('Particle Shader Animated', [
        wbInteger('Start Frame', itU32),
        wbInteger('Start Frame Variation', itU32),
        wbInteger('End Frame', itU32),
        wbInteger('Loop Start Frame', itU32),
        wbInteger('Loop Start Variation', itU32),
        wbInteger('Frame Count', itU32),
        wbInteger('Frame Count Variation', itU32)
      ]),
      wbInteger('Flags', itU32, wbFlags([
        'No Membrane Shader',
        'Membrane Grayscale Color',
        'Membrane Grayscale Alpha',
        'No Particle Shader',
        'Edge Effect Inverse',
        'Affect Skin Only',
        'Ignore Alpha',
        'Project UVs',
        'Ignore Base Geometry Alpha',
        'Lighting',
        'No Weapons',
        'Unknown 11',
        'Unknown 12',
        'Unknown 13',
        'Unknown 14',
        'Particle Animated',
        'Particle Grayscale Color',
        'Particle Grayscale Alpha',
        'Unknown 18',
        'Unknown 19',
        'Unknown 20',
        'Unknown 21',
        'Unknown 22',
        'Unknown 23',
        'Use Blood Geometry'
      ])),
      wbFloat('Fill/Texture Effect - Texture Scale (U)'),
      wbFloat('Fill/Texture Effect - Texture Scale (V)'),
      wbInteger('Scene Graph Emit Depth Limit', itU32)
    ], cpNormal, True, nil, 0)
  ], False, nil, cpNormal, False, nil {wbEFSHAfterLoad});

  wbRecord(ENCH, 'Object Effect', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbStruct(ENIT, 'Effect Data', [
      wbInteger('Enchantment Cost', itS32),
      wbInteger('Flags', itU32, wbFlags([
        'No Auto-Calc',
        '',
        'Extend Duration On Recast'
      ])),
      wbInteger('Cast Type', itU32, wbCastEnum),
      wbInteger('Enchantment Amount', itS32),
      wbInteger('Target Type', itU32, wbTargetEnum),
      wbInteger('Enchant Type', itU32, wbEnum([], [
        $06, 'Enchantment',
        $0C, 'Staff Enchantment'
      ])),
      wbFloat('Charge Time'),
      wbFormIDCk('Base Enchantment', [ENCH, NULL]),
      wbFormIDCk('Worn Restrictions', [FLST, NULL])
    ], cpNormal, True),
    wbEffectsReq
  ]);

  wbRecord(EYES, 'Eyes', [
    wbEDIDReq,
    wbFULLReq,
    wbString(ICON, 'Texture', 0, cpNormal, True),
    wbInteger(DATA, 'Flags', itU8, wbFlags([
      {0x00000001}'Playable',
      {0x00000002}'Not Male',
      {0x00000004}'Not Female',
      {0x00000008}'Unknown 4',
      {0x00000010}'Unknown 5',
      {0x00000020}'Unknown 6',
      {0x00000040}'Unknown 7',
      {0x00000080}'Unknown 8'
    ]), cpNormal, True)
  ]);

  wbXNAM :=
    wbStructSK(XNAM, [0], 'Relation', [
      wbFormIDCkNoReach('Faction', [FACT, RACE]),
      wbInteger('Modifier', itS32),
      wbInteger('Group Combat Reaction', itU32, wbEnum([
      {0x00000001}'Neutral',
      {0x00000002}'Enemy',
      {0x00000004}'Ally',
      {0x00000008}'Friend'
    ]))
  ]);
  wbXNAMs := wbRArrayS('Relations', wbXNAM);

  wbRecord(FACT, 'Faction', [
    wbEDIDReq,
    wbFULL,
    wbXNAMs,
    wbStruct(DATA, 'Flags', [
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001}'Hidden From NPC',
        {0x00000002}'Special Combat',
        {0x00000004}'Unknown 3',
        {0x00000008}'Unknown 4',
        {0x00000010}'Unknown 5',
        {0x00000020}'Unknown 6',
        {0x00000040}'Track Crime',
        {0x00000080}'Ignore Crimes: Murder',
        {0x00000100}'Ignore Crimes: Assult',
        {0x00000200}'Ignore Crimes: Stealing',
        {0x00000400}'Ignore Crimes: Trespass',
        {0x00000800}'Do Not Report Crimes Against Members',
        {0x00001000}'Crime Gold - Use Defaults',
        {0x00002000}'Ignore Crimes: Pickpocket',
        {0x00004000}'Vendor',
        {0x00008000}'Can Be Owner',
        {0x00010000}'Ignore Crimes: Werewolf',
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
      ]))
    ], cpNormal, True, nil, 1),
    wbFormIDCk(JAIL, 'Exterior Jail Marker', [REFR]),
    wbFormIDCk(WAIT, 'Follower Wait Marker', [REFR]),
    wbFormIDCk(STOL, 'Stolen Goods Container', [REFR]),
    wbFormIDCk(PLCN, 'Player Inventory Container', [REFR]),
    wbFormIDCk(CRGR, 'Shared Crime Faction List', [FLST]),
    wbFormIDCk(JOUT, 'Jail Outfit', [OTFT]),
    wbStruct(CRVA, 'Grime Gold', [
      {01} wbInteger('Arrest', itU8, wbEnum(['False', 'True'])),
      {02} wbInteger('Attack On Sight', itU8, wbEnum(['False', 'True'])),
      {02} wbInteger('Murder', itU16),
      {02} wbInteger('Assult', itU16),
      {02} wbInteger('Trespass', itU16),
      {02} wbInteger('Pickpocket', itU16),
      {02} wbInteger('Unknown', itU16),
      {02} wbFloat('Steal Multiplier'),
      {02} wbInteger('Escape', itU16),
      {02} wbInteger('Werewolf', itU16)
      ], cpNormal, True, nil, 7),
    wbRStructsSK('Ranks', 'Rank', [0], [
      wbInteger(RNAM, 'Rank#', itU32),
      wbLString(MNAM, 'Male Title'),
      wbLString(FNAM, 'Female Title'),
      wbString(INAM, 'Insignia Unused')
    ], []),
    wbFormIDCk(VEND, 'Vendor Buy/Sell List', [FLST]),
    wbFormIDCk(VENC, 'Merchant Container', [REFR]),
    wbStruct(VENV, 'Grime Gold', [
      {01} wbInteger('Start Hour', itU16),
      {02} wbInteger('End Hour', itU16),
      {02} wbInteger('Radius', itU16),
      {02} wbByteArray('Unknown 1', 2),
             wbInteger('Only Buys Stolen Items', itU8, wbEnum(['False', 'True'])),
             wbInteger('Not/Sell Buy', itU8, wbEnum(['False', 'True'])),
      {02} wbByteArray('Unknown 2', 2)
      ]),
    wbStruct(PLVD, 'Location', [
      wbLocationData
    ]),
    wbCITC,
    wbCTDAs
  ], False, nil, cpNormal, False, nil {wbFACTAfterLoad});

  wbRecord(FURN, 'Furniture', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODLReq,
    wbDEST,
    wbKeywords,
    wbUnknown(PNAM),
    wbInteger(FNAM, 'Flags', itU16, wbFlags([
      {0x0001} 'Unknown 0',
      {0x0002} 'Ignored By Sandbox'
    ])),
    wbFormIDCk(KNAM, 'Interaction Keyword', [KYWD, NULL]),
    wbInteger(MNAM, 'Active Markers / Flags', itU32, wbFlags([
      {0x00000001} 'Sit 0',
      {0x00000002} 'Sit 1',
      {0x00000004} 'Sit 2',
      {0x00000008} 'Sit 3',
      {0x00000010} 'Sit 4',
      {0x00000020} 'Sit 5',
      {0x00000040} 'Sit 6',
      {0x00000080} 'Sit 7',
      {0x00000100} 'Sit 8',
      {0x00000200} 'Sit 9',
      {0x00000400} 'Sit 10',
      {0x00000800} 'Sit 11',
      {0x00001000} 'Sit 12',
      {0x00002000} 'Sit 13',
      {0x00004000} 'Sit 14',
      {0x00008000} 'Sit 15',
      {0x00010000} 'Sit 16',
      {0x00020000} 'Sit 17',
      {0x00040000} 'Sit 18',
      {0x00080000} 'Sit 19',
      {0x00100000} 'Sit 20',
      {0x00200000} 'Sit 21',
      {0x00400000} 'Sit 22',
      {0x00800000} 'Sit 23',
      {0x01000000} 'Unknown 25',
      {0x02000000} 'Disables Activation',
      {0x03000000} 'Is Perch',
      {0x08000000} 'Must Exit to Talk',
      {0x10000000} 'Unknown 29',
      {0x20000000} 'Unknown 30',
      {0x40000000} 'Unknown 31',
      {0x80000000} 'Unknown 32'
    ])),
    wbStruct(WBDT, 'Workbench Data', [
      wbInteger('Bench Type', itU8, wbEnum([
        {0} 'None',
        {1} 'Create object',
        {2} 'Smithing Weapon',
        {3} 'Enchanting',
        {4} 'Enchanting Experiment',
        {5} 'Alchemy',
        {6} 'Alchemy Experiment',
        {7} 'Smithing Armor'
      ])),
      wbInteger('Uses Skill', itS8, wbSkillEnum)
    ]),
    wbFormIDCk(NAM1, 'Associated Spell', [SPEL]),
    wbRArray('Markers', wbRStruct('Marker', [
      wbInteger(ENAM, 'Marker Index', itU32),
      wbStruct(NAM0, 'Disabled Entry Points', [
        wbByteArray('Unknown', 2),
        wbInteger('Disabled Points', itU16, wbFlags([
          {0x0001} 'Front',
          {0x0002} 'Behind',
          {0x0004} 'Right',
          {0x0008} 'Left',
          {0x0010} 'Up'
        ]))
      ]),
      wbFormIDCk(FNMK, 'Marker Keyword', [KYWD, NULL])
    ], [])),
    wbRArray('Marker Entry Points', wbStruct(FNPR, 'Marker', [
        wbInteger('Type', itU16, wbEnum([
          {0} 'Unused',
          {1} 'Sit',
          {2} 'Lay'
        ])),
        wbInteger('Entry Points', itU16, wbFlags([
          {0x0001} 'Front',
          {0x0002} 'Behind',
          {0x0004} 'Right',
          {0x0008} 'Left',
          {0x0010} 'Up'
        ]))
    ])),
    wbString(XMRK, 'Model Filename')
  ]);

//----------------------------------------------------------------------------
// For expansion to use wbGLOBUnionDecider to display Short, Long, Float
// correctly without making a signed float by default
//----------------------------------------------------------------------------
  wbRecord(GLOB, 'Global', [
    wbEDIDReq,
    wbInteger(FNAM, 'Type', itU8, wbGLOBFNAM, nil, cpNormal, True),
    wbFloat(FLTV, 'Value', cpNormal, True)
  ]);

  wbRecord(GMST, 'Game Setting', [
    wbString(EDID, 'Editor ID', 0, cpCritical, True, nil, wbGMSTEDIDAfterSet),
    wbUnion(DATA, 'Value', wbGMSTUnionDecider, [
      wbLString('Name'),
      wbInteger('Int', itS32),
      wbFloat('Float'),
      wbBoolU32
    ], cpNormal, True)
  ]);

  wbRecord(KYWD, 'KYWD', [
    wbEDIDReq,
    wbCNAM
  ]);
end;

procedure DefineTES5e;
begin
  wbRecord(LCRT, 'LCRT', [
    wbEDIDReq,
    wbCNAM
  ]);

  wbRecord(AACT, 'AACT', [
    wbEDIDReq,
    wbCNAMReq
  ]);

  wbRecord(TXST, 'Texture Set', [
    wbEDIDReq,
    wbOBNDReq,
    wbRStruct('Textures (RGB/A)', [
      wbString(TX00,'Difuse'),
      wbString(TX01,'Normal/Gloss'),
      wbString(TX02,'Environment Mask'),
      wbString(TX03,'Glow/SubSurface Tint'),
      wbString(TX04,'Height'),
      wbString(TX05,'Environment'),
      wbString(TX06,'Multilayer'),
      wbString(TX07,'Backlight Mask')
    ], []),
    wbDODT,
    wbInteger(DNAM, 'DNAM Record Flags', itU16, wbFlags([
      {0x00000001}'No Specular Map',
      {0x00000002}'Facegen Textures',
      {0x00000004}'Has Model Space Normal Map',
      {0x00000008}'DNAM Unknown 4',
      {0x00000010}'DNAM Unknown 5',
      {0x00000020}'DNAM Unknown 6',
      {0x00000040}'DNAM Unknown 7',
      {0x00000080}'DNAM Unknown 8',
      {0x00000100}'DNAM Unknown 9',
      {0x00000200}'DNAM Unknown 10',
      {0x00000400}'DNAM Unknown 11',
      {0x00000800}'DNAM Unknown 12',
      {0x00001000}'DNAM Unknown 13',
      {0x00002000}'DNAM Unknown 14',
      {0x00004000}'DNAM Unknown 15',
      {0x00008000}'DNAM Unknown 16'
    ]))
  ]);

  wbRecord(MICN, 'Menu Icon', [
    wbEDIDReq,
    wbICONReq
  ]);

  wbRecord(HDPT, 'Head Part', [
    wbEDIDReq,
    wbFULL,
    wbMODL,
    wbInteger(DATA, 'Flags', itU8, wbFlags([
      {0x01} 'Playable',
      {0x02} 'Male',
      {0x04} 'Female',
      {0x10} 'Is Extra Part',
      {0x20} 'Use Solid Tint'
    ]), cpNormal, True),
    wbInteger(PNAM, 'Type', itU32, wbEnum([
      'Misc',
      'Face',
      'Eyes',
      'Hair',
      'Facial Hair',
      'Scar',
      'Eyebrows'
    ])),
    wbRArray('Extra Parts',
      wbFormIDCk(HNAM, 'Part', [HDPT])
    ),
    wbRStructs('Parts', 'Part', [
      wbInteger(NAM0, 'Part Type', itU32, wbEnum([
        'Race Morph',
        'Tri',
        'Chargen Morph'
      ])),
      wbString(NAM1, 'Filename', 0, cpTranslate, True)
    ], []),
    wbFormIDCk(TNAM, 'Texture Set', [TXST, NULL]),
    wbFormIDCk(CNAM, 'Color', [CLFM, NULL]),
    wbFormIDCk(RNAM, 'Valid Races', [FLST, NULL])
  ]);

  wbRecord(ASPC, 'Acoustic Space', [
    wbEDIDReq,
    wbOBNDReq,
    wbFormIDCk(SNAM, 'Ambient Sound', [SNDR]),
    wbFormIDCk(RDAT, 'Use Sound from Region (Interiors Only)', [REGN]),
    wbFormIDCk(BNAM, 'Environment Type (reverb)', [REVB])
  ]);

//------------------------------------------------------------------------------
// As we already know, there is nothing in this Top Group
//------------------------------------------------------------------------------
  wbRecord(SCPT, 'Script', [
    wbEDIDReq
//    wbSCHRReq,
//    wbByteArray(SCDA, 'Compiled Script'),
//    wbStringScript(SCTX, 'Script Source', 0, cpNormal{, True}),
//    wbRArrayS('Local Variables', wbRStructSK([0], 'Local Variable', [
//      wbSLSD,
//      wbString(SCVR, 'Name', 0, cpCritical, True)
//    ], [])),
//    wbSCROs
  ]);

  wbRecord(SCOL, 'Static Collection', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODLReq,
    wbRStructsSK('Parts', 'Part', [0], [
      wbFormIDCk(ONAM, 'Static', [STAT]),
      wbArrayS(DATA, 'Placements', wbStruct('Placement', [
        wbStruct('Position', [
          wbFloat('X'),
          wbFloat('Y'),
          wbFloat('Z')
        ]),
        wbStruct('Rotation', [
          wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
          wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
          wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
        ]),
        wbFloat('Scale')
      ]), 0, cpNormal, True)
    ], [], cpNormal, True)
  ]);

  wbRecord(MSTT, 'Moveable Static', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODLReq,
    wbDEST,
    wbInteger(DATA, 'Flags', itU8, wbFlags([
      'On Local Map'
    ]), cpNormal, True),
    wbFormIDCk(SNAM, 'Looping Sound', [SNDR])
  ]);
end;

procedure DefineTES5f;
begin
  wbRecord(PWAT, 'Placeable Water', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODLReq,
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
    wbOBNDReq,
    wbMODL,
    wbInteger(IDLF, 'Flags', itU8, wbFlags([
      'Run in Sequence',
      '',
      'Do Once',
      '',
      'Ignored by Sandbox'
    ]), cpNormal, True),
    wbInteger(IDLC, 'Animation Count', itU8),
    wbFloat(IDLT, 'Idle Timer Setting', cpNormal, True),
    wbArray(IDLA, 'Animations', wbFormIDCk('Animation', [IDLE]), 0, nil, nil, cpNormal, True)
  ]);

  wbRecord(PROJ, 'Projectile', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODLReq,
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
        'Pass Through Small Transparent',
        'Disable Combat Aim Correction',
        'Rotation'
      ])),
      {02} wbInteger('Type', itU16, wbEnum([], [
        $01, 'Missile',
        $02, 'Lobber',
        $04, 'Beam',
        $08, 'Flame',
        $10, 'Cone',
        $20, 'Barrier',
        $40, 'Arrow'
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
      {64} wbFormIDCk('Default Weapon Source', [WEAP, NULL]),
      {68} wbFloat('Cone Spread'),
      {72} wbFloat('Collision Radius'),
      {76} wbFloat('Lifetime'),
      {80} wbFloat('Relaunch Interval'),
           wbFormIDCk('Decal Data', [TXST, NULL]),
           wbFormIDCk('Collision Layer', [COLL, NULL])
    ], cpNormal, True, nil, 22),
    wbRStructSK([0], 'Muzzle Flash Model', [
      wbString(NAM1, 'Model Filename'),
      wbByteArray(NAM2, 'Texture Files Hashes', 0, cpIgnore)
    ], [], cpNormal, True),
    wbInteger(VNAM, 'Sound Level', itU32, wbSoundLevelEnum, cpNormal, True)
  ]);

  wbRecord(HAZD, 'HAZD', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD, NULL]),
    wbStruct(DATA, 'Data', [
      wbInteger('Limit', itU32),
      wbFloat('Radius'),
      wbFloat('Lifetime'),
      wbFloat('Image Space Radius'),
      wbFloat('Target Interval'),
      wbInteger('Flags', itU32, wbFlags([
        {0x01} 'Affects Player Only',
        {0x02} 'Inherit Duration from Spawn Spell',
        {0x04} 'Align to Impact Normal',
        {0x08} 'Inherit Radius from Spawn Spell',
        {0x10} 'Drop to Ground'
      ])),
      wbFormIDCk('Spell', [ENCH, NULL]),
      wbFormIDCk('Light', [LIGH, NULL]),
      wbFormIDCk('Impact Data Set', [IPDS, NULL]),
      wbFormIDCk('Sound', [SNDR, NULL])
    ])
  ]);

  wbSoulGemEnum := wbEnum([
    {0} 'None',
    {1} 'Petty',
    {2} 'Lesser',
    {3} 'Common',
    {4} 'Greater',
    {5} 'Grand'
  ]);

  wbRecord(SLGM, 'Soul Gem', [
    wbEDID,
    wbOBND,
    wbFULL,
    wbMODL,
    wbKeywords,
    wbICON,
    wbSCRI,
    wbStruct(DATA, '', [
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ], cpNormal, True),
    wbInteger(SOUL, 'Contained Soul', itU8, wbSoulGemEnum, cpNormal, True),
    wbInteger(SLCP, 'Maximum Capacity', itU8, wbSoulGemEnum, cpNormal, True),
    wbFormID(NAM0, 'Unknown')
  ]);

	wbRecord(NAVI, 'Navigation Mesh Info Map', [
    wbEDID,
    wbInteger(NVER, 'Version', itU32),
    wbRArray('Unknown',
      wbArrayS(NVMI, 'Unknown', wbByteArray('Unknown' ,4))
    ),
    wbArrayS(NVPP, 'Unknown', wbByteArray('Unknown' ,4)),
    wbArrayS(NVSI, 'Unknown', wbByteArray('Unknown' ,4))
  ]);

//------------------------------------------------------------------------------
// Begin Old NAVI
//------------------------------------------------------------------------------
//  wbRecord(NAVI, 'Navigation Mesh Info Map', [
//    wbEDID,
//    wbInteger(NVER, 'Version', itU32),
//    wbRArray('Unknown',
//      wbStruct(NVMI, 'Unknown', [
//        wbByteArray('Unknown', 4),
//        wbFormIDCk('Navigation Mesh', [NAVM]),
//        wbFormIDCk('Location', [CELL, WRLD]),
//        wbStruct('Grid', [
//          wbInteger('X', itS16),
//          wbInteger('Y', itS16)
//        ]),
//        wbUnknown
//{        wbUnion('Data', wbNAVINVMIDecider, [
//          wbStruct('Data', [
//            wbUnknown
//          ]),
//          wbStruct('Data', [
//            wbArray('Unknown', wbFloat('Unknown'), 3),
//            wbByteArray('Unknown', 4)
//          ]),
//          wbStruct('Data', [
//            wbArray('Unknown', wbArray('Unknown', wbFloat('Unknown'), 3), 3),
//            wbInteger('Count 1', itU16),
//            wbInteger('Count 2', itU16),
//            wbArray('Unknown', wbArray('Unknown', wbFloat('Unknown'), 3), [], wbNAVINAVMGetCount1),
//            wbUnknown
//          ]),
//          wbStruct('Data', [
//            wbUnknown
//          ])
//        ])}
//      ])
//    ),
//    wbRArray('Unknown',
//      wbStruct(NVCI, 'Unknown', [
//        wbFormIDCk('Unknown', [NAVM]),
//        wbArray('Unknown', wbFormIDCk('Unknown', [NAVM]), -1),
//        wbArray('Unknown', wbFormIDCk('Unknown', [NAVM]), -1),
//        wbArray('Doors', wbFormIDCk('Door', [REFR]), -1)
//      ])
//    )
//  ]);
//------------------------------------------------------------------------------
// End Old NAVI
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// New NAVM
//------------------------------------------------------------------------------
  wbRecord(NAVM, 'Navigation Mesh', [
    wbArrayS(NVNM, 'Unknown NAVM-NVNM', wbFormIDCk('Unknown', [NAVM, CELL, REFR, NULL])),
    wbArrayS(ONAM, 'Unknown NAVM-ONAM', wbFormIDCk('Unknown', [NAVM, CELL, REFR, NULL])),
    wbArrayS(PNAM, 'Unknown NAVM-PNAM', wbFormIDCk('Unknown', [NAVM, CELL, REFR, NULL])),
    wbArrayS(NNAM, 'Unknown NAVM-NNAM', wbFormIDCk('Unknown', [NAVM, CELL, REFR, NULL]))
  ], False, wbNAVMAddInfo);
//------------------------------------------------------------------------------
// Begin Old NAVM
//------------------------------------------------------------------------------
//  wbRecord(NAVM, 'Navigation Mesh', [
//    wbEDID,
//    wbInteger(NVER, 'Version', itU32),
//    wbStruct(DATA, '', [
//      wbFormIDCk('Cell', [CELL]),
//      wbInteger('Vertex Count', itU32),
//      wbInteger('Triangle Count', itU32),
//      wbInteger('External Connections Count', itU32),
//      wbInteger('NVCA Count', itU32),
//      wbInteger('Doors Count', itU32)
//    ]),
//    wbArray(NVVX, 'Vertices', wbStruct('Vertex', [
//      wbFloat('X'),
//      wbFloat('Y'),
//      wbFloat('Z')
//    ])),
//    wbArray(NVTR, 'Triangles', wbStruct('Triangle', [
//      wbArray('Vertices', wbInteger('Vertex', itS16), 3),
//      wbArray('Edges', wbInteger('Triangle', itS16, wbNVTREdgeToStr, wbNVTREdgeToInt), [
//        '0 <-> 1',
//        '1 <-> 2',
//        '2 <-> 0'
//      ]),
//      wbInteger('Flags', itU32, wbFlags([
//        'Triangle #0 Is External',
//        'Triangle #1 Is External',
//        'Triangle #2 Is External',
//        'Unknown 4',
//        'Unknown 5',
//        'Unknown 6',
//        'Unknown 7',
//        'Unknown 8',
//        'Unknown 9',
//        'Unknown 10',
//        'Unknown 11',
//        'Unknown 12',
//        'Unknown 13',
//        'Unknown 14',
//        'Unknown 15',
//        'Unknown 16',
//        'Unknown 17',
//        'Unknown 18',
//        'Unknown 19',
//        'Unknown 20',
//        'Unknown 21',
//        'Unknown 22',
//        'Unknown 23',
//        'Unknown 24',
//        'Unknown 25',
//        'Unknown 26',
//        'Unknown 27',
//        'Unknown 28',
//        'Unknown 29',
//        'Unknown 30',
//        'Unknown 31',
//        'Unknown 32'
//      ]))
//    ])),
//    wbArray(NVCA, 'Unknown', wbInteger('Unknown', itS16)),
//    wbArray(NVDP, 'Doors', wbStruct('Door', [
//      wbFormIDCk('Reference', [REFR]),
//      wbInteger('Unknown', itU16),
//      wbByteArray('Unknown', 2)
//    ])),
//    wbStruct(NVGD, 'Unknown', [
//      wbUnknown
//      wbByteArray('Unknown', 4),
//      wbFloat('Unknown'),
//      wbFloat('Unknown'),
//      wbFloat('Unknown'),
//      wbFloat('Unknown'),
//      wbFloat('Unknown'),
//      wbFloat('Unknown'),
//      wbFloat('Unknown'),
//      wbFloat('Unknown'),
//      wbArray('Unknown', wbArray('Unknown', wbInteger('Unknown', itU16), -2))
//    ]),
//    wbArray(NVEX, 'External Connections', wbStruct('Connection', [
//      wbByteArray('Unknown', 4),
//      wbFormIDCk('Navigation Mesh', [NAVM], False, cpBenign),
//      wbInteger('Triangle', itU16, nil, cpBenign)
//    ]))
//  ], False, wbNAVMAddInfo);
//------------------------------------------------------------------------------
// End Old NAVM
//------------------------------------------------------------------------------

end;

procedure DefineTES5g;
begin

   wbRecord(EXPL, 'Explosion', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbEITM,
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD]),
    wbStruct(DATA, 'Data', [
      wbFormIDCk('Light', [LIGH, NULL]),
      wbFormIDCk('Sound 1', [SNDR, NULL]),
      wbFormIDCk('Sound 2', [SNDR, NULL]),
      wbFormIDCk('Impact Data Set', [IPDS, NULL]),
      wbFormID('Placed Object'),
      wbFormIDCk('Spawn Projectile', [PROJ, NULL]),
      wbFloat('Force'),
      wbFloat('Damage'),
      wbFloat('Radius'),
      wbFloat('IS Radius'),
      wbFloat('Vertical Offset Mult'),
      wbInteger('Flags', itU32, wbFlags([
        'Unknown 0',
        'Always Uses World Orientation',
        'Knock Down - Always',
        'Knock Down - By Formula',
        'Ignore LOS Check',
        'Push Explosion Source Ref Only',
        'Ignore Image Space Swap',
        'Chain',
        'No Controller Vibration'
      ])),
      wbInteger('Sound Level', itU32, wbSoundLevelEnum, cpNormal, True)
    ])
  ]);

  wbRecord(DEBR, 'Debris', [
    wbEDIDReq,
    wbRStructs('Models', 'Model', [
      wbStruct(DATA, 'Data', [
        wbInteger('Percentage', itU8),
        wbString('Model Filename'),
        wbInteger('Flags', itU8, wbFlags([
          'Has Collission Data'
        ]))
      ], cpNormal, True),
      wbMODT
    ], [], cpNormal, True)
  ]);

  wbRecord(IMGS, 'Image Space', [
    wbEDIDReq,
    wbUnknown(ENAM),
    wbStruct(HNAM, 'HDR', [
      wbFloat('Eye Adapt Speed'),
      wbFloat('Bloom Blur Radius'),
      wbFloat('Bloom Threshold'),
      wbFloat('Bloom Scale'),
      wbFloat('Receive Bloom Threshold'),
      wbFloat('White'),
      wbFloat('Sunlight Scale'),
      wbFloat('Sky Scale'),
      wbFloat('Eye Adapt Strength')
    ]),
    wbStruct(CNAM, 'Cinematic', [
      wbFloat('Saturation'),
      wbFloat('Brightness'),
      wbFloat('Contrast')
    ]),
    wbStruct(TNAM, 'Tint', [
      wbFloat('Amount'),
      wbStruct('Color', [
        wbFloat('Red', cpNormal, True, 255, 0),
        wbFloat('Green', cpNormal, True, 255, 0),
        wbFloat('Blue', cpNormal, True, 255, 0)
      ])
    ]),
    wbStruct(DNAM, 'Depth of Field', [
      wbFloat('Strength'),
      wbFloat('Distance'),
      wbFloat('Range'),
      wbByteArray('Unknown', 2),
      wbInteger('Sky / Blur Radius', itU16, wbEnum([], [
        16384, 'Radius 0',
        16672, 'Radius 1',
        16784, 'Radius 2',
        16848, 'Radius 3',
        16904, 'Radius 4',
        16936, 'Radius 5',
        16968, 'Radius 6',
        17000, 'Radius 7',
        16576, 'No Sky, Radius 0',
        16736, 'No Sky, Radius 1',
        16816, 'No Sky, Radius 2',
        16880, 'No Sky, Radius 3',
        16920, 'No Sky, Radius 4',
        16952, 'No Sky, Radius 5',
        16984, 'No Sky, Radius 6',
        17016, 'No Sky, Radius 7'
      ]))
    ], cpNormal, False, nil, 3)
  ]);

  wbRecord(IMAD, 'Image Space Adapter', [
    wbEDID,
    wbStruct(DNAM, 'Data', [
      wbInteger('Flags', itU32, wbFlags(['Animatable'])),
      wbFloat('Duration'),
      wbByteArray('Unknown', 4*48),
      wbInteger('Radial Blur Flags', itU32, wbFlags(['Use Target'])),
      wbFloat('Radial Blur Center X'),
      wbFloat('Radial Blur Center Y'),
      wbArray('Unknown', wbByteArray('Unknown', 4), 3),
      wbInteger('DoF Flags', itU32, wbFlags([
        {0x00000001}'Use Target',
        {0x00000002}'Unknown 2',
        {0x00000004}'Unknown 3',
        {0x00000008}'Unknown 4',
        {0x00000010}'Unknown 5',
        {0x00000020}'Unknown 6',
        {0x00000040}'Unknown 7',
        {0x00000080}'Unknown 8',
        {0x00000100}'Mode - Front',
        {0x00000200}'Mode - Back',
        {0x00000400}'No Sky',
        {0x00000800}'Blur Radius Bit 2',
        {0x00001000}'Blur Radius Bit 1',
        {0x00002000}'Blur Radius Bit 0'
      ])),
      wbUnknown
    ]),
    wbStruct(BNAM, 'Blur', [
      wbFloat('Unknown'),
      wbFloat('Radius'),
      wbUnknown
    ]),
    wbStruct(VNAM, 'Double Vision', [
      wbFloat('Unknown'),
      wbFloat('Strength'),
      wbUnknown
    ]),
    wbRStruct('Cinematic Colors', [
      wbStruct(TNAM, 'Tint', [
        wbFloat('Unknown'),
        wbStruct('Tint', [
          wbFloat('Red', cpNormal, True, 255, 0),
          wbFloat('Green', cpNormal, True, 255, 0),
          wbFloat('Blue', cpNormal, True, 255, 0),
          wbFloat('Alpha', cpNormal, True, 255, 0)
        ]),
        wbUnknown
      ]),
      wbStruct(NAM3, 'Fade', [
        wbFloat('Unknown'),
        wbStruct('Fade', [
          wbFloat('Red', cpNormal, True, 255, 0),
          wbFloat('Green', cpNormal, True, 255, 0),
          wbFloat('Blue', cpNormal, True, 255, 0),
          wbFloat('Alpha', cpNormal, True, 255, 0)
        ]),
        wbUnknown
      ])
    ], []),
    wbRStruct('Radial Blur', [
      wbStruct(RNAM, '', [
        wbFloat('Unknown'),
        wbFloat('Strength'),
        wbUnknown
      ]),
      wbStruct(SNAM, '', [
        wbFloat('Unknown'),
        wbFloat('Rampup'),
        wbUnknown
      ]),
      wbStruct(UNAM, '', [
        wbFloat('Unknown'),
        wbFloat('Start'),
        wbUnknown
      ]),
      wbStruct(NAM1, '', [
        wbFloat('Unknown'),
        wbFloat('Rampdown'),
        wbUnknown
      ]),
      wbStruct(NAM2, '', [
        wbFloat('Unknown'),
        wbFloat('Downstart'),
        wbUnknown
      ])
    ], []),
    wbRStruct('Depth of Field', [
      wbStruct(WNAM, 'Depth of Field', [
        wbFloat('Unknown'),
        wbFloat('Strength'),
        wbUnknown
      ]),
      wbStruct(XNAM, 'Depth of Field', [
        wbFloat('Unknown'),
        wbFloat('Distance'),
        wbUnknown
      ]),
      wbStruct(YNAM, 'Depth of Field', [
        wbFloat('Unknown'),
        wbFloat('Range'),
        wbUnknown
      ])
    ], []),
    wbStruct(NAM4, 'FullScreen Motion Blur', [
      wbFloat('Unknown'),
      wbFloat('Strength'),
      wbUnknown
    ]),
    wbRStruct('HDR', [
      wbStruct(_00_IAD, 'Eye Adapt Speed', [
        wbFloat('Unknown'),
        wbFloat('Multiply'),
        wbUnknown
      ]),
      wbStruct(_40_IAD, 'Eye Adapt Speed', [
        wbFloat('Unknown'),
        wbFloat('Add'),
        wbUnknown
      ]),
      wbStruct(_01_IAD, 'Bloom Blur Radius', [
        wbFloat('Unknown'),
        wbFloat('Multiply'),
        wbUnknown
      ]),
      wbStruct(_41_IAD, 'Bloom Blur Radius', [
        wbFloat('Unknown'),
        wbFloat('Add'),
        wbUnknown
      ]),
      wbStruct(_02_IAD, 'Bloom Threshold', [
        wbFloat('Unknown'),
        wbFloat('Multiply'),
        wbUnknown
      ]),
      wbStruct(_42_IAD, 'Bloom Threshold', [
        wbFloat('Unknown'),
        wbFloat('Add'),
        wbUnknown
      ]),
      wbStruct(_03_IAD, 'Bloom Scale', [
        wbFloat('Unknown'),
        wbFloat('Multiply'),
        wbUnknown
      ]),
      wbStruct(_43_IAD, 'Bloom Scale', [
        wbFloat('Unknown'),
        wbFloat('Add'),
        wbUnknown
      ]),
      wbStruct(_04_IAD, 'Target Lum Min', [
        wbFloat('Unknown'),
        wbFloat('Multiply'),
        wbUnknown
      ]),
      wbStruct(_44_IAD, 'Target Lum Min', [
        wbFloat('Unknown'),
        wbFloat('Add'),
        wbUnknown
      ]),
      wbStruct(_05_IAD, 'Target Lum Max', [
        wbFloat('Unknown'),
        wbFloat('Multiply'),
        wbUnknown
      ]),
      wbStruct(_45_IAD, 'Target Lum Max', [
        wbFloat('Unknown'),
        wbFloat('Add'),
        wbUnknown
      ]),
      wbStruct(_06_IAD, 'Sunlight Scale', [
        wbFloat('Unknown'),
        wbFloat('Multiply'),
        wbUnknown
      ]),
      wbStruct(_46_IAD, 'Sunlight Scale', [
        wbFloat('Unknown'),
        wbFloat('Add'),
        wbUnknown
      ]),
      wbStruct(_07_IAD, 'Sky Scale', [
        wbFloat('Unknown'),
        wbFloat('Multiply'),
        wbUnknown
      ]),
      wbStruct(_47_IAD, 'Sky Scale', [
        wbFloat('Unknown'),
        wbFloat('Add'),
        wbUnknown
      ])
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
    wbRStruct('Cinematic', [
      wbStruct(_11_IAD, 'Saturation', [
        wbFloat('Unknown'),
        wbFloat('Multiply'),
        wbUnknown
      ]),
      wbStruct(_51_IAD, 'Saturation', [
        wbFloat('Unknown'),
        wbFloat('Add'),
        wbUnknown
      ]),
      wbStruct(_12_IAD, 'Brightness', [
        wbFloat('Unknown'),
        wbFloat('Multiply'),
        wbUnknown
      ]),
      wbStruct(_52_IAD, 'Brightness', [
        wbFloat('Unknown'),
        wbFloat('Add'),
        wbUnknown
      ]),
      wbStruct(_13_IAD, 'Contrast', [
        wbFloat('Unknown'),
        wbFloat('Multiply'),
        wbUnknown
      ]),
      wbStruct(_53_IAD, 'Contrast', [
        wbFloat('Unknown'),
        wbFloat('Add'),
        wbUnknown
      ])
    ], []),
    wbUnknown(_14_IAD),
    wbUnknown(_54_IAD)
  ]);

  wbRecord(FLST, 'FormID List', [
    wbString(EDID, 'Editor ID', 0, cpBenign, True, nil, wbFLSTEDIDAfterSet),
    wbRArrayS('FormIDs', wbFormID(LNAM, 'FormID'), cpNormal, False, nil, nil, nil, wbFLSTLNAMIsSorted)
  ]);

  wbRecord(PERK, 'Perk', [
    wbEDIDReq,
    wbVMAD,
    wbFULL,
    wbDESCReq,
    wbICON,
    wbCTDAs,
    wbStruct(DATA, 'Data', [
      wbInteger('Trait', itU8, wbEnum(['False', 'True'])),
      wbInteger('Level', itU8),
      wbInteger('Num Ranks', itU8),
      wbInteger('Playable', itU8, wbEnum(['False', 'True'])),
      wbInteger('Hidden', itU8, wbEnum(['False', 'True']))
    ], cpNormal, True{, nil, 4}),
    wbFormIDCK(NNAM, 'Next Perk', [PERK, NULL]),

    wbRArray('Perk Entries', wbRStruct('Perk Entry', [
      wbStructSK(PRKE, [1, 2, 0], 'Header', [
        wbInteger('Type', itU8, wbEnum([
          'Quest + Stage',
          'Ability',
          'Entry Point'
        ]), cpNormal, False, nil, wbPERKPRKETypeAfterSet),
        wbInteger('Rank', itU8),
        wbInteger('Priority', itU8)
      ]),
      wbUnion(DATA, 'Effect Data', wbPerkDATADecider, [
        wbStructSK([0, 1], 'Quest + Stage', [
          wbFormIDCk('Quest', [QUST]),
          wbInteger('Quest Stage', itS8{, wbPerkDATAQuestStageToStr, wbCTDAParam2QuestStageToInt}),
          wbByteArray('Unused', 3)
        ]),
        wbFormIDCk('Ability', [SPEL]),
        wbStructSK([0, 1], 'Entry Point', [
          wbInteger('Entry Point', itU8, wbEntryPointsEnum, cpNormal, True, nil{, wbPERKEntryPointAfterSet}),
          wbInteger('Function', itU8, wbEnum([
            {0} 'Unknown 0',
            {1} 'Set Value', // EPFT=1
            {2} 'Add Value', // EPFT=1
            {3} 'Multiply Value', // EPFT=1
            {4} 'Add Range To Value', // EPFT=2
            {5} 'Add Actor Value Mult', // EPFT=2
            {6} 'Absolute Value', // no params
            {7} 'Negative Absolute Value', // no params
            {8} 'Add Leveled List', // EPFT=3
            {9} 'Add Activate Choice', // EPFT=4
           {10} 'Select Spell', // EPFT=5
           {11} 'Select Text', // EPFT=6
           {12} 'Set to Actor Value Mult', // EPFT=2
           {13} 'Multiply Actor Value Mult', // EPFT=2
           {14} 'Multiply 1 + Actor Value Mult', // EPFT=2
           {15} 'Set Text' // EPFT=7
          ])),
          wbInteger('Perk Condition Tab Count', itU8, nil, cpIgnore)
        ])
      ], cpNormal, True),

      wbRStructsSK('Perk Conditions', 'Perk Condition', [0], [
        wbInteger(PRKC, 'Run On (Tab Index)', itS8{, wbPRKCToStr, wbPRKCToInt}),
        wbCTDAsReq
      ], [], cpNormal, False{, nil, nil, wbPERKPRKCDontShow}),

      wbRStruct('Function Parameters', [
        wbInteger(EPFT, 'Type', itU8),
        // case(EPFT) of
        // 1: EPFD=float
        // 2: EPFD=float,float
        // 3: EPFD=LVLI
        // 4: EPFD=SPEL, EPF2=lstring, EPFT3=int32 flags
        // 5: EPFD=SPEL
        // 6: EPFD=string
        // 7: EPFD=lstring
        wbLString(EPF2, 'Button Label'),
        wbStruct(EPF3, 'Script Flags', [
          wbInteger('Script Flags', itU8, wbFlags([
            'Run Immediately',
            'Replace Default'
          ])),
          wbByteArray('Unknown', 3)
        ]),
        wbUnion(EPFD, 'Data', wbEPFDDecider, [
          {0} wbByteArray('Unknown'),
          {1} wbFloat('Float'),
          {2} wbStruct('Float, Float', [
                wbFloat('Float 1'),
                wbFloat('Float 2')
              ]),
          {3} wbFormIDCk('Leveled Item', [LVLI]),
          {4} wbFormIDCk('Spell', [SPEL]),
          {5} wbFormIDCk('Spell', [SPEL]),
          {6} wbString('Text'),
          {7} wbLString('Text'),
          {8} wbStruct('Actor Value, Float', [
                wbInteger('Actor Value', itU32, wbEPFDActorValueToStr, wbEPFDActorValueToInt),
                wbFloat('Float')
              ])
        ], cpNormal, False{, wbEPFDDontShow})
      ], [], cpNormal, False{, wbPERKPRKCDontShow}),
      wbEmpty(PRKF, 'End Marker', cpIgnore, True)
    ], []))
  ]);

  wbRecord(BPTD, 'Body Part Data', [
    wbEDIDReq,
    wbMODLReq,
    wbRStructs('Body Parts', 'Body Part', [
      wbLString(BPTN, 'Part Name', 0, cpNormal, True),
      wbString(BPNN, 'Part Node', 0, cpNormal, True),
      wbString(BPNT, 'VATS Target', 0, cpNormal, True),
      wbString(BPNI, 'IK Data - Start Node', 0, cpNormal, True),
      wbStruct(BPND, '', [
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
               'Head',
               'Eye',
               'LookAt',
               'Fly Grab',
               'Saddle'
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
          ]),
          wbStruct('Rotation', [
            {56} wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
            {60} wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
            {64} wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
          ])
        ]),
        {68} wbFormIDCk('Severable - Impact DataSet', [IPDS, NULL]),
        {72} wbFormIDCk('Explodable - Impact DataSet', [IPDS, NULL]),
        {28} wbInteger('Severable - Decal Count', itU8),
        {28} wbInteger('Explodable - Decal Count', itU8),
        {76} wbByteArray('Unknown', 2),
        {80} wbFloat('Limb Replacement Scale')
      ], cpNormal, True),
      wbString(NAM1, 'Limb Replacement Model', 0, cpNormal, True),
      wbString(NAM4, 'Gore Effects - Target Bone', 0, cpNormal, True),
      wbByteArray(NAM5, 'Texture Files Hashes', 0, cpIgnore)
    ], [], cpNormal, True),
    wbFormIDCk(RAGA, 'Ragdoll', [RGDL])
  ]);

  wbRecord(ADDN, 'Addon Node', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODLReq,
    wbInteger(DATA, 'Node Index', itS32, nil, cpNormal, True),
    wbFormIDCk(SNAM, 'Sound', [SOUN, NULL]),
    wbStruct(DNAM, 'Data', [
      wbInteger('Master Particle System Cap', itU16),
      wbInteger('Flags', itU16, wbFlags([
        {0x00000001}'Unknown 0',
        {0x00000002}'Always Loaded'
      ]))
    ], cpNormal, True)
  ]);
end;

procedure DefineTES5h;
begin
  wbRecord(AVIF, 'ActorValue Information', [
    wbEDIDReq,
    wbFULL,
    wbDESCReq,
    wbString(ANAM, 'Abbreviation'),
    wbUnknown(CNAM),
    wbStruct(AVSK, '', [
      wbFloat('XP Mult'),
      wbUnknown
    ]),
    wbRArray('Perk Tree',
      wbRStruct('Node', [
        wbFormIDCk(PNAM, 'Perk', [PERK, NULL]),
        wbUnknown(FNAM),
        wbInteger(XNAM, 'Perk-Grid X', itU32),
        wbInteger(YNAM, 'Perk-Grid Y', itU32),
        wbFloat(HNAM, 'Horizontal Position'),
        wbFloat(VNAM, 'Vertical Position'),
        wbFormIDCk(SNAM, 'Skill', [AVIF, NULL]),
        wbRArray('Connections', wbInteger(CNAM, 'Line', itU32)),
        wbInteger(INAM, 'Index', itU32)
      ], [])
    )
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
    wbMODL,
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
        'Target',
        'Lead Actor'
      ])),
      {08} wbInteger('Target', itU32, wbEnum([
        'Attacker',
        'Projectile',
        'Target',
        'Lead Actor'
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
      {36} wbFloat('Target % Between Actors'),
      {40} wbFloat('Near Target Distance')
    ], cpNormal, True, nil),
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD])
  ]);

  wbRecord(CPTH, 'Camera Path', [
    wbEDIDReq,
    wbCTDAs,
    wbArray(ANAM, 'Related Camera Paths', wbFormIDCk('Related Camera Path', [CPTH, NULL]), ['Parent', 'Previous Sibling'], cpNormal, True),
    wbInteger(DATA, 'Camera Zoom', itU8, wbEnum([], [
      0, 'Default, Must Have Camera Shots',
      1, 'Disable, Must Have Camera Shots',
      2, 'Shot List, Must Have Camera Shots',
      128, 'Default',
      129, 'Disable',
      130, 'Shot List'
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

  wbRecord(MATT, 'Material Type', [
    wbEDIDReq,
    wbFormIDCk(PNAM, 'Material Parent', [MATT, NULL]),
    wbString(MNAM, 'Material Name'),
    wbStruct(CNAM, 'Havok Display Color', [
      wbFloat('Red', cpNormal, True, 255, 0),
      wbFloat('Green', cpNormal, True, 255, 0),
      wbFloat('Blue', cpNormal, True, 255, 0)
    ]),
    wbFloat(BNAM, 'Buoyancy'),
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      'Stair Material',
      'Arrows Stick'
    ], False)),
    wbFormIDCk(HNAM, 'Havok Impact Data Set', [IPDS, NULL])
  ]);

  wbRecord(IPCT, 'Impact', [
    wbEDIDReq,
    wbMODL,
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
      wbInteger('Flags', itU8, wbFlags([
        {0x01} 'No Decal Data'
      ])),
      wbInteger('Impact Result', itU8, wbEnum([
         {0} 'Default',
         {1} 'Destroy',
         {2} 'Bounce',
         {3} 'Impale',
         {4} 'Stick'
      ])),
      wbByteArray('Unknown', 2)
    ], cpNormal, True),
    wbDODT,
    wbFormIDCk(DNAM, 'Texture Set', [TXST]),
    wbFormIDCk(ENAM, 'Secondary Texture Set', [TXST]),
    wbFormIDCk(SNAM, 'Sound 1', [SNDR, NULL]),
    wbFormIDCk(NAM1, 'Sound 2', [SNDR, NULL]),
    wbFormIDCk(NAM2, 'Hazard', [HAZD, NULL])
  ]);

  wbRecord(IPDS, 'Impact DataSet', [
    wbEDIDReq,
    wbRArray('Data', wbStruct(PNAM, '', [
      wbFormIDCk('Material', [MATT]),
      wbFormIDCk('Impact', [IPCT])
    ]))
  ]);

  wbRecord(ECZN, 'Encounter Zone', [
    wbEDIDReq,
    wbStruct(DATA, '', [
      wbFormIDCkNoReach('Owner', [NPC_, FACT, NULL]),
      wbFormIDCk('Location', [LCTN, NULL]),
      wbInteger('Rank', itS8),
      wbInteger('Min Level', itS8),
      wbInteger('Flags', itU8, wbFlags([
        'Never Resets',
        'Match PC Below Minimum Level',
        'Disable Combat Boundary'
      ])),
      wbInteger('Max Level', itS8)
    ], cpNormal, True, nil, 2)
  ]);

  wbRecord(LCTN, 'Location', [
    wbEDIDReq,

    wbUnknown(ACPR),
    wbArray(LCPR, 'Actors', wbStruct('', [
      wbFormIDCk('Actor', [ACHR]),
      wbFormIDCk('Location', [WRLD, CELL]),
      wbByteArray('Unknown', 4)
    ])),

    wbUnknown(RCPR),

    wbUnknown(ACUN),
    wbArray(LCUN, 'Unique Refs', wbStruct('', [
      wbFormIDCk('Actor', [NPC_]),
      wbFormIDCk('Ref', [ACHR]),
      wbFormIDCk('Location', [LCTN])
    ])),

    wbUnknown(ACSR),
    wbArray(LCSR, 'Location Ref Types', wbStruct('', [
      wbFormIDCk('Loc Ref Type', [LCRT]),
      wbFormIDCk('Marker', [REFR, ACHR]),
      wbFormIDCk('Location', [WRLD, CELL]),
      wbByteArray('Unknown', 4)
    ])),

    wbUnknown(ACEC),
    wbRArray('Unknown',
      wbStruct(LCEC, 'Unknown', [
        wbFormIDCk('Location', [WRLD, CELL]),
        wbArray('Unknown', wbByteArray('Unknown', 4))
      ])
    ),

    wbArray(ACID, 'Unknown', wbFormIDCk('Ref', [ACHR, REFR])),
    wbArray(LCID, 'Unknown', wbFormIDCk('Ref', [ACHR, REFR])),

    wbUnknown(ACEP),
    wbArray(LCEP, 'Unknown', wbStruct('', [
      wbFormIDCk('Actor', [ACHR]),
      wbFormIDCk('Ref', [REFR]),
      wbByteArray('Unknown', 4)
    ])),

    wbFull,
    wbKeywords,
    wbFormIDCk(PNAM, 'Parent Location', [LCTN, NULL]),
    wbFormIDCk(NAM1, 'Music', [MUSC, NULL]),
    wbFormIDCk(FNAM, 'Unreported Crime Faction', [FACT]),
    wbFormIDCk(MNAM, 'World Location Marker Ref', [REFR]),
    wbFloat(RNAM, 'World Location Radius'),
    wbFormIDCk(NAM0, 'Horse Marker Ref', [REFR]),
    wbCNAM
  ]);

end;

procedure DefineTES5i;
begin
  wbRecord(MESG, 'Message', [
    wbEDIDReq,
    wbDESCReq,
    wbFULL,
    wbFormIDCk(INAM, 'Icon', [MICN, NULL], False, cpNormal, True),
    wbFormIDCk(QNAM, 'Owner Quest', [QUST]),
    wbInteger(DNAM, 'Flags', itU32, wbFlags([
      'Message Box',
      'Auto Display'
    ]), cpNormal, True, False, nil, wbMESGDNAMAfterSet),
    wbInteger(TNAM, 'Display Time', itU32, nil, cpNormal, False, False, wbMESGTNAMDontShow),
    wbRStructs('Menu Buttons', 'Menu Button', [
      wbLString(ITXT, 'Button Text'),
      wbCTDAs
    ], [])
  ], False, nil, cpNormal, False, wbMESGAfterLoad);

  wbRecord(RGDL, 'Ragdoll', [
    wbEDIDReq,
    wbInteger(NVER, 'Version', itU32, nil, cpNormal, True),
    wbStruct(DATA, 'General Data', [
      wbInteger('Dynamic Bone Count', itU32),
      wbByteArray('Unknown', 4),
      wbStruct('Enabled', [
        wbInteger('Feedback', itU8, wbEnum(['No', 'Yes'])),
        wbInteger('Foot IK (broken, don''t use)', itU8, wbEnum(['No', 'Yes'])),
        wbInteger('Look IK (broken, don''t use)', itU8, wbEnum(['No', 'Yes'])),
        wbInteger('Grab IK (broken, don''t use)', itU8, wbEnum(['No', 'Yes'])),
        wbInteger('Pose Matching', itU8, wbEnum(['No', 'Yes']))
      ]),
      wbByteArray('Unknown', 1)
    ], cpNormal, True),
    wbFormIDCk(XNAM, 'Actor Base', [NPC_], False, cpNormal, True),
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
    ], cpNormal, True),
    wbArray(RAFB, 'Feedback Dynamic Bones', wbInteger('Bone', itU16), 0, nil, nil, cpNormal, True),
    wbStruct(RAPS, 'Pose Matching Data', [
    {00} wbArray('Match Bones', wbInteger('Bone', itU16, wbHideFFFF), 3),
    {06} wbInteger('Flags', itU8, wbFlags([
           'Disable On Move'
         ])),
    {07} wbByteArray('Unknown', 1),
    {08} wbFloat('Motors Strength'),
    {12} wbFloat('Pose Activation Delay Time'),
    {16} wbFloat('Match Error Allowance'),
    {20} wbFloat('Displacement To Disable')
    ], cpNormal, True),
    wbString(ANAM, 'Death Pose')
  ]);

  wbRecord(DOBJ, 'Default Object Manager', [
    wbArray(DNAM, 'Objects',
      wbStruct('Object', [
        wbString('Use', 4),
        wbFormID('Object ID')
      ]), 0, nil, nil, cpNormal, True
    )
  ]);

  wbRecord(LGTM, 'Lighting Template', [
    wbEDIDReq,
    wbStruct(DATA, 'Lighting', [
      wbStruct('Ambient Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unknown', 1)
      ]),
      wbStruct('Directional Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unknown', 1)
      ]),
      wbStruct('Fog Color Near', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unknown', 1)
      ]),
      wbFloat('Fog Near'),
      wbFloat('Fog Far'),
      wbInteger('Directional Rotation XY', itS32),
      wbInteger('Directional Rotation Z', itS32),
      wbFloat('Directional Fade'),
      wbFloat('Fog Clip Dist'),
      wbFloat('Fog Power'),
      wbByteArray('Unknown', 32),
      wbStruct('Fog Color Far', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unknown', 1)
      ]),
      wbFloat('Fog Max'),
      wbStruct('Light Fade Distances', [
        wbFloat('Start'),
        wbFloat('End')
      ]),
      wbByteArray('Unknown', 4)
    ], cpNormal, True, nil, 11),
    wbStruct(DALC, 'Directional Ambient Values', [
      wbArray('Colors',
        wbStruct('Color', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unknown', 1)
        ]),
        ['X+', 'X-', 'Y+', 'Y-', 'Z+', 'Z-']
      ),
      wbStruct('Specular (unused)', [
        wbStruct('Color', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unknown', 1)
        ]),
        wbFloat('Fresnel Power')
      ], cpNormal, True, nil, 1)
    ])
  ]);

  wbRecord(MUSC, 'Music Type', [
    wbEDIDReq,
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      {0x01} 'Plays One Selection',
      {0x02} 'Abrupt Transition',
      {0x04} 'Cycle Tracks',
      {0x08} 'Maintain Track Order',
      {0x10} 'Unknown 5',
      {0x20} 'Ducks Current Track'
    ]), cpNormal, True),
    wbStruct(PNAM, 'Data', [
      wbInteger('Priority', itU16),
      wbInteger('Ducking (dB)', itU16, wbDiv(100))
    ]),
    wbFloat(WNAM, 'Fade Duration'),
    wbArray(TNAM, 'Music Tracks', wbFormIDCk('Track', [MUST, NULL]))
  ]);

  wbRecord(FSTP, 'Footstep', [
    wbEDIDReq,
    wbFormIDCk(DATA, 'Impact Data Set', [IPDS, NULL], False, cpNormal, True),
    wbString(ANAM, 'Tag', 0, cpNormal, True)
  ]);

  wbRecord(FSTS, 'Footstep Set', [
    wbEDIDReq,
    wbStruct(XCNT, 'Count', [
      wbInteger('Walk Forward Sets', itU32),
      wbInteger('Run Forward Sets', itU32),
      wbInteger('Walk Forward Alternate Sets', itU32),
      wbInteger('Run Forward Alternate Sets', itU32),
      wbInteger('Walk Forward Alternate 2 Sets', itU32)
    ], cpNormal, True),
    wbArray(DATA, 'Footstep Sets', wbFormIDCk('Footstep', [FSTP]), 0, nil, nil, cpNormal, True)
  ]);

  wbRecord(SMBN, 'SMBN', [
    wbEDIDReq,
    wbFormIDCk(PNAM, 'Parent ', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCk(SNAM, 'Child ', [SMQN, SMBN, SMEN, NULL]),
    wbUnknown(CITC),
    wbCTDAs,
    wbUnknown(DNAM),
    wbUnknown(XNAM)
  ]);

  wbRecord(SMQN, 'SMQN', [
    wbEDID,
    wbFormIDCk(PNAM, 'Parent ', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCk(SNAM, 'Child ', [SMQN, SMBN, SMEN, NULL]),
    wbUnknown(CITC),
    wbCTDAs,
    wbUnknown(DNAM),
    wbUnknown(XNAM),
    wbUnknown(MNAM),
    wbInteger(QNAM, 'Count', itU32),
    wbRArray('Array NNAM, FNAM, RNAM', wbRStruct('Unknown', [
      wbFormID(NNAM, 'Unknown'),
      wbUnknown(FNAM),
      wbUnknown(RNAM)
    ], []))
  ]);

  wbRecord(SMEN, 'SMEN', [
    wbEDID,
    wbFormIDCk(PNAM, 'Parent ', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCk(SNAM, 'Child ', [SMQN, SMBN, SMEN, NULL]),
    wbUnknown(CITC),
    wbCTDAs,
    wbUnknown(DNAM),
    wbUnknown(XNAM),
    wbString(ENAM, 'Unknown', 4)
  ]);
end;

procedure DefineTES5j;
begin
  wbRecord(DLBR, 'Dialog Branch', [
    wbEDIDReq,
    wbFormIDCk(QNAM, 'Quest', [QUST], False, cpNormal, True),
    wbInteger(TNAM, 'Unknown', itU32),
    wbInteger(DNAM, 'Flags', itU32, wbFlags([
      {0x01} 'Top-Level',
      {0x02} 'Blocking',
      {0x04} 'Exclusive'
    ])),
    wbFormIDCk(SNAM, 'Starting Topic', [DIAL], False, cpNormal, True)
  ]);

  wbRecord(MUST, 'MUST', [
    wbEDIDReq,
    wbInteger(CNAM, 'Track Type', itU32, wbEnum([], [
      $23F678C3, 'Palette',
      $6ED7E048, 'Single Track',
      $A1A9C4D5, 'Silent Track' {>>> BUG this value is not recognized <<<}
    ]), cpNormal, True),
    wbFloat(FLTV, 'Duration'),
    wbFloat(DNAM, 'Fade-Out'),
    wbString(ANAM, 'Track Filename'),
    wbString(BNAM, 'Finale Filename'),
    wbArray(FNAM, 'Cue Points', wbFloat('Point')),
    wbStruct(LNAM, 'Loop Data', [
      wbFloat('Loop Begins'),
      wbFloat('Loop Ends'),
      wbInteger('Loop Count', itU32)
    ]),
    wbCITC,
    wbCTDAs,
    wbArray(SNAM, 'Tracks', wbFormIDCk('Track', [MUST, NULL]))
  ]);

  wbRecord(DLVW, 'Dialog View', [
    wbEDIDReq,
    wbFormIDCk(QNAM, 'Quest', [QUST], True, cpNormal, True),
    wbRArray('Branches', wbFormIDCk(BNAM, 'Branch', [DLBR])),
    wbRArray('Array TNAM', wbRStruct('Unknown', [
      wbUnknown(TNAM)
    ], [])),
    wbUnknown(ENAM),
    wbUnknown(DNAM)
  ]);

  wbRecord(WOOP, 'WOOP', [
    wbEDIDReq,
    wbFULL,
    wbUnknown(TNAM)
  ]);

  wbRecord(SHOU, 'SHOU', [
    wbEDIDReq,
    wbFULL,
    wbMDOB,
    wbDESC,
    wbRArray('Array SNAM', wbRStruct('Unknown', [
      wbUnknown(SNAM)
    ], []))
  ]);

  wbRecord(EQUP, 'EQUP', [
    wbEDIDReq,
    wbArray(PNAM, 'Slot Parents', wbFormID('Can Be Equipped'), 0, nil, nil, cpNormal, False),
    wbInteger(DATA, 'Flags', itU32, wbFlags([
      'Use All Parents'
    ]), cpNormal, True)
  ]);

  wbRecord(RELA, 'RELA', [
    wbEDIDReq,
    wbUnknown(DATA)
  ]);

  wbRecord(SCEN, 'SCEN', [
    wbEDIDReq,
    wbVMAD,
    wbUnknown(FNAM),

    {-- 1st Block --}
    // Start array HNAM NAM0
    wbRArray('Array Start',
      wbRStruct('The Array', [
        wbEmpty(HNAM, 'HNAM Marker - Start'),
        wbUnknown(NAM0),
        wbEmpty(NEXT, 'NEXT Marker'),
        // CTDA before or after next
        wbRStruct('CTDA Only', [
          wbCTDAs
        ], []),
        wbRStruct('NEXT CTDA', [
          wbEmpty(NEXT, 'NEXT Marker'),
          wbCTDAs
        ], []),
        // SCHR SCDA SCTX QNAM before or after next
        wbRStruct('SCHR SCDA SCTX QNAM SCRO Before NEXT', [
          wbUnknown(SCHR),
          wbUnknown(SCDA),
          wbUnknown(SCTX),
          wbUnknown(QNAM),
          wbSCROs
        ], []),
        wbRStruct('NEXT SCHR SCDA SCTX QNAM SCRO', [
          wbEmpty(NEXT, 'NEXT Marker'),
          wbUnknown(SCHR),
          wbUnknown(SCDA),
          wbUnknown(SCTX),
          wbUnknown(QNAM),
          wbSCROs
        ], []),
        wbRStruct('WNAM', [
          wbUnknown(WNAM)
        ], []),
      wbEmpty(HNAM, 'HNAM Marker - End')
      ], []) // <-- End Array Struct
    ), // <-- End Array

    {-- 2nd Block --}
      wbRArray('Array ALID, LNAM, DNAM No Ending marker', wbRStruct('ALID Start', [
        wbUnknown(ALID),
        wbUnknown(LNAM),
        wbUnknown(DNAM)
      ], [])),

    {-- 3rd Block --}
      wbRArray('Array ANAM NAM0 followed by ALID INAM SNAM ENAM PNAM Ending in ANAM', wbRStruct('Unknown', [
        wbUnknown(ANAM),
        wbUnknown(NAM0),
        wbUnknown(ALID),
        wbUnknown(LNAM),
        wbUnknown(INAM),
        wbUnknown(FNAM),
        wbRArray('Array SNAM, ENAM', wbRStruct('Unknown', [
          wbUnknown(SNAM),
          wbUnknown(ENAM)
        ], [])),
        wbRStruct('SCHR QNAM Only After the SNAM before PNAM and Final ANAM', [
         wbUnknown(SCHR),
         wbUnknown(QNAM)
        ], []),
        wbRArray('Array PNAM followed by DATA - DEVA', wbRStruct('Unknown', [
          wbUnknown(PNAM)
        ], [])),
        wbUnknown(DATA),
        wbUnknown(HTID),
        wbUnknown(DMAX),
        wbUnknown(DMIN),
        wbUnknown(DEMO),
        wbUnknown(DEVA),
        wbByteArray(ANAM, 'ANAM End Marker')
      ], [])),
    wbRStruct('Final SCHR SCTX QNAM Only', [
      wbUnknown(SCHR),
      wbUnknown(SCDA),
      wbUnknown(SCTX),
      wbUnknown(QNAM),
      wbSCROs
    ], []),
    wbRStruct('Final NEXT SCHR SCTX QNAM', [
      wbEmpty(NEXT, 'NEXT Marker'),
        wbUnknown(SCHR),
        wbUnknown(SCDA),
        wbUnknown(SCTX),
        wbUnknown(QNAM),
        wbSCROs
    ], []),
    wbUnknown(PNAM),
    wbUnknown(INAM),
    wbUnknown(VNAM),
    wbCTDAs
  ]);

  wbRecord(ASTP, 'Relationships', [
    wbEDIDReq,
    wbString(MPRT, 'Male Parent Title'),
    wbString(FPRT, 'Female Parent Title'),
    wbString(MCHT, 'Male Child Title'),
    wbString(FCHT, 'Female Child Title'),
    wbInteger(DATA, 'Flags', itU32, wbFlags([
      'Related'
    ]))
  ]);
end;

procedure DefineTES5k;
begin
  wbRecord(OTFT, 'Outfit', [
    wbEDIDReq,
    wbArrayS(INAM, 'Items', wbFormIDCk('Item', [ARMO]))
  ]);

  wbRecord(ARTO, 'Art object', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODL,
    wbInteger(DNAM, 'Art Type', itU32, wbEnum([
      'Magic Casting',
      'Magic Hit Effect',
      'Enchantment Effect'
    ]))
  ]);

  wbRecord(MATO, 'Material Object', [
    wbEDIDReq,
    wbMODL,
    wbRArray('Property Data',
      wbByteArray(DNAM, 'Data', 0, cpIgnore, False, False, wbNeverShow)
    ),
    wbStruct(DATA, 'Directional Material Data', [
      wbFloat('Falloff Scale'),
      wbFloat('Falloff Bias'),
      wbFloat('Noise UV Scale'),
      wbFloat('Material UV Scale'),
      wbStruct('Projection Vector', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]),
      wbFloat('Normal Dampener'),
      wbStruct('Single Pass Color', [
        wbFloat('Red', cpNormal, True, 255, 0),
        wbFloat('Green', cpNormal, True, 255, 0),
        wbFloat('Blue', cpNormal, True, 255, 0)
      ]),
      wbInteger('Flags', itU32, wbFlags(['Single Pass']))
    ], cpNormal, True, nil, 5)
  ]);

  wbRecord(MOVT, 'MOVT', [
    wbEDIDReq,
    wbString(MNAM, 'Name'),
    wbStruct(SPED, 'Default Data', [
      wbFloat('Left Walk'),
      wbFloat('Left Run'),
      wbFloat('Right Walk'),
      wbFloat('Right Run'),
      wbFloat('Forward Walk'),
      wbFloat('Forward Run'),
      wbFloat('Back Walk'),
      wbFloat('Back Run'),
      wbFloat('Rotate in Place Walk', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
      wbFloat('Rotate in Place Run', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
      wbFloat('Rotate while Moving Run', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
    ], cpNormal, True, nil, 10),
    wbStruct(INAM, 'Anim Change Thresholds', [
      wbFloat('Directional', cpNormal, True, 57.296),
      wbFloat('Movement Speed'),
      wbFloat('Rotation Speed', cpNormal, True, 57.296)
    ])
  ]);

  wbRecord(SNDR, 'SNDR', [
    wbEDIDReq,
    wbUnknown(CNAM),
    wbFormID(GNAM, 'Category'),
    wbFormIDCk(SNAM, 'String', [SNDR, NULL]),
    wbRArray('Sounds',
      wbRStruct('Sound Files', [
        wbString(ANAM, 'File Name')
      ],[])
    ),
    wbFormIDCk(ONAM, 'Output Model', [SOPM, NULL]),
    wbLString(FNAM, 'String'),
    wbCTDAs,
    wbStruct(LNAM, 'Values', [
      wbByteArray('Unknown', 1),
//      wbByteArray('Looping', 1),
      wbInteger('Looping', itU8, wbEnum([], [
        $00 , 'None',
        $08 , 'Loop',
        $10 , 'Envelope Fast',
        $20 , 'Envelope Slow'
      ])),
      wbByteArray('Unknown', 1),
      wbInteger('Rumble Send Value = (Small / 7) + ((Big / 7) * 16)', itU8)
    ]),
    wbStruct(BNAM, 'Values', [
      wbInteger('% Frequency Shift', itU8),
      wbInteger('% Frequency Variance', itU8),
      wbInteger('Priority', itU8),
      wbInteger('db Variance', itU8),
      wbInteger('Static Attentuation (db)', itU16, wbdiv(100))
    ])
  ]);

  wbRecord(DUAL, 'DUAL', [
    wbEDIDReq,
    wbOBNDReq,
    wbStruct(DATA, 'Data', [
      wbFormIDCk('Projectile', [PROJ, NULL]),
      wbFormIDCk('Explosion', [EXPL, NULL]),
      wbFormIDCk('Effect Shader', [EFSH, NULL]),
      wbFormIDCk('Hit Effect Art', [ARTO, NULL]),
      wbFormIDCk('Impact Data Set', [IPDS, NULL]),
      wbInteger('Inherit Scale', itU32, wbFlags([
        'Hit Effect Art',
        'Projectile',
        'Explosion'
      ]))
    ], cpNormal, True)
  ]);

  wbRecord(SNCT, 'SNCT', [
    wbEDIDReq,
    wbFULL,
    wbUnknown(FNAM),
//    wbStruct(FNAM, 'Data', [
//    wbInteger('Flags', itU32, wbFlags([
//    {0x00000001}'Unknown 1',
//    {0x00000002}'Unknown 2',
//    {0x00000004}'Unknown 3',
//    {0x00000008}'Unknown 4',
//    {0x00000010}'Unknown 5',
//    {0x00000020}'Unknown 6',
//    {0x00000040}'Unknown 7',
//    {0x00000080}'Unknown 8',
//    {0x00000100}'Unknown 9',
//    {0x00000200}'Unknown 10',
//    {0x00000400}'Unknown 11',
//    {0x00000800}'Unknown 12',
//    {0x00001000}'Unknown 13',
//    {0x00002000}'Unknown 14',
//    {0x00004000}'Unknown 15',
//    {0x00008000}'Unknown 16',
//    {0x00010000}'Unknown 17',
//    {0x00020000}'Unknown 18',
//    {0x00040000}'Unknown 19',
//    {0x00080000}'Unknown 20',
//    {0x00100000}'Unknown 21',
//    {0x00200000}'Unknown 22',
//    {0x00400000}'Unknown 23',
//    {0x00800000}'Unknown 24',
//    {0x01000000}'Unknown 25',
//    {0x02000000}'Unknown 26',
//    {0x03000000}'Unknown 27',
//    {0x08000000}'Unknown 28',
//    {0x10000000}'Unknown 29',
//    {0x20000000}'Unknown 30',
//    {0x40000000}'Unknown 31',
//    {0x80000000}'Unknown 32'
//    ]))
//    ], cpNormal, True),
    wbFormIDCk(PNAM, 'String', [SNCT, NULL]),
    wbUnknown(VNAM),
    wbUnknown(UNAM)
  ]);

//----------------------------------------------------------------------------
// wbONAM Made for SOPM
//
//----------------------------------------------------------------------------
  wbSOPM_ONAM := wbRStruct('An ONAM Field in SOPM', [
    wbStruct(ONAM,'Some Values', [
        wbInteger('Value 1', itS16),
        wbInteger('Value 2', itS16),
        wbInteger('Value 3', itS16),
        wbInteger('Value 4', itS16),
        wbInteger('Value 5', itS16),
        wbInteger('Value 6', itS16),
        wbInteger('Value 7', itS16),
        wbInteger('Value 8', itS16),
        wbInteger('Value 9', itS16),
        wbInteger('Value 10', itS16),
        wbInteger('Value 11', itS16),
        wbInteger('Value 12', itS16)
      ])
  ], []);

  wbRecord(SOPM, 'SOPM', [
    wbEDIDReq,
    wbUnknown(NAM1),
    wbUnknown(FNAM),
    wbUnknown(MNAM),
    wbUnknown(CNAM),
    wbSOPM_ONAM,
    wbStruct(SNAM,'Some SNAM Values', [
        wbInteger('Value 1', itS16),
        wbInteger('Value 2', itS16),
        wbInteger('Value 3', itS16),
        wbInteger('Value 4', itS16),
        wbInteger('Value 5', itS16),
        wbInteger('Value 6', itS16),
        wbInteger('Value 7', itS16),
        wbInteger('Value 8', itS16)
      ]),
    wbStruct(ANAM,'Some ANAM Values', [
        wbInteger('Value 1', itS16),
        wbInteger('Value 2', itS16),
        wbInteger('Value 3', itS16),
        wbInteger('Value 4', itS16),
        wbInteger('Value 5', itS16),
        wbInteger('Value 6', itS16),
        wbInteger('Value 7', itS16),
        wbInteger('Value 8', itS16),
        wbInteger('Value 9', itS16),
        wbInteger('Value 10', itS16)
      ])
  ]);

  wbRecord(COLL, 'Collision Layer', [
    wbEDIDReq,
    wbDESCReq,
    wbInteger(BNAM, 'ID?', itU32, nil, cpNormal, True),
    wbStruct(FNAM, 'Debug Color', [
      wbInteger('Red', itU8),
      wbInteger('Green', itU8),
      wbInteger('Blue', itU8),
      wbInteger('Unused', itU8)
    ], cpNormal, True),
    wbInteger(GNAM, 'Flags', itU32, wbFlags([
      {0x00000001} 'Trigger Volume',
      {0x00000002} 'Sensor',
      {0x00000004} 'Navmesh Obstacle'
    ]), cpNormal, True),
    wbString(MNAM, 'Name', 0, cpNormal, True),
    wbInteger(INTV, 'Interactables Count', itU32, nil, cpNormal, True),
    wbArrayS(CNAM, 'Collides With', wbFormIDCk('Forms', [COLL]), 0, cpNormal, False)
  ]);

  wbRecord(CLFM, 'Color', [
    wbEDIDReq,
    wbFULL,
    wbCNAMReq,
    wbInteger(FNAM, 'Playable', itU32, wbEnum(['False', 'True']), cpNormal, True)
  ]);
end;

procedure DefineTES5l;
begin
  wbRecord(REVB, 'Reverb Parameters', [
    wbEDIDReq,
    wbStruct(DATA, 'Data', [
      wbInteger('Decay Time (ms)', itU16),
      wbInteger('HF Reference (Hz)', itU16),
      wbInteger('Room Filter', itS8),
      wbInteger('Room HF Filter', itS8),
      wbInteger('Reflections', itS8),
      wbInteger('Reverb Amp', itS8),
      wbInteger('Decay HF Ratio', itU8, wbDiv(100)),
      wbInteger('Reflect Delay (ms), scaled', itU8),
      wbInteger('Reverb Delay (ms)', itU8),
      wbInteger('Diffusion %', itU8),
      wbInteger('Density %', itU8),
      wbInteger('Unknown', itU8)
    ], cpNormal, True)
  ]);

  wbRecord(GRAS, 'Grass', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODLReq,
    wbStruct(DATA, '', [
      wbInteger('Density', itU8),
      wbInteger('Min Slope', itU8),
      wbInteger('Max Slope', itU8),
      wbByteArray('Unknown', 1),
      wbInteger('Units From Water', itU16),
      wbByteArray('Unknown', 2),
      wbInteger('Units From Water Type', itU32, wbEnum([
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
      wbByteArray('Unknown', 3)
    ], cpNormal, True)
  ]);

//------------------------------------------------------------------------------
// HAIR is a HDPT in Skyrim
//------------------------------------------------------------------------------
  wbRecord(HAIR, 'Hair', [
    wbEDIDReq
//    wbFULLReq,
//    wbMODLReq,
//    wbString(ICON, 'Texture', 0, cpNormal, True),
//    wbInteger(DATA, 'Flags', itU8, wbFlags([
//      'Playable',
//      'Not Male',
//      'Not Female',
//      'Fixed'
//    ]), cpNormal, True)
  ]);

//------------------------------------------------------------------------------
// Start Old Hair
//------------------------------------------------------------------------------
//  wbRecord(HAIR, 'Hair', [
//    wbEDIDReq,
//    wbFULLReq,
//    wbMODLReq,
//    wbString(ICON, 'Texture', 0, cpNormal, True),
//    wbInteger(DATA, 'Flags', itU8, wbFlags([
//      'Playable',
//      'Not Male',
//      'Not Female',
//      'Fixed'
//    ]), cpNormal, True)
//  ]);
//------------------------------------------------------------------------------
// End Old Hair
//------------------------------------------------------------------------------

  wbRecord(IDLE, 'Idle Animation', [
    wbEDID,
    wbCTDAs,
    wbString(DNAM, 'Filename'),
    wbString(ENAM, 'Animation Event'),
    wbArray(ANAM, 'Related Idle Animations', wbFormIDCk('Related Idle Animation', [AACT, IDLE, NULL]), ['Parent', 'Previous Sibling'], cpNormal, True),
    wbStruct(DATA, 'Unused Data', [
      wbStruct('Looping seconds (both 255 forever)', [
        wbInteger('Min', itU8),
        wbInteger('Max', itU8)
      ]),
      wbInteger('Flags', itU8, wbFlags([
        {0x01} 'Parent',
        {0x02} 'Sequence',
        {0x04} 'No Attacking',
        {0x04} 'Blocking'
      ], True)),
      wbInteger('Animation Group Section', itU8, wbIdleAnam),
      wbInteger('Replay Delay', itU16)
    ], cpIgnore, True)
  ]);

  wbRecord(INFO, 'Dialog response', [
    wbEDIDReq,
    wbVMAD,
    wbUnknown(DATA),
    wbStruct(ENAM, 'Response flags', [
      wbInteger('Flags', itU16, wbFlags([
        {0x0001} 'Goodbye',
        {0x0002} 'Random',
        {0x0004} 'Say once',
        {0x0008} 'Unknown 4',
        {0x0010} 'Unknown 5',
        {0x0020} 'Random end',
        {0x0040} 'Invisible continue',
        {0x0080} 'Walk Away',
        {0x0100} 'Walk Away Invisible in Menu',
        {0x0200} 'Force subtitle',
        {0x0400} 'Can move while greeting',
        {0x0800} 'No LIP File',
        {0x1000} 'Requires post-processing',
        {0x2000} 'Audio Output Override',
        {0x4000} 'Spends favor points',
        {0x8000} 'Unknown 16'
      ])),
      wbInteger('Reset Hours', itU16, wbDiv(2730))
    ]),
    wbFormIDCk(PNAM, 'Previous INFO', [INFO, NULL]),
    wbInteger(CNAM, 'Favor Level', itU8, wbEnum([
      'None',
      'Small',
      'Medium',
      'Large'
    ])),

    wbRArray('Link To', wbFormIDCk(TCLT, 'Response', [DIAL, INFO, NULL])),
    wbFormID(DNAM, 'Response Data'),
    wbCTDAs,

    wbRArray('Responses', wbRStruct('Response', [ // Begin Array
      wbStruct(TRDT, 'Response Data', [
        wbInteger('Emotion Type', itU32, wbEnum([
          {0} 'Neutral',
          {1} 'Anger',
          {2} 'Disgust',
          {3} 'Fear',
          {4} 'Sad',
          {5} 'Happy',
          {6} 'Surprise',
          {7} 'Puzzled'
        ])),
        wbInteger('Emotion Value', itU32),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbFormIDCk('Sound', [SNDR, NULL]),
        wbInteger('Flags', itU8, wbFlags([
          'Use Emotion Animation'
        ])),
        wbByteArray('Unknown', 3)
      ]),
      wbLString(NAM1, 'Response Text', 0),
      wbString(NAM2, 'Script Notes', 0),
      wbString(NAM3, 'Edits', 0),
      wbFormIDCk(SNAM, 'Idle Animations: Speaker', [IDLE]),
      wbCTDAs,
      wbFormIDCk(LNAM, 'Idle Animations: Listener', [IDLE])
    ], [])), // End Array

//    wbRStruct('Unknown', [
//      wbUnknown(SCHR),
//      wbFormID(QNAM, 'Unknown')
//    ], []),
    wbRArray('Unknown',
      wbRStruct('Unknown', [
        wbUnknown(SCHR),
        wbFormID(QNAM, 'Unknown'),
        wbEmpty(NEXT, 'Marker')
      ], [])
    ),

    wbLString(RNAM, 'Prompt'),
    wbFormIDCk(ANAM, 'Speaker', [NPC_]),
    wbFormIDCk(TWAT, 'Walk Away Topic', [DIAL]),
    wbFormIDCk(ONAM, 'Audio Output Override', [SNDR])
  ], False, nil{wbINFOAddInfo}, cpNormal, False, nil{wbINFOAfterLoad});

  wbRecord(INGR, 'Ingredient', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbKeywords,
    wbMODL,
    wbICON,
    wbETYPReq,
    wbSounds,
    wbStruct(DATA, '', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True),
    wbStruct(ENIT, 'Effect Data', [
      wbInteger('Ingredient Value', itS32),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'No auto-calculation',
        {0x00000002} 'Food item',
        {0x00000004} 'Unknown 3',
        {0x00000008} 'Unknown 4',
        {0x00000010} 'Unknown 5',
        {0x00000020} 'Unknown 6',
        {0x00000040} 'Unknown 7',
        {0x00000080} 'Unknown 8',
        {0x00000100} 'References Persist'
      ]))
    ], cpNormal, True),
    wbEffectsReq
  ]);

  wbRecord(KEYM, 'Key', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULLReq,
    wbMODL,
    wbICON,
    wbDEST,
    wbSounds,
    wbKeywords,
    wbStruct(DATA, '', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True)
  ]);

  wbQuadrantEnum := wbEnum([
    {0} 'Bottom Left',
    {1} 'Bottom Right',
    {2} 'Top Left',
    {3} 'Top Right'
  ]);

  if wbSimpleLAND then begin

    wbRecord(LAND, 'Landscape', [
      wbByteArray(DATA, 'Unknown'),
      wbByteArray(VNML, 'Vertex Normals'),
      wbByteArray(VHGT, 'Vertext Height Map'),
      wbByteArray(VCLR, 'Vertex Colours'),

      wbRArrayS('Layers', wbRUnion('Layer', [
        wbRStructSK([0],'Base Layer', [
          wbStructSK(BTXT, [1, 3], 'Base Layer Header', [
            wbFormIDCk('Texture', [LTEX, NULL]),
            wbInteger('Quadrant', itU8, wbQuadrantEnum),
            wbByteArray('Unknown', 1),
            wbInteger('Layer', itS16)
          ])
        ], []),
        wbRStructSK([0],'Alpha Layer', [
          wbStructSK(ATXT, [1, 3], 'Alpha Layer Header', [
            wbFormIDCk('Texture', [LTEX, NULL]),
            wbInteger('Quadrant', itU8, wbQuadrantEnum),
            wbByteArray('Unknown', 1),
            wbInteger('Layer', itS16)
          ]),
          wbByteArray(VTXT, 'Alpha Layer Data')
        ], [])
      ], [])),

      wbArray(VTEX, 'Textures', wbFormIDCk('Texture', [LTEX, NULL]))
    ]);

  end else begin

    wbRecord(LAND, 'Landscape', [
      wbByteArray(DATA, 'Unknown'),
      wbArray(VNML, 'Vertex Normals', wbStruct('Row', [
        wbArray('Columns', wbStruct('Column', [
          wbInteger('X', itU8),
          wbInteger('Y', itU8),
          wbInteger('Z', itU8)
        ]), 33)
      ]), 33),
      wbStruct(VHGT, 'Vertext Height Map', [
        wbFloat('Offset'),
        wbArray('Rows', wbStruct('Row', [
          wbArray('Columns', wbInteger('Column', itU8), 33)
        ]), 33),
        wbByteArray('Unknown', 3)
      ]),
      wbArray(VCLR, 'Vertex Colours', wbStruct('Row', [
        wbArray('Columns', wbStruct('Column', [
          wbInteger('X', itU8),
          wbInteger('Y', itU8),
          wbInteger('Z', itU8)
        ]), 33)
      ]), 33),

      wbRArrayS('Layers', wbRUnion('Layer', [
        wbRStructSK([0],'Base Layer', [
          wbStructSK(BTXT, [1, 3], 'Base Layer Header', [
            wbFormIDCk('Texture', [LTEX, NULL]),
            wbInteger('Quadrant', itU8, wbQuadrantEnum),
            wbByteArray('Unknown', 1),
            wbInteger('Layer', itS16)
          ])
        ], []),
        wbRStructSK([0],'Alpha Layer', [
          wbStructSK(ATXT, [1, 3], 'Alpha Layer Header', [
            wbFormIDCk('Texture', [LTEX, NULL]),
            wbInteger('Quadrant', itU8, wbQuadrantEnum),
            wbByteArray('Unknown', 1),
            wbInteger('Layer', itS16)
          ]),
          wbArrayS(VTXT, 'Alpha Layer Data', wbStructSK([0], 'Cell', [
            wbInteger('Position', itU16, wbAtxtPosition),
            wbByteArray('Unknown', 2),
            wbFloat('Opacity')
          ]))
        ], [])
      ], [])),

      wbArray(VTEX, 'Textures', wbFormIDCk('Texture', [LTEX, NULL]))
    ]);

  end;

  wbRecord(LIGH, 'Light', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbMODL,
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
        wbInteger('Unknown', itU8)
      ]),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Dynamic',
        {0x00000002} 'Can be Carried',
        {0x00000004} 'Negative',
        {0x00000008} 'Flicker',
        {0x00000010} 'Unknown',
        {0x00000020} 'Off By Default',
        {0x00000040} 'Flicker Slow',
        {0x00000080} 'Pulse',
        {0x00000100} 'Pulse Slow',
        {0x00000200} 'Spot Light',
        {0x00000400} 'Shadow Spotlight',
        {0x00000800} 'Shadow Hemisphere',
        {0x00001000} 'Shadow Omnidirectional',
        {0x00002000} 'Portal-strict'
      ])),
      wbFloat('Falloff Exponent'),
      wbFloat('FOV'),
      wbFloat('Near Clip'),
      wbStruct('Flicker Effect', [
        wbFloat('Period', cpNormal, False, 0.01),
        wbFloat('Intensity Amplitude'),
        wbFloat('Movement Amplitude')
      ]),
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ], cpNormal, True),
    wbFloat(FNAM, 'Fade value', cpNormal, True),
    wbFormIDCk(SNAM, 'Sound', [SNDR])
  ], False, nil, cpNormal, False, wbLIGHAfterLoad);
end;

procedure DefineTES5m;
begin
  wbRecord(LSCR, 'Load Screen', [
    wbEDIDReq,
    wbICONReq,
    wbDESCReq,
    wbCTDAs,
    wbFormIDCk(NNAM, 'Loading Screen NIF', [STAT, NULL], False, cpNormal, True),
    wbFloat(SNAM, 'Initial Scale'),
    wbStruct(RNAM, 'Initial Rotation', [
      wbInteger('X', itS16),
      wbInteger('Y', itS16),
      wbInteger('Z', itS16)
    ]),
    wbStruct(ONAM, 'Rotation Offset Constraints', [
      wbInteger('Min', itS16),
      wbInteger('Max', itS16)
    ]),
    wbStruct(XNAM, 'Initial Translation Offset', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ]),
    wbString(MOD2, 'Camera Path', 0, cpNormal, True),
    wbFormIDCk(WMI1, 'Load Screen Type', [LSCT], False, cpNormal, True)
  ]);

  wbRecord(LTEX, 'Landscape Texture', [
    wbEDIDReq,
    wbFormIDCk(TNAM, 'Texture Set', [TXST], False, cpNormal, True),
    wbFormIDCk(MNAM, 'Material Type', [MATT, NULL], False, cpNormal, True),
    wbStruct(HNAM, 'Havok Data', [
      wbInteger('Friction', itU8),
      wbInteger('Restitution', itU8)
    ], cpNormal, True),
    wbInteger(SNAM, 'Texture Specular Exponent', itU8, nil, cpNormal, True),
    wbRArrayS('Grasses', wbFormIDCk(GNAM, 'Grass', [GRAS]))
  ]);

  wbRecord(LVLN, 'Leveled NPC', [
    wbEDIDReq,
    wbOBNDReq,
    wbLVLD,
    wbInteger(LVLF, 'Flags', itU8, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count'
    ]), cpNormal, True),
    wbLLCT,
    wbRArrayS('Leveled List Entries',
      wbRStructExSK([0], [1], 'Leveled List Entry', [
        wbStructExSK(LVLO , [0, 2], [3], 'Base Data', [
          wbInteger('Level', itS16),
          wbByteArray('Unknown', 2),
          wbFormIDCk('Reference', [NPC_, LVLN]),
          wbInteger('Count', itS16),
          wbByteArray('Unknown', 2)
        ]),
				wbCOED
      ], []),
    cpNormal, True),
    wbMODL
  ]);

  wbRecord(LVLI, 'Leveled Item', [
    wbEDIDReq,
    wbOBNDReq,
    wbLVLD,
    wbInteger(LVLF, 'Flags', itU8, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count',
      {0x04} 'Use All',
      {0x08} 'Special Loot'
    ]), cpNormal, True),
    wbFormIDCk(LVLG, 'Global', [GLOB]),
    wbLLCT,
    wbRArrayS('Leveled List Entries',
      wbRStructExSK([0], [1], 'Leveled List Entry', [
        wbStructExSK(LVLO , [0, 2], [3], 'Base Data', [
          wbInteger('Level', itS16),
          wbByteArray('Unknown', 2),
          wbFormIDCk('Reference', [ARMO, AMMO, APPA, MISC, WEAP, BOOK, LVLI, KEYM, ALCH, LIGH]),
          wbInteger('Count', itS16),
          wbByteArray('Unknown', 2)
        ]),
        wbCOED
      ], [])
    )
  ]);

   wbRecord(LVSP, 'Leveled Spell', [
    wbEDIDReq,
    wbOBNDReq,
    wbLVLD,
    wbInteger(LVLF, 'Flags', itU8, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count'
    ]), cpNormal, True),
    wbLLCT,
    wbRArrayS('Leveled List Entries',
      wbRStructSK([0], 'Leveled List Entry', [
        wbStructExSK(LVLO , [0, 2], [3], 'Base Data', [
        wbInteger('Level', itS16),
        wbByteArray('Unknown', 2),
        wbFormIDCk('Reference', [SPEL]),
        wbInteger('Count', itS16),
        wbByteArray('Unknown', 2)
      ])
      ], [])
    )
  ]);

  wbMGEFType := wbStruct('Effect Type', [
    {64} wbInteger('Archtype', itU32, wbEnum([
      {00} 'Value Modifier',
      {01} 'Script',
      {02} 'Dispel',
      {03} 'Cure Disease',
      {04} 'Absorb',
      {05} 'Dual Value Modifier',
      {06} 'Calm',
      {07} 'Demoralize',
      {08} 'Frenzy',
      {09} 'Disarm',
      {10} 'Command Summoned',
      {11} 'Invisibility',
      {12} 'Light',
      {13} 'Unknown 13',
      {14} 'Unknown 14',
      {15} 'Lock',
      {16} 'Open',
      {17} 'Bound Weapon',
      {18} 'Summon Creature',
      {19} 'Detect Life',
      {20} 'Telekinesis',
      {21} 'Paralysis',
      {22} 'Reanimate',
      {23} 'Soul Trap',
      {24} 'Turn Undead',
      {25} 'Guide',
      {26} 'Werewolf Feed',
      {27} 'Cure Paralysis',
      {28} 'Cure Addiction',
      {29} 'Cure Poison',
      {30} 'Concussion',
      {31} 'Value and Parts',
      {32} 'Accumulate Magnitude',
      {33} 'Stagger',
      {34} 'Peak Value Modifier',
      {35} 'Cloak',
      {36} 'Werewolf',
      {37} 'Slow Time',
      {38} 'Rally',
      {39} 'Enhance Weapon',
      {40} 'Spawn Hazard',
      {41} 'Etherealize',
      {42} 'Banish',
      {43} 'Spawn Scripted Ref',
      {44} 'Disguise',
      {45} 'Grab Actor',
      {46} 'Vampire Lord'
    ]), cpNormal, False, nil{, wbMGEFArchtypeAfterSet})
  ]);

  wbMGEFData := wbRstruct('Magic Effect Data', [
    wbStruct(DATA, 'Data', [
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001}  'Hostile',
        {0x00000002}  'Recover',
        {0x00000004}  'Detrimental',
        {0x00000008}  'Snap to Navmesh',
        {0x00000010}  'No Hit Event',
				{0x00000020}  'Unknown 6',
				{0x00000040}  'Unknown 7',
				{0x00000080}  'Unknown 8',
				{0x00000100}  'Dispell with Keywords',
				{0x00000200}  'No Duration',
				{0x00000400}  'No Magnitude',
				{0x00000800}  'No Area',
				{0x00001000}  'FX Persist',
				{0x00002000}  'Unknown 14',
				{0x00004000}  'Gory Visuals',
				{0x00008000}  'Hide in UI',
				{0x00010000}  'Unknown 17',
				{0x00020000}  'No Recast',
				{0x00040000}  'Unknown 19',
				{0x00080000}  'Unknown 20',
				{0x00100000}  'Unknown 21',
				{0x00200000}  'Power Affects Magnitude',
				{0x00400000}  'Power Affects Duration',
				{0x00800000}  'Unknown 24',
				{0x01000000}  'Unknown 25',
				{0x02000000}  'Unknown 26',
				{0x04000000}  'Painless',
				{0x08000000}  'No Hit Effect',
				{0x10000000}  'No Death Dispel',
				{0x20000000}  'Unknown 30',
				{0x40000000}  'Unknown 31',
				{0x80000000}  'Unknown 32'
			])),
      wbFloat('Base Cost'),
      wbUnion('Assoc. Item', wbMGEFFAssocItemDecider, [
        wbFormID('Unknown', cpIgnore),
        wbFormIDCk('Assoc. Item', [LIGH, NULL]),
        wbFormIDCk('Assoc. Item', [WEAP, ARMO, NULL]),
        wbFormIDCk('Assoc. Item', [NPC_, NULL]),
        wbFormIDCk('Assoc. Item', [HAZD, NULL]),
        wbFormIDCk('Assoc. Item', [SPEL, NULL]),
        wbFormIDCk('Assoc. Item', [RACE, NULL]),
        wbFormIDCk('Assoc. Item', [ENCH, NULL]),
        wbFormIDCk('Assoc. Item', [KYWD, NULL])
      ]),
      wbInteger('Magic Skill', itS32, wbActorValueEnum),
      wbInteger('Resist Value', itS32, wbActorValueEnum),
      wbByteArray('Unknown', 4),
      wbFormIDCk('Casting Light', [LIGH, NULL]),
      wbFloat('Taper Weight'),
      wbFormIDCk('Hit Shader', [EFSH, NULL]),
      wbFormIDCk('Enchant Shader', [EFSH, NULL]),
      wbInteger('Minimum Skill Level', itU32),
      wbStruct('Spellmaking', [
        wbInteger('Area', itU32),
        wbFloat('Casting Time')
      ]),
      wbFloat('Taper Curve'),
      wbFloat('Taper Duration'),
      wbFloat('Second AV Weight'),
      wbMGEFType,
      wbActorValue,
      wbFormIDCk('Projectile', [PROJ, NULL]),
      wbFormIDCk('Explosion', [EXPL, NULL]),
      wbInteger('Casting Type', itU32, wbCastEnum),
      wbInteger('Delivery', itU32, wbTargetEnum),
      wbInteger('Second Actor Value', itS32, wbActorValueEnum),
      wbFormIDCk('Casting Art', [ARTO, NULL]),
      wbFormIDCk('Hit Effect Art', [ARTO, NULL]),
      wbFormIDCk('Impact Data', [IPDS, NULL]),
      wbFloat('Skill Usage Multiplier'),
      wbStruct('Dual Casting', [
        wbFormIDCk('Art', [DUAL, NULL]),
        wbFloat('Scale')
      ]),
      wbFormIDCk('Enchant Art', [ARTO, NULL]),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbFormIDCk('Equip Ability', [SPEL, NULL]),
      wbFormIDCk('Image Space Modifier', [IPDS, NULL]),
      wbFormIDCk('Perk to Apply', [PERK, NULL]),
      wbInteger('Casting Sound Level', itU32, wbSoundLevelEnum),
      wbStruct('Script Effect AI', [
        wbFloat('Score'),
        wbFloat('Delay Time')
      ])
    ], cpNormal, True)
  ], []);

  wbRecord(MGEF, 'Magic Effect', [
    wbEDIDReq,
    wbVMAD,
    wbFULL,
    wbMDOB,
    wbKeywords,
    wbMGEFData,
    wbRArrayS('Counter Effects', wbFormIDCk(ESCE, 'Effect', [MGEF])),
    wbArray(SNDD, 'Sounds', wbStruct('', [
      wbInteger('Type', itU32, wbEnum([
        'Sheathe/Draw',
        'Charge',
        'Ready',
        'Release',
        'Concentration Cast Loop',
        'On Hit'
      ])),
      wbFormIDCk('Sound', [SNDR])
    ])),
    wbLString(DNAM, 'Magic Item Description'),
    wbCTDAs
  ], False, nil, cpNormal, False, nil {wbMGEFAfterLoad});

  wbRecord(MISC, 'Misc. Item', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbDEST,
    wbSounds,
    wbKeywords,
    wbStruct(DATA, 'Data', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True)
  ]);

  wbRecord(APPA, 'Alchemical Apparatus', [
    wbEDID,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbDEST,
    wbSounds,
    wbInteger(QUAL, 'Quality', itS32, wbEnum([
      ], [
      0, 'Novice',
      1, 'Apprentice',
      2, 'Journeyman',
      3, 'Expert',
      4, 'Master'
    ])),
    wbDESC,
    wbStruct(DATA, 'Data', [
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ])
  ]);

  wbRecord(COBJ, 'Constructible Object', [
    wbEDIDReq,
    wbCOCT,
    wbCTDAs,
    wbFormID(CNAM, 'Created Object'),
    wbFormIDCk(BNAM, 'Workbench Keyword', [KYWD]),
    wbInteger(NAM1, 'Created Object Count', itU16)
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

//-----------------------------------------------------------------------------
//Start New NPC_
//-----------------------------------------------------------------------------
  wbRecord(NPC_, 'Non-Player Character', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbStruct(ACBS, 'Configuration', [
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Female',
        {0x00000002} 'Essential',
        {0x00000004} 'Is CharGen Face Preset',
        {0x00000008} 'Respawn',
        {0x00000010} 'Auto-calc stats',
        {0x00000020} 'Unique',
        {0x00000040} 'Doesn''t affect stealth meter',
        {0x00000080} 'PC Level Mult',
        {0x00000100} 'Use Template?',
        {0x00000200} '',
        {0x00000400} '',
        {0x00000800} 'Protected',
        {0x00001000} '',
        {0x00002000} '',
        {0x00004000} 'Summonable',
        {0x00008000} '',
        {0x00010000} 'Doesn''t bleed',
        {0x00020000} '',
        {0x00040000} 'Bleedout Override',
        {0x00080000} 'Opposite Gender Anims',
        {0x00100000} 'Simple Actor',
        {0x00200000} 'looped script?',
        {0x00400000} '',
        {0x00800000} '',
        {0x01000000} '',
        {0x02000000} '',
        {0x04000000} '',
        {0x08000000} '',
        {0x10000000} 'looped audio?',
        {0x20000000} 'Is Ghost',
        {0x40000000} '',
        {0x80000000} 'Invulnerable'
        ], [
        {0x00000001} nil,
        {0x00000002} nil,
        {0x00000004} nil,
        {0x00000008} nil,
        {0x00000010} nil,
        {0x00000020} nil,
        {0x00000040} nil,
        {0x00000080} nil,
        {0x00000100} nil,
        {0x00000200} nil,
        {0x00000400} nil,
        {0x00000800} nil,
        {0x00001000} nil,
        {0x00002000} nil,
        {0x00004000} nil,
        {0x00008000} nil,
        {0x00010000} nil,
        {0x00020000} nil,
        {0x00040000} nil,
        {0x00080000} nil,
        {0x00100000} nil,
        {0x00200000} nil,
        {0x00400000} nil,
        {0x00800000} nil,
        {0x01000000} nil,
        {0x02000000} nil,
        {0x04000000} nil,
        {0x08000000} nil,
        {0x10000000} nil,
        {0x20000000} nil,
        {0x40000000} nil,
        {0x80000000} nil
      ])),
      wbInteger('Magicka Offset', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
      wbInteger('Stamina Offset', itU16, nil, cpNormal, False, wbActorTemplateUseAIData),
      wbUnion('Level', wbCreaLevelDecider, [
        wbInteger('Level', itS16, nil, cpNormal, True, wbActorTemplateUseStats),
        wbInteger('Level Mult', itS16, wbDiv(1000), cpNormal, True, wbActorTemplateUseStats)
      ], cpNormal, True, wbActorTemplateUseStats),
      wbInteger('Calc min level', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
      wbInteger('Calc max level', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
      wbInteger('Speed Multiplier', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
      wbInteger('Disposition Base', itS16, nil, cpNormal, True, wbActorTemplateUseTraits),
      wbInteger('Template Flags', itU16, wbFlags([
        {0x0001} 'Use Traits',
        {0x0002} 'Use Stats',
        {0x0004} 'Use Factions',
        {0x0008} 'Use Spell List',
        {0x0010} 'Use AI Data',
        {0x0020} 'Use AI Packages',
        {0x0040} 'Use Model/Animation?',
        {0x0080} 'Use Base Data',
        {0x0100} 'Use Inventory',
        {0x0200} 'Use Script',
        {0x0400} 'Use Def Pack List',
        {0x1000} 'Use Keywords'
      ])),
      wbInteger('Health Offset', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
      wbInteger('Bleedout Override', itU16, nil, cpNormal, True, wbActorTemplateUseStats)
    ], cpNormal, True),
    wbRArrayS('Factions',
      wbStructSK(SNAM, [0], 'Faction', [
        wbFormIDCk('Faction', [FACT]),
        wbInteger('Rank', itU8),
        wbByteArray('Unknown', 3)
      ]), cpNormal, False, nil, nil, wbActorTemplateUseFactions
    ),
    wbFormIDCk(INAM, 'Death item', [LVLI], False, cpNormal, False, wbActorTemplateUseTraits),
    wbFormIDCk(VTCK, 'Voice', [VTYP], False, cpNormal, False, wbActorTemplateUseTraits),
    wbFormIDCk(TPLT, 'Template', [LVLN, NPC_]),
    wbFormIDCk(RNAM, 'Race', [RACE], False, cpNormal, True, wbActorTemplateUseTraits),
    wbDEST,
    wbSPCT,
    wbSPLOs,
    wbFormIDCk(WNAM, 'Worn Armor', [ARMO], False, cpNormal, False),
    wbFormIDCk(ANAM, 'Far away model', [ARMO], False, cpNormal, False, wbActorTemplateUseTraits),
    wbFormIDCk(ATKR, 'Attack Race', [RACE], False, cpNormal, False),
    wbRArray('Attacks', wbAttackData),
    wbFormIDCk(SPOR, 'Spectator override package list', [FLST], False, cpNormal, False),
    wbFormIDCk(ECOR, 'Combat override package list', [FLST], False, cpNormal, False),
    wbInteger(PRKZ, 'Perk Count', itU32),
    wbRArray('Perks', wbPRKR),
    wbFormIDCk(OCOR, 'Observe dead body override package list', [FLST], False, cpNormal, False),
    wbFormIDCk(GWOR, 'Guard warn override package list', [FLST], False, cpNormal, False),
    wbCOCTReq,
    wbAIDT,
    wbRArray('Packages', wbFormIDCk(PKID, 'Package', [PACK]), cpNormal, False, wbActorTemplateUseAIPackages),
    wbKeywords,
    wbFormIDCk(CNAM, 'Class', [CLAS], False, cpNormal, True),
    wbFULL,
    wbLString(SHRT, 'Short Name'),
    wbByteArray(DATA, 'Marker'),
    wbDNAMActor,
    wbRArrayS('Head Parts', wbFormIDCk(PNAM, 'Head Part', [HDPT]), cpNormal, False, nil, nil, wbActorTemplateUseModelAnimation),
    wbFormIDCk(HCLF, 'Hair Color', [CLFM], False, cpNormal, False),
    wbFormIDCk(ZNAM, 'Combat Style', [CSTY], False, cpNormal, False),
    wbFormIDCk(GNAM, 'Gift Filter', [FTST], False, cpNormal, False),
    wbUnknown(NAM5, cpNormal, True),
    wbFloat(NAM6, 'Height', cpNormal, True),
    wbFloat(NAM7, 'Weight', cpNormal, True),
    wbInteger(NAM8, 'Sound Level', itU32, wbEnum([], [1, 'Normal', 2, 'Silent', 3, 'Very Loud']), cpNormal, True),
    wbCSDTs,
    // When CSCR exists CSDT, CSDI, CSDC are not present
    wbFormIDCk(CSCR, 'Inherits Sounds From', [NPC_], False, cpNormal, False),
    wbFormIDCk(DOFT, 'Default outfit', [OTFT], False, cpNormal, False),
    wbFormIDCk(SOFT, 'Sleeping outfit', [OTFT], False, cpNormal, False),
    wbFormIDCk(DPLT, 'Default Package List', [FLST], False, cpNormal, False),
    wbFormIDCk(CRIF, 'Crime faction', [FACT], False, cpNormal, False),
    wbFormIDCk(FTST, 'Head texture', [TXST], False, cpNormal, False),
    wbStruct(QNAM, 'Texture lightning', [
      wbFloat('Red'),
      wbFloat('Green'),
      wbFloat('Blue')
    ]),
    wbStruct(NAM9, 'Face morph', [
      wbFloat('Nose Long/Short'),
      wbFloat('Nose Up/Down'),
      wbFloat('Jaw Up/Down'),
      wbFloat('Jaw Narrow/Wide'),
      wbFloat('Jaw Farward/Back'),
      wbFloat('Cheeks Up/Down'),
      wbFloat('Cheeks Farward/Back'),
      wbFloat('Eyes Up/Down'),
      wbFloat('Eyes In/Out'),
      wbFloat('Brows Up/Down'),
      wbFloat('Brows In/Out'),
      wbFloat('Brows Farward/Back'),
      wbFloat('Lips Up/Down'),
      wbFloat('Lips In/Out'),
      wbFloat('Chin Narrow/Wide'),
      wbFloat('Chin Up/Down'),
      wbFloat('Chin Underbite/Overbite'),
      wbFloat('Eyes Farward/Back'),
      wbFloat('Unknown')
    ], cpNormal, True),
    wbStruct(NAMA, 'Face parts', [
      wbInteger('Nose', itU32),
      wbInteger('Unknown', itS32),
      wbInteger('Eyes', itU32),
      wbInteger('Mouth', itU32)
    ]),
//-----------------------------------------------------------------------------
// Array of TINI, TINC, TINV, TIAS
//-----------------------------------------------------------------------------
    wbRArray('Tint Layers', wbRStruct('Layer', [
      wbInteger(TINI, 'Tint Index', itU16),
      wbStruct(TINC, 'Tint Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbInteger('Alpha', itU8)
      ]),
      wbInteger(TINV, 'Interpolation Value', itU32, wbDiv(100)),
      wbInteger(TIAS, 'Preset', itS16)
    ], []))
  ], False, nil, cpNormal, False, wbNPCAfterLoad);
//-----------------------------------------------------------------------------
//End New NPC_
//
//Start Old NPC_
//-----------------------------------------------------------------------------
//  wbRecord(NPC_, 'Non-Player Character', [
//    wbEDIDReq,
//    wbOBNDReq,
//    wbFULLActor,
//    wbMODLActor,
//    wbStruct(ACBS, 'Configuration', [
//      {00} wbInteger('Flags', itU32, wbFlags([
//             {0x000001} 'Female',
//             {0x000002} 'Essential',
//             {0x000004} 'Is CharGen Face Preset',
//             {0x000008} 'Respawn',
//             {0x000010} 'Auto-calc stats',
//             {0x000020} '',
//             {0x000040} '',
//             {0x000080} 'PC Level Mult',
//             {0x000100} 'Use Template',
//             {0x000200} 'No Low Level Processing',
//             {0x000400} '',
//             {0x000800} 'No Blood Spray',
//             {0x001000} 'No Blood Decal',
//             {0x002000} '',
//             {0x004000} '',
//             {0x008000} '',
//             {0x010000} '',
//             {0x020000} '',
//             {0x040000} '',
//             {0x080000} '',
//             {0x100000} 'No VATS Melee',
//           {0x00200000} '',
//           {0x00400000} 'Can be all races',
//           {0x00800000} 'Autocalc Service',
//           {0x01000000} '',
//           {0x02000000} '',
//           {0x03000000} 'No Knockdowns',
//           {0x08000000} 'Not Pushable',
//           {0x10000000} '', {28}
//           {0x20000000} '',
//           {0x40000000} 'No Rotating To Head-track',
//           {0x80000000} ''
//           ], [
//             {0x000001 Female} wbActorTemplateUseTraits,
//             {0x000002 Essential} wbActorTemplateUseBaseData,
//             {0x000004 Is CharGen Face Preset} nil,
//             {0x000008 Respawn} wbActorTemplateUseBaseData,
//             {0x000010 Auto-calc stats} wbActorTemplateUseStats,
//             {0x000020 } nil,
//             {0x000040 } nil,
//             {0x000080 PC Level Mult} wbActorTemplateUseStats,
//             {0x000100 Use Template} nil,
//             {0x000200 No Low Level Processing} wbActorTemplateUseBaseData,
//             {0x000400 } nil,
//             {0x000800 No Blood Spray} wbActorTemplateUseModelAnimation,
//             {0x001000 No Blood Decal} wbActorTemplateUseModelAnimation,
//             {0x002000 } nil,
//             {0x004000 } nil,
//             {0x008000 } nil,
//             {0x010000 } nil,
//             {0x020000 } nil,
//             {0x040000 } nil,
//             {0x080000 } nil,
//             {0x100000 No VATS Melee} nil,
//           {0x00200000 } nil,
//           {0x00400000 Can be all races} nil,
//           {0x00800000 } nil,
//           {0x01000000 } nil,
//           {0x02000000 } nil,
//           {0x03000000 No Knockdowns} nil,
//           {0x08000000 Not Pushable} wbActorTemplateUseModelAnimation,
//           {0x10000000 } nil,
//           {0x20000000 } nil,
//           {0x40000000 No Rotating To Head-track} wbActorTemplateUseModelAnimation,
//           {0x80000000 } nil
//           ])),
//      {04} wbInteger('Fatigue', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
//      {06} wbInteger('Barter gold', itU16, nil, cpNormal, False, wbActorTemplateUseAIData),
//      {08} wbUnion('Level', wbCreaLevelDecider, [
//             wbInteger('Level', itS16, nil, cpNormal, True, wbActorTemplateUseStats),
//             wbInteger('Level Mult', itS16, wbDiv(1000), cpNormal, True, wbActorTemplateUseStats)
//           ], cpNormal, True, wbActorTemplateUseStats),
//      {10} wbInteger('Calc min', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
//      {12} wbInteger('Calc max', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
//      {14} wbInteger('Speed Multiplier', itU16, nil, cpNormal, True, wbActorTemplateUseStats),
//      {16} wbFloat('Karma (Alignment)', cpNormal, False, 1, -1, wbActorTemplateUseTraits),
//      {20} wbInteger('Disposition Base', itS16, nil, cpNormal, False, wbActorTemplateUseTraits),
//      {22} wbInteger('Template Flags', itU16, wbFlags([
//        'Use Traits',
//        'Use Stats',
//        'Use Factions',
//        'Use Actor Effect List',
//        'Use AI Data',
//        'Use AI Packages',
//        'Use Model/Animation',
//        'Use Base Data',
//        'Use Inventory',
//        'Use Script'
//      ]))
//    ], cpNormal, True),
//    wbRArrayS('Factions',
//      wbStructSK(SNAM, [0], 'Faction', [
//        wbFormIDCk('Faction', [FACT]),
//        wbInteger('Rank', itU8),
//        wbByteArray('Unused', 3)
//      ]),
//    cpNormal, False, nil, nil, wbActorTemplateUseFactions),
//    wbFormIDCk(INAM, 'Death item', [LVLI], False, cpNormal, False, wbActorTemplateUseTraits),
//    wbFormIDCk(VTCK, 'Voice', [VTYP], False, cpNormal, True, wbActorTemplateUseTraits),
//    wbFormIDCk(TPLT, 'Template', [LVLN, NPC_]),
//    wbFormIDCk(RNAM, 'Race', [RACE], False, cpNormal, True, wbActorTemplateUseTraits),
//    wbSPLOs,
//    wbFormIDCk(EITM, 'Unarmed Attack Effect', [ENCH, SPEL], False, cpNormal, False, wbActorTemplateUseActorEffectList),
//    wbInteger(EAMT, 'Unarmed Attack Animation', itU16, wbAttackAnimationEnum, cpNormal, True, False, wbActorTemplateUseActorEffectList),
//    wbDESTActor,
//    wbSCRIActor,
//    wbRArrayS('Items', wbCNTO, cpNormal, False, nil, nil, wbActorTemplateUseInventory),
//    wbAIDT,
//    wbRArray('Packages', wbFormIDCk(PKID, 'Package', [PACK]), cpNormal, False, wbActorTemplateUseAIPackages),
//    wbFormIDCk(CNAM, 'Class', [CLAS], False, cpNormal, True, wbActorTemplateUseTraits),
//    wbStruct(DATA, '', [
//      {00} wbInteger('Base Health', itS32),
//      {04} wbArray('Attributes', wbInteger('Attribute', itU8), [
//            'Strength',
//            'Perception',
//            'Endurance',
//            'Charisma',
//            'Intelligence',
//            'Agility',
//            'Luck'
//          ], cpNormal, False, wbActorAutoCalcDontShow),
//          wbByteArray('Unused'{, 14 - only present in old record versions})
//    ], cpNormal, True, wbActorTemplateUseStats),
//    wbStruct(DNAM, '', [
//      {00} wbArray('Skill Values', wbInteger('Skill', itU8), [
//             'Barter',
//             'Big Guns (obsolete)',
//             'Energy Weapons',
//             'Explosives',
//             'Lockpick',
//             'Medicine',
//             'Melee Weapons',
//             'Repair',
//             'Science',
//             'Guns',
//             'Sneak',
//             'Speech',
//             'Survival',
//             'Unarmed'
//           ]),
//      {14} wbArray('Skill Offsets', wbInteger('Skill', itU8), [
//             'Barter',
//             'Big Guns (obsolete)',
//             'Energy Weapons',
//             'Explosives',
//             'Lockpick',
//             'Medicine',
//             'Melee Weapons',
//             'Repair',
//             'Science',
//             'Guns',
//             'Sneak',
//             'Speech',
//             'Survival',
//             'Unarmed'
//           ])
//    ], cpNormal, False, wbActorTemplateUseStatsAutoCalc),
//    wbRArrayS('Head Parts',
//      wbFormIDCk(PNAM, 'Head Part', [HDPT]),
//    cpNormal, False, nil, nil, wbActorTemplateUseModelAnimation),
//    wbFormIDCk(HNAM, 'Hair', [HAIR], False, cpNormal, False, wbActorTemplateUseModelAnimation),
//    wbFloat(LNAM, 'Hair length', cpNormal, False, 1, -1, wbActorTemplateUseModelAnimation),
//    wbFormIDCk(ENAM, 'Eyes', [EYES], False, cpNormal, False, wbActorTemplateUseModelAnimation),
//    wbStruct(HCLR, 'Hair color', [
//    wbInteger('Red', itU8),
//      wbInteger('Green', itU8),
//      wbInteger('Blue', itU8),
//      wbByteArray('Unused', 1)
//    ], cpNormal, True, wbActorTemplateUseModelAnimation),
//    wbFormIDCk(ZNAM, 'Combat Style', [CSTY], False, cpNormal, False, wbActorTemplateUseTraits),
//    wbInteger(NAM4, 'Impact Material Type', itU32, wbImpactMaterialTypeEnum, cpNormal, True, False, wbActorTemplateUseModelAnimation),
//    wbFaceGenNPC,
//    wbInteger(NAM5, 'Unknown', itU16, nil, cpNormal, True, False, nil, nil, 255),
//    wbFloat(NAM6, 'Height', cpNormal, True, 1, -1, wbActorTemplateUseTraits),
//    wbFloat(NAM7, 'Weight', cpNormal, True, 1, -1, wbActorTemplateUseTraits)
//  ], True, nil, cpNormal, False, wbNPCAfterLoad);
//-----------------------------------------------------------------------------
//End NPC_
//-----------------------------------------------------------------------------

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
//          '',
          'Actors: Any'
        ]);

  wbPKDTSpecificFlagsUnused := False;

  wbPKDTFlags := wbFlags([
    {0x00000001} 'Offers Services',
    {0x00000002} 'Unknown 2',
    {0x00000004} 'Must complete',
    {0x00000008} 'Maintain Speed at Goal',
    {0x00000010} 'Unknown 5',
    {0x00000020} 'Unknown 6',
    {0x00000040} 'Unlock doors at package start',
    {0x00000080} 'Unlock doors at package end',
    {0x00000100} 'Unknown 9',
    {0x00000200} 'Continue if PC Near',
    {0x00000400} 'Once per day',
    {0x00000800} 'Unknown 12',
    {0x00001000} 'Unknown 13',
    {0x00002000} 'Preferred Speed',
    {0x00004000} 'Unknown 15',
    {0x00008000} 'Unknown 16',
    {0x00010000} 'Unknown 17',
    {0x00020000} 'Always Sneak',
    {0x00040000} 'Allow Swimming',
    {0x00080000} 'Unknown 20',
    {0x00100000} 'Ignore Combat',
    {0x00200000} 'Weapons Unequipped',
    {0x00400000} 'Unknown 23',
    {0x00800000} 'Weapon Drawn',
    {0x01000000} 'Unknown 25',
    {0x02000000} 'Unknown 26',
    {0x04000000} 'Unknown 27',
    {0x08000000} 'No Combat Alert',
    {0x10000000} 'Unknown 29',
    {0x20000000} 'Wear Sleep Outfit (unused)',
    {0x40000000} 'Unknown 31',
    {0x80000000} 'Unknown 32'
  ]);

  wbPKDTInterruptFlags := wbFlags([
    {0x0001}'Hellos to player',
    {0x0002}'Random conversations',
    {0x0004}'Observe combat behavior',
    {0x0008}'Greet corpse behavior',
    {0x0010}'Reaction to player actions',
    {0x0020}'Friendly fire comments',
    {0x0040}'Aggro Radius Behavior',
    {0x0080}'Allow Idle Chatter',
    {0x0100}'Unknown 9',
    {0x0200}'World Interactions',
    {0x0400}'Unknown 11',
    {0x0800}'Unknown 12',
    {0x1000}'Unknown 13',
    {0x2000}'Unknown 14',
    {0x4000}'Unknown 15',
    {0x8000}'Unknown 16'
  ]);

  wbPKDT := wbStruct(PKDT, 'Pack Data', [
    wbInteger('General Flags', itU32, wbPKDTFlags),
    wbInteger('Type', itU8, wbEnum ([], [
      18, 'Package',
      19, 'Package Template'
    ])),
    wbInteger('Interrupt Override', itU8, wbEnum([
      'None',
      'Spectator',
      'ObserveDead',
      'GuardWarn',
      'Combat'
    ])),
    wbInteger('Preferred Speed', itU8, wbEnum([
      'Walk',
      'Jog',
      'Run',
      'Fast Walk'
    ])),
    wbByteArray('Unknown', 1),
    wbInteger('Interrupt Flags', itU16, wbPKDTInterruptFlags),
    wbByteArray('Unknown', 2)
  ], cpNormal, True);

  wbPSDT := wbStruct(PSDT, 'Schedule', [
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
    wbInteger('Hour', itS8),
    wbInteger('Minute', itS8),
    wbByteArray('Unknown', 3),
    wbInteger('Duration (minutes)', itS32)
  ], cpNormal, True);

  wbIDLF := wbRStruct('Idle Animations', [
    wbInteger(IDLF, 'Flags', itU8, wbEnum([], [
       8, 'Random',
       9, 'Run in Sequence',
      12, 'Random, Do Once',
      13, 'Run in Sequence, Do Once'
    ]), cpNormal, True),
    wbStruct(IDLC, '', [
      wbInteger( 'Animation Count', itU8),
      wbByteArray('Unknown', 3)
    ], cpNormal, True, nil, 1),
    wbFloat(IDLT, 'Idle Timer Setting', cpNormal, True),
    wbArray(IDLA, 'Animations', wbFormIDCk('Animation', [IDLE]), 0, nil, nil, cpNormal, True),
    wbByteArray(IDLB, 'Unknown', 4, cpIgnore)
  ], []);

  wbINAM := wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True);
end;

procedure DefineTES5n;
begin

  wbUNAMs:= wbRArray('Data Inputs', wbRStruct('Data Input', [
    wbInteger(UNAM, 'Index', itS8),
    wbString(BNAM, 'Name'),
    wbInteger(PNAM, 'Flags', itU32, wbFlags([
      'Public'
    ]))
  ], []));

  wbRecord(PACK, 'Package', [
    wbEDIDReq,
    wbVMAD,
    wbPKDT,
    wbPSDT,
    wbCTDAs,
    wbIDLF,
    wbFormIDCk(CNAM, 'Combat Style', [CSTY]),
    wbFormIDCk(QNAM, 'Owner Quest', [QUST]),
    wbStruct(PKCU, 'Counter', [
      wbInteger('Data Input Count', itU32),
      wbFormIDCk('Package Template', [PACK]),
      wbInteger('Version Counter (autoincremented)', itU32)
    ], cpNormal, True),
    wbRStruct('Package Data', [
      wbRArray('Data Input Values', wbRStruct('Value', [
        wbString(ANAM, 'Type'),
        wbUnion(CNAM, 'Value', wbPubPackCNAMDecider, [
          {0} wbByteArray('Unknown'),
          {1} wbInteger('Value', itU8, wbEnum(['False', 'True'])),
          {2} wbInteger('Value', itU32),
          {3} wbFloat('Value')
        ]),
        wbUnknown(BNAM),
        wbPDTOs,
        wbStruct(PLDT, 'Location', [wbLocationData]),
        wbStruct(PTDA, 'Target', [wbTargetData]),
        wbUnknown(TPIC)
      ], [], cpNormal, False)),
      wbUNAMs
    ], []),
    wbByteArray(XNAM, 'Marker'),
    wbRStruct('Procedure Tree', [
      wbRArray('Branches', wbRStruct('Branch', [
        wbString(ANAM, 'Branch Type'),
        wbInteger(CITC, 'Condition Count', itU32),
        wbCTDAs,
        wbStruct(PRCB, 'Root', [
          wbInteger('Branch Count', itU32),
          wbInteger('Flags', itU32, wbFlags([
            'Repeat when Complete'
          ]))
        ]),
        wbString(PNAM, 'Procedure Type'),
        wbInteger(FNAM, 'Flags', itU32, wbFlags(['Success Completes Package'])),
        wbRArray('Data Input Indexes', wbInteger(PKC2, 'Index', itU8)),
        {>>> PFO2 should be single, there is only 1 PACK [00095F46] <PatrolAndHunt> in Skyrim.esm with 2xPFO2 <<<}
        wbRArray('Flags Override',
          wbStruct(PFO2, 'Data', [
            wbInteger('Set General Flags', itU32, wbPKDTFlags),
            wbInteger('Clear General Flags', itU32, wbPKDTFlags),
            wbInteger('Set Interrupt Flags', itU16, wbPKDTInterruptFlags),
            wbInteger('Clear Interrupt Flags', itU16, wbPKDTInterruptFlags),
            wbInteger('Preferred Speed Override', itU8, wbEnum([
              'Walk',
              'Jog',
              'Run',
              'Fast Walk'
            ])),
            wbByteArray('Unknown', 3)
          ])
        ),
        wbRArray('Unknown', wbUnknown(PFOR))
      ], [], cpNormal, False))
    ], []),
    wbUNAMs,
    wbRStruct('OnBegin', [
      wbEmpty(POBA, 'OnBegin Marker', cpNormal, True),
      wbINAM,
      wbUnknown(SCHR),
      wbUnknown(SCTX),
      wbUnknown(QNAM),
      wbUnknown(TNAM),
      wbPDTOs
    ], []),
    wbRStruct('OnEnd', [
      wbEmpty(POEA, 'OnEnd Marker', cpNormal, True),
      wbINAM,
      wbUnknown(SCHR),
      wbUnknown(SCTX),
      wbUnknown(QNAM),
      wbUnknown(TNAM),
      wbPDTOs
    ], []),
    wbRStruct('OnChange', [
      wbEmpty(POCA, 'OnChange Marker', cpNormal, True),
      wbINAM,
      wbUnknown(SCHR),
      wbUnknown(SCDA),
      wbUnknown(SCTX),
      wbUnknown(QNAM),
      wbUnknown(TNAM),
      wbPDTOs
    ], [])
  ], False, nil, cpNormal, False, nil {wbPACKAfterLoad});

  wbRecord(QUST, 'Quest', [
    wbEDIDReq,
    wbVMAD,
    wbFULL,

    wbStruct(DNAM, 'Quest Data', [
      wbInteger('Flags', itU16, wbFlags([
        {0x0001} 'Start Game Enabled',
        {0x0002} 'Unknown 2',
        {0x0004} 'Unknown 3',
        {0x0008} 'Unknown 4',
        {0x0010} 'Allow repeated stages',
        {0x0020} 'Unknown 6',
        {0x0040} 'Unknown 7',
        {0x0080} 'Unknown 8',
        {0x0100} 'Run Once',
        {0x0200} 'Exclude from dialogue export',
        {0x0400} 'Warn on alias fill failure',
        {0x0800} 'Unknown 12'
      ])),
      wbInteger('Priority', itU8),
      wbByteArray('Unknown', 5),
      wbInteger('Type', itU32, wbEnum([
        {0} 'None',
        {1} 'Main Quest',
        {2} 'Mages'' Guild',
        {3} 'Thieves'' Guild',
        {4} 'Dark Brotherhood',
        {5} 'Companion Quests',
        {6} 'Miscellaneous',
        {7} 'Daedric',
        {8} 'Side Quest',
        {9} 'Civil War',
       {10} 'DLC01 - Vampire',
       {11} 'DLC02'
      ]))
    ]),

    wbString(ENAM, 'Event'),
    wbRArray('Text Display Globals', wbFormIDCk(QTGL, 'Global', [GLOB])),
    wbString(FLTR, 'Object Window Filter', 0, cpTranslate),
    wbRStruct('Quest Dialogue Conditions', [wbCTDAs], [], cpNormal, True),
    wbEmpty(NEXT, 'Marker'),
    wbCTDAs, // Unknown

    wbRArrayS('Stages', wbRStructSK([0], 'Stage', [
      wbStruct(INDX, 'Stage Index', [
        wbInteger('Stage Index', itU16),
        wbInteger('Flags', itU8, wbFlags([
          {0x01} 'Unknown 1',
          {0x02} 'Start Up Stage',
          {0x04} 'Shut Down Stage',
          {0x08} 'Keep Instance Data From Here On'
        ])),
        wbByteArray('Unknown', 1)
      ]),
      wbRArray('Log Entries', wbRStruct('Log Entry', [
        wbInteger(QSDT, 'Stage Flags', itU8, wbFlags([
          {0x01} 'Complete Quest',
          {0x02} 'Fail Quest'
        ])),
        wbCTDAs,
        wbLString(CNAM, 'Log Entry'),
        wbFormIDCk(NAM0, 'Next Quest', [QUST]),
        wbUnknown(SCHR),
        wbUnknown(SCTX),
        wbUnknown(QNAM)
      ], []))
    ], [])),

    wbRArray('Objectives', wbRStruct('Objective', [
      wbInteger(QOBJ, 'Objective Index', itU16),
      wbInteger(FNAM, 'Flags', itU32, wbFlags(['ORed With Previous'])),
      wbLString(NNAM, 'Display Text', 0, cpNormal, True),
      wbRArray('Targets', wbRStruct('Target', [
        wbStruct(QSTA, 'Target', [
          wbInteger('Alias', itU32),
          wbInteger('Flags', itU8, wbFlags([
            {0x01} 'Compass Marker Ignores Locks'
          ])),
          wbByteArray('Unknown', 3)
        ]),
        wbCTDAs
      ], []))
    ], [])),

    wbByteArray(ANAM, 'Aliases Marker', 4),

    wbRArray('Aliases',
      wbRStruct('Alias', [
        wbRUnion('Alias Type / ID', [
          wbInteger(ALST, 'Reference Alias ID', itU32),
          wbInteger(ALLS, 'Location Alias ID', itU32)
        ], []),
        wbString(ALID, 'Alias Name', 0, cpTranslate),
        wbStruct(FNAM, 'Alias Flags', [
          wbInteger('Flags', itU16, wbFlags([
            {0x0001}'Reserves Location/Reference',
            {0x0002}'Optional',
            {0x0004}'Quest Object',
            {0x0008}'Allow Reuse in Quest',
            {0x0010}'Allow Dead',
            {0x0020}'Matching Ref - In Loaded Area',
            {0x0040}'Essential',
            {0x0080}'Allow Disabled',
            {0x0100}'Stores Text',
            {0x0200}'Allow Reserved',
            {0x0400}'Protected',
            {0x0800}'Forced by Aliases?',
            {0x1000}'Allow Destroyed',
            {0x2000}'Matching Ref - Closest',
            {0x4000}'Uses Stored Text',
            {0x8000}'Initially Disabled'
          ])),
          wbInteger('Additional Flags', itU16, wbFlags([
            {0x0001}'Allow Cleared',
            {0x0002}'Clear Names When Removed'
          ]))
        ], cpNormal, False, nil, 1),
        wbInteger(ALFI, 'Force Into Alias When Filled', itU32),
        wbFormIDCk(ALFL, 'Specific Location', [LCTN]),
        wbFormID(ALFR, 'Forced Reference'),
        wbFormIDCk(ALUA, 'Unique Actor', [NPC_]),
        wbRStruct('Location Alias Reference', [
          wbInteger(ALFA, 'Alias', itU32),
          wbFormIDCk(KNAM, 'Keyword', [KYWD]),
          wbFormIDCk(ALRT, 'Ref Type', [LCRT])
        ], []),
        wbRStruct('External Alias Reference', [
          wbFormIDCk(ALEQ, 'Quest', [QUST]),
          wbInteger(ALEA, 'Alias', itU32)
        ], []),
        wbRStruct('Create Reference to Object', [
          wbFormID(ALCO, 'Object'),
          wbStruct(ALCA, 'Alias', [
            wbInteger('Alias', itU16),
            wbInteger('Create', itU16, wbEnum([] ,[
              $0000, 'At',
              $8000, 'In'
            ]))
          ]),
          wbInteger(ALCL, 'Level', itU32, wbEnum([
            'Easy',
            'Medium',
            'Hard',
            'Very Hard',
            'None'
          ]))
        ], []),
        wbRStruct('Find Matching Reference', [
          wbInteger(ALNA, 'Near Alias', itU32),
          wbInteger(ALNT, 'Near Type', itU32, wbEnum([
            'Linked Ref Child'
          ]))
        ], []),
        wbRStruct('Find Matching Reference', [
          wbString(ALFE, 'From Event', 4),
          wbByteArray(ALFD, 'Event Data')
        ], []),
        wbCTDAs,
        wbKeywords,
        {>>> When there is no COCT, CNTO comes right after Keywords and produces an error <<<}
        {>>> Error: record QUST contains unexpected (or out of order) subrecord CNTO 4F544E43  <<<}
        wbInteger(COCT, 'Count', itU32),
        wbCNTOs,
        wbFormIDCk(SPOR, 'Spectator override package list', [FLST], False, cpNormal, False),
        wbFormIDCk(OCOR, 'Observe dead body override package list', [FLST], False, cpNormal, False),
        wbFormIDCk(GWOR, 'Guard warn override package list', [FLST], False, cpNormal, False),
        wbFormIDCk(ECOR, 'Combat override package list', [FLST], False, cpNormal, False),
        wbFormIDCk(ALDN, 'Display Name', [MESG]),
        wbRArray('Alias Spells', wbFormIDCk(ALSP, 'Spell', [SPEL])),
        wbRArray('Alias Factions', wbFormIDCk(ALFC, 'Faction', [FACT])),
        wbRArray('Alias Package Data', wbFormIDCk(ALPC, 'Package', [PACK])),
        wbFormIDCk(VTCK, 'Voice Types', [NPC_, FLST, NULL]),
        wbEmpty(ALED, 'Alias End', cpNormal, True)
      ], [])
    ),

    wbString(NNAM, 'Description', 0, cpNormal, True),
    wbRArray('Targets', wbRStruct('Target', [
      wbStruct(QSTA, 'Target', [
        wbFormIDCkNoReach('Target', [REFR, PGRE, PMIS, ACRE, ACHR], True),
        wbInteger('Flags', itU8, wbFlags([
          {0x01} 'Compass Marker Ignores Locks'
        ])),
        wbByteArray('Unknown', 3)
      ]),
      wbCTDAs
    ], []))
    //wbCOCT,
    //wbKeywords,
    //wbUnknown(NAM0)
  ]);

  wbBodyPartIndexEnum := wbEnum([
    'Body Texture'
  ]);

  wbNoseMorphFlags := wbInteger('Nose Morph Flags', itU32, wbFlags([
        {0x00000001}'NoseType0',
        {0x00000002}'NoseType1',
        {0x00000004}'NoseType2',
        {0x00000008}'NoseType3',
        {0x00000010}'NoseType4',
        {0x00000020}'NoseType5',
        {0x00000040}'NoseType6',
        {0x00000080}'NoseType7',
        {0x00000100}'NoseType8',
        {0x00000200}'NoseType9',
        {0x00000400}'NoseType10',
        {0x00000800}'NoseType11',
        {0x00001000}'NoseType12',
        {0x00002000}'NoseType13',
        {0x00004000}'NoseType14',
        {0x00008000}'NoseType15',
        {0x00010000}'NoseType16',
        {0x00020000}'NoseType17',
        {0x00040000}'NoseType18',
        {0x00080000}'NoseType19',
        {0x00100000}'NoseType20',
        {0x00200000}'NoseType21',
        {0x00400000}'NoseType22',
        {0x00800000}'NoseType23',
        {0x01000000}'NoseType24',
        {0x02000000}'NoseType25',
        {0x03000000}'NoseType26',
        {0x08000000}'NoseType27',
        {0x10000000}'NoseType28',
        {0x20000000}'NoseType29',
        {0x40000000}'NoseType30',
        {0x80000000}'NoseType31'
  ]));

  wbBrowMorphFlags := wbInteger('Brow Morph Flags', itU32, wbFlags([
    {0x00000001}'BrowType0',
    {0x00000002}'BrowType1',
    {0x00000004}'BrowType2',
    {0x00000008}'BrowType3',
    {0x00000010}'BrowType4',
    {0x00000020}'BrowType5',
    {0x00000040}'BrowType6',
    {0x00000080}'BrowType7',
    {0x00000100}'BrowType8',
    {0x00000200}'BrowType9',
    {0x00000400}'BrowType10',
    {0x00000800}'BrowType11',
    {0x00001000}'BrowType12',
    {0x00002000}'BrowType13',
    {0x00004000}'BrowType14',
    {0x00008000}'BrowType15',
    {0x00010000}'BrowType16',
    {0x00020000}'BrowType17',
    {0x00040000}'BrowType18',
    {0x00080000}'BrowType19',
    {0x00100000}'BrowType20'
  ], True));

  wbEyesMorphFlags01 := wbInteger('Eye Morph Flags 1', itU32, wbFlags([
        {0x00000001}'EyesType0',
        {0x00000002}'EyesType1',
        {0x00000004}'EyesType2',
        {0x00000008}'EyesType3',
        {0x00000010}'EyesType4',
        {0x00000020}'EyesType5',
        {0x00000040}'EyesType6',
        {0x00000080}'EyesType7',
        {0x00000100}'EyesType8',
        {0x00000200}'EyesType9',
        {0x00000400}'EyesType10',
        {0x00000800}'EyesType11',
        {0x00001000}'EyesType12',
        {0x00002000}'EyesType13',
        {0x00004000}'EyesType14',
        {0x00008000}'EyesType15',
        {0x00010000}'EyesType16',
        {0x00020000}'EyesType17',
        {0x00040000}'EyesType18',
        {0x00080000}'EyesType19',
        {0x00100000}'EyesType20',
        {0x00200000}'EyesType21',
        {0x00400000}'EyesType22',
        {0x00800000}'EyesType23',
        {0x01000000}'EyesType24',
        {0x02000000}'EyesType25',
        {0x03000000}'EyesType26',
        {0x08000000}'EyesType27',
        {0x10000000}'EyesType28',
        {0x20000000}'EyesType29',
        {0x40000000}'EyesType30',
        {0x80000000}'EyesType31'
  ]));

  wbEyesMorphFlags02 := wbInteger('Eye Morph Flags 2', itU8, wbFlags([
        {0x00000001}'EyesType32',
        {0x00000002}'EyesType33',
        {0x00000004}'EyesType34',
        {0x00000008}'EyesType35',
        {0x00000010}'EyesType36',
        {0x00000020}'EyesType37',
        {0x00000040}'EyesType38'
  ], True));

  wbLipMorphFlags := wbInteger('Lip Morph Flags', itU32, wbFlags([
        {0x00000001}'LipType0',
        {0x00000002}'LipType1',
        {0x00000004}'LipType2',
        {0x00000008}'LipType3',
        {0x00000010}'LipType4',
        {0x00000020}'LipType5',
        {0x00000040}'LipType6',
        {0x00000080}'LipType7',
        {0x00000100}'LipType8',
        {0x00000200}'LipType9',
        {0x00000400}'LipType10',
        {0x00000800}'LipType11',
        {0x00001000}'LipType12',
        {0x00002000}'LipType13',
        {0x00004000}'LipType14',
        {0x00008000}'LipType15',
        {0x00010000}'LipType16',
        {0x00020000}'LipType17',
        {0x00040000}'LipType18',
        {0x00080000}'LipType19',
        {0x00100000}'LipType20',
        {0x00200000}'LipType21',
        {0x00400000}'LipType22',
        {0x00800000}'LipType23',
        {0x01000000}'LipType24',
        {0x02000000}'LipType25',
        {0x03000000}'LipType26',
        {0x08000000}'LipType27',
        {0x10000000}'LipType28',
        {0x20000000}'LipType29',
        {0x40000000}'LipType30',
        {0x80000000}'LipType31'
  ]));

  wbSizeIndexEnum := wbEnum([
    'Small',
    'Medium',
    'Large',
    'Extra Large'
  ]);

  wbTintMaskTypeEnum := wbEnum([
    'None',
    'Lip Color',
    'Cheek Color',
    'Eyeliner',
    'EyeSocket Upper',
    'EyeSocket Lower',
    'Skin Tone',
    'Paint',
    'Laugh Lines',
    'Cheek Color Lower',
    'Nose',
    'Chin',
    'Neck',
    'Forehead',
    'Dirt',
    'Unknown 16'
  ]);

//------------------------------------------------------------------------------
// Copied here for reference
//------------------------------------------------------------------------------
//  wbFaceGenNPC := wbRStruct('FaceGen Data', [
//    wbByteArray(FGGS, 'FaceGen Geometry-Symmetric', 0, cpNormal, True),
//    wbByteArray(FGGA, 'FaceGen Geometry-Asymmetric', 0, cpNormal, True),
//    wbByteArray(FGTS, 'FaceGen Texture-Symmetric', 0, cpNormal, True)
//  ], [], cpNormal, True, wbActorTemplateUseModelAnimation);

  wbTintMasks := wbRArray('Tint Masks', wbRStruct('Tint Assets', [
    wbRArray('Tint Layer', wbRStruct('Texture', [
      wbInteger(TINI, 'Unknown', itU16),
      wbString(TINT, 'File Name'),
      {>>> When set to None TINP does not exist Needs routine to add when
      changing the Mask Type <<<}
      wbInteger(TINP, 'Mask Type', itU16, wbTintMaskTypeEnum),
      wbFormIDCk(TIND, 'Preset Default', [CLFM, NULL])
    ], [])),
    wbRArray('Array TINC, TINV, TIRS', wbRStruct('Unknown', [
      wbFormIDCk(TINC, 'Preset', [CLFM, NULL]),
			wbFloat(TINV, 'Default Value for this Preset'),
      wbInteger(TIRS, 'Unknown', itU16)
    ], []))
  ], []));

  wbRACE_VNAMFlags := wbInteger('Flags 3', itU32, wbFlags([
        {0x00000001}'Hand To Hand Melee',
        {0x00000002}'One Hand Sword',
        {0x00000004}'One Hand Dagger',
        {0x00000008}'One Hand Axe',
        {0x00000010}'One Hand Mace',
        {0x00000020}'Two Hand Sword',
        {0x00000040}'Two Hand Axe',
        {0x00000080}'Bow',
        {0x00000100}'Staff',
        {0x00000200}'Spell',
        {0x00000400}'Shield',
        {0x00000800}'Torch',
        {0x00001000}'Crossbow'
      ], True));

  wbRACE_DATAFlags01 := wbInteger('Flags', itU32, wbFlags([
        {0x00000001}'Playable',
        {0x00000002}'FaceGen Head',
        {0x00000004}'Child',
        {0x00000008}'Tilt Front/Back',
        {0x00000010}'Tilt Left/Right',
        {0x00000020}'No Shadow',
        {0x00000040}'Swims',
        {0x00000080}'Flies',
        {0x00000100}'Walks',
        {0x00000200}'Immobile',
        {0x00000400}'Not Pushable',
        {0x00000800}'No Combat In Water',
        {0x00001000}'No Rotating to Head-Track',
        {0x00002000}'Don''t Show Blood Spray',
        {0x00004000}'Don''t Show Blood Decal',
        {0x00008000}'Uses Head Track Anims',
        {0x00010000}'Spells Align w/Magic Node',
        {0x00020000}'Use World Raycasts For FootIK',
        {0x00040000}'Allow Ragdoll Collision',
        {0x00080000}'Regen HP In Combat',
        {0x00100000}'Can''t Open Doors',
        {0x00200000}'Allow PC Dialogue',
        {0x00400000}'No Knockdowns',
        {0x00800000}'Allow Pickpocket',
        {0x01000000}'Always Use Proxy Controller',
        {0x02000000}'Don''t Show Weapon Blood',
        {0x03000000}'Overlay Head Part List', {>>>Only one can be active<<<}
        {0x08000000}'Override Head Part List', {>>>Only one can be active<<<}
        {0x10000000}'Can Pickup Items',
        {0x20000000}'Allow Multiple Membrane Shaders',
        {0x40000000}'Can Dual Wield',
        {0x80000000}'Avoids Roads'
      ]));

  wbRACE_DATAFlags02 := wbInteger('Flags 2', itU32, wbFlags([
        {0x00000001}'',
        {0x00000002}'Non-Hostile'
      ], True));

  wbPhonemeTargets := wbUnion(PHWT, 'Union', wbPHWTDecider, [
    wbStruct('Phoneme Targets', [
        wbFloat('Aah'),
        wbFloat('BigAah'),
        wbFloat('BMP'),
        wbFloat('ChJsh'),
        wbFloat('DST'),
        wbFloat('Eee'),
        wbFloat('Eh'),
        wbFloat('FV'),
        wbFloat('I'),
        wbFloat('K'),
        wbFloat('N'),
        wbFloat('Oh'),
        wbFloat('OohQ'),
        wbFloat('R'),
        wbFloat('TH'),
        wbFloat('W')
      ]),
    wbStruct('Phoneme Targets', [
        wbFloat('Aah'),
        wbFloat('BigAah'),
        wbFloat('BMP'),
        wbFloat('ChJsh'),
        wbFloat('DST'),
        wbFloat('Eee'),
        wbFloat('Eh'),
        wbFloat('FV')
      ]),
      wbbyteArray('Unknown', 0)
  ]);

  wbPHWT := wbRStruct('FaceFX Phonemes', [
    wbRStruct('FaceFX - IY', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - IH', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - EH', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - EY', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - AE', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - AA', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - AW', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - AY', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - AH', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - AO', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - OY', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - OW', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - UH', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - UW', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - ER', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - AX', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - S', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - SH', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - Z', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - ZH', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - F', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - TH', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - V', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - DH', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - M', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - N', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - NG', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - L', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - R', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - W', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - Y', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - HH', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - B', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - D', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - JH', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - G', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - P', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - T', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - K', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - CH', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - SIL', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - SHOTSIL', [wbPhonemeTargets], []),
    wbRStruct('FaceFX - FLAP', [wbPhonemeTargets], [])
  ], []);

  wbMorphs := wbRStruct('Available Morphs', [
      wbByteArray(MPAI, 'Unknown', 0),
      wbStruct(MPAV, 'Nose Variants', [
        wbNoseMorphFlags,
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4)
      ]),
      wbByteArray(MPAI, 'Unknown', 0),
      wbStruct(MPAV, 'Brow Variants', [
        wbBrowMorphFlags,
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4)
      ]),
      wbByteArray(MPAI, 'Unknown', 0),
      wbStruct(MPAV, 'Eye Variants', [
        wbEyesMorphFlags01,
        wbEyesMorphFlags02,
        wbByteArray('Unknown', 3),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4)
      ]),
      wbByteArray(MPAI, 'Unknown', 0),
      wbStruct(MPAV, 'Lip Variants', [
        wbLipMorphFlags,
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4)
      ])
    ], []);

  wbHeadPart := wbRStruct('Head Part', [
    wbInteger(INDX, 'Head Part Number', itU32), {>>> Needs Count Updated <<<}
    wbFormIDCk(HEAD, 'Head', [HDPT, NULL])
  ], []);

  wbRecord(RACE, 'Race', [
    wbEDIDReq,
    wbFULLReq,
    wbDESCReq,
    wbSpells,
    wbFormIDCk(WNAM, 'Skin', [ARMO, NULL]),
    wbBODT,
    wbKeywords,
    wbStruct(DATA, '', [
      wbArrayS('Skill Boosts', wbStructSK([0], 'Skill Boost', [
        wbInteger('Skill', itS8, wbActorValueEnum),
        wbInteger('Boost', itS8)
      ]), 7),
      wbByteArray('Unknown', 2),
      wbFloat('Male Height'),
      wbFloat('Female Height'),
      wbFloat('Male Weight'),
      wbFloat('Female Weight'),
      wbRACE_DATAFlags01,
      wbFloat('Starting Health'),
      wbFloat('Starting Magicka'),
      wbFloat('Starting Stamina'),
      wbFloat('Base Carry Weight'),
      wbFloat('Base Mass'),
      wbFloat('Acceleration rate'),
      wbFloat('Deceleration rate'),
      wbInteger('Size', itU32, wbSizeIndexEnum),
      wbInteger('Head Biped Object', itS32, wbBipedObjectEnum),
      wbInteger('Hair Biped Object', itS32, wbBipedObjectEnum),
      wbFloat('Injured Health Pct'),
      {>>> When Set to None this Equals FF FF FF FF <<<}
      wbInteger('Shield Biped Object', itS32, wbBipedObjectEnum),
      wbFloat('Health Regen'),
      wbFloat('Magicka Regen'),
      wbFloat('Stamina Regen'),
      wbFloat('Unarmed Damage'),
      wbFloat('Unarmed Reach'),
      wbInteger('Body Biped Object', itS32, wbBipedObjectEnum),
      wbFloat('Aim Angle Tolerance'),
      wbByteArray('Unknown', 4),
      wbFloat('Angular Acceleration Rate'),
      wbFloat('Angular Tolerance'),
      wbRACE_DATAFlags02,
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 0)
    ], cpNormal, True),
    wbEmpty(MNAM, 'Marker'),
    wbString(ANAM, 'Skeletal Model'),
    wbMODT,
    wbEmpty(FNAM, 'Marker'),
    wbString(ANAM, 'Skeletal Model'),
    wbMODT,
    wbEmpty(NAM2, 'Marker NAM2 #1'),
    wbRArrayS('Movement Type Names', wbString(MTNM, 'Name')),
    wbArray(VTCK, 'Voices', wbFormIDCk('Voice', [VTYP]), ['Male', 'Female'], cpNormal, True),
    wbArray(DNAM, 'Decapitate Armors', wbFormIDCk('Decapitate Armor', [ARMO]), ['Male', 'Female'], cpNormal, True),
    wbArray(HCLF, 'Default Hair Colors', wbFormIDCk('Default Hair Color', [CLFM]), ['Male', 'Female'], cpNormal, True),
    wbInteger(TINL, 'Total Number of Tints in List', itU16, nil, nil, cpNormal, True), {>>> Needs Count Updated <<<}
    wbFloat(PNAM, 'FaceGen - Main clamp', cpNormal, True),
    wbFloat(UNAM, 'FaceGen - Face clamp', cpNormal, True),
    wbFormIDCk(ATKR, 'Attack Race', [RACE], False, cpNormal, False),
    wbRArray('Attacks', wbAttackData),
    wbRStruct('Body Data', [
      wbEmpty(NAM1, 'Body Data Marker', cpNormal, True),
      wbRStruct('Male Body Data', [
        wbEmpty(MNAM, 'Male Data Marker'),
        wbRArrayS('Parts', wbRStructSK([0], 'Part', [
          wbInteger(INDX, 'Index', itU32, wbBodyPartIndexEnum),
          wbMODLReq
        ], []), cpNormal, True)
      ], [], cpNormal, True),
      wbRStruct('Female Body Data', [
        wbEmpty(FNAM, 'Female Data Marker', cpNormal, True),
        wbRArrayS('Parts', wbRStructSK([0], 'Part', [
          wbInteger(INDX, 'Index', itU32, wbBodyPartIndexEnum),
          wbMODLReq
        ], []), cpNormal, True)
      ], [], cpNormal, True)
    ], [], cpNormal, True),
    wbArrayS(HNAM, 'Hairs', wbFormIDCk('Hair', [HDPT, NULL]), 0, cpNormal),
    wbArrayS(ENAM, 'Eyes', wbFormIDCk('Eye', [EYES, NULL]),  0,  cpNormal),
    wbFormIDCk(GNAM, 'Body Part Data', [BPTD, NULL]),
	  wbEmpty(NAM2, 'Marker NAM2 #2', cpNormal),
	  wbEmpty(NAM3, 'Marker NAM3 #3', cpNormal, True),
    wbRStruct('Male Behavoir Graph', [
      wbEmpty(MNAM, 'Male Data Marker'),
      wbMODL
    ], [], cpNormal, True),
    wbRStruct('Female Behavoir Graph', [
      wbEmpty(FNAM, 'Female Data Marker', cpNormal, True),
      wbMODL
    ], [], cpNormal, True),
    wbFormIDCk(NAM4, 'Material Type', [MATT, NULL]),
    wbFormIDCk(NAM5, 'Impact Data Set', [IPDS, NULL]),
		wbFormIDCk(NAM7, 'Decapitation FX', [ARTO, NULL]),
    wbFormIDCk(ONAM, 'Open Loot Sound', [SNDR, NULL]),
    wbFormIDCk(LNAM, 'Close Loot Sound', [SNDR, NULL]),
    {>>> When NAME is user defined wbBipedObjectEnum will be incorrect <<<}
    wbRArrayS('Biped Object Names', wbString(NAME, 'Name')),
    wbRArray('Movement Types', wbRStruct('Movement Types', [
      wbFormIDCk(MTYP, 'Movement Type', [MOVT, NULL]),
      wbStruct(SPED, 'Override Values', [
        wbFloat('Left - Walk'),
        wbFloat('Left - Run'),
        wbFloat('Right - Walk'),
        wbFloat('Right - Run'),
        wbFloat('Forward - Walk'),
        wbFloat('Forward - Run'),
        wbFloat('Back - Walk'),
        wbFloat('Back - Run'),
        wbFloat('Rotate - Walk'),
        wbFloat('Rotate - Walk'),
        wbFloat('Unknown')
      ])
    ], [])),
    wbStruct(VNAM, 'Equipment Flags', [wbRACE_VNAMFlags]),
    wbRArrayS('Equip Slots', wbFormIDCk(QNAM, 'Equip Slot', [EQUP, NULL])),
    wbFormIDCk(UNES, 'Unarmed Equip Slot', [EQUP, NULL]),
    wbRArrayS('Phoneme Target Names', wbString(PHTN, 'Name')),
    wbPHWT,
    // Start Movement Data
    wbFormIDCk(WKMV, 'Walk', [MOVT, NULL]),
		wbFormIDCk(RNMV, 'Run', [MOVT, NULL]),
		wbFormIDCk(SWMV, 'Swim', [MOVT, NULL]),
		wbFormIDCk(FLMV, 'Fly', [MOVT, NULL]),
		wbFormIDCk(SNMV, 'Sneak', [MOVT, NULL]),
		wbFormIDCk(SPMV, 'Sprint', [MOVT, NULL]),
    // Start Head Data
    wbRStruct('Head Data', [
      wbEmpty(NAM0, 'Head Data Marker', cpNormal, True),
      wbRStruct('Male Head Data', [
        wbEmpty(MNAM, 'Male Data Marker', cpNormal, True),
          wbRArrayS('Head Parts', wbHeadPart),
          wbMorphs,
          wbRArrayS('Race Presets Male', wbFormIDCk(RPRM, 'Preset NPC', [NPC_, NULL])),
          wbRArrayS('Available Hair Colors Male', wbFormIDCk(AHCM, 'Hair Color', [CLFM, NULL])),
          wbRArrayS('Face Details Testure Set List Male', wbFormIDCk(FTSM, 'Testure Set', [TXST, NULL])),
          wbFormIDCk(DFTM, 'Default Face Texture Male', [TXST, NULL]),
          wbTintMasks,
          wbMODLReq
      ], [], cpNormal, True),
      wbRStruct('Female Head Data', [
        wbEmpty(NAM0, 'Head Data Marker', cpNormal, True),
        wbEmpty(FNAM, 'Female Data Marker', cpNormal, True),
          wbRArrayS('Head Parts', wbHeadPart),
          wbMorphs,
          wbRArrayS('Race Presets Female', wbFormIDCk(RPRF, 'Preset NPC', [NPC_, NULL])),
          wbRArrayS('Available Hair Colors Female', wbFormIDCk(AHCF, 'Hair Color', [CLFM, NULL])),
          wbRArrayS('Face Details Texture Set List Female', wbFormIDCk(FTSF, 'Texture Set', [TXST, NULL])),
          wbFormIDCk(DFTF, 'Default Face Texture Female', [TXST, NULL]),
          wbTintMasks,
          wbMODLReq
      ], [], cpNormal, True)
    ], [], cpNormal, True),
    // End Head Data
    wbFormIDCk(NAM8, 'Morph race', [RACE, NULL]),
    wbFormIDCk(RNAM, 'Armor race', [RACE, NULL])
  ], False, nil, cpNormal, False, wbRemoveOFST);


  wbRecord(REFR, 'Placed Object', [
    wbEDID,
    wbVMAD,
    wbFormIDCk(NAME, 'Base', [TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, LVLN, LVLC,
                              MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, CHIP,
                              MSTT, PWAT, SCOL, TACT, TXST, CCRD], False, cpNormal, True),

    {--- Bound Contents ---}
    {--- Bound Data ---}
    wbStruct(XMBO, 'Bound Half Extents', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ]),

    {--- Primitive ---}
    wbStruct(XPRM, 'Primitive', [
      wbStruct('Bounds', [
        wbFloat('X', cpNormal, True, 2, 4),
        wbFloat('Y', cpNormal, True, 2, 4),
        wbFloat('Z', cpNormal, True, 2, 4)
      ]),
      wbStruct('Color', [
        {84} wbFloat('Red', cpNormal, False, 255, 0),
        {88} wbFloat('Green', cpNormal, False, 255, 0),
        {92} wbFloat('Blue', cpNormal, False, 255, 0)
      ]),
      wbFloat('Unknown'),
      wbInteger('Type', itU32, wbEnum([
        'None',
        'Box',
        'Sphere',
        'Portal Box'
      ]))
    ]),

    wbStruct(XOCP, 'Occlusion Plane Data', [
      wbStruct('Size', [
        wbFloat('Width', cpNormal, False, 2),
        wbFloat('Height', cpNormal, False, 2)
      ]),
      wbStruct('Position', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]),
      wbStruct('Rotation (Quaternion?)', [
        wbFloat('q1'),
        wbFloat('q2'),
        wbFloat('q3'),
        wbFloat('q4')
      ])
    ]),

    wbArray(XPOD, 'Portal Data', wbStruct('References', [
      wbFormIDCk('Origin', [REFR, NULL]),
      wbFormIDCk('Destination', [REFR, NULL])
    ])),

    wbRStruct('Bound Data', [
      wbStruct(XRMR, 'Header', [
        //wbInteger('Linked Rooms Count', itU16),
        wbByteArray('Unknown', 1),
        wbInteger('Flags', itU8, wbFlags([
          'Unknown 1',
          'Unknown 2',
          'Unknown 3',
          'Unknown 4',
          'Unknown 5',
          'Unknown 6',
          'Has Image Space',
          'Has Lighting Template'
        ])),
        wbByteArray('Unknown', 2)
      ]),
      wbFormIDCk(LNAM, 'Lighting Template', [LGTM]),
      wbFormIDCk(INAM, 'Image Space', [IMGS]),
      wbRArrayS('Linked Rooms',
        wbFormIDCk(XLRM, 'Linked Room', [REFR])
      )
    ], []),
    wbEmpty(XMBP, 'MultiBound Primitive Marker'),

    wbXRGD,
    wbXRGB,
    wbFloat(XRDS, 'Radius'),

    {--- Reflected By / Refracted By ---}
    wbRArrayS('Reflected/Refracted By',
      wbStructSK(XPWR, [0], 'Water', [
        wbFormIDCk('Reference', [REFR]),
        wbInteger('Type', itU32, wbFlags([
          'Reflection',
          'Refraction'
        ]))
      ], cpNormal, False, nil, 1)
    ),

    {--- Lit Water ---}
    wbRArrayS('Lit Water',
      wbFormIDCk(XLTW, 'Water', [REFR])
    ),

    {--- Emittance ---}
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),
		wbStruct(XLIG, 'Light Data', [
      wbFloat('FOV 90+/-'),
      wbFloat('Fade 1.35+/-'),
      wbByteArray('Unknown', 4),
      wbFloat('Shadow Depth Bias'),
      wbByteArray('Unknown', 4)
    ]),
		wbStruct(XALP, 'Alpha', [
      wbInteger('Cutoff', itU8),
      wbInteger('Base', itU8)
    ]),

    {--- Teleport ---}
    wbStruct(XTEL, 'Teleport Destination', [
      wbFormIDCk('Door', [REFR], True),
      wbPosRot,
      wbInteger('Flags', itU32, wbFlags([
        'No Alarm'
      ]))
    ]),
    wbFormIDCk(XTNM, 'Message Box', [MESG]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),

 		wbRstruct('Water Velocity', [
			wbUnknown(XWCN),
			wbStruct(XWCU, 'Water Velocity', [
				wbFloat('X Offset'),
				wbFloat('Y Offset'),
				wbFloat('Z Offset'),
				wbByteArray('Unknown', 4),
				wbFloat('X Angle'),
				wbFloat('Y Angle'),
				wbFloat('Z Angle'),
				wbByteArray('Unknown', 4),
				wbByteArray('Unknown', 4),
				wbByteArray('Unknown', 4),
				wbByteArray('Unknown', 4),
				wbByteArray('Unknown', 4)
			])
		], []),

    wbStruct(XCVL, 'Unknown', [
			wbByteArray('Unknown', 4),
			wbFloat('X Angle'),
			wbByteArray('Unknown', 4)
    ]),
		wbUnknown(XCZA),
    wbFormIDCk(XCZC, 'Unknown', [CELL, NULL]),
    wbXSCL,
    wbFormIDCk(XSPC, 'Spawn Container', [REFR]),

    {--- Activate Parents ---}
    wbRStruct('Activate Parents', [
      wbInteger(XAPD, 'Flags', itU8, wbFlags([
        'Parent Activate Only'
      ], True)),
      wbRArrayS('Activate Parent Refs',
        wbStructSK(XAPR, [0], 'Activate Parent Ref', [
          wbFormIDCk('Reference', [REFR, ACRE, ACHR, PGRE, PMIS]),
          wbFloat('Delay')
        ])
      )
    ], []),

    wbFormIDCk(XLIB, 'Leveled Item Base Object', [LVLI]),
    wbXLCM,
    wbFormIDCk(XLCN, 'Persistent Location', [LCTN]),

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

    {--- Lock ---}
    wbStruct(XLOC, 'Lock Data', [
      wbInteger('Level', itU8),
      wbByteArray('Unknown', 3),
      wbFormIDCkNoReach('Key', [KEYM, NULL]),
      wbInteger('Flags', itU8, wbFlags(['', '', 'Leveled Lock'])),
      wbByteArray('Unknown', 3),
      wbByteArray('Unknown', 8)
    ], cpNormal, False, nil, 5),

    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),

    {--- Generated Data ---}
    wbStruct(XNDP, 'Navigation Door Link', [
      wbFormIDCk('Navigation Mesh', [NAVM]),
      wbInteger('Unknown', itU16),
      wbByteArray('Unknown', 2)
    ]),

    wbArray(XLRT, 'Location Ref Type', wbFormIDCk('Ref', [LCRT, NULL])),
    wbEmpty(XIS2, 'Ignored by Sandbox'),

    {--- Ownership ---}
    wbOwnership,

    wbInteger(XCNT, 'Item Count', itS32),
    wbFloat(XCHG, 'Charge'),
    wbFormIDCk(XLRL, 'Location Reference', [LCRT, NULL]),

    wbXESP,
    wbRArray('Linked References', wbStruct(XLKR, 'Linked Reference', [
      wbFormIDCk('Keyword', [KYWD, NULL]),
      wbFormIDCk('Ref', [REFR, ACRE, ACHR, PGRE, PMIS])
    ])),

    wbRArray('Patrol', wbRStruct('Data', [
      wbFloat(XPRD, 'Idle Time', cpNormal, True),
      wbEmpty(XPPA, 'Patrol Script Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbStruct(SCHR, 'Unknown', [
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4)
      ]),
      wbUnknown(SCTX),
      wbPDTOs
    ], [])),

    {--- Flags ---}
    wbInteger(XACT, 'Action Flag', itU32, wbFlags([
      'Use Default',
      'Activate',
      'Open',
      'Open by Default'
    ])),

    wbFloat(XHTW, 'Head-Tracking Weight'),
    wbFloat(XFVC, 'Favor Cost'),

    wbEmpty(ONAM, 'Open by Default'),

    {--- Map Data ---}
    wbRArray('Map', wbRStruct('Map Data', [
      wbEmpty(XMRK, 'Map Data Marker'),
      wbInteger(FNAM, 'Flags', itU8, wbFlags([
        {0x01} 'Visible',
        {0x02} 'Can Travel To'
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
        wbByteArray('Unknown', 1)
      ], cpNormal, True)
    ], [])),

    {--- Attach reference ---}
    wbFormIDCk(XATR, 'Attach Ref', [REFR]),
    wbDataPosRot
  ], True, wbPlacedAddInfo, cpNormal, False, nil{wbREFRAfterLoad});


  wbRecord(REGN, 'Region', [
    wbEDID,

    wbStruct(RCLR, 'Map Color', [
      wbInteger('Red', itU8),
      wbInteger('Green', itU8),
      wbInteger('Blue', itU8),
      wbByteArray('Unknown', 1)
    ], cpNormal, True),
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
          {0} 'Unknown 0',
          {1} 'Unknown 1',
          {2} 'Objects',
          {3} 'Weather',
          {4} 'Map',
          {5} 'Land',
          {6} 'Grass',
          {7} 'Sound',
          {8} 'Imposter',
          {9} 'Unknown 10',
          {10}'Unknown 11',
          {11}'Unknown 12',
          {12}'Unknown 13',
          {13}'Unknown 14',
          {14}'Unknown 15',
          {15}'Unknown 16'
        ])),
        wbInteger('Flags', itU8, wbFlags([
          'Override'
        ])),
        wbInteger('Priority', itU8),
        wbByteArray('Unknown')
      ], cpNormal, True),

      {--- Icon ---}
      wbICON,

      {--- Sound ---}
      wbInteger(RDMD, 'Music Type', itU32, wbMusicEnum, cpIgnore, False, False, wbNeverShow),
      wbFormIDCk(RDMO, 'Music', [MUSC], False, cpNormal, False, wbREGNSoundDontShow),
      wbFormIDCk(RDSI, 'Incidental MediaSet', [MSET], False, cpNormal, False, wbREGNSoundDontShow),
      wbRArray('Battle MediaSets', wbFormIDCk(RDSB, 'Battle MediaSet', [MSET]), cpNormal, False, wbREGNSoundDontShow),
      wbArrayS(RDSA, 'Sounds', wbStructSK([0], 'Sound', [
        wbFormIDCk('Sound', [SOUN]),
        wbInteger('Flags', itU32, wbFlags([
          {0x00000001}'Pleasant',
          {0x00000002}'Cloudy',
          {0x00000004}'Rainy',
          {0x00000008}'Snowy',
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
        ])),
        wbInteger('Chance', itU32, wbScaledInt4ToStr, wbScaledInt4ToInt)
      ]), 0, cpNormal, False, nil, nil, wbREGNSoundDontShow),

			{--- Map ---}
      wbLString(RDMP, 'Map Name', 0, cpTranslate, False, wbREGNMapDontShow),

      {followed by one of these: }

      {--- Objects ---}
      wbArray(RDOT, 'Objects', wbStruct('Object', [
        wbFormIDCk('Object', [TREE, STAT, LTEX]),
        wbInteger('Parent Index', itU16, wbHideFFFF),
        wbByteArray('Unknown', 2),
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
        wbByteArray('Unknown', 4),
        wbFloat('Max Height'),
        wbFloat('Sink'),
        wbFloat('Sink Variance'),
        wbFloat('Size Variance'),
        wbStruct('Angle Variance', [
          wbInteger('X', itU16),
          wbInteger('Y', itU16),
          wbInteger('Z', itU16)
        ]),
        wbByteArray('Unknown', 2),
        wbByteArray('Unknown', 4)
      ]), 0, nil, nil, cpNormal, False, wbREGNObjectsDontShow),

      {--- Grass ---}
      wbArrayS(RDGS, 'Grasses', wbStructSK([0], 'Grass', [
        wbFormIDCk('Grass', [GRAS]),
        wbByteArray('Unknown',4)
      ]), 0, cpNormal, False, nil, nil, wbREGNGrassDontShow),

      {--- Weather ---}
      wbArrayS(RDWT, 'Weather Types', wbStructSK([0], 'Weather Type', [
        wbFormIDCk('Weather', [WTHR]),
        wbInteger('Chance', itU32),
        wbFormIDCk('Global', [GLOB, NULL])
      ]), 0, cpNormal, False, nil, nil, wbREGNWeatherDontShow),

      {--- Imposter ---}
      wbArrayS(RDID, 'Imposters', wbFormIDCk('Imposter', [REFR]), 0, cpNormal, False, nil, nil, wbREGNImposterDontShow)
    ], []))
  ], True);

//------------------------------------------------------------------------------
//  SNDD - Sound Data: 00 00 00 00
//                     00 00 00 00
//                     00 00 00 00
//                     64 00 32 00
//                     14 00 05 00
//                     00 00 50 00
//                     80 00 00 00
//                     00 00 00 00
//                     00 00 00 00

  wbSNDD := wbRUnion('Sound Data', [
    wbStruct(SNDD, 'Sound Data', [
      wbInteger('Minimum Attentuation Distance', itU8, wbMul(5)),
      wbInteger('Maximum Attentuation Distance', itU8, wbMul(100)),
      wbInteger('Frequency Adjustment %', itS8),
      wbByteArray('Uknown', 1),
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
        {0x1000} 'Mute When Submerged',
        {0x2000} 'Start at Random Position'
      ])),
      wbInteger('Static attentuation cdB', itS16),
      wbInteger('Stop time ', itU8),
      wbInteger('Start time ', itU8),
      wbArray('Attenuation Curve', wbInteger('Point', itS16), 5),
      wbInteger('Reverb Attenuation Control', itS16),
      wbInteger('Priority', itS32),
//        wbByteArray('Unknown', 8)
      wbInteger('x', itS32),
      wbInteger('y', itS32)
    ], cpNormal, True)
//      wbStruct(SNDX, 'Sound Data', [
//        wbInteger('Minimum attentuation distance', itU8, wbMul(5)),
//        wbInteger('Maximum attentuation distance', itU8, wbMul(100)),
//        wbInteger('Frequency adjustment %', itS8),
//        wbByteArray('Unused', 1),
//        wbInteger('Flags', itU32, wbFlags([
//          {0x0001} 'Random Frequency Shift',
//          {0x0002} 'Play At Random',
//          {0x0004} 'Environment Ignored',
//          {0x0008} 'Random Location',
//          {0x0010} 'Loop',
//          {0x0020} 'Menu Sound',
//          {0x0040} '2D',
//          {0x0080} '360 LFE',
//          {0x0100} 'Dialogue Sound',
//          {0x0200} 'Envelope Fast',
//          {0x0400} 'Envelope Slow',
//          {0x0800} '2D Radius',
//          {0x1000} 'Mute When Submerged'
//        ])),
//        wbInteger('Static attentuation cdB', itS16),
//        wbInteger('Stop time ', itU8),
//        wbInteger('Start time ', itU8)
//      ], cpNormal, True)
//------------------------------------------------------------------------------
// Might be Usefull for this routine
//
//    wbArray(ANAM, 'Attenuation Curve', wbInteger('Point', itS16), 5, nil, nil, cpNormal, False, wbNeverShow),
//    wbInteger(GNAM, 'Reverb Attenuation Control', itS16, nil, cpNormal, False, False, wbNeverShow),
//    wbInteger(HNAM, 'Priority', itS32, nil, cpNormal, False, False, wbNeverShow),
//    wbInteger(RNAM, 'Random Chance %', itU8),
//------------------------------------------------------------------------------
    ], [], cpNormal, True);

  wbRecord(SOUN, 'Sound', [
    wbEDIDReq,
    wbOBNDReq,
    wbString(FNAM, 'Sound Filename'),
    wbStruct(SNDD,'Some Values', [
      wbInteger('Value 1', itS16),
      wbInteger('Value 2', itS16),
      wbInteger('Value 3', itS16),
      wbInteger('Value 4', itS16),
      wbInteger('Value 5', itS16),
      wbInteger('Value 6', itS16),
      wbInteger('Value 7', itS16),
      wbInteger('Value 8', itS16),
      wbInteger('Value 9', itS16),
      wbInteger('Value 10', itS16),
      wbInteger('Value 11', itS16),
      wbInteger('Value 12', itS16),
      wbInteger('Value 13', itS16),
      wbInteger('Value 14', itS16),
      wbInteger('Value 15', itS16),
      wbInteger('Value 16', itS16),
      wbInteger('Value 17', itS16),
      wbInteger('Value 18', itS16)
    ]),
//    wbUnknown(SNDD),
//    wbSNDD,
    wbFormIDCk(SDSC, 'Sound Descriptor', [SNDR, NULL])
  ], False, nil, cpNormal, False, wbSOUNAfterLoad);

  wbSPIT := wbStruct(SPIT, '', [
      wbInteger('Base Cost', itU32),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Manual Cost Calc',
        {0x00000002} 'Unknown 2',
        {0x00000004} 'Unknown 3',
        {0x00000008} 'Unknown 4',
        {0x00000010} 'Unknown 5',
        {0x00000020} 'Unknown 6',
        {0x00000040} 'Unknown 7',
        {0x00000080} 'Unknown 8',
        {0x00000100} 'Unknown 9',
        {0x00000200} 'Unknown 10',
        {0x00000400} 'Unknown 11',
        {0x00000800} 'Unknown 12',
        {0x00001000} 'Unknown 13',
        {0x00002000} 'Unknown 14',
        {0x00004000} 'Unknown 15',
        {0x00008000} 'Unknown 16',
        {0x00010000} 'Unknown 17',
        {0x00020000} 'PC Start Spell',
        {0x00040000} 'Unknown 19',
        {0x00080000} 'Area Effect Ignores LOS',
        {0x00100000} 'Ignore Resistance',
        {0x00200000} 'No Absorb/Reflect',
        {0x00400000} 'Unknown 23',
        {0x00800000} 'No Dual Cast Modification',
        {0x01000000} 'Unknown 25',
        {0x02000000} 'Unknown 26',
        {0x04000000} 'Unknown 27',
        {0x08000000} 'Unknown 28',
        {0x10000000} 'Unknown 29',
        {0x20000000} 'Unknown 30',
        {0x40000000} 'Unknown 31',
        {0x80000000} 'Unknown 32'
      ])),
      wbInteger('Type', itU32, wbEnum([
        {0} 'Spell',
        {1} 'Disease',
        {2} 'Power',
        {3} 'Lesser Power',
        {4} 'Ability',
        {5} 'Poison',
        {6} 'Unknown 6',
        {7} 'Unknown 7',
        {8} 'Unknown 8',
        {9} 'Unknown 9',
       {10} 'Addiction',
       {11} 'Voice'
      ])),
      wbFloat('Charge Time'),
      wbInteger('Cast Type', itU32, wbCastEnum),
      wbInteger('Type', itU32, wbTargetEnum),
      wbFloat('Cast Duration'),
      wbFloat('Range'),
      wbFormIDCk('Half-cost Perk', [PERK])
    ], cpNormal, True);

  wbRecord(SPEL, 'Actor Effect', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbKeywords,
    wbMDOB,
    wbETYP,
    wbDESCReq,
    wbSPIT,
    wbEffectsReq
  ]);

  wbRecord(SCRL, 'SCRL', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbKeywords,
    wbMDOB,
    wbETYP,
    wbDESC,
    wbMODL,
    wbDEST,
    wbSounds,
    wbStruct(DATA, 'Item', [
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ], cpNormal, True),
    wbSPIT,
    wbEffectsReq
  ]);

  wbRecord(STAT, 'Static', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODL,
    {Unused in this record for TES5
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
    wbFormIDCk(RNAM, 'Sound - Looping/Random', [SOUN])}
    wbUnknown(DNAM),
    wbUnknown(MNAM)
 ]);

  wbRecord(TES4, 'Main File Header', [
    wbStruct(HEDR, 'Header', [
      wbFloat('Version'),
      wbInteger('Number of Records', itU32),
      wbByteArray('Next Object ID', 4)
    ], cpNormal, True),
    wbByteArray(OFST, 'Unknown', 0, cpIgnore),
    wbByteArray(DELE, 'Unknown', 0, cpIgnore),
    wbString(CNAM, 'Author', 0, cpTranslate, True),
    wbString(SNAM, 'Description', 0, cpTranslate),
    wbRArray('Master Files', wbRStruct('Master File', [
      wbString(MAST, 'Filename', 0, cpNormal, True),
      wbByteArray(DATA, 'Unknown', 8, cpIgnore, True)
    ], [ONAM])),
    wbArray(ONAM, 'Overriden Forms', wbFormIDCk('Form', [ACHR, LAND, NAVM, PGRE, PHZD, REFR]), 0, nil, nil, cpNormal, False, wbTES4ONAMDontShow),
    wbByteArray(SCRN, 'Screenshot'),
    wbUnknown(INTV),
    wbUnknown(INCC)
  ], True, nil, cpNormal, True, wbRemoveOFST);
end;

procedure DefineTES5o;
begin
  wbRecord(TREE, 'Tree', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODLReq,
    wbFormIDCK(PFIG, 'Magic Effect', [INGR, ALCH, NULL]),
    wbUnknown(PFIG),
    wbFormIDCK(SNAM, 'Sound', [SNDR, NULL]),
    wbUnknown(PFPC),
    wbFULL,
    wbICONReq,
    wbStruct(CNAM, 'Tree Data', [
      wbFloat('Leaf Curvature'),
      wbFloat('Minimum Leaf Angle'),
      wbFloat('Maximum Leaf Angle'),
      wbFloat('Branch Dimming Value'),
      wbFloat('Leaf Dimming Value'),
      wbInteger('Shadow Radius', itS32),
      wbFloat('Rock Speed'),
      wbFloat('Rustle Speed'),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4)
    ], cpNormal, True),
    wbStruct(BNAM, 'Billboard Dimensions', [
      wbFloat('Width'),
      wbFloat('Height')
    ], cpNormal, True)
  ]);

  wbRecord(FLOR, 'Flora', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULLReq,
    wbMODL,
    wbDEST,
    wbKeywords,
    wbUnknown(PNAM),
    wbLString(RNAM, 'Activate Text Override'),
    wbUnknown(FNAM),
    wbFormIDCk(PFIG, 'Ingredient', [INGR, ALCH, NULL]),
    wbFormIDCK(SNAM, 'Sound', [SNDR, NULL]),
    wbStruct(PFPC, 'Seasonal ingredient production', [
      wbInteger('Spring', itU8),
      wbInteger('Summer ', itU8),
      wbInteger('Fall', itU8),
      wbInteger('Winter', itU8)
    ], cpNormal, True)
  ]);

  wbRecord(WATR, 'Water', [
    wbEDIDReq,
    wbFULL,
    wbRArray('Array of Noise Maps', wbRStruct('Noise Maps', [
      wbString(NNAM, 'Noise Map')
    ], [])),
    wbInteger(ANAM, 'Opacity', itU8, nil, cpNormal, True),
    wbInteger(FNAM, 'Flags', itU8, wbFlags([
      {0}'Causes Damage',
      {1}'Reflective'
    ]), cpNormal, True),
    wbString(MNAM, 'Material ID', 0, cpNormal, True),
    wbFormIDCk(SNAM, 'Sound', [SNDR, NULL]),
    wbUnknown(TNAM),
    wbUnknown(INAM),
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
        wbByteArray('Unknown', 4),
        wbFloat('Fog Properties - Above Water - Fog Distance - Near Plane'),
        wbFloat('Fog Properties - Above Water - Fog Distance - Far Plane'),
        wbStruct('Shallow Color', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unknown', 1)
        ]),
        wbStruct('Deep Color', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unknown', 1)
        ]),
        wbStruct('Reflection Color', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unknown', 1)
        ]),
        wbByteArray('Unknown', 4),
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
        wbFloat('Noise Properties - Noise Layer Three - Amplitude Scale'),
        wbByteArray('Unknown', 0)
      ], cpNormal, True),
//      ], cpNormal, True, nil, 46),
      wbStruct(DATA, 'Visual Data', [
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Water Properties - Sun Power'),
        wbFloat('Water Properties - Reflectivity Amount'),
        wbFloat('Water Properties - Fresnel Amount'),
        wbByteArray('Unknown', 4),
        wbFloat('Fog Properties - Above Water - Fog Distance - Near Plane'),
        wbFloat('Fog Properties - Above Water - Fog Distance - Far Plane'),
        wbStruct('Shallow Color', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unknown', 1)
        ]),
        wbStruct('Deep Color', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unknown', 1)
        ]),
        wbStruct('Reflection Color', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unknown', 1)
        ]),
        wbByteArray('Unknown', 4),
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
    ], cpNormal, True),
    wbUnknown(NAM0),
    wbUnknown(NAM1),
    wbUnknown(NAM2),
    wbUnknown(NAM3),
    wbUnknown(NAM4)
  ], False, nil, cpNormal, False, wbWATRAfterLoad);

  wbRecord(WEAP, 'Weapon', [
    wbEDIDReq,
    wbVMAD,
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
    wbUnknown(BIDS),
    wbUnknown(BAMT),
    wbKeywords,
    wbDESC,
    wbBIPL,
    wbSounds,
    wbRStruct('Shell Casing Model', [
      wbString(MOD2, 'Model Filename'),
      wbByteArray(MO2T, 'Texture Files Hashes', 0, cpIgnore),
      wbMO2S
    ], []),
    wbRStruct('Scope Model', [
      wbString(MOD3, 'Model Filename'),
      wbByteArray(MO3T, 'Texture Files Hashes', 0, cpIgnore),
      wbMO3S
    ], []),
    wbFormIDCK(EFSD, 'Scope Effect', [EFSH]),
    wbRStruct('World Model', [
      wbString(MOD4, 'Model Filename'),
      wbByteArray(MO4T, 'Texture Files Hashes', 0, cpIgnore),
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
    wbString(NNAM, 'Embedded Weapon Node'),

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
      {24} wbFloat('Unknown'),
      {28} wbFloat('Sight FOV'),
      {32} wbFloat,
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
      {43} wbInteger('Embedded Weapon - Actor Value', itU8, wbEnum([
        {00} 'Perception',
        {01} 'Endurance',
        {02} 'Left Attack',
        {03} 'Right Attack',
        {04} 'Left Mobility',
        {05} 'Right Mobilty',
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
        {0x00000800}'Long Burst',
        {0x00001000}'Scope has NightVision',
        {0x00002000}'Scope from Mod'
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
     wbByteArray('Unknown', 1),
     wbInteger('Reload Animation - Mod', itU8, wbReloadAnimEnum),
     wbByteArray('Unknown', 2),
     wbFloat('Regen Rate'),
     wbFloat('Kill Impulse'),
     wbFloat('Value B - Mod 1'),
     wbFloat('Value B - Mod 2'),
     wbFloat('Value B - Mod 3'),
     wbFloat('Impulse Dist'),
     wbInteger('Skill Req', itU32)
    ], cpNormal, True, nil, 36),

   wbStruct(CRDT, 'Critical Data', [
      {00} wbInteger('Critical Damage', itU16),
      {09} wbByteArray('Unknown', 2),
      {04} wbFloat('Crit % Mult'),
      {08} wbInteger('Flags', itU8, wbFlags([
        'On Death'
      ])),
      {09} wbByteArray('Unknown', 3),
      {12} wbFormIDCk('Effect', [SPEL, NULL])
    ], cpNormal, True),
    wbStruct(VATS, 'VATS', [
     wbFormIDCk('Effect',[SPEL, NULL]),
     wbFloat('Skill'),
     wbFloat('Dam. Mult'),
     wbFloat('AP'),
     wbInteger('Silent', itU8, wbEnum(['No', 'Yes'])),
     wbInteger('Mod Required', itU8, wbEnum(['No', 'Yes'])),
     wbByteArray('Unknown', 2)
    ]),
    wbInteger(VNAM, 'Sound Level', itU32, wbSoundLevelEnum, cpNormal, True),
    wbFormID(CNAM, 'Unknown')
  ], False, nil, cpNormal, False, wbWEAPAfterLoad);

  wbRecord(WRLD, 'Worldspace', [
    wbEDIDReq,
    wbRArray('Array RNAM', wbRStruct('Unknown', [
      wbUnknown(RNAM)
    ], [])),
    wbUnknown(MHDT),
    wbFULL,
    wbRStruct('Unknonw', [
      wbUnknown(WCTR),
      wbUnknown(LTMP)
    ], []),
    wbRStruct('XLCN XEZN', [
      wbFormIDCk(XLCN, 'Location', [LCTN, NULL]),
      wbFormIDCk(XEZN, 'Encounter Zone', [ECZN])
    ], []),
    wbRStruct('XEZN XLCN', [
      wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),
      wbFormIDCk(XLCN, 'Location', [LCTN, NULL])
    ], []),
    wbRStruct('Parent', [
      wbFormIDCk(WNAM, 'Worldspace', [WRLD]),
      wbStruct(PNAM, '', [
        wbInteger('Flags', itU16, wbFlags([
          {0x00000001}'Use Land Data',
          {0x00000002}'Use LOD Data',
          {0x00000004}'Use Map Data',
          {0x00000008}'Use Water Data',
          {0x00000010}'Use Climate Data',
          {0x00000020}'Use Image Space Data',
          {0x00000040}'Unknown 7',
          {0x00000080}'Unknown 8',
          {0x00000100}'Unknown 9',
          {0x00000200}'Unknown 10',
          {0x00000400}'Unknown 11',
          {0x00000800}'Unknown 12',
          {0x00001000}'Unknown 13',
          {0x00002000}'Unknown 14',
          {0x00004000}'Unknown 15',
          {0x00008000}'Unknown 16'
        ], True))
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
      wbStruct('Uable Dimensions', [
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
      wbFloat('World Map Scale'), // 'World Map Scale'
      wbFloat('Cell X Offset'), // 'Cell X Offset'
      wbFloat('Cell Y Offset'), // 'Cell Y Offset'
      wbFloat('Unknown')
    ], cpNormal, True),
    wbFormIDCk(INAM, 'Image Space', [IMGS]),
    wbFloat(NAMA, 'Unknown'),
    wbInteger(DATA, 'Flags', itU8, wbFlags([
      {0x01} 'Small World',
      {0x02} 'Can''t Fast Travel',
      {0x04} 'Unknown 3',
      {0x08} 'Unknown 4',
      {0x10} 'No LOD Water',
      {0x20} 'No LOD Noise',
      {0x40} 'Don''t Allow NPC Fall Damage',
      {0x80} 'Needs Water Adjustment'
    ]), cpNormal, True),
    wbRStruct('Object Bounds', [
      wbStruct(NAM0, 'Min', [
        wbFloat('X'),
        wbFloat('Y')
      ], cpNormal, True),
      wbStruct(NAM9, 'Max', [
        wbFloat('X'),
        wbFloat('Y')
      ], cpNormal, True)
    ], [], cpNormal, True),
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
    wbUnknown(TNAM),
    wbUnknown(UNAM),
    wbUnknown(XWEM),
    wbByteArray(OFST, 'Unknown', 0)
  ], False, nil, cpNormal, False, wbRemoveOFST);

  wbRecord(WTHR, 'Weather', [
    wbEDIDReq,
//    wbFormIDCk(_0_IAD, 'Sunrise Image Space Modifier', [IMAD]),
//    wbFormIDCk(_1_IAD, 'Day Image Space Modifier', [IMAD]),
//    wbFormIDCk(_2_IAD, 'Sunset Image Space Modifier', [IMAD]),
//    wbFormIDCk(_3_IAD, 'Night Image Space Modifier', [IMAD]),
//    wbFormIDCk(_4_IAD, 'Unknown', [IMAD]),
//    wbFormIDCk(_5_IAD, 'Unknown', [IMAD]),

    wbRUnion('Union', [
      wbRStruct('Dynamic Cloud Textures', [
        wbString(_00_0TX, 'Unknown'),
        wbString(_10_0TX, 'Unknown'),
        wbString(_20_0TX, 'Unknown'),
        wbString(_30_0TX, 'Unknown'),
        wbString(_40_0TX, 'Unknown'),
        wbString(_50_0TX, 'Unknown'),
        wbString(_60_0TX, 'Unknown'),
        wbString(_70_0TX, 'Unknown'),
        wbString(_80_0TX, 'Unknown'),
        wbString(_90_0TX, 'Unknown'),
        wbString(_3A_0TX, 'Unknown'),
        wbString(_3B_0TX, 'Unknown'),
        wbString(_3C_0TX, 'Unknown'),
        wbString(_3D_0TX, 'Unknown'),
        wbString(_3E_0TX, 'Unknown'),
        wbString(_3F_0TX, 'Unknown'),
        wbString(_40h_0TX, 'Unknown'),
        wbString(A0TX, 'Unknown'),
        wbString(B0TX, 'Unknown'),
        wbString(C0TX, 'Unknown'),
        wbString(D0TX, 'Unknown'),
        wbString(E0TX, 'Unknown'),
        wbString(F0TX, 'Unknown'),
        wbString(G0TX, 'Unknown'),
        wbString(H0TX, 'Unknown'),
        wbString(I0TX, 'Unknown'),
        wbString(J0TX, 'Unknown'),
        wbString(K0TX, 'Unknown'),
        wbString(L0TX, 'Unknown')
      ], [])
    ], []),

    wbString(DNAM, 'Cloud Textures - Layer 0', 0, cpNormal, True),
    wbString(CNAM, 'Cloud Textures - Layer 1', 0, cpNormal, True),
    wbString(ANAM, 'Cloud Textures - Layer 2', 0, cpNormal, True),
    wbString(BNAM, 'Cloud Textures - Layer 3', 0, cpNormal, True),
    wbUnknown(LNAM),
    wbFormIDCK(MNAM, 'Precipitation Type', [SPGD, NULL]),
    wbUnknown(NNAM),
//    wbArray(ONAM, 'Cloud Speed', wbInteger('Layer', itU8{, wbDiv(2550)}), 4, nil, nil, cpNormal, True),
    wbUnknown(ONAM),
    wbRArray('Unknown', wbRStruct('Unknown', [
      wbArray(RNAM, 'Unknown', wbByteArray('Unknown', 4), 0, nil, nil, cpNormal, True)
    ], [])),
    wbRArray('Unknown', wbRStruct('Unknown', [
      wbArray(QNAM, 'Unknown', wbByteArray('Unknown', 4), 0, nil, nil, cpNormal, True)
    ], [])),
    wbRArray('Unknown', wbRStruct('Unknown', [
      wbArray(PNAM, 'Unknown', wbByteArray('Unknown', 4), 0, nil, nil, cpNormal, True)
    ], [])),
//    wbByteArray(PNAM, 'Unknown', 0, cpIgnore),
//    wbRArray('Unknown - PNAM', wbRStruct('Unknown', [
//      wbArray(PNAM, 'Unknown', wbFormID('Unknown'), 0, nil, nil, cpNormal, True)
//    ], [])),
    wbRArray('Unknown', wbRStruct('Unknown', [
      wbArray(JNAM, 'Unknown', wbByteArray('Unknown', 4), 0, nil, nil, cpNormal, True)
    ], [])),
//    wbRArray('Unknown - PNAM', wbRStruct('Unknown', [
//      wbArray(JNAM, 'Unknown', wbFormID('Unknown'), 0, nil, nil, cpNormal, True)
//    ], [])),
//    wbUnknown(NAM0),
    wbArray(NAM0, 'Colors by Types/Times',
      wbArray('Type',
        wbStruct('Time', [
          wbInteger('Red', itU8),
          wbInteger('Green', itU8),
          wbInteger('Blue', itU8),
          wbByteArray('Unknown', 1)
        ]),
        ['Sunrise', 'Day', 'Sunset', 'Night']
      ),
      ['Unknown 1','Unknown 2','Unknown 3','Ambient','Unknown 5','Unknown 6',
      'Unknown 7','Unknown 8','Unknown 9','Unknown 10', 'Unknown 11', 'Unknown 12',
      'Unknown 13','Unknown 14','Unknown 15','Unknown 16','Unknown 17']
    , cpNormal, True),
    wbStruct(FNAM, 'Fog Distance', [
      wbFloat('Day - Near'),
      wbFloat('Day - Far'),
      wbFloat('Night - Near'),
      wbFloat('Night - Far'),
      wbFloat('Day - Power'),
      wbFloat('Night - Power'),
      wbFloat('Day - Max'),
      wbFloat('Night - Max')
    ], cpNormal, True),
//    wbByteArray(INAM, 'Unknown', 304, cpIgnore, True),
//    wbUnknown(INAM),
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
      ]),
      wbByteArray('Unknown', 4)
    ], cpNormal, True),
    wbUnknown(NAM1),
    wbRArray('Sounds',
      wbStruct(SNAM, 'Sound', [
        wbFormIDCK('Sound', [SNDR, NULL]),
        wbInteger('Type', itU32, wbEnum([
          {0x01} 'Default',
          {0x02} 'Precipitation',
          {0x04} 'Wind',
          {0x08} 'Thunder'
        ]))
      ])
    ),
    wbRArrayS('Texture Names', wbFormIDCk(TNAM, 'Texture Name', [STAT, NULL])),
    wbStruct(IMSP, 'Image Spaces', [
      wbFormIDCK('Sunrise', [IMGS, NULL]),
      wbFormIDCK('Day', [IMGS, NULL]),
      wbFormIDCK('Sunset', [IMGS, NULL]),
      wbFormIDCK('Night', [IMGS, NULL])
    ]),

  wbRArray('Directional Ambient Lightning Colors',
    wbStruct(DALC, 'In order by Day/Night/Sunrise/Sunset', [
      wbArray('Time of Day',
        wbStruct('Values For', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unknown', 1)
      ]), ['X+','X-','Y+','Y-','Z+', 'Z-', 'Specular']),
      wbFloat('Fresnel Power')
    ])
  ),

    wbUnknown(NAM2),
    wbUnknown(NAM3),
    wbMODL
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
    wbSounds,
    wbStruct(DATA, 'Data', [
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ])
  ]);

  wbRecord(ALOC, 'Media Location Controller', [
    wbEDIDReq,
    wbFULL,
    wbByteArray(NAM1, 'Flags and Enums, messily combined'),
    wbUnknown(NAM2),
    wbUnknown(NAM3),
    wbFloat(NAM4, 'Location Delay'),
    wbInteger(NAM5, 'Day Start', itU32, wbAlocTime),
    wbInteger(NAM6, 'Night Start', itU32, wbAlocTime),
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
    wbInteger(NAM1, 'Type', itU32, wbEnum([
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
    wbFloat(FNAM, 'Recovery Time (B) / Layer Crossfade Time (D,L) / Daytime Max (I)'),
    wbFloat(GNAM, 'Nighttime Max (I)'),
    wbFormIDCk(HNAM, 'Intro (B,D) / Daytime (I)', [SOUN]),
    wbFormIDCk(INAM, 'Outro (B,D) / Nighttime (I)', [SOUN]),
    wbUnknown(DATA)
  ]);

  wbRecord(AMEF, 'Ammo Effect', [
    wbEDIDReq,
    wbFULL,
    wbStruct(DATA, 'Data', [
      wbInteger('Type', itU32, wbEnum([
        'Damage Mod',
        'DR Mod',
        'DT Mod',
        'Spread Mod',
        'Weapon Condition Mod',
        'Fatigue Mod'
      ])),
      wbInteger('Operation', itU32, wbEnum([
        'Add',
        'Multiply',
        'Subtract'
      ])),
      wbFloat('Value')
    ])
  ]);
end;

procedure DefineTES5p;
begin
  wbRecord(CCRD, 'Caravan Card', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbSounds,
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
      wbInteger(INTV, 'Value', itU32, wbEnum([
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
    wbInteger(DATA, 'Value', itU32)
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
    wbStruct(DATA, 'Data', [
      wbInteger('Type', itU32, wbEnum([
        'Kill from a Form List',
        'Kill a specific FormID',
        'Kill any in a category',
        'Hit an Enemy',
        'Discover a Map Marker',
        'Use an Item',
        'Acquire an Item',
        'Use a Skill',
        'Do Damage',
        'Use an Item from a List',
        'Acquire an Item from a List',
        'Miscellaneous Stat'
      ])),
      wbInteger('Threshold', itU32),
      wbInteger('Flags', itU32, wbFlags([
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
    wbSounds
  ]);

  wbRecord(CMNY, 'Caravan Money', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbSounds,
    wbInteger(DATA, 'Absolute Value', itU32)
  ]);

  wbRecord(CSNO, 'Casino', [
    wbEDIDReq,
    wbFULL,
    wbStruct(DATA, 'Data', [
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
      wbInteger('Flags', itU32, wbFlags([
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
      wbFormIDCk('Actor Effect', [SPEL])
    ], cpNormal, True)
  ]);

  wbRecord(HUNG, 'Hunger Stage', [
    wbEDIDReq,
    wbStruct(DATA, '', [
      wbInteger('Trigger Threshold', itU32),
      wbFormIDCk('Actor Effect', [SPEL])
    ], cpNormal, True)
  ]);

  wbRecord(LSCT, 'Load Screen Type', [
    wbEDIDReq,
    wbStruct(DATA, 'Data', [
      wbInteger('Type', itU32, wbEnum([
        'None',
        'XP Progress',
        'Objective',
        'Tip',
        'Stats'
      ])),
      wbStruct('Data 1', [
        wbInteger('X', itU32),
        wbInteger('Y', itU32),
        wbInteger('Width', itU32),
        wbInteger('Height', itU32),
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
          'Left',
          'Center',
          '',
          'Right'
        ]))
      ]),
      wbByteArray('Unknown', 20),
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
end;

procedure DefineTES5q;
begin
  wbRecord(RCCT, 'Recipe Category', [
    wbEDIDReq,
    wbFULL,
    wbInteger(DATA, 'Flags', itU8, wbFlags([
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
    wbStruct(DATA, 'Data', [
      wbInteger('Skill', itS32, wbActorValueEnum),
      wbInteger('Level', itU32),
      wbFormIDCk('Category', [RCCT]),
      wbFormIDCk('Sub-Category', [RCCT])
    ]),
    wbRStructs('Ingredients', 'Ingredient', [
      wbFormIDCk(RCIL, 'Item', [ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, IMOD, CMNY, CCRD, LIGH], False, cpNormal, True),
      wbInteger(RCQY, 'Quantity', itU32, nil, cpNormal, True)
    ], []),
    wbRStructs('Outputs', 'Output', [
      wbFormIDCk(RCOD, 'Item', [ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, IMOD, CMNY, CCRD, LIGH], False, cpNormal, True),
      wbInteger(RCQY, 'Quantity', itU32, nil, cpNormal, True)
    ], [])
  ]);

  wbRecord(REPU, 'Reputation', [
    wbEDIDReq,
    wbFULL,
    wbICON,
    wbFloat(DATA, 'Value')
  ]);

  wbRecord(SLPD, 'Sleep Deprivation Stage', [
    wbEDIDReq,
    wbStruct(DATA, '', [
      wbInteger('Trigger Threshold', itU32),
      wbFormIDCk('Actor Effect', [SPEL])
    ], cpNormal, True)
  ]);

   wbAddGroupOrder(GMST);
   wbAddGroupOrder(KYWD);
   wbAddGroupOrder(LCRT);
   wbAddGroupOrder(AACT);
   wbAddGroupOrder(TXST);
   wbAddGroupOrder(GLOB);
   wbAddGroupOrder(CLAS);
   wbAddGroupOrder(FACT);
   wbAddGroupOrder(HDPT);
   wbAddGroupOrder(HAIR); {Empty}
   wbAddGroupOrder(EYES);
   wbAddGroupOrder(RACE);
   wbAddGroupOrder(SOUN);
   wbAddGroupOrder(ASPC);
   wbAddGroupOrder(MGEF);
   wbAddGroupOrder(SCPT); {Empty}
   wbAddGroupOrder(LTEX);
   wbAddGroupOrder(ENCH);
   wbAddGroupOrder(SPEL);
   wbAddGroupOrder(SCRL);
   wbAddGroupOrder(ACTI);
   wbAddGroupOrder(TACT);
   wbAddGroupOrder(ARMO);
   wbAddGroupOrder(BOOK);
   wbAddGroupOrder(CONT);
   wbAddGroupOrder(DOOR);
   wbAddGroupOrder(INGR);
   wbAddGroupOrder(LIGH);
   wbAddGroupOrder(MISC);
   wbAddGroupOrder(APPA);
   wbAddGroupOrder(STAT);
   wbAddGroupOrder(SCOL); {Empty}
   wbAddGroupOrder(MSTT);
   wbAddGroupOrder(PWAT); {Empty}
   wbAddGroupOrder(GRAS);
   wbAddGroupOrder(TREE);
   wbAddGroupOrder(CLDC); {Empty}
   wbAddGroupOrder(FLOR);
   wbAddGroupOrder(FURN);
   wbAddGroupOrder(WEAP);
   wbAddGroupOrder(AMMO);
   wbAddGroupOrder(NPC_);
   wbAddGroupOrder(LVLN);
   wbAddGroupOrder(KEYM);
   wbAddGroupOrder(ALCH);
   wbAddGroupOrder(IDLM);
   wbAddGroupOrder(COBJ);
   wbAddGroupOrder(PROJ);
   wbAddGroupOrder(HAZD);
   wbAddGroupOrder(SLGM);
   wbAddGroupOrder(LVLI);
   wbAddGroupOrder(WTHR);
   wbAddGroupOrder(CLMT);
   wbAddGroupOrder(SPGD);
   wbAddGroupOrder(RFCT);
   wbAddGroupOrder(REGN);
   wbAddGroupOrder(NAVI);
   wbAddGroupOrder(CELL);
   wbAddGroupOrder(WRLD);
   wbAddGroupOrder(DIAL);
   wbAddGroupOrder(QUST);
   wbAddGroupOrder(IDLE);
   wbAddGroupOrder(PACK); {Original Routine Crashes Dump}
   wbAddGroupOrder(CSTY);
   wbAddGroupOrder(LSCR);
   wbAddGroupOrder(LVSP);
   wbAddGroupOrder(ANIO);
   wbAddGroupOrder(WATR);
   wbAddGroupOrder(EFSH);
   wbAddGroupOrder(EXPL);
   wbAddGroupOrder(DEBR);
   wbAddGroupOrder(IMGS);
   wbAddGroupOrder(IMAD);
   wbAddGroupOrder(FLST);
   wbAddGroupOrder(PERK); {Original Routine Crashes Dump}
   wbAddGroupOrder(BPTD);
   wbAddGroupOrder(ADDN);
   wbAddGroupOrder(AVIF);
   wbAddGroupOrder(CAMS);
   wbAddGroupOrder(CPTH);
   wbAddGroupOrder(VTYP);
   wbAddGroupOrder(MATT);
   wbAddGroupOrder(IPCT);
   wbAddGroupOrder(IPDS);
   wbAddGroupOrder(ARMA);
   wbAddGroupOrder(ECZN);
   wbAddGroupOrder(LCTN);
   wbAddGroupOrder(MESG);
   wbAddGroupOrder(RGDL); {Empty}
   wbAddGroupOrder(DOBJ);
   wbAddGroupOrder(LGTM);
   wbAddGroupOrder(MUSC);
   wbAddGroupOrder(FSTP);
   wbAddGroupOrder(FSTS);
   wbAddGroupOrder(SMBN);
   wbAddGroupOrder(SMQN);
   wbAddGroupOrder(SMEN);
   wbAddGroupOrder(DLBR);
   wbAddGroupOrder(MUST);
   wbAddGroupOrder(DLVW);
   wbAddGroupOrder(WOOP);
   wbAddGroupOrder(SHOU);
   wbAddGroupOrder(EQUP);
   wbAddGroupOrder(RELA);
   wbAddGroupOrder(SCEN);
   wbAddGroupOrder(ASTP);
   wbAddGroupOrder(OTFT);
   wbAddGroupOrder(ARTO);
   wbAddGroupOrder(MATO);
   wbAddGroupOrder(MOVT);
//   wbAddGroupOrder(HAZD);
   wbAddGroupOrder(SNDR);
   wbAddGroupOrder(DUAL);
   wbAddGroupOrder(SNCT);
   wbAddGroupOrder(SOPM);
   wbAddGroupOrder(COLL);
   wbAddGroupOrder(CLFM);
   wbAddGroupOrder(REVB);
end;

procedure DefineTES5;
begin
  DefineTES5a;
  DefineTES5b;
  DefineTES5c;
  DefineTES5d;
  DefineTES5e;
  DefineTES5f;
  DefineTES5g;
  DefineTES5h;
  DefineTES5i;
  DefineTES5j;
  DefineTES5k;
  DefineTES5l;
  DefineTES5m;
  DefineTES5n;
  DefineTES5o;
  DefineTES5p;
  DefineTES5q;
end;

initialization
end.
