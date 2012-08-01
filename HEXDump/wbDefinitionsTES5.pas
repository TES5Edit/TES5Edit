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

//------------------------------------------------------------------------------
// In FO3/FNV/TES4/Edit wbBSA.pas was never in the wbDefinitions Files
//------------------------------------------------------------------------------
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
  ACHR : TwbSignature = 'ACHR';
  ACPR : TwbSignature = 'ACPR'; { New To Skyrim }
  ACRE : TwbSignature = 'ACRE';
  ACTI : TwbSignature = 'ACTI';
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
  BMDT : TwbSignature = 'BMDT';
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
  CREA : TwbSignature = 'CREA';
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
  NVNM : TwbSignature = 'NVNM'; { New to Skyrim }
  NVPP : TwbSignature = 'NVPP'; { New to Skyrim }
  NVTR : TwbSignature = 'NVTR';
  NVVX : TwbSignature = 'NVVX';
  OBND : TwbSignature = 'OBND';
  OCOR : TwbSignature = 'OCOR'; { New to Skyrim }
  OFST : TwbSignature = 'OFST';
  ONAM : TwbSignature = 'ONAM';
  OTFT : TwbSignature = 'OTFT';
  PACK : TwbSignature = 'PACK';
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
  SPOR : TwbSignature = 'SPOR'; { New to Skyrim }
  STAT : TwbSignature = 'STAT';
  STOL : TwbSignature = 'STOL'; { New to Skyrim }
  SWMV : TwbSignature = 'SWMV'; { New to Skyrim }
  TACT : TwbSignature = 'TACT';
  TCFU : TwbSignature = 'TCFU';
  TCLF : TwbSignature = 'TCLF';
  TCLT : TwbSignature = 'TCLT';
  TDUM : TwbSignature = 'TDUM';
  TERM : TwbSignature = 'TERM';
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
  XWCU : TwbSignature = 'XWCU'; { New To Skyrim }
  XXXX : TwbSignature = 'XXXX';
  YNAM : TwbSignature = 'YNAM';
  ZNAM : TwbSignature = 'ZNAM';

var
  wbPKDTSpecificFlagsUnused : Boolean;
  wbEDID: IwbSubRecordDef;
  wbEDIDReq: IwbSubRecordDef;
  wbSoulGemEnum: IwbEnumDef;
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
  wbCTDAOld: IwbSubRecordStructDef;
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
//-----------------------------------------------------------------------------
// New
  wbBoolU8: IwbIntegerDef;
  wbBoolU16: IwbIntegerDef;
  wbBoolU32: IwbIntegerDef;
  wbFULLFact: IwbSubRecordDef;
  wbScriptEntry: IwbStructDef;
  wbPropTypeEnum: IwbEnumDef;
  wbScriptObject: IwbStructDef;
  wbScriptFragments: IwbUnionDef;
  wbATKD: IwbSubRecordDef; {Attack Data}
  wbLLCT: IwbSubRecordDef;
  wbLVLD: IwbSubRecordDef;
  wbVMAD: IwbSubRecordDef;
  wbCOCT: IwbSubRecordDef;
  wbCOCTReq: IwbSubRecordDef;
  wbKWDAs: IwbSubRecordDef;
  wbKSIZ: IwbSubRecordDef;
  wbCNAM: IwbSubRecordDef;
  wbCITC: IwbSubRecordDef; {Associated with CTDA}
  wbPRKR: IwbSubRecordDef; {Perk Array Record}
  wbDNAMActor: IwbSubRecordDef;
  wbMGEFData: IwbSubRecordStructDef;
  wbMGEFType: IwbStructDef;
  wbRNAM: IwbSubRecordDef;
  wbSNAM: IwbSubRecordDef;
  wbQNAM: IwbSubRecordDef;
  wbMDOB: IwbSubRecordDef;
  wbSPIT: IwbSubRecordDef;
  wbSOPM_ONAM: IwbSubRecordStructDef;
  wbSNDD: IwbSubRecordUnionDef;
  wbCTDANew: IwbSubRecordStructDef;
  wbDMDSs: IwbSubRecordDef;
  wbMO5S: IwbSubRecordDef;
  wbDMDL: IwbSubRecordDef;
  wbSizeIndexEnum: IwbEnumDef;
  wbSPCT: IwbSubRecordDef;
  wbTintMasks: IwbSubRecordArrayDef;
  wbMODT: IwbSubRecordDef;
  wbDMDT: IwbSubRecordDef;
  wbCTDAParm1: IwbUnionDef;
// --- Pack ---
  wbPKDT: IwbSubRecordDef;
  wbPLDT: IwbSubRecordDef;
  wbPSDT: IwbSubRecordDef;
  wbPTDA: IwbSubRecordDef;
  wbIDLF: IwbSubRecordStructDef;
  wbPubPack: IwbSubRecordStructDef;
  wbProdTree: IwbSubRecordStructDef;
  wbINAM: IwbSubRecordDef;
  wbPDTOs: IwbSubRecordDef;
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

  if not Assigned(aElement) then
    Exit;

  if aElement.ElementType = etValue then
    Supports(aElement.Container, IwbContainerElementRef, Container)
  else
    Supports(aElement, IwbContainerElementRef, Container);

  if not Assigned(Container) then
    Exit;

  Param1 := Container.ElementByName['Quest'];

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
    ctToStr: begin
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


function wbIdleAnam(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr: begin
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
      else
        Result := '<Unknown: '+IntToStr(aInt)+'>';
      end;
    end;
    ctToSortKey: Result := Chr(aInt);
    ctCheck: begin
      case aInt of
        Ord('s'), Ord('l'), Ord('f'): Result := '';
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
    case Integer(ArchType) of
      01: Result := 2;//Script
      18: Result := 3;//Bound Item
      19: Result := 4;//Summon Creature
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
  Container.ElementNativeValues['..\Assoc. Item'] := 0;
  case Integer(aNewValue) of
    11: Container.ElementNativeValues['..\Actor Value'] := 48;//Invisibility
    12: Container.ElementNativeValues['..\Actor Value'] := 49;//Chameleon
    24: Container.ElementNativeValues['..\Actor Value'] := 47;//Paralysis
    36: Container.ElementNativeValues['..\Actor Value'] := 51;//Turbo
  else
    Container.ElementNativeValues['..\Actor Value'] := -1;
  end;
end;

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


//----------------------------------------------------------------------------
// 's': Added since GMST does contain strings however the strings are in the 
//      localization files.
//
//----------------------------------------------------------------------------
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
        's': Result := 0; {String}
        'i': Result := 1; {intS32}
        'f': Result := 2; {Float}
        'b': Result := 3; {Boolean}
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
  Result := True;
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
    if Integer(Container.ElementNativeValues['..\DATA\Entry Point\Function']) = 5 then
      Result := 5;
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
var
  Container     : IwbRecord;
begin
  Result := 0;
end;

function wbScriptFragmentsCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;
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
  wbCTDAFunctions : array[0..250] of TCTDAFunction = (
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
{New}(Index: 448; Name: 'CanFlyHere'; ParamType1: ptEncounterZone{Correct}),
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
    (Name: 'Absolute Value'; FunctionType: epfFloat; ParamType: epfpNone),
    (Name: 'Negative Absolute Value'; FunctionType: epfFloat; ParamType: epfpNone),
    (Name: 'Add Leveled List'; FunctionType: epfLeveledItem; ParamType: epfpLeveledItem),
    (Name: 'Add Activate Choice'; FunctionType: epfScript; ParamType: epfpScript)
  );

  wbPERKEntryPoints : array[0..73] of TPERKEntryPoint = (
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
{36}(Name: 'Modify Enemy Critical Hit Chance'; Condition: epcWeaponTarget),
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
  EntryPointVar := Container.ElementNativeValues['..\..\..\DATA\Entry Point\Entry Point'];
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
  EntryPointVar := Container.ElementNativeValues['..\Entry Point'];
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
  FunctionTypeVar := Container.ElementNativeValues['..\..\DATA\Entry Point\Function'];
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
      Container.ElementNativeValues['DATA - Data\Actor Value'] := NewActorValue;
  finally
    wbEndInternalEdit;
  end;
end;

{ Not called, needs revision }
procedure wbPACKAfterLoad(const aElement: IwbElement);
var
  Container     : IwbContainerElementRef;
  MainRecord    : IwbMainRecord;
  OldContainer  : IwbContainerElementRef;
  NewContainer  : IwbContainerElementRef;
  //NewContainer2 : IwbContainerElementRef;
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

    if Supports(Container.RemoveElement('PLD2'), IwbContainerElementRef, OldContainer) then begin
      if not Supports(Container.Add('Locations'), IwbContainerElementRef, NewContainer) then
        Assert(False);
      NewContainer.RemoveElement('PLD2');
      NewContainer.AddElement(OldContainer);
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

function wbPxDTLocationDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
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
  wbCOCT := wbInteger(COCT, 'Count', itU32);
  wbCITC := wbInteger(CITC, 'Count', itU32);
  wbLVLD := wbInteger(LVLD, 'Chance none', itU8, nil, cpNormal, True);
  wbCOCTReq := wbInteger(COCT, 'Count', itU32, nil, cpNormal, True);
  wbKWDAs := wbArrayS(KWDA, 'Keywords', wbFormID('Keyword'), 0, cpNormal, True);
  wbKSIZ := wbInteger(KSIZ, 'Keywords Count', itU32);
  wbDMDL := wbString(DMDL, 'Model Filename');
  wbSNAM := wbFormIDCk(SNAM, 'Sound - Open', [SOUN]);
  wbQNAM := wbFormIDCk(QNAM, 'Sound - Close', [SOUN]);
  wbMDOB := wbFormID(MDOB, 'Menu Display Object', cpNormal, False);
  wbCNAM := wbStruct(CNAM, 'Linked Reference Color', [
             wbStruct('Link Start Color', [
               wbInteger('Red', itU8),
               wbInteger('Green', itU8),
               wbInteger('Blue', itU8),
               wbByteArray('Unnknown', 1)
             ])
           ]);
	wbMODT := wbStruct(MODT, 'Texture Files Hashes', [
							wbByteArray('Unknown')
						], cpIgnore, False, wbNeverShow);

	wbDMDT := wbStruct(DMDT, 'Texture Files Hashes', [
							wbByteArray('Unknown')
						], cpIgnore, False, wbNeverShow);

  wbDODT := wbStruct(DODT, 'Decal Data', [
							wbByteArray('Unknown')
						], cpIgnore, False, wbNeverShow);

  wbDNAMActor := wbStruct(DNAM, 'Player Skills', [
							wbByteArray('Unknown')
						], cpIgnore, False, wbNeverShow);

  wbSPCT := wbByteArray(SPCT, 'Spell Count');

//-----------------------------------------------------------------
// End New Routines
//-----------------------------------------------------------------

  wbRecordFlags := wbInteger('Record Flags', itU32, wbFlags([
    {0x00000001}'ESM',
    {0x00000002}'Unknown 2',
    {0x00000004}'Unknown 3',
    {0x00000008}'Unknown 4',
    {0x00000010}'Unknown 5',
    {0x00000020}'Deleted',
    {0x00000040}'Unknown 7',
    {0x00000080}'(TES4) Localized',
    {0x00000100}'Unknown 9',
    {0x00000200}'Hidden from local map / Starts dead',
    {0x00000400}'Quest item / Persistent reference / (LSCR) Displays in Main Menu',
    {0x00000800}'Initialy disabled',
    {0x00001000}'Ignored',
    {0x00002000}'Unknown 14',
    {0x00004000}'Unknown 15',
    {0x00008000}'Unknown 16',
    {0x00010000}'Unknown 17',
    {0x00020000}'Unknown 18',
    {0x00040000}'Unknown 19',
    {0x00080000}'VWD',
    {0x00100000}'Unknown 21',
    {0x00200000}'Dangerous / Off limits',
    {0x00400000}'Compressed',
    {0x00800000}'Can''t wait',
    {0x01000000}'Unknown 25',
    {0x02000000}'Unknown 26',
    {0x03000000}'Unknown 27',
    {0x08000000}'Unknown 28',
    {0x10000000}'Unknown 29',
    {0x20000000}'Unknown 30',
    {0x40000000}'Unknown 31',
    {0x80000000}'Unknown 32'
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
     'Silent'
    ]);

  wbWeaponAnimTypeEnum := wbEnum([
    {00} 'Hand to Hand',
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

  wbEDID := wbString(EDID, 'Editor ID');
  wbEDIDReq := wbString(EDID, 'Editor ID');
  wbFULL := wbLString(FULL, 'Name');
  wbFULLActor := wbLString(FULL, 'Name');
  wbFULLReq := wbLString(FULL, 'Name');
  wbDESC := wbLString(DESC, 'Description');
  wbDESCReq := wbLString(DESC, 'Description');
  wbXSCL := wbByteArray(XSCL, 'Scale');

  wbOBND := wbArray(OBND, 'Object Bounds', wbStruct('Corner', [
    wbInteger('X1', itS16),
    wbInteger('Y1', itS16),
    wbInteger('Z1', itS16),
    wbInteger('X2', itS16),
    wbInteger('Y2', itS16),
    wbInteger('Z2', itS16)
  ]));

  wbOBNDReq := wbArray(OBND, 'Object Bounds', wbStruct('Corner', [
    wbInteger('X1', itS16),
    wbInteger('Y1', itS16),
    wbInteger('Z1', itS16),
    wbInteger('X2', itS16),
    wbInteger('Y2', itS16),
    wbInteger('Z2', itS16)
  ]), 1, nil, nil, cpNormal, True);

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
    wbInteger('unknown', itU8),
    //wbInteger('propertyCount', itU16),
    wbArray('Properties', wbStruct('Property', [
      wbLenString('propertyName', 2),
      wbInteger('propertyType', itU8, wbPropTypeEnum),
      wbInteger('Unknown', itU8),
      wbUnion('Value', wbScriptPropertyDecider, [
        {00} wbStruct('Data', [wbUnknown]),
        {01} wbByteArray('Data', 8), {wbScriptObject,}
        {02} wbLenString('Data', 2),
        {03} wbInteger('Data', itU32),
        {04} wbByteArray('Data', 4),
        {05} wbInteger('Data', itU8),
        {11} wbArray('Data', wbByteArray('Element', 8), -1),
        {12} wbArray('Data', wbLenString('Element', 2), -1),
        {13} wbArray('Data', wbInteger('Element', itU32), -1),
        {14} wbArray('Data', wbByteArray('Element', 4), -1),
        {15} wbArray('Data', wbInteger('Element', itU8), -1)
      ])
    ]), -2)
  ]);

  wbScriptFragments := wbUnion('Fragments', wbScriptFragmentDecider, [
    // 00 None
    wbByteArray('Unknown'),
    // 01 QUST Fragments
    wbStruct('Data', [
      wbInteger('Unknown', itS8),
      wbInteger('fragmentCount', itU16),
      wbLenString('fileName', 2),
      wbArray('fragments', wbStruct('fragment', [
        wbInteger('Quest Stage Index', itU16),
        wbInteger('Unknown', itS16),
        wbInteger('Unknown', itS32),
        wbInteger('Unknown', itS8),
        wbLenString('scriptName', 2),
        wbLenString('fragmentName', 2)
      ]), [], wbScriptFragmentsCounter),
      wbArray('Aliases', wbStruct('Alias', [
        wbInteger('Unknown', itS16),
        wbInteger('AliasID', itU16),
        wbInteger('Unknown', itS32),
        wbInteger('Unknown', itS16),
        wbInteger('objFormat', itS16),
        wbArray('Scripts', wbScriptEntry, -2)
      ]), -2)
    ])
  ]);

  wbVMAD := wbStruct(VMAD, 'Papyrus Script Data', [
    wbInteger('version', itS16),
    wbInteger('objFormat', itS16),
    //wbInteger('scriptCount', itU16),
    wbArray('Scripts', wbScriptEntry, -2),
    wbArray('Fragments', wbUnknown)
    //wbScriptFragments
  ]);

  wbATKD := wbByteArray(ATKD, 'Attack Data');

  wbPRKR := wbByteArray(PRKR, 'Perk Record');

  wbREPL := wbFormIDCkNoReach(REPL, 'Repair List', [FLST]);
  wbEITM := wbFormIDCk(EITM, 'Object Effect', [ENCH, SPEL]);
  wbBIPL := wbFormIDCk(BIPL, 'Biped Model List', [FLST]);

  wbCOED := wbByteArray(COED, 'Extra Data');

  wbYNAM := wbFormIDCk(YNAM, 'Sound - Pick Up', [SOUN]);
  wbZNAM := wbFormIDCk(ZNAM, 'Sound - Drop', [SOUN]);

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

  wbMO2S := wbByteArray(MO2S, 'Alternate Textures');
	
  wbMO3S := wbByteArray(MO3S, 'Alternate Textures');
	
  wbMO4S := wbByteArray(MO4S, 'Alternate Textures');
	
  wbMO5S := wbByteArray(MO5S, 'Alternate Textures');

  wbMOSD := wbByteArray(MOSD, 'FaceGen Model Flags');

  wbMODS := wbByteArray(MODS, 'Alternate Textures');

  wbMODD := wbByteArray(MODD, 'FaceGen Model Flags');

//------------------------------------------------------------------------------
// wbMODL MODL, MODB, MODT, MODS, MODD
//------------------------------------------------------------------------------
  wbMODL :=
    wbRStruct('Model', [
      wbString(MODL, 'Model Filename'),
      wbByteArray(MODB, 'Unknown'),
      wbByteArray(MODT, 'Texture Files Hashes'),
      wbMODS,
      wbMODD
    ], []);

  wbMODLActor :=
    wbRStruct('Model', [
      wbString(MODL, 'Model Filename'),
      wbByteArray(MODB, 'Unknown'),
      wbByteArray(MODT, 'Texture Files Hashes'),
      wbMODS,
      wbMODD
    ], []);

  wbMODLReq :=
    wbRStruct('Model', [
      wbString(MODL, 'Model Filename'),
      wbByteArray(MODB, 'Unknown'),
      wbByteArray(MODT, 'Texture Files Hashes'),
      wbMODS,
      wbMODD
    ], []);

  wbDMDSs := wbByteArray(DMDS, 'Alternate Textures');

//------------------------------------------------------------------------------
// wbDEST DEST, DSTD, DMDL, DMDT, DMDS, DSTF
//------------------------------------------------------------------------------
  wbDEST := wbRStruct('Destructable', [
    wbByteArray(DEST, 'Header'),
    wbRArray('Stages',  // Begin Stage Array
      wbRStruct('Stage', [ // Begin Stage RStruct
        wbByteArray(DSTD, 'Destruction Stage Data'),
        wbRStruct('Model', [ 
          wbString(DMDL, 'Model Filename'),
          wbDMDT,
          wbDMDSs
        ], []), // End DMDL
        wbByteArray(DSTF, 'End Marker')
      ], []) // Begin Stage RStruct
    ) // End Stage Array
  ], []);

  wbDESTActor  := wbRStruct('Destructable', [
    wbByteArray(DEST, 'Header'),
    wbRArray('Stages',  // Begin Stage Array
      wbRStruct('Stage', [ // Begin Stage RStruct
        wbByteArray(DSTD, 'Destruction Stage Data'),
        wbRStruct('Model', [ 
          wbString(DMDL, 'Model Filename'),
          wbDMDT,
          wbDMDSs
        ], []), // End DMDL
        wbByteArray(DSTF, 'End Marker')
      ], []) // Begin Stage RStruct
    ) // End Stage Array
  ], []);

  wbSCRI := wbFormIDCk(SCRI, 'Script', [SCPT]);
  wbSCRIActor := wbFormIDCk(SCRI, 'Script', [SCPT], False, cpNormal, False, wbActorTemplateUseScript);
  wbENAM := wbFormIDCk(ENAM, 'Object Effect', [ENCH]);

  wbXLOD := wbByteArray(XLOD, 'Distant LOD Data');

  wbXESP := wbByteArray(XESP, 'Enable Parent');

  wbSCHRReq := wbByteArray(SCHR, 'Basic Script Data');

  wbSCROs := 
    wbRArray('References',
      wbRUnion('', [
        wbFormIDCk(SCRO, 'Global Reference',
          [ACTI, DOOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, IMAD,
           BOOK, KEYM, ALCH, LIGH, QUST, PLYR, PACK, LVLI, ECZN, EXPL, FLST, IDLM, PMIS,
           FACT, ACHR, REFR, ACRE, GLOB, DIAL, CELL, SOUN, MGEF, WTHR, CLAS, EFSH, RACE,
           LVLC, CSTY, WRLD, SCPT, IMGS, MESG, MSTT, MUSC, NOTE, PERK, PGRE, PROJ, LVLN,
           WATR, ENCH, TREE, REPU, REGN, CSNO, CHAL, IMOD, RCCT, CMNY, CDCK, CHIP, CCRD,
           NULL]),
        wbByteArray(SCRV, 'Local Variable')
      ], [])
    );

  wbSLSD := wbByteArray(SLSD, 'Local Variable Data');

  wbEmbeddedScript := wbRStruct('Embedded Script', [
    wbSCHRReq,
    wbByteArray(SCDA, 'Compiled Embedded Script'),
    wbStringScript(SCTX, 'Embedded Script Source'),
    wbRArrayS('Local Variables', wbRStructSK([0], 'Local Variable', [
      wbSLSD,
      wbString(SCVR, 'Name')
    ], [])),
    wbSCROs
  ], []);

  wbEmbeddedScriptPerk := wbRStruct('Embedded Script', [
    wbSCHRReq,
    wbByteArray(SCDA, 'Compiled Embedded Script'),
    wbStringScript(SCTX, 'Embedded Script Source'),
    wbRArrayS('Local Variables', wbRStructSK([0], 'Local Variable', [
      wbSLSD,
      wbString(SCVR, 'Name')
    ], [])),
    wbSCROs
  ], []);

  wbEmbeddedScriptReq := wbRStruct('Embedded Script', [
    wbSCHRReq,
    wbByteArray(SCDA, 'Compiled Embedded Script'),
    wbStringScript(SCTX, 'Embedded Script Source'),
    wbRArrayS('Local Variables', wbRStructSK([0], 'Local Variable', [
      wbSLSD,
      wbString(SCVR, 'Name')
    ], [])),
    wbSCROs
  ], []);

  wbXLCM := wbByteArray(XLCM, 'Level Modifier');
  wbXOWN := wbFormIDCkNoReach(XOWN, 'Owner', [FACT, ACHR, NPC_]);
  wbXGLB := wbFormIDCk(XGLB, 'Global variable', [GLOB]);

//------------------------------------------------------------------------------
// Begin ACHR
//------------------------------------------------------------------------------
  wbRecord(ACHR, 'Placed NPC', [
    wbEDID,
    wbVMAD,
    wbFormIDCk(NAME, 'Base', [NPC_], False, cpNormal, True),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),
    wbXRGD,
    wbXRGB,

    {--- Patrol Data ---}
    wbRStruct('Patrol Data', [
      wbByteArray(XPRD, 'Idle Time', 4),
      wbByteArray(XPPA, 'Patrol Script Marker'),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL]),
      wbFormIDCk(TNAM, 'Topic', [DIAL, NULL])
    ], []),

    {--- Leveled Actor ----}
    wbXLCM,

    {--- Merchant Container ----}
    wbFormIDCk(XMRC, 'Merchant Container', [REFR], True),

    {--- Extra ---}
    wbByteArray(XCNT, 'Count'),
    wbByteArray(XRDS, 'Radius'),
    wbByteArray(XHLP, 'Health'),

    {--- Decals ---}
    wbRArrayS('Linked Decals',
      wbByteArray(XDCR, 'Decal')
    ),

	  {--- Activate Parents ---}
		wbRUnion('Union', [
      wbRStruct('XLKR XAPD XAPR', [
        wbArrayS(XLKR, 'Linked References', wbFormIDCk('Linked Reference', [REFR, ACRE, ACHR, PGRE, PMIS]), 0, cpNormal, False),
				wbRStruct('Activate Parents', [
					wbByteArray(XAPD, 'Flags'),
					wbRArrayS('Activate Parent Refs',
						wbByteArray(XAPR, 'Activate Parent Ref')
					)
				], [])
      ], []),
      wbRStruct('XAPD XAPR XLKR', [
				wbRStruct('Activate Parents', [
					wbByteArray(XAPD, 'Flags'),
					wbRArrayS('Activate Parent Refs',
						wbByteArray(XAPR, 'Activate Parent Ref')
					)
				], []),
        wbArrayS(XLKR, 'Linked References', wbFormIDCk('Linked Reference', [REFR, ACRE, ACHR, PGRE, PMIS]))
      ], [])
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

		wbUnknown(XLCN),
		wbUnknown(XLRT),

    wbString(XATO, 'Activation Prompt'),

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
  ], wbAllowUnordered);
//------------------------------------------------------------------------------
// End ACHR
//------------------------------------------------------------------------------

  wbRecord(ACRE, 'Placed Creature', [
    wbEDID,
    wbFormIDCk(NAME, 'Base', [CREA], False, cpNormal, True),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),

    wbXRGD,
    wbXRGB,

    {--- Patrol Data ---}
    wbRStruct('Patrol Data', [
      wbByteArray(XPRD, 'Idle Time'),
      wbByteArray(XPPA, 'Patrol Script Marker'),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, 'Topic', [DIAL, NULL], False, cpNormal, True)
    ], []),

    {--- Leveled Actor ----}
    wbXLCM,

    {--- Ownership ---}
    wbRStruct('Ownership', [
      wbXOWN,
      wbByteArray(XRNK, 'Faction rank')
    ], [XCMT, XCMO]),

    {--- Merchant Container ----}
    wbFormIDCk(XMRC, 'Merchant Container', [REFR], True),

    {--- Extra ---}
    wbInteger(XCNT, 'Count', itS32),
    wbByteArray(XRDS, 'Radius'),
    wbByteArray(XHLP, 'Health'),

    {--- Decals ---}
    wbRArrayS('Linked Decals',
      wbByteArray(XDCR, 'Decal')
    ),

    {--- Linked Ref ---}
    wbFormIDCk(XLKR, 'Linked Reference', [REFR, ACRE, ACHR, PGRE, PMIS]),
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

    {--- Activate Parents ---}
    wbRStruct('Activate Parents', [
      wbByteArray(XAPD, 'Flags'),
      wbRArrayS('Activate Parent Refs',
        wbByteArray(XAPR, 'Activate Parent Ref')
			)
    ], []),

    wbString(XATO, 'Activation Prompt'),

    {--- Enable Parent ---}
    wbXESP,

    {--- Emittance ---}
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),

    {--- Flags ---}
    wbByteArray(XIBS, 'Ignored By Sandbox'),

    {--- 3D Data ---}
    wbXSCL,
    wbDATAPosRot
  ], wbAllowUnordered);

  wbRecord(ACTI, 'Activator', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbSCRI,
    wbDEST,
    wbKSIZ,
    wbKWDAs,
    wbByteArray(PNAM, 'Unknown'),
    wbFormIDCk(SNAM, 'Sound - Looping', [SOUN]),
    wbFormIDCk(VNAM, 'Sound - Activation', [SOUN]),
    wbFormIDCk(INAM, 'Radio Template', [SOUN]),
    wbFormIDCk(RNAM, 'Radio Station', [TACT]),
    wbFormIDCk(WNAM, 'Water Type', [WATR]),
    wbByteArray(FNAM, 'Unknown'),
    wbFormID(KNAM, 'Unknown'),
    wbString(XATO, 'Activation Prompt')
  ], wbAllowUnordered);

  wbICON := wbRStruct('Icon', [
    wbString(ICON, 'Large Icon filename'),
    wbString(MICO, 'Small Icon filename')
  ], []);

  wbICONReq := wbRStruct('Icon', [
    wbString(ICON, 'Large Icon filename'),
    wbString(MICO, 'Small Icon filename')
  ], []);

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
        {00} 'Aggresion',
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
        {33} 'Big Guns (obsolete)',
        {34} 'Energy Weapons',
        {35} 'Explosives',
        {36} 'Lockpick',
        {37} 'Medicine',
        {38} 'Melee Weapons',
        {39} 'Repair',
        {40} 'Science',
        {41} 'Guns',
        {42} 'Sneak',
        {43} 'Speech',
        {44} 'Survival',
        {45} 'Unarmed',
        {46} 'Inventory Weight',
        {47} 'Paralysis',
        {48} 'Invisibility',
        {49} 'Chameleon',
        {50} 'Night Eye',
        {51} 'Turbo',
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
        {72} 'Ignore Crippled Limbs',
        {73} 'Dehydration',
        {74} 'Hunger',
        {75} 'Sleep Deprivation',
        {76} 'Damage Threshold'
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
        {11} 'Stimpack',
        {12} 'Food',
        {13} 'Alcohol'
      ], [
        -1, 'None'
      ]);

  wbETYP := wbByteArray(ETYP, 'Equiptment Type');
  wbETYPReq := wbByteArray(ETYP, 'Equiptment Type');

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

procedure DefineTES5b;
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

  wbAxisEnum :=
    wbEnum([], [
      88, 'X',
      89, 'Y',
      90, 'Z'
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

  wbEFIT := wbByteArray(EFIT, 'Effect');

  wbCTDANew :=
    wbRStruct('Conditions', [
			wbByteArray(CTDA, 'Condition'),
	    wbString(CIS2, 'Unknown'),
  		wbString(CIS1, 'Unknown')
    ], []);

  wbCTDAs := wbRArray('Conditions', wbCTDANew, cpNormal, False);
  wbCTDAsReq := wbRArray('Conditions', wbCTDANew, cpNormal, True);

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
    ], []);

  wbRecord(ALCH, 'Ingestible', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULLReq,
    wbKSIZ,
    wbKWDAs,
    wbDESCReq,
    wbMODL,
    wbYNAM,
    wbZNAM,
    wbByteArray(DATA, 'Weight', 4),
    wbByteArray(ENIT, 'Effect Data'),
    wbEffectsReq
  ], wbAllowUnordered);

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
    wbDESC,
    wbKSIZ,
    wbKWDAs,
    wbByteArray(DATA, 'Data'),
    wbByteArray(DAT2, 'Data 2'),
    wbString(ONAM, 'Short Name'),
    wbString(QNAM, 'Abbrev.'),
    wbRArray('Ammo Effects',
      wbFormIDCk(RCIL, 'Effect', [AMEF])
    )
  ], wbAllowUnordered);

  wbRecord(ANIO, 'Animated Object', [
    wbEDIDReq,
    wbMODLReq,
    wbString(BNAM, 'Type', 0, cpNormal, True),
    wbFormIDCk(DATA, 'Animation', [IDLE], False, cpNormal, True)
  ], wbAllowUnordered);

  wbBMDT := wbByteArray(BMDT, 'Biped Data');

  wbRecord(ARMO, 'Armor', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbSCRI,
    wbEITM,
    wbBMDT,
    wbRStruct('Male biped model', [
      wbString(MODL, 'Model Filename'),
      wbByteArray(MODT, 'Texture Files Hashes'),
      wbMODS,
      wbMODD
    ], []),
    wbRStruct('Male world model', [
      wbString(MOD2, 'Model Filename'),
      wbByteArray(MO2T, 'Texture Files Hashes'),
      wbMO2S
    ], []),
    wbString(ICON, 'Male icon filename'),
    wbString(MICO, 'Male mico filename'),
    wbRStruct('Female biped model', [
      wbString(MOD3, 'Model Filename'),
      wbByteArray(MO3T, 'Texture Files Hashes'),
      wbMO3S,
      wbMOSD
    ], [], cpNormal, False, nil, True),
    wbRStruct('Female world model', [
      wbString(MOD4, 'Model Filename'),
      wbByteArray(MO4T, 'Texture Files Hashes'),
      wbMO4S
    ], []),
    wbByteArray(BODT, 'Unknown'),
    wbString(ICO2, 'Female icon filename'),
    wbString(MIC2, 'Female mico filename'),
    wbString(BMCT, 'Ragdoll Constraint Template'),
    wbREPL,
    wbBIPL,
    wbETYPReq,
    wbByteArray(BIDS, 'Unknown'),
    wbByteArray(BAMT, 'Unknown'),
    wbYNAM,
    wbZNAM,
    wbByteArray(RNAM, 'Unknown'),
    wbKSIZ,
    wbKWDAs,
    wbDESC,
    wbRArray('Unknown - MODL', wbRStruct('Unknown', [
      wbFormIDCK(MODL, 'Model Filename', [ARMA, NULL])
    ], [])),
    wbByteArray(DATA, 'Data'),
    wbByteArray(DNAM, 'Unknown'),
    wbByteArray(BNAM, 'Overrides Animation Sounds'),
    wbByteArray(SNAM, 'Animation Sound'),
    wbFormIDCk(TNAM, 'Anmation Sounds Template', [ARMO])
  ], wbAllowUnordered);

  wbRecord(ARMA, 'Armor Addon', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbBMDT,
    wbRStruct('Male biped model', [
      wbString(MODL, 'Model Filename'),
      wbByteArray(MODT, 'Texture Files Hashes'),
      wbMODS,
      wbMODD
    ], [], cpNormal, False, nil, True),
    wbByteArray(BODT, 'Unknown'),
    wbByteArray(RNAM, 'Unknown'),
    wbByteArray(DNAM, 'Unknown'),
    wbRStruct('Male world model', [
      wbString(MOD2, 'Model Filename'),
      wbByteArray(MO2T, 'Texture Files Hashes', 0, cpIgnore),
      wbMO2S
    ], []),
    wbString(ICON, 'Male icon filename'),
    wbString(MICO, 'Male mico filename'),
    wbRStruct('Female biped model', [
      wbString(MOD3, 'Model Filename'),
      wbByteArray(MO3T, 'Texture Files Hashes', 0, cpIgnore),
      wbMO3S,
      wbMOSD
    ], [], cpNormal, False, nil, True),
    wbRStruct('Female world model', [
      wbString(MOD4, 'Model Filename'),
      wbByteArray(MO4T, 'Texture Files Hashes', 0, cpIgnore),
      wbMO4S
    ], []),
    wbRStruct('Unknown world model', [
      wbString(MOD5, 'Model Filename'),
      wbByteArray(MO5T, 'Texture Files Hashes', 0, cpIgnore),
      wbMO5S
    ], []),
    wbFormIDCK(NAM0, 'Male', [TXST, NULL]),
    wbFormIDCK(NAM1, 'Female', [TXST, NULL]),
    wbFormIDCK(NAM2, 'Male 1st Person', [FLST, NULL]),
    wbFormIDCK(NAM3, 'Female 1st Person', [FLST, NULL]),
    wbRArray('Unknown - MODL', wbRStruct('Unknown', [
      wbFormIDCK(MODL, 'Model Filename', [RACE, NULL])
    ], [])),
    wbFormIDCK(SNDD, 'Footstep Sound', [FSTS, NULL]),
    wbString(ICO2, 'Female icon filename'),
    wbString(MIC2, 'Female mico filename'),
    wbETYPReq,
    wbByteArray(DATA, 'Data')
  ], wbAllowUnordered);

  wbRecord(BOOK, 'Book', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbDESCReq,
    wbFormID(YNAM, 'Unknown'),
    wbKSIZ,
    wbKWDAs,
    wbByteArray(DATA, 'Data'),
    wbFormID(INAM, 'Unknown'),
    wbByteArray(CNAM, 'Unknown')
  ], wbAllowUnordered);

  wbSPLO := wbFormIDCk(SPLO, 'Actor Effect', [SPEL]);
  wbSPLOs := wbRArrayS('Actor Effects', wbSPLO, cpNormal, False, nil, nil, wbActorTemplateUseActorEffectList);

//------------------------------------------------------------------------------
// Begin CELL
//------------------------------------------------------------------------------
// Pattern  1:           DATA      XCLC           LTMP XCLW                                         XCMO                          XCAS
// Pattern  2:           DATA      XCLC TVDT      LTMP XCLW
// Pattern  3:           DATA      XCLC TVDT MHDT LTMP XCLW XCLR
// Pattern  4:           DATA      XCLC           LTMP XCLW
// Pattern  5: EDID      DATA      XCLC TVDT MHDT LTMP XCLW XCLR      XLCN
// Pattern  6: EDID FULL DATA XCLL                LTMP XCLW      XCIM XLCN                          XCMO           XEZN           XCAS
// Pattern  7: EDID FULL DATA XCLL                LTMP XCLW      XCIM XLCN                          XCMO XCCM      XCAS XWEM XEZN
// Pattern  8: EDID FULL DATA XCLL                LTMP XCLW      XCIM XLCN                          XCMO                          XCAS
// Pattern  9: EDID FULL DATA XCLL                LTMP XCLW           XLCN XCIM      XOWN           XCMO XCCM XILL                XCAS
// Pattern 10: EDID FULL DATA XCLL                LTMP XCLW      XCIM XLCN                                         XEZN XWEM XCMO XCAS
// Pattern 11: EDID FULL DATA XCLL                LTMP XCLW      XCIM XLCN                          XCMO                XWEM XOWN
// Pattern 12: EDID FULL DATA XCLL                LTMP XCLW           XLCN XCIM           XCWT XCCM XCMO           XEZN XWEM XCAS
// Pattern 13: EDID FULL DATA XCLL                LTMP XCLW      XCIM XLCN                                    XEZN XCMO XWEM XCAS
// Pattern 14: EDID FULL DATA XCLL                LTMP XCLW      XCIM XLCN                                    XEZN XCMO XWEM XCCM XCAS
// Pattern 15: EDID FULL DATA XCLL                LTMP XCLW           XLCN XCMO XCIM                          XCCM XCWT XWEM XOWN XCAS
// Pattern 16: EDID FULL DATA XCLL                LTMP XCLW           XLCN XCIM                                    XEZN XWEM           [When XIS2 is present]
// Pattern 17: EDID FULL DATA XCLL                LTMP XCLW      XCIM XLCN                               XCAS XEZN XCMO XWEM
// Pattern 18: EDID FULL DATA XCLL                LTMP XCLW      XCIM XLCN                          XCMO XEZN XCAS XCCM XWEM
// Pattern 19:
// Pattern 20:
// Pattern 21:
// Pattern 22:
// Pattern 23:
// Pattern 24:
// Pattern 25:
// Pattern 26:
// Pattern 27:
// Pattern 28:
// Pattern 29:
// Pattern 30:
//------------------------------------------------------------------------------
  wbRecord(CELL, 'Cell', [
// EDID
    wbEDID,
// FULL
    wbFULL,
// DATA
    wbByteArray(DATA, 'Flags'),
// XCLC Not sure which should go first
    wbByteArray(XCLC, 'Grid'),
    wbByteArray(XCLL, 'Lighting'),
    wbByteArray(IMPF, 'Footstep Materials'),
// TVDT
		wbUnknown(TVDT),
// MHDT
		wbUnknown(MHDT),
// LTMP
    wbRStruct('Light Template', [
      wbFormIDCk(LTMP, 'Template', [LGTM, NULL]),
      wbByteArray(LNAM, 'Inherit')
    ], [], cpNormal, True ),
// XCLW
    wbByteArray(XCLW, 'Water Height', 4),
    wbString(XNAM, 'Water Noise Texture'),
// XCLR
    wbArrayS(XCLR, 'Regions', wbFormIDCk('Region', [REGN])),
		wbRUnion('Union', [
// XCIM XLCN
      wbRStruct('XCIM XLCN', [
        wbFormIDCk(XCIM, 'Image Space', [IMGS]), // Moved from between XCLR and XCET
        wbFormID(XLCN, 'Unknown')
      ], [XCMO]),
// XLCN XCIM
      wbRStruct('XLCN XCIM', [
        wbFormID(XLCN, 'Unknown'),
        wbFormIDCk(XCIM, 'Image Space', [IMGS]) // Moved from between XCLR and XCET
      ], [XCMO])
    ], [XCMO]),
//    wbByteArray(XCET, 'Unknown', 1, cpIgnore), Left over from FNV
    wbFormIDCk(XCWT, 'Water', [WATR]),
// XOWN
    wbRStruct('Ownership', [
      wbXOWN,
      wbInteger(XRNK, 'Faction rank', itS32)
    ], [XCMO]), // XCMT Left over
//  wbByteArray(XCMT, 'Unknown', 1, cpIgnore), // XCMT Left over
// XCMO
    wbFormIDCk(XCMO, 'Music Type', [MUSC]),
// XCCM
    wbFormIDCk(XCCM, 'Climate', [CLMT]), // Moved from between XCET and XCWT
// XILL
		wbFormID(XILL, 'Unknown'),
		wbRUnion('Union', [
// XCAS XWEM XEZN
      wbRStruct('XCAS XEZN XCMO XWEM', [
        wbFormIDCk(XCAS, 'Acoustic Space', [ASPC]), // Moved from between XOWN (Ownership) and XCMT
        wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]), // Moved from between XCET and XCCM
        // XCMO
        wbFormIDCk(XCMO, 'Music Type', [MUSC]),
        wbUnknown(XWEM)
      ], []),
// XEZN XCAS
      wbRStruct('XEZN XCAS', [
        wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]), // Moved from between XCET and XCCM
        wbFormIDCk(XCAS, 'Acoustic Space', [ASPC]) // Moved from between XOWN (Ownership) and XCMT
      ], [])
    ], [])
  ], wbAllowUnordered);
//------------------------------------------------------------------------------
// End CELL
//------------------------------------------------------------------------------

  wbRecord(PHZD, 'PHZD', [
    wbVMAD,
    wbUnknown(NAME),
    wbUnknown(XESP),
    wbUnknown(XSCL),
    wbUnknown(DATA)
  ], wbAllowUnordered);

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
    wbUnknown(DATA),
    wbUnknown(ATTR)
  ], wbAllowUnordered);
end;

procedure DefineTES5c;
begin

  wbRecord(CLDC, 'CLDC', [
    wbEDIDReq
  ], wbAllowUnordered);

  wbRecord(CLMT, 'Climate', [
    wbEDIDReq,
    wbArrayS(WLST, 'Weather Types', wbByteArray('Weather Type')),
    wbString(FNAM, 'Sun Texture'),
    wbString(GNAM, 'Sun Glare Texture'),
    wbMODL,
    wbByteArray(TNAM, 'Timing')
  ], wbAllowUnordered);

  wbRecord(SPGD, 'SPGD', [
    wbEDIDReq,
    wbUnknown(DATA),
    wbString(ICON, 'File Name')
  ], wbAllowUnordered);

  wbRecord(RFCT, 'RFCT', [
    wbEDIDReq,
    wbByteArray(DATA, 'Effect Data')
  ], wbAllowUnordered);

  wbCNTO :=
    wbRStruct('Item', [
      wbByteArray(CNTO, 'Item'),
      wbCOED
    ], []);

  wbCNTOs := wbRArrayS('Items', wbCNTO);

//------------------------------------------------------------------------------
// Begin New CONT
//------------------------------------------------------------------------------
  wbRecord(CONT, 'Container', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbCOCT,
    wbCNTOs,
    wbByteArray(DATA, 'Data'),
    wbSNAM,
    wbQNAM
  ], True);

  wbCSDT := wbRStructSK([0], 'Sound Type', [
		wbByteArray(CSDT, 'Type'),
		wbRArrayS('Sounds', wbRStruct('Sound', [
			wbFormIDCk(CSDI, 'Sound', [SOUN, NULL]),
			wbByteArray(CSDC, 'Sound Chance')
		], []))
  ], []);

  wbCSDTs := wbRArrayS('Sound Types', wbCSDT);

  wbAIDT := wbByteArray(AIDT, 'AI Data');

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

  wbRecord(CREA, 'Creature', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULLActor,
    wbMODLActor,
    wbSPLOs,
    wbFormIDCk(EITM, 'Unarmed Attack Effect', [ENCH, SPEL]),
    wbByteArray(EAMT, 'Unarmed Attack Animation'),
    wbArrayS(NIFZ, 'Model List', wbStringLC('Model')),
    wbByteArray(NIFT, 'Texture Files Hashes'),
    wbByteArray(ACBS, 'Configuration'),
    wbByteArray(SNAM, 'Faction'),
    wbFormIDCk(INAM, 'Death item', [LVLI]),
    wbFormIDCk(VTCK, 'Voice', [VTYP]),
    wbFormIDCk(TPLT, 'Template', [CREA, LVLC]),
    wbDESTActor,
    wbSCRIActor,
    wbRArrayS('Items', wbCNTO),
    wbAIDT,
    wbRArray('Packages', wbFormIDCk(PKID, 'Package', [PACK])),
    wbArrayS(KFFZ, 'Animations', wbStringLC('Animation')),
    wbByteArray(DATA, 'Data'),
    wbByteArray(RNAM, 'Attack reach'),
    wbFormIDCk(ZNAM, 'Combat Style', [CSTY]),
    wbFormIDCk(PNAM, 'Body Part Data', [BPTD]),
    wbByteArray(TNAM, 'Turning Speed'),
    wbByteArray(BNAM, 'Base Scale'),
    wbByteArray(WNAM, 'Foot Weight'),
    wbByteArray(NAM4, 'Impact Material Type'),
    wbByteArray(NAM5, 'Sound Level'),
    wbFormIDCk(CSCR, 'Inherits Sounds from', [CREA]),
    wbCSDTs,
    wbFormIDCk(CNAM, 'Impact Dataset', [IPDS]),
    wbFormIDCk(LNAM, 'Melee Weapon List', [FLST])
  ], True);

end;

procedure DefineTES5d;
begin
  
	wbRecord(CSTY, 'Combat Style', [
    wbEDIDReq,
    wbByteArray(CSTD, 'Advanced - Standard'),
    wbByteArray(CSAD, 'Advanced - Advanced'),
    wbByteArray(CSSD, 'Simple'),
    wbByteArray(CSGD),
    wbByteArray(CSMD),
    wbByteArray(CSME),
    wbByteArray(CSCR),
    wbByteArray(CSLR),
    wbByteArray(CSFL),
    wbByteArray(DATA)
  ], wbAllowUnordered);

  wbRecord(DIAL, 'Dialog Topic', [
    wbEDID,
    wbFULL,
    wbByteArray(PNAM, 'Priority'),
    wbFormIDCk(BNAM, 'Branch', [DLBR, NULL]),
    wbFormIDCk(QNAM, 'Quest', [QUST, NULL], False, cpNormal, False),
    wbUnknown(SNAM),
    wbByteArray(DATA, 'Data'),
    wbByteArray(TIFC, 'Info Count')
  ], wbAllowUnordered);


  wbRecord(DOOR, 'Door', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODLReq,
    wbSCRI,
    wbDEST,
    wbFormIDCk(SNAM, 'Sound - Open', [SOUN]),
    wbFormIDCk(ANAM, 'Sound - Close', [SOUN]),
    wbFormIDCk(BNAM, 'Sound - Looping', [SOUN]),
    wbByteArray(FNAM, 'Flags')
  ], wbAllowUnordered);

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
    'Greater Than or Equal Than',
    'Always Show'
  ]);

  wbRecord(EFSH, 'Effect Shader', [
    wbEDID,
    wbString(ICON, 'Fill Texture'),
    wbString(ICO2, 'Particle Shader Texture'),
    wbString(NAM7, 'Post Effect'),
    wbString(NAM8, 'Looped Gradient'),
    wbString(NAM9, 'End Gradient'),
    wbByteArray(DATA, 'Data')
  ], wbAllowUnordered);

  wbRecord(ENCH, 'Object Effect', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbUnknown(ENIT),
    wbEffectsReq
  ], wbAllowUnordered);

  wbRecord(EYES, 'Eyes', [
    wbEDIDReq,
    wbFULLReq,
    wbString(ICON, 'Texture', 0{, cpNormal, True??}),
    wbUnknown(DATA)
  ], wbAllowUnordered);

  wbXNAM := wbByteArray(XNAM, 'Relation');
  wbXNAMs := wbRArrayS('Relations', wbXNAM);

  wbRecord(FACT, 'Faction', [
    wbEDIDReq,
    wbFULL,
    wbXNAMs,
    wbByteArray(DATA, 'Flags'),
    wbFormID(JAIL, 'Unknown'),
    wbFormID(WAIT, 'Unknown'),
    wbFormID(STOL, 'Unknown'),
    wbFormID(PLCN, 'Unknown'),
    wbFormID(CRGR, 'Unknown'),
    wbFormID(JOUT, 'Unknown'),
    wbByteArray(CRVA, 'Grime Gold'),
    wbRStructsSK('Ranks', 'Rank', [0], [
      wbByteArray(RNAM, 'Rank#'),
      wbLString(MNAM, 'Male', 0, cpTranslate),
      wbLString(FNAM, 'Female', 0, cpTranslate),
      wbString(INAM, 'Insignia Unused')
    ], []),
    wbFormID(VEND, 'Vendor Buy/Sell List'),
    wbFormID(VENC, 'Merchant Container'),
    wbUnknown(VENV),
    wbUnknown(PLVD),
    wbCITC,
    wbCTDAs
  ], wbAllowUnordered);

  wbRecord(FURN, 'Furniture', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODLReq,
    wbSCRI,
    wbDEST,
    wbKSIZ,
    wbKWDAs,
    wbUnknown(PNAM),
    wbUnknown(FNAM),
    wbFormIDCk(KNAM, 'Reputation', [KYWD, NULL]),
    wbByteArray(MNAM, 'Marker Flags', 0, cpNormal, True),
    wbUnknown(WBDT),
    wbRArray('Array ENAM, NAM0, FNMK', wbRStruct('Unknown', [
      wbUnknown(ENAM),
      wbUnknown(NAM0),
      wbFormIDCk(FNMK, 'Reputation', [KYWD, NULL])
    ], [])),
    wbRArray('Array FNPR', wbRStruct('Unknown', [
      wbUnknown(FNPR)
    ], [])),
    wbString(XMRK, 'Model Filename')
  ], wbAllowUnordered);

  wbRecord(GLOB, 'Global', [
    wbEDIDReq,
    wbByteArray(FNAM, 'Type'),
    wbByteArray(FLTV, 'Value')
  ], wbAllowUnordered);

  wbRecord(GMST, 'Game Setting', [
    wbString(EDID, 'Editor ID', 0, cpCritical, True, nil, wbGMSTEDIDAfterSet),
    wbByteArray(DATA, 'Value')
  ], wbAllowUnordered);

  wbRecord(KYWD, 'KYWD', [
    wbEDIDReq,
    wbCNAM
  ], wbAllowUnordered);

  wbRecord(LCRT, 'LCRT', [
    wbEDIDReq,
    wbCNAM
  ], wbAllowUnordered);

  wbRecord(AACT, 'AACT', [
    wbEDIDReq,
    wbCNAM
  ], wbAllowUnordered);

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
    wbByteArray(DNAM, 'DNAM Record Flags')
  ], wbAllowUnordered);

  wbRecord(MICN, 'Menu Icon', [
    wbEDIDReq,
    wbICONReq
  ], wbAllowUnordered);

  wbRecord(HDPT, 'Head Part', [
    wbEDIDReq,
    wbFULLReq,
    wbMODL,
    wbByteArray(DATA, 'Flags'),
    wbByteArray(PNAM, 'Part Info'),
    wbRArray('Extra Parts',
      wbFormIDCk(HNAM, 'Part', [HDPT])
    ),
    wbRArray('Parts',
      wbRStruct('Part List', [
        wbByteArray(NAM0, 'Part Type'),
        wbString(NAM1, 'Filename', 0, cpTranslate, True)
      ], [])
    ),
    wbFormIDCk(TNAM, 'Texture Set', [TXST, NULL]),
    wbFormIDCk(RNAM, 'Form List', [FLST, NULL])
  ], wbAllowUnordered);

  wbRecord(ASPC, 'Acoustic Space', [
    wbEDIDReq,
    wbOBNDReq,
    wbFormIDCk(SNAM, 'Dawn / Default Loop', [NULL, SOUN], False, cpNormal, True),
    wbFormIDCk(SNAM, 'Afternoon', [NULL, SOUN], False, cpNormal, True),
    wbFormIDCk(SNAM, 'Dusk', [NULL, SOUN], False, cpNormal, True),
    wbFormIDCk(SNAM, 'Night', [NULL, SOUN], False, cpNormal, True),
    wbFormIDCk(SNAM, 'Walla', [NULL, SOUN], False, cpNormal, True),
    wbInteger(WNAM, 'Walla Trigger Count', itU32, nil, cpNormal, True),
    wbFormIDCk(RDAT, 'Use Sound from Region (Interiors Only)', [REGN]),
    wbUnknown(BNAM),
    wbByteArray(ANAM, 'Environment Type'),
    wbByteArray(INAM, 'Is Interior')
  ], wbAllowUnordered);

  wbRecord(TACT, 'Talking Activator', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODLReq,
    wbSCRI,
    wbDEST,
    wbFormIDCk(SNAM, 'Looping Sound', [SOUN]),
    wbUnknown(PNAM),
    wbUnknown(FNAM),
    wbFormIDCk(VNAM, 'Voice Type', [VTYP]),
    wbFormIDCk(INAM, 'Radio Template', [SOUN])
  ], wbAllowUnordered);

  wbRecord(SCPT, 'Script', [
    wbEDIDReq
  ], wbAllowUnordered);

  wbRecord(TERM, 'Terminal', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbSCRI,
    wbDEST,
    wbDESCReq,
    wbFormIDCk(SNAM, 'Sound - Looping', [SOUN]),
    wbFormIDCk(PNAM, 'Password Note', [NOTE]),
    wbByteArray(DNAM, 'Data'),
    wbRArray('Menu Items',
      wbRStruct('Menu Item', [
        wbString(ITXT, 'Item Text'),
        wbString(RNAM, 'Result Text', 0, cpNormal, True),
        wbByteArray(ANAM, 'Flags'),
        wbFormIDCk(INAM, 'Display Note', [NOTE]),
        wbFormIDCk(TNAM, 'Sub Menu', [TERM]),
        wbEmbeddedScriptReq,
        wbCTDAs
      ], [])
    )
  ], wbAllowUnordered);

  wbRecord(SCOL, 'Static Collection', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODLReq,
    wbRStructsSK('Parts', 'Part', [0], [
      wbFormIDCk(ONAM, 'Static', [STAT]),
      wbRArray('Unknown', wbRStruct('Unknown', [
        wbByteArray(DATA, 'Unknown')
      ], []))
    ], [], cpNormal, True)
  ], wbAllowUnordered);

  wbRecord(MSTT, 'Moveable Static', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODLReq,
    wbDEST,
    wbByteArray(DATA, 'Unknown'),
    wbFormIDCk(SNAM, 'Sound', [SOUN])
  ], wbAllowUnordered);

  wbRecord(PWAT, 'Placeable Water', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODLReq,
    wbByteArray(DNAM, 'Unknown')
  ], wbAllowUnordered);

  wbRecord(IDLM, 'Idle Marker', [
    wbEDIDReq,
    wbOBNDReq,
    wbByteArray(IDLF, 'Flags'),
    wbByteArray(IDLC, 'Unknown'),
    wbByteArray(IDLT, 'Idle Timer Setting'),
    wbArray(IDLA, 'Animations', wbFormIDCk('Animation', [IDLE]))
  ], wbAllowUnordered);

  wbRecord(NOTE, 'Note', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbYNAM,
    wbZNAM,
    wbByteArray(DATA, 'Type'),
    wbRArrayS('Quests',
      wbFormIDCkNoReach(ONAM, 'Quest', [QUST])
    ),
    wbString(XNAM, 'Texture'),
    wbByteArray(TNAM, 'Text / Topic'),
    wbByteArray(SNAM, 'Sound / NPC')
  ], wbAllowUnordered);

end;

procedure DefineTES5e;
begin

  wbRecord(PROJ, 'Projectile', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODLReq,
    wbDEST,
    wbByteArray(DATA, 'Data'),
    wbRStruct('Muzzle Flash Model', [
      wbString(NAM1, 'Model Filename'),
      wbByteArray(NAM2, 'Texture Files Hashes')
    ], [], cpNormal, True),
    wbByteArray(VNAM, 'Sound Level')
  ], wbAllowUnordered);

  wbRecord(HAZD, 'HAZD', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbFormIDCk(MNAM, 'Unknown', [IMAD, NULL]),
    wbByteArray(DATA, 'Data')
  ], wbAllowUnordered);

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
    wbKSIZ,
    wbKWDAs,
    wbICON,
    wbSCRI,
    wbByteArray(DATA, 'Data'),
    wbByteArray(SOUL, 'Contained Soul'),
    wbByteArray(SLCP, 'Maximum Capacity'),
    wbFormID(NAM0, 'Unknown')
  ], wbAllowUnordered);

  wbRecord(NAVI, 'Navigation Mesh Info Map', [
    wbEDID,
    wbByteArray(NVER, 'Version'),
    wbRArray('Unknown',
      wbByteArray(NVMI, 'Unknown')
    ),
    wbRArray('Unknown',
      wbByteArray(NVPP, 'Unknown')
    )
  ], wbAllowUnordered);

  wbRecord(NAVM, 'Navigation Mesh', [
    wbUnknown(NVNM),
    wbUnknown(ONAM),
    wbUnknown(PNAM),
    wbUnknown(NNAM)
  ], wbAllowUnordered);


  wbRecord(PGRE, 'Placed Grenade', [
    wbEDID,
    wbFormIDCk(NAME, 'Base', [PROJ], False, cpNormal, True),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),

    wbXRGD,
    wbXRGB,

    {--- Patrol Data ---}
    wbRStruct('Patrol Data', [
      wbByteArray(XPRD, 'Idle Time'),
      wbByteArray(XPPA, 'Patrol Script Marker'),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, 'Topic', [DIAL, NULL], False, cpNormal, True)
    ], []),

    {--- Ownership ---}
    wbRStruct('Ownership', [
      wbXOWN,
      wbByteArray(XRNK, 'Faction rank')
    ], [XCMT, XCMO]),

    {--- Extra ---}
    wbByteArray(XCNT, 'Count'),
    wbByteArray(XRDS, 'Radius'),
    wbByteArray(XHLP, 'Health'),

    {--- Reflected By / Refracted By ---}
    wbRArrayS('Reflected/Refracted By', wbRStruct('Patrol Data', [
      wbByteArray(XPWR, 'Water')
    ], [])),

    {--- Decals ---}
    wbRArrayS('Linked Decals', wbRStruct('Patrol Data', [
      wbByteArray(XDCR, 'Decal')
    ], [])),

    {--- Linked Ref ---}
    wbFormIDCk(XLKR, 'Linked Reference', [REFR, ACRE, ACHR, PGRE, PMIS]),
    wbByteArray(XCLP, 'Linked Reference Color'),

    {--- Activate Parents ---}
    wbRStruct('Activate Parents', [
      wbByteArray(XAPD, 'Flags'),
      wbRArrayS('Activate Parent Refs',
        wbByteArray(XAPR, 'Activate Parent Ref')
      )
    ], []),

    wbString(XATO, 'Activation Prompt'),

    {--- Enable Parent ---}
    wbXESP,

    {--- Emittance ---}
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),

    {--- Flags ---}
    wbByteArray(XIBS, 'Ignored By Sandbox'),

    {--- 3D Data ---}
    wbXSCL,
    wbDATAPosRot
  ], wbAllowUnordered);

  wbRecord(PMIS, 'Placed Missile', [
    wbEDID,
    wbFormIDCk(NAME, 'Base', [PROJ], False, cpNormal, True),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),

    wbXRGD,
    wbXRGB,

    {--- Patrol Data ---}
    wbRStruct('Patrol Data', [
      wbByteArray(XPRD, 'Idle Time'),
      wbByteArray(XPPA, 'Patrol Script Marker'),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbEmbeddedScriptReq,
      wbFormIDCk(TNAM, 'Topic', [DIAL, NULL], False, cpNormal, True)
    ], []),

    {--- Ownership ---}
    wbRStruct('Ownership', [
      wbXOWN,
      wbByteArray(XRNK, 'Faction rank')
    ], []),

    {--- Extra ---}
    wbByteArray(XCNT, 'Count'),
    wbByteArray(XRDS, 'Radius'),
    wbByteArray(XHLP, 'Health'),

    {--- Reflected By / Refracted By ---}
    wbRArrayS('Reflected/Refracted By',
      wbByteArray(XPWR, 'Water')
    ),

    {--- Decals ---}
    wbRArrayS('Linked Decals',
      wbByteArray(XDCR, 'Decal')
    ),

    {--- Linked Ref ---}
    wbFormIDCk(XLKR, 'Linked Reference', [REFR, ACRE, ACHR, PGRE, PMIS]),
    wbByteArray(XCLP, 'Linked Reference Color'),

    {--- Activate Parents ---}
    wbRStruct('Activate Parents', [
      wbByteArray(XAPD, 'Flags'),
      wbRArrayS('Activate Parent Refs',
        wbByteArray(XAPR, 'Activate Parent Ref')
      )
    ], []),

    wbString(XATO, 'Activation Prompt'),

    {--- Enable Parent ---}
    wbXESP,

    {--- Emittance ---}
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),

    {--- Flags ---}
    wbByteArray(XIBS, 'Ignored By Sandbox'),

    {--- 3D Data ---}
    wbXSCL,
    wbDATAPosRot
  ], wbAllowUnordered);


   wbRecord(EXPL, 'Explosion', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbEITM,
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD]),
    wbByteArray(DATA, 'Data'),
    wbFormIDCk(INAM, 'Placed Impact Object', [TREE, SOUN, ACTI, DOOR, STAT, FURN,
          CONT, ARMO, AMMO, LVLN, LVLC, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS,
          ASPC, IDLM, ARMA, MSTT, NOTE, PWAT, SCOL, TACT, TERM, TXST, CHIP])
  ], wbAllowUnordered);

  wbRecord(DEBR, 'Debris', [
    wbEDIDReq,
    wbRStructs('Models', 'Model', [
      wbByteArray(DATA, 'Data'),
      wbMODT
    ], [])
  ], wbAllowUnordered);

  wbRecord(IMGS, 'Image Space', [
    wbEDIDReq,
    wbUnknown(ENAM),
    wbUnknown(HNAM),
    wbUnknown(CNAM),
    wbUnknown(TNAM),
    wbByteArray(DNAM, 'Dnam')
  ], wbAllowUnordered);

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
  ], wbAllowUnordered);

  wbRecord(FLST, 'FormID List', [
    wbString(EDID, 'Editor ID'),
    wbRArrayS('FormIDs', wbFormID(LNAM, 'FormID'))
  ], wbAllowUnordered);

  wbRecord(PERK, 'Perk', [
    wbEDIDReq,
    wbVMAD,
    wbFULL,
    wbDESCReq,
    wbICON,
    wbCTDAs,
    wbByteArray(DATA, 'Data'),
    wbFormIDCK(NNAM, 'Next Perk', [PERK,NULL]),
    wbRArray('The Array', wbRStruct('Unknown', [ // Array PRKE to PRKF
      wbByteArray(PRKE, 'Header'),
      wbByteArray(DATA, 'Effect Data'),
      wbRArray('Perk Conditions', wbRStruct('Perk Condition', [
          wbByteArray(PRKC, 'Run On'),
          wbCTDAsReq
      ], [])),
      wbRStruct('Entry Point Function Parameters', [
        wbUnknown(EPFT),
        wbLString(EPF2, 'Unknown'{, 0, cpNormal, False, wbEPF2DontShow}),
        wbUnknown(EPF3),
        wbUnknown(EPFD)
      ], []),
      wbByteArray(PRKF, 'End Marker')
    ], []))
  ], wbAllowUnordered);

  wbRecord(BPTD, 'Body Part Data', [
    wbEDIDReq,
    wbMODLReq,
    wbRStructs('Body Parts', 'Body Part', [
      wbString(BPTN, 'Part Name'),
      wbString(BPNN, 'Part Node'),
      wbString(BPNT, 'VATS Target'),
      wbString(BPNI, 'IK Data - Start Node'),
      wbByteArray(BPND, 'Unknown'),
      wbString(NAM1, 'Limb Replacement Model'),
      wbString(NAM4, 'Gore Effects - Target Bone'),
      wbByteArray(NAM5, 'Texture Files Hashes')
    ], [], cpNormal, True),
    wbFormIDCk(RAGA, 'Ragdoll', [RGDL])
  ], wbAllowUnordered);

  wbRecord(ADDN, 'Addon Node', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODLReq,
    wbByteArray(DATA, 'Node Index'),
    wbFormIDCk(SNAM, 'Sound', [SOUN]),
    wbByteArray(DNAM, 'Data')
  ], wbAllowUnordered);

  wbRecord(AVIF, 'ActorValue Information', [
    wbEDIDReq,
    wbFULL,
    wbDESCReq,
    wbUnknown(ANAM),
    wbRArray('Array of INAM or CNAM', // The Aray
      wbRUnion('Union', [ // The Union
        wbRStruct('Starts with CNAM', [ // The start of the CNAM
          wbUnknown(CNAM),
          wbUnknown(AVSK),
          wbUnknown(INAM),
          wbFormID(PNAM, 'Unknown'),
          wbUnknown(FNAM),
          wbUnknown(XNAM),
          wbUnknown(YNAM),
          wbUnknown(HNAM),
          wbUnknown(VNAM),
          wbFormID(SNAM, 'Unknown')
        ], []), // The End of the CNAM
        wbRStruct('Starts with INAM', [ // The start of the INAM
          wbUnknown(INAM),
          wbFormID(PNAM, 'Unknown'),
          wbUnknown(FNAM),
          wbUnknown(XNAM),
          wbUnknown(YNAM),
          wbUnknown(HNAM),
          wbUnknown(VNAM),
          wbFormID(SNAM, 'Unknown')
        ], []) // The End of the INAM
      ], []) // The End of Union
    ) // The End of Array
//    wbICON,
//    wbString(ANAM, 'Short Name')
  ], wbAllowUnordered);

  wbRecord(RADS, 'Radiation Stage', [
    wbEDIDReq,
    wbByteArray(DATA, 'Data')
  ], wbAllowUnordered);

  wbRecord(CAMS, 'Camera Shot', [
    wbEDIDReq,
    wbMODL,
    wbByteArray(DATA, 'Data'),
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD])
  ], wbAllowUnordered);

  wbRecord(CPTH, 'Camera Path', [
    wbEDIDReq,
    wbCTDAs,
    wbArray(ANAM, 'Related Camera Paths', wbFormIDCk('Related Camera Path', [CPTH, NULL]), ['Parent', 'Previous Sibling']),
    wbByteArray(DATA, 'Camera Zoom'),
    wbRArray('Camera Shots', wbFormIDCk(SNAM, 'Camera Shot', [CAMS]))
  ], wbAllowUnordered);

  wbRecord(VTYP, 'Voice Type', [
    wbEDIDReq,
    wbByteArray(DNAM, 'Flags')
  ], wbAllowUnordered);

  wbRecord(MATT, 'MATT', [
    wbEDIDReq,
    wbFormID(PNAM, 'Material parent'),
    wbString(MNAM, 'Material name'),
    wbunknown(CNAM),
    wbunknown(BNAM),
    wbunknown(FNAM),
    wbFormID(HNAM, 'Havok name')
  ], wbAllowUnordered);

  wbRecord(IPCT, 'Impact', [
    wbEDIDReq,
    wbMODL,
    wbByteArray(DATA, 'Data'),
    wbDODT,
    wbFormIDCk(DNAM, 'Texture Set', [TXST]),
    wbunknown(ENAM),
    wbFormIDCk(SNAM, 'Sound 1', [SNDR, SOUN, NULL]),
    wbFormIDCk(NAM1, 'Sound 2', [SNDR, SOUN, NULL]),
    wbFormIDCk(NAM2, 'Unknown', [HAZD, NULL])
  ], wbAllowUnordered);

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
    ], cpNormal, True, nil, 9),
    wbRArray('Unknown - LCEC', wbRStruct('Unknown', [
      wbUnknown(PNAM)
    ], []))
  ], wbAllowUnordered);

  wbRecord(ECZN, 'Encounter Zone', [
    wbEDIDReq,
    wbByteArray(DATA, 'Data')
  ], wbAllowUnordered);

  wbRecord(LCTN, 'LCTN', [
    wbEDIDReq,
    wbUnknown(ACPR),
    wbUnknown(LCPR),
    wbUnknown(LCUN),
    wbUnknown(LCSR),
    wbRArray('Unknown - LCEC', wbRStruct('Unknown', [
      wbUnknown(LCEC)
    ], [])),
    wbUnknown(LCID),
    wbUnknown(LCEP),
    wbFull,
    wbKSIZ,
    wbKWDAs,
    wbFormIDCk(PNAM, 'Unknown', [LCTN, NULL]),
    wbFormIDCk(NAM1, 'Unknown', [MUSC, NULL]),
    wbUnknown(FNAM),
    wbUnknown(MNAM),
    wbUnknown(RNAM),
    wbUnknown(NAM0),
    wbUnknown(CNAM)
  ], wbAllowUnordered);

  wbRecord(MESG, 'Message', [
    wbEDIDReq,
    wbDESCReq,
    wbFULL,
    wbFormIDCk(INAM, 'Icon', [MICN, NULL], False, cpNormal, True),
    wbByteArray(NAM0, 'Unknown'),
    wbByteArray(NAM1, 'Unknown'),
    wbByteArray(NAM2, 'Unknown'),
    wbByteArray(NAM3, 'Unknown'),
    wbByteArray(NAM4, 'Unknown'),
    wbByteArray(NAM5, 'Unknown'),
    wbByteArray(NAM6, 'Unknown'),
    wbByteArray(NAM7, 'Unknown'),
    wbByteArray(NAM8, 'Unknown'),
    wbByteArray(NAM9, 'Unknown'),
    wbUnknown(QNAM),
    wbByteArray(DNAM, 'Flags'),
    wbByteArray(TNAM, 'Display Time'),
    wbRStructs('Menu Buttons', 'Menu Button', [
      wbLString(ITXT, 'Button Text'),
      wbCTDAs
    ], [])
  ], wbAllowUnordered);

  wbRecord(RGDL, 'Ragdoll', [
    wbEDIDReq,
    wbByteArray(NVER, 'Version'),
    wbByteArray(DATA, 'General Data'),
    wbFormIDCk(XNAM, 'Actor Base', [CREA, NPC_], False, cpNormal, True),
    wbFormIDCk(TNAM, 'Body Part Data', [BPTD], False, cpNormal, True),
    wbByteArray(RAFD, 'Feedback Data'),
    wbArray(RAFB, 'Feedback Dynamic Bones', wbByteArray('Bone')),
    wbByteArray(RAPS, 'Pose Matching Data'),
    wbString(ANAM, 'Death Pose')
  ], wbAllowUnordered);

  wbRecord(DOBJ, 'Default Object Manager', [
    wbArray(DNAM, 'Unknown',
      wbStruct('Unknown', [
        wbString('Unknown'),
        wbFormID('Unknown')
      ])
		)
  ], wbAllowUnordered);

  wbRecord(LGTM, 'Lighting Template', [
    wbEDIDReq,
    wbByteArray(DATA, 'Lighting'),
    wbUnknown(DALC)
  ], wbAllowUnordered);

  wbRecord(MUSC, 'Music Type', [
    wbEDIDReq,
    wbString(FNAM, 'Filename'),
    wbByteArray(ANAM, 'dB (positive = Loop)'),
    wbUnknown(PNAM),
    wbUnknown(WNAM),
    wbUnknown(TNAM)
  ], wbAllowUnordered);

  wbRecord(FSTP, 'FSTP', [
    wbEDIDReq,
    wbUnknown(DATA),
    wbUnknown(ANAM)
  ], wbAllowUnordered);

  wbRecord(FSTS, 'FSTS', [
    wbEDIDReq,
    wbByteArray(XCNT, 'Lighting'),
    wbArray(DATA, 'Footstep Sets', wbFormID('Footstep'))
  ], wbAllowUnordered);

  wbRecord(SMBN, 'SMBN', [
    wbEDIDReq,
    wbFormIDCk(PNAM, 'Parent ', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCk(SNAM, 'Child ', [SMQN, SMBN, SMEN, NULL]),
    wbUnknown(CITC),
    wbCTDAs,
    wbUnknown(DNAM),
    wbUnknown(XNAM)
  ], wbAllowUnordered);

  wbRecord(SMQN, 'SMQN', [
    wbEDID,
    wbFormIDCk(PNAM, 'Parent ', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCk(SNAM, 'Child ', [SMQN, SMBN, SMEN, NULL]),
    wbUnknown(CITC),
    wbCTDAs,
    wbUnknown(DNAM),
    wbUnknown(XNAM),
    wbUnknown(MNAM),
    wbByteArray(QNAM, 'Count'),
    wbRArray('Array NNAM, FNAM, RNAM', wbRStruct('Unknown', [
      wbFormID(NNAM, 'Unknown'),
      wbUnknown(FNAM),
      wbUnknown(RNAM)
    ], []))
  ], wbAllowUnordered);

  wbRecord(SMEN, 'SMEN', [
    wbEDID,
    wbFormIDCk(PNAM, 'Parent ', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCk(SNAM, 'Child ', [SMQN, SMBN, SMEN, NULL]),
    wbUnknown(CITC),
    wbCTDAs,
    wbUnknown(DNAM),
    wbUnknown(XNAM),
    wbString(ENAM, 'Unknown', 4)
  ], wbAllowUnordered);

  wbRecord(DLBR, 'DLBR', [
    wbEDIDReq,
    wbFormIDCk(QNAM, 'Reference?', [QUST], False, cpNormal, True),
    wbByteArray(TNAM, 'Unknown'),
    wbByteArray(DNAM, 'Unknown'),
    wbFormIDCk(SNAM, 'Start Dialog', [DIAL], False, cpNormal, True)
  ], wbAllowUnordered);

  wbRecord(MUST, 'MUST', [
    wbEDIDReq,
    wbUnknown(CNAM),
    wbUnknown(FLTV),
    wbUnknown(ANAM),
    wbByteArray(LNAM, 'Loop Data'),
    wbUnknown(BNAM),
    wbUnknown(DNAM),
    wbUnknown(FNAM),
    wbUnknown(CITC),
    wbCTDAs,
    wbUnknown(SNAM)
  ], wbAllowUnordered);

  wbRecord(DLVW, 'DLVW', [
    wbEDIDReq,
    wbUnknown(QNAM),
    wbRArray('Array BNAM', wbRStruct('Unknown', [
      wbUnknown(BNAM)
    ], [])),
    wbRArray('Array TNAM', wbRStruct('Unknown', [
      wbUnknown(TNAM)
    ], [])),
    wbUnknown(ENAM),
    wbUnknown(DNAM)
  ], wbAllowUnordered);

  wbRecord(WOOP, 'WOOP', [
    wbEDIDReq,
    wbFULL,
    wbUnknown(TNAM)
  ], wbAllowUnordered);

  wbRecord(SHOU, 'SHOU', [
    wbEDIDReq,
    wbFULL,
    wbMDOB,
    wbDESC,
    wbRArray('Array SNAM', wbRStruct('Unknown', [
      wbUnknown(SNAM)
    ], []))
  ], wbAllowUnordered);

  wbRecord(EQUP, 'EQUP', [
    wbEDIDReq,
    wbArray(PNAM, 'Equipped Hands Reference', wbFormID('Can Be Equipped'), 0, nil, nil, cpNormal, False),
    wbUnknown(DATA)
  ], wbAllowUnordered);

  wbRecord(RELA, 'RELA', [
    wbEDIDReq,
    wbUnknown(DATA)
  ], wbAllowUnordered);

//------------------------------------------------------------------------------
//
// Pattern  1: EDID VMAD FNAM / HNAM NAM0           NEXT                                    NEXT           WNAM HNAM / HNAM NAM0           NEXT                NEXT           WNAM HNAM / HNAM NAM0           NEXT CTDA CTDA           NEXT           WNAM HNAM / HNAM NAM0      NEXT CTDA           NEXT           WNAM HNAM / HNAM NAM0 NEXT           / NEXT WNAM HNAM
// Pattern  2: EDID VMAD FNAM / HNAM NAM0           NEXT CTDA CTDA                          NEXT           WNAM HNAM / HNAM NAM0           NEXT                NEXT           WNAM HNAM / HNAM NAM0 CTDA      NEXT                     NEXT           WNAM HNAM / HNAM NAM0      NEXT                NEXT           WNAM HNAM / HNAM NAM0 NEXT CTDA CTDA / NEXT WNAM HNAM
// Pattern  3: EDID VMAD FNAM / HNAM NAM0           NEXT CTDA CTDA                          NEXT           WNAM HNAM / HNAM NAM0      CTDA NEXT                NEXT           WNAM HNAM / HNAM NAM0 CTDA      NEXT                     NEXT           WNAM HNAM / HNAM NAM0 CTDA NEXT                NEXT           WNAM HNAM / HNAM NAM0 CTDA NEXT      / NEXT WNAM HNAM / HNAM NAM0 CTDA NEXT CTDA / NEXT WNAM HNAM / HNAM NAM0 CTDA NEXT CTDA NEXT WNAM HNAM
// Pattern  4: EDID      FNAM / HNAM NAM0 CTDA CTDA NEXT CTDA      SCHR           QNAM      NEXT SCHR QNAM WNAM HNAM / HNAM NAM0 CTDA CTDA NEXT [CD] SCHR QNAM NEXT SCHR QNAM WNAM HNAM / HNAM NAM0 CTDA CTDA NEXT           SCHR QNAM NEXT SCHR QNAM WNAM HNAM / HNAM NAM0      NEXT      SCHR QNAM NEXT SCHR QNAM WNAM HNAM / HNAM NAM0 NEXT SCHR QNAM NEXT SCHR QNAM WNAM HNAM HNAM NAM0 NEXT SCHR QNAM NEXT SCHR QNAM WNAM HNAM
// Pattern  5: EDID      FNAM / HNAM NAM0           NEXT           SCHR           QNAM      NEXT SCHR QNAM WNAM HNAM / HNAM NAM0           NEXT [CD] SCHR QNAM NEXT SCHR QNAM WNAM HNAM / HNAM NAM0           NEXT           SCHR QNAM NEXT SCHR QNAM WNAM HNAM / HNAM NAM0      NEXT      SCHR QNAM NEXT SCHR QNAM WNAM HNAM / HNAM NAM0 NEXT SCHR QNAM NEXT SCHR QNAM WNAM HNAM HNAM NAM0 NEXT SCHR QNAM NEXT SCHR QNAM WNAM HNAM
// Pattern  6: EDID      FNAM / HNAM NAM0           NEXT           SCHR SCDA SCTX QNAM SCRO NEXT SCHR QNAM WNAM HNAM / HNAM NAM0           NEXT      SCHR QNAM NEXT SCHR QNAM WNAM HNAM / HNAM NAM0           NEXT           SCHR QNAM NEXT SCHR QNAM WNAM HNAM / HNAM NAM0      NEXT      SCHR QNAM NEXT SCHR QNAM WNAM HNAM / HNAM NAM0 NEXT CTDA CTDA SCHR QNAM NEXT SCHR QNAM WNAM HNAM HNAM NAM0 NEXT SCHR QNAM NEXT SCHR QNAM WNAM HNAM HNAM NAM0 NEXT SCHR QNAM NEXT SCHR QNAM WNAM HNAM
// Pattern  7: EDID FNAM HNAM NAM0 CTDA CTDA NEXT CTDA SCHR QNAM NEXT SCHR QNAM WNAM HNAM HNAM NAM0 CTDA CTDA NEXT SCHR QNAM NEXT SCHR QNAM WNAM HNAM HNAM NAM0 CTDA CTDA NEXT SCHR QNAM NEXT SCHR QNAM WNAM HNAM HNAM NAM0 NEXT SCHR QNAM NEXT SCHR QNAM WNAM HNAM HNAM NAM0 NEXT SCHR QNAM NEXT SCHR QNAM WNAM HNAM HNAM NAM0 NEXT SCHR QNAM NEXT SCHR QNAM WNAM HNAM
//
// P1 Block 2: ALID LNAM DNAM ALID LNAM DNAM
// P1 Block 3: ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM / ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM SNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM SNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM SNAM ANAM ANAM NAM0 ALID INAM FNAM SNAM ENAM DATA HTID DMAX DMIN DEMO DEVA ANAM ANAM NAM0 ALID INAM FNAM SNAM ENAM DATA HTID DMAX DMIN DEMO DEVA ANAM ANAM NAM0 ALID INAM FNAM SNAM ENAM DATA HTID DMAX DMIN DEMO DEVA ANAM ANAM NAM0 ALID INAM FNAM SNAM ENAM DATA HTID DMAX DMIN DEMO DEVA ANAM PNAM INAM VNAM
// P2 Block 2: ALID LNAM DNAM ALID LNAM DNAM
// P2 Block 3: ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM / ANAM NAM0 ALID INAM SNAM ENAM SNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM SNAM ANAM ANAM NAM0 ALID INAM FNAM SNAM ENAM DATA HTID DMAX DMIN DEMO DEVA ANAM PNAM INAM VNAM
// P3 Block 2: ALID LNAM DNAM ALID LNAM DNAM ALID LNAM DNAM ALID LNAM DNAM ALID LNAM DNAM ALID LNAM DNAM ALID LNAM DNAM ALID LNAM DNAM ALID LNAM DNAM ALID LNAM DNAM ANAM NAM0 ALID INAM FNAM SNAM ENAM DATA HTID DMAX DMIN DEMO DEVA ANAM
//                                                                                                            / ANAM NAM0 ALID INAM FNAM SNAM ENAM DATA HTID DMAX DMIN DEMO DEVA ANAM ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN DEMO DEVA ANAM ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN DEMO DEVA ANAM ANAM NAM0 ALID INAM FNAM SNAM ENAM DATA HTID DMAX DMIN DEMO DEVA ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM SNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM SNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0
//           : ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 / ALID INAM SNAM ENAM PNAM ANAM                          / ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM PNAM INAM VNAM
// P4 Block 2: ALID LNAM DNAM ALID LNAM DNAM ANAM NAM0 / ALID INAM SNAM ENAM DATA HTID DMAX DMIN DEMO DEVA ANAM / ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN DEMO DEVA ANAM ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN DEMO DEVA ANAM ANAM NAM0 ALID INAM SNAM ENAM SNAM SCHR QNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM SCHR QNAM NEXT SCHR QNAM PNAM INAM VNAM
// P5 Block 2: ALID ALID ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN ANAM ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN ANAM / ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN ANAM ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN ANAM ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN ANAM ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN ANAM SCHR QNAM NEXT SCHR QNAM PNAM INAM
// P6 Block 2: ALID ALID ALID ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN ANAM                          / ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN ANAM ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN ANAM ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN ANAM ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN ANAM ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN ANAM ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN ANAM ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM SCHR SCTX QNAM NEXT SCHR SCTX QNAM PNAM INAM
// P7 Block 2: ALID LNAM DNAM ALID LNAM DNAM ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN DEMO DEVA ANAM / ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN DEMO DEVA ANAM ANAM NAM0 ALID INAM SNAM ENAM DATA HTID DMAX DMIN DEMO DEVA ANAM ANAM NAM0 ALID INAM SNAM ENAM SNAM SCHR QNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM ANAM NAM0 ALID INAM SNAM ENAM PNAM ANAM SCHR QNAM NEXT SCHR QNAM PNAM INAM VNAM
//
//------------------------------------------------------------------------------
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
  ], wbAllowUnordered);

  wbRecord(ASTP, 'ASTP', [
    wbEDIDReq,
    wbUnknown(MPRT),
    wbUnknown(FPRT),
    wbUnknown(MCHT),
    wbUnknown(FCHT),
    wbUnknown(DATA)
  ], wbAllowUnordered);

  wbRecord(OTFT, 'OTFT', [
    wbEDIDReq,
    wbUnknown(INAM)
  ], wbAllowUnordered);

  wbRecord(ARTO, 'ARTO', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODL,
    wbUnknown(DNAM),
    wbUnknown(DATA)
  ], wbAllowUnordered);

  wbRecord(MATO, 'MATO', [
    wbEDIDReq,
    wbMODL,
    wbRArray('Unknown - DNAM', wbRStruct('Unknown', [
      wbUnknown(DNAM)
    ], [])),
    wbUnknown(DATA)
  ], wbAllowUnordered);

  wbRecord(MOVT, 'MOVT', [
    wbEDIDReq,
    wbUnknown(MNAM),
    wbUnknown(SPED),
    wbUnknown(INAM)
  ], wbAllowUnordered);

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
    wbByteArray(LNAM, 'Values'),
    wbByteArray(BNAM, 'Values')
  ], wbAllowUnordered);

  wbRecord(DUAL, 'DUAL', [
    wbEDIDReq,
    wbOBNDReq,
    wbUnknown(DATA)
  ], wbAllowUnordered);

  wbRecord(SNCT, 'SNCT', [
    wbEDIDReq,
    wbFULL,
    wbUnknown(FNAM),
    wbFormIDCk(PNAM, 'String', [SNCT, NULL]),
    wbUnknown(VNAM),
    wbUnknown(UNAM)
  ], wbAllowUnordered);

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
    wbByteArray(ONAM, 'Unknown'),
    wbByteArray(SNAM, 'Some SNAM Values'),
    wbByteArray(ANAM, 'Some ANAM Values')
  ], wbAllowUnordered);

  wbRecord(COLL, 'COLL', [
    wbEDIDReq,
    wbDESCReq,
    wbFormID(BNAM, 'B Name', cpNormal, True),
    wbByteArray(FNAM, 'Unknown Flags'),
    wbByteArray(GNAM, 'Unknown Flags'),
    wbString(MNAM, 'MNAM Name'),
    wbByteArray(INTV, 'Interactables Count'),
    wbArrayS(CNAM, 'CNAM FormID', wbFormIDCk('Forms', [COLL]), 0, cpNormal, False)
  ], wbAllowUnordered);

//----------------------------------------------------------------------------
// New
//----------------------------------------------------------------------------
  wbRecord(CLFM, 'Color', [
    wbEDIDReq,
    wbFULL,
    wbByteArray(CNAM, 'ColorID'),
    wbByteArray(FNAM, 'Playable')
  ], wbAllowUnordered);

  wbRecord(REVB, 'REVB', [
    wbEDIDReq,
    wbByteArray(DATA, 'Data', 0, cpNormal, True)
  ], wbAllowUnordered);

  wbRecord(GRAS, 'Grass', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODLReq,
    wbByteArray(DATA, 'Data')
  ], wbAllowUnordered);

  wbRecord(HAIR, 'Hair', [
    wbEDIDReq
  ], wbAllowUnordered);

  wbRecord(IDLE, 'Idle Animation', [
    wbEDID,
    wbMODLReq,
    wbCTDAs,
    wbString(DNAM, 'Filename'),
    wbString(ENAM, 'Animation Event'),
    wbArray(ANAM, 'Related Idle Animations', wbFormIDCk('Related Idle Animation', [AACT, IDLE, NULL]), ['Parent', 'Previous Sibling']),
    wbByteArray(DATA, 'Data')
  ], wbAllowUnordered);

  wbRecord(INFO, 'Dialog response', [
    wbEDIDReq,
    wbVMAD,
    wbByteArray(DATA, 'Info Data'),
    wbByteArray(ENAM, 'Response flags'),
    wbFormIDCk(PNAM, 'Previous INFO', [INFO, NULL]),
    wbByteArray(CNAM, 'Unknown Flags'),
    wbRArray('Responses?', wbFormIDCk(TCLT, 'Response INFO', [DIAL, INFO, NULL])),
    wbRArray('Unknown - TRDT', wbRStruct('Unknown', [
      wbByteArray(TRDT, 'Unknown'),
      wbLString(NAM1, 'Dialog String 1'),
      wbString(NAM2, 'Dialog String 2'),
      wbString(NAM3, 'Dialog String 3'),
      wbFormIDCk(SNAM, 'Idle Animations: Speaker', [IDLE]),
      wbFormIDCk(LNAM, 'Idle Animations: Listener', [IDLE])
    ], [])),
    wbFormID(DNAM, 'Response Data'),
    wbCTDAs,

    wbRStruct('First SCHR', [
      wbunknown(SCHR),
      wbFormID(QNAM, 'Unknown')
    ], [], cpNormal, True),
    wbRStruct('NEXT and Second SCHR', [
      wbEmpty(NEXT, 'Marker'),
      wbunknown(SCHR),
      wbFormID(QNAM, 'Unknown')
    ], [], cpNormal, True),

    wbUnknown(RNAM),
    wbFormID(ANAM, 'Unknown'),
    wbFormID(TWAT, 'Walk Away Topic'),
    wbFormID(ONAM, 'Audio Output Override')
  ], wbAllowUnordered);

  wbRecord(INGR, 'Ingredient', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbKSIZ,
    wbKWDAs,
    wbMODL,
    wbICON,
    wbSCRI,
    wbETYPReq,
    wbYNAM,
    wbZNAM,
    wbByteArray(DATA, 'Weight'),
    wbByteArray(ENIT, 'Effect Data'),
    wbEffectsReq
  ], wbAllowUnordered);

  wbRecord(KEYM, 'Key', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULLReq,
    wbMODL,
    wbICONReq,
    wbSCRI,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbKSIZ,
    wbKWDAs,
    wbByteArray(DATA, 'Data'),
    wbFormIDCk(RNAM, 'Sound - Random/Looping', [SOUN])
  ], wbAllowUnordered);

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

      wbRArrayS('Layers', 
				wbRUnion('Layer', [
					wbRStructSK([0],'Base Layer', [
						wbByteArray(BTXT, 'Base Layer Header')
					], []),
					wbRStructSK([0],'Alpha Layer', [
						wbByteArray(ATXT, 'Alpha Layer Header'),
						wbByteArray(VTXT, 'Alpha Layer Data')
					], [])
      ], [])),
      wbArray(VTEX, 'Textures', wbFormIDCk('Texture', [LTEX, NULL]))
    ], wbAllowUnordered);

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
    ], wbAllowUnordered);

  end;

  wbRecord(LIGH, 'Light', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODL,
    wbSCRI,
    wbFULL,
    wbICON,
    wbByteArray(DATA, 'Data'),
    wbByteArray(FNAM, 'Fade value'),
    wbFormIDCk(SNAM, 'Sound', [SOUN])
  ], wbAllowUnordered);

  wbRecord(LSCR, 'Load Screen', [
    wbEDIDReq,
    wbICONReq,
    wbDESCReq,
    wbCTDAs,
    wbUnknown(NNAM),
    wbUnknown(SNAM),
    wbUnknown(RNAM),
    wbUnknown(ONAM),
    wbUnknown(XNAM),
    wbString(MOD2, 'Camera File', 0, cpNormal, True),
    wbFormIDCk(WMI1, 'Load Screen Type', [LSCT], False, cpNormal, True)
  ], wbAllowUnordered);

  wbRecord(LTEX, 'Landscape Texture', [
    wbEDIDReq,
    wbICON,
    wbFormIDCk(TNAM, 'Texture', [TXST], False, cpNormal, True),
    wbFormIDCk(MNAM, 'Texture', [MATT, NULL], False, cpNormal, True),
    wbByteArray(HNAM, 'Havok Data'),
    wbByteArray(SNAM, 'Texture Specular Exponent'),
    wbRArrayS('Grasses', wbFormIDCk(GNAM, 'Grass', [GRAS]))
  ], wbAllowUnordered);

  wbRecord(LVLN, 'Leveled NPC', [
    wbEDIDReq,
    wbOBNDReq,
    wbLVLD,
    wbByteArray(LVLF, 'Flags'),
    wbLLCT,
    wbRArrayS('Leveled List Entries',
      wbRStruct('Leveled List Entry', [
        wbByteArray(LVLO, 'Base Data'),
				wbCOED
      ], [])
    ),
    wbMODL
  ], wbAllowUnordered);

  wbRecord(LVLI, 'Leveled Item', [
    wbEDIDReq,
    wbOBNDReq,
    wbLVLD,
    wbByteArray(LVLF, 'Flags'),
    wbFormIDCk(LVLG, 'Global', [GLOB]),
    wbLLCT,
    wbRArrayS('Leveled List Entries',
      wbRStruct('Leveled List Entry', [
        wbByteArray(LVLO, 'Base Data'),
        wbCOED
      ], [])
    )
  ], wbAllowUnordered);

   wbRecord(LVSP, 'Leveled Spell', [
    wbEDIDReq,
    wbOBNDReq,
    wbLVLD,
    wbByteArray(LVLF, 'Flags'),
    wbLLCT,
    wbRArrayS('Leveled Spell List Entries',
      wbRStructExSK([0], [1], 'Leveled Spell List Entry', [
        wbByteArray(LVLO, 'Base Data'),
				wbCOED
      ], [])
    )
  ], wbAllowUnordered);

  wbMGEFType := wbStruct('Effect Type', [
    {64} wbInteger('Archtype', itU32, wbEnum([
      {00} 'Value Modifier',
      {01} 'Script',
      {02} 'Dispel',
      {03} 'Cure Disease',
      {04} 'Unknown 4',
      {05} 'Unknown 5',
      {06} 'Unknown 6',
      {07} 'Unknown 7',
      {08} 'Unknown 8',
      {09} 'Unknown 9',
      {10} 'Unknown 10',
      {11} 'Invisibility',
      {12} 'Chameleon',
      {13} 'Light',
      {14} 'Unknown 14',
      {15} 'Unknown 15',
      {16} 'Lock',
      {17} 'Open',
      {18} 'Bound Item',
      {19} 'Summon Creature',
      {20} 'Unknown 20',
      {21} 'Unknown 21',
      {22} 'Unknown 22',
      {23} 'Unknown 23',
      {24} 'Paralysis',
      {25} 'Unknown 25',
      {26} 'Unknown 26',
      {27} 'Unknown 27',
      {28} 'Unknown 28',
      {29} 'Unknown 29',
      {30} 'Cure Paralysis',
      {31} 'Cure Addiction',
      {32} 'Cure Poison',
      {33} 'Concussion',
      {34} 'Value And Parts',
      {35} 'Limb Condition',
      {36} 'Turbo'
    ]), cpNormal, False, nil, wbMGEFArchtypeAfterSet)
  ]);

  wbMGEFData := wbRstruct('Magic Effect Data', [
    wbByteArray(DATA, 'Data')
  ], []);

  wbRecord(MGEF, 'Base Effect', [
    wbEDIDReq,
    wbVMAD,
    wbFULL,
    wbFormID(MDOB, 'Menu Display Object'),
    wbKSIZ,
    wbKWDAs,
    wbByteArray(DATA),
    wbUnknown(SNDD),
    wbUnknown(DNAM),
    wbCTDAs
  ], wbAllowUnordered);


  wbRecord(MISC, 'Misc. Item', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbSCRI,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbKSIZ,
    wbKWDAs,
    wbByteArray(DATA, 'Data'),
    wbFormIDCk(RNAM, 'Sound - Random/Looping', [SOUN])
  ], wbAllowUnordered);

  wbRecord(APPA, 'Alchemical Apparatus', [
    wbEDID,
    wbOBNDReq,
    wbFULL,
    wbUnknown(QUAL),
    wbDESC,
    wbMODL,
    wbICON,
    wbSCRI,
    wbUnknown(DATA)
  ], wbAllowUnordered);

  wbRecord(COBJ, 'Constructible Object', [
    wbEDID,
    wbCOCT,
    wbCNTOs,
    wbCTDAs,
    wbFormID(CNAM, 'Unknown'),
    wbFormID(BNAM, 'Unknown'),
    wbUnknown(NAM1)
  ], wbAllowUnordered);

  wbFaceGen := wbRStruct('FaceGen Data', [
    wbByteArray(FGGS, 'FaceGen Geometry-Symmetric'),
    wbByteArray(FGGA, 'FaceGen Geometry-Asymmetric'),
    wbByteArray(FGTS, 'FaceGen Texture-Symmetric')
  ], []);

  wbFaceGenNPC := wbRStruct('FaceGen Data', [
    wbByteArray(FGGS, 'FaceGen Geometry-Symmetric'),
    wbByteArray(FGGA, 'FaceGen Geometry-Asymmetric'),
    wbByteArray(FGTS, 'FaceGen Texture-Symmetric')
  ], []);

  wbRecord(NPC_, 'Non-Player Character', [
    wbEDIDReq,
    wbVMAD,
    wbOBNDReq,
    wbByteArray(ACBS, 'Configuration'),
    wbRArray('Factions', wbRStruct('Faction', [
      wbByteArray(SNAM, 'Data')
    ], [])),
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
    wbRArray('Attack Data', wbATKD),
    wbArray(ATKE, 'Attack Event', wbString),
    wbFormIDCk(SPOR, 'Spectator override package list', [FLST], False, cpNormal, False),
    wbFormIDCk(ECOR, 'Combat override package list', [FLST], False, cpNormal, False),
    wbByteArray(PRKZ, 'Perk Count'),
    wbRArray('Perks', wbPRKR),
    wbFormIDCk(OCOR, 'Observe dead body override package list', [FLST], False, cpNormal, False),
    wbFormIDCk(GWOR, 'Guard warn override package list', [FLST], False, cpNormal, False),
    wbCOCTReq,
    wbCNTOs,
    wbAIDT,
    wbRArray('Packages', wbFormIDCk(PKID, 'Package', [PACK]), cpNormal, False, wbActorTemplateUseAIPackages),
    wbKSIZ,
    wbKWDAs,
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
    wbByteArray(NAM6, 'Height'),
    wbByteArray(NAM7, 'Weight'),
    wbByteArray(NAM8, 'Sound Level'),
    wbCSDTs,
    // When CSCR exists CSDT, CSDI, CSDC are not present
    wbFormIDCk(CSCR, 'Inherits Sounds From', [NPC_], False, cpNormal, False),
    wbFormIDCk(DOFT, 'Default outfit', [OTFT], False, cpNormal, False),
    wbFormIDCk(SOFT, 'Sleeping outfit', [OTFT], False, cpNormal, False),
    wbFormIDCk(DPLT, 'Default Package List', [FLST], False, cpNormal, False),
    wbFormIDCk(CRIF, 'Crime faction', [FACT], False, cpNormal, False),
    wbFormIDCk(FTST, 'Head texture', [TXST], False, cpNormal, False),
    wbByteArray(QNAM, 'Texture lightning'),
    wbByteArray(NAM9, 'Face morph'),
    wbByteArray(NAMA, 'Face parts'),
    wbRArray('Tint Layers', wbRStruct('Layer', [
      wbInteger(TINI, 'Tint Index', itU16),
      wbByteArray(TINC, 'Tint Color'),
      wbByteArray(TINV, 'Interpolation Value'),
      wbByteArray(TIAS, 'Preset')
    ], []))
  ], wbAllowUnordered);

  wbPKDTFlags := wbFlags([
          {0x00000001} 'Unknown 1',
          {0x00000002} 'Unknown 2',
          {0x00000004} 'Must complete',
          {0x00000008} 'Maintain Speed at Goal',
          {0x00000010} 'Unknown 5',
          {0x00000020} 'Unknown 6',
          {0x00000040} 'Unlock doors at package start',
          {0x00000080} 'Unlock doors at package end',
          {0x00000100} 'Unknown 9',
          {0x00000200} 'Unknown 10',
          {0x00000400} 'Once per day',
          {0x00000800} 'Unknown 12',
          {0x00001000} 'Unknown 13',
          {0x00002000} 'Preferred Speed',
          {0x00004000} 'Unknown 15',
          {0x00008000} 'Unknown 16',
          {0x00010000} 'Unknown 17',
          {0x00020000} 'Allow Sneak',
          {0x00040000} 'Allow Sweeming',
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
          {0x20000000} 'Wear Sleep Outfit',
          {0x40000000} 'Unknown 31',
          {0x80000000} 'Unknown 32'
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
          {11} 'Unknown 11',
          {12} 'Sandbox',
          {13} 'Patrol',
          {14} 'Guard',
          {15} 'Dialogue',
          {16} 'Use Weapon',
          {17} 'Unknown 17',
          {18} 'Unknown 18',
          {19} 'Unknown 19',
          {20} 'Unknown 20',
          {21} 'Unknown 21',
          {22} 'Unknown 22',
          {23} 'Unknown 23',
          {24} 'Unknown 24',
          {25} 'Unknown 25',
          {26} 'Unknown 26',
          {27} 'Unknown 27',
          {28} 'Unknown 28',
          {29} 'Unknown 29',
          {30} 'Unknown 30',
          {31} 'Unknown 31',
          {32} 'Unknown 32'
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
//          '',
          'Actors: Any'
        ]);

  wbPKDTSpecificFlagsUnused := False;

  wbPKDT := wbStruct(PKDT, 'Pack Data', [
    wbInteger('General Flags', itU32, wbPKDTFlags),
    wbInteger('Type', itU8, wbPKDTType),
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
    wbInteger('Interrupt Flags', itU32, wbFlags([
      {0x00000001}'Hellos to player',
      {0x00000002}'Random conversations',
      {0x00000004}'Observe combat behavior',
      {0x00000008}'Greet corpse behavior',
      {0x00000010}'Reaction to player actions',
      {0x00000020}'Friendly fire comments',
      {0x00000040}'Aggro Radius Behavior',
      {0x00000080}'Allow Idle Chatter',
      {0x00000100}'Unknown 9',
      {0x00000200}'World Interactions',
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

  wbPLDT := wbStruct(PLDT, 'Location', [
    wbInteger('Type', itS32, wbEnum([
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
    ])),
    wbUnion('Location Value', wbPxDTLocationDecider, [
      {0} wbFormIDCkNoReach('Reference', [REFR, PGRE, PMIS, ACHR, ACRE, PLYR], True),
      {1} wbFormIDCkNoReach('Cell', [CELL]),
      {2} wbByteArray('Unknown', 4, cpIgnore),
      {3} wbByteArray('Unknown', 4, cpIgnore),
      {4} wbFormIDCkNoReach('Object ID', [ACTI, DOOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, CHIP]),
      {5} wbInteger('Object Type', itU32, wbObjectTypeEnum),
      {6} wbFormIDCk('Keyword', [KYWD]),
      {7} wbByteArray('Unknown', 4, cpIgnore),
      {8} wbByteArray('Alias ID', 4),
      {9} wbFormIDCkNoReach('Reference', [REFR, PGRE, PMIS, ACHR, ACRE, PLYR], True),
     {10} wbByteArray('Unknown', 4, cpIgnore),
     {11} wbByteArray('Unknown', 4, cpIgnore),
     {12} wbByteArray('Unknown', 4, cpIgnore)
    ]),
    wbInteger('Radius', itS32)
  ]);

  wbPTDA := wbStruct(PTDA, 'Target Value', [
    wbInteger('Type', itS32, wbEnum([
      {0} 'Specific Reference',
      {1} 'Object ID',
      {2} 'Object Type',
      {3} 'Linked Reference',
      {4} 'Ref Alias',
      {5} 'Unknown 5',
      {6} 'Self'
    ]), cpNormal, False, nil, nil, 2),
    wbUnion('Target', wbPxDTLocationDecider, [
      {0} wbFormIDCkNoReach('Reference', [ACHR, ACRE, REFR, PGRE, PMIS, PLYR], True),
      {1} wbFormIDCkNoReach('Object ID', [ACTI, DOOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, FACT, FLST, IDLM, CHIP]),
      {2} wbInteger('Object Type', itU32, wbObjectTypeEnum),
      {3} wbFormID('Reference'),
      {4} wbByteArray('Alias ID', 4),
      {5} wbByteArray('Unknown', 4, cpIgnore),
      {6} wbByteArray('Unknown', 4, cpIgnore)
    ]),
    wbInteger('Count / Distance', itS32)
  ]);

  wbIDLF := wbRStruct('Idle Animations', [
    wbInteger(IDLF, 'Flags', itU8, wbFlags([
      'Run in Sequence',
      '',
      'Do Once'
    ]), cpNormal, True),
    wbStruct(IDLC, '', [
      wbInteger( 'Animation Count', itU8),
      wbByteArray('Unknown', 3)
    ], cpNormal, True, nil, 1),
    wbFloat(IDLT, 'Idle Timer Setting', cpNormal, True),
    wbArray(IDLA, 'Animations', wbFormIDCk('Animation', [IDLE]), 0, nil, nil, cpNormal, True),
    wbByteArray(IDLB, 'Unknown', 4, cpIgnore)
  ], []);

  wbUNAMs:= wbRArray('Activity IDs', wbRStruct('Activity', [
    wbByteArray(UNAM, 'ID'),
    wbString(BNAM, 'Name'),
    wbUnknown(PNAM)
  ], []));

  wbINAM := wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True);
  wbPDTOs := wbArray(PDTO, 'Topic', wbFormIDCk('Topic', [DIAL, NULL]), 0, nil, nil, cpNormal, True);

  wbPubPack := wbRStruct('Public Package Data', [
    wbRArray('Activities', wbRStruct('Activity', [
      wbString(ANAM, 'Activity Type'),
      wbByteArray(CNAM, 'Activity Value'),
      wbUnknown(BNAM),
      wbPDTOs,
      wbByteArray(PLDT),
      wbByteArray(PTDA),
      wbUnknown(TPIC)
    ], [], cpNormal, False)),
    wbUNAMs
  ], []);

  wbProdTree := wbRStruct('Procedure Tree', [
    wbRArray('Branches', wbRStruct('Branch', [
      wbString(ANAM, 'Branch Type'),
      wbByteArray(CITC, 'Condition Count'),
      wbCTDAs,
      wbUnknown(PRCB),
      wbString(PNAM, 'Procedure Type'),
      wbByteArray(FNAM, 'Flags'),
      wbRArray('Some PK C2', wbRStruct('PKC2 Array', [
        wbUnknown(PKC2)
      ], [])),
      wbRArray('Some PFO2', wbUnknown(PFO2)),
      wbRArray('Some PFOR', wbUnknown(PFOR))
    ], []))
  ], []);

//------------------------------------------------------------------------------
// Begin PACK
//------------------------------------------------------------------------------
  wbRecord(PACK, 'Package', [
    wbEDIDReq,
    wbVMAD,
    wbPKDT,
    wbPSDT,
    wbCTDAs,
    wbIDLF,
    wbFormIDCk(CNAM, 'Combat Style', [CSTY]),
    wbFormIDCk(QNAM, 'Owner Quest', [QUST]),
    wbByteArray(PKCU, 'PKCU'),
    wbPubPack,
    wbUnknown(XNAM),
    wbProdTree,
    wbUNAMs,
    wbRStruct('OnBegin', [
      wbByteArray(POBA, 'OnBegin Marker'),
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
      wbByteArray(POCA, 'OnChange Marker'),
      wbINAM,
      wbUnknown(SCHR),
      wbUnknown(SCDA),
      wbUnknown(SCTX),
      wbUnknown(QNAM),
      wbUnknown(TNAM),
      wbPDTOs
    ], [])
  ], wbAllowUnordered);
//------------------------------------------------------------------------------
// End PACK
//------------------------------------------------------------------------------

  wbRecord(QUST, 'Quest', [
    wbEDIDReq,
    wbVMAD,
    wbSCRI,
    wbFULL,
    wbUnknown(DNAM),
    wbUnknown(ENAM),
    wbRArray('Unknown - QTGL', wbRStruct('Unknown', [
      wbUnknown(QTGL)
    ], [])),
    wbString(FLTR, 'Object Window Filter', 0, cpTranslate),

    wbRStruct('Conditions (Begin)', [
      wbCTDAs
    ], [], cpNormal, True),
    wbRStruct('Conditions (End)', [
      wbByteArray(NEXT, 'Marker'),
      wbCTDAs
    ], [], cpNormal, True),

    wbICON,
    wbByteArray(DATA, 'General'),
    wbRArrayS('Stages', wbRStruct('Stage', [
      wbByteArray(INDX, 'Stage Index'),
      wbRArray('Log Entries', wbRStruct('Log Entry', [
        wbByteArray(QSDT, 'Stage Flags'),
        wbCTDAs,
        wbLString(CNAM, 'Log Entry'),
        wbEmbeddedScriptReq,
        wbFormIDCk(NAM0, 'Next Quest', [QUST]),
        wbUnknown(SCHR),
        wbUnknown(QNAM),
        wbUnknown(SCTX)
      ], []))
    ], [])),
    wbRArray('Objectives', wbRStruct('Objective', [
      wbByteArray(QOBJ, 'Objective Index'),
      wbUnknown(FNAM),
      wbLString(NNAM, 'Description', 0, cpNormal, True),
      wbRArray('Targets', wbRStruct('Target', [
        wbByteArray(QSTA, 'Target'),
        wbCTDAs
      ], []))
    ], [])),
    wbUnknown(ANAM),
    wbRArray('ALST/ALLS',
      wbRUnion('Union', [
        wbRStruct('ALST/ALLS', [
          wbUnknown(ALST),
          wbString(ALID, 'Alias Name', 0, cpTranslate),
          wbUnknown(FNAM),
          wbUnknown(ALNA),
          wbUnknown(ALNT),
          wbUnknown(ALFI),
          wbUnknown(ALFE),
          wbUnknown(ALFD),
          wbUnknown(ALUA),
          wbUnknown(ALFR),
          wbCTDAs,
          wbUnknown(ALCO),
          wbUnknown(ALCA),
          wbUnknown(ALCL),
          wbUnknown(ALFA),
          wbUnknown(ALRT),
          wbKSIZ,
          wbKWDAs,
          wbUnknown(ALEQ),
          wbUnknown(ALEA),
          wbCOCT,
          wbCNTOs,
          wbUnknown(SPOR),
          wbUnknown(ECOR),
          wbUnknown(ALDN),
          wbRArray('Unknown - ALSP', wbRStruct('Unknown', [
            wbUnknown(ALSP)
          ], [])),
          wbRArray('Unknown - ALFC', wbRStruct('Unknown', [
            wbUnknown(ALFC)
          ], [])),
          wbRArray('Unknown - ALPC', wbRStruct('Unknown', [
            wbUnknown(ALPC)
          ], [])),
          wbUnknown(VTCK),
          wbUnknown(ALED)
        ], []),
        wbRStruct('The ALLS', [
          wbUnknown(ALLS),
          wbString(ALID, 'Alias Name', 0, cpTranslate),
          wbUnknown(FNAM),
          wbUnknown(ALFI),
          wbUnknown(ALFE),
          wbUnknown(ALFD),
          wbCTDAs,
          wbUnknown(ALCO),
          wbUnknown(ALFL),
          wbUnknown(ALFA),
          wbUnknown(ALEQ),
          wbUnknown(ALEA),
          wbUnknown(KNAM),
          wbUnknown(ALED)
        ], [])
      ], [])
    ),
    wbCTDAs,
    wbString(NNAM, 'Description', 0, cpNormal, True),
    wbRArray('Targets', wbRStruct('Target', [
      wbByteArray(QSTA, 'Target'),
      wbCTDAs
    ], [])),
    wbCOCT,
    wbCNTOs,
    wbKSIZ,
    wbKWDAs,
    wbUnknown(NAM0)
  ], wbAllowUnordered);

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

  wbBodyPartIndexEnum := wbEnum([
    'Upper Body',
    'Left Hand',
    'Right Hand',
    'Upper Body Texture'
  ]);

  wbSizeIndexEnum := wbEnum([
    'Small',
    'Medium',
    'Large',
    'Extra Large'
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
    wbRArray('Array TINI, TINT, TINP, TIND', wbRStruct('Unknown', [
      wbUnknown(TINI),
      wbString(TINT, 'File Name'),
      wbUnknown(TINP),
      wbFormIDCk(TIND, 'Head Feature Set', [CLFM, NULL])
    ], [])),
    wbRArray('Array TINC, TINV, TIRS', wbRStruct('Unknown', [
      wbStruct(TINC, 'Reference Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unknown', 1)
      ]),
			wbUnknown(TINV),
			wbUnknown(TIRS)
    ], []))
  ], []));

  wbRecord(RACE, 'Race', [
    wbEDIDReq,
    wbFULLReq,
    wbDESCReq,
    wbSPCT,
    wbSPLOs,
    wbFormIDCk(WNAM, 'Skin', [ARMO, NULL]),
    wbArrayS(BODT, 'Body Templates', wbByteArray('Unknown', 4), 0, cpNormal, True),
    wbKSIZ,
    wbKWDAs,
    wbXNAMs,
    wbByteArray(DATA, 'Data'),
    wbRStruct('Start Of Male', [
      wbByteArray(MNAM, 'Marker'),
      wbString(ANAM, 'Skeletal Model'),
      wbMODT
    ], [], cpNormal, True),
    wbRStruct('Start Of Female', [
      wbByteArray(FNAM, 'Marker'),
      wbString(ANAM, 'Skeletal Model'),
      wbMODT
    ], [], cpNormal, True),
    wbFormIDCk(YNAM, 'Younger', [RACE]),
    wbByteArray(NAM2, 'Unknown Marker'),
    wbRArray('Array MTNM', wbRStruct('Unknown', [
      wbString(MTNM, 'Unknown')
    ], [])),
    wbArray(VTCK, 'Voices', wbFormIDCk('Voice', [VTYP]), ['Male', 'Female'], cpNormal, True),
    wbByteArray(CNAM, 'Default Hair Colors'),
    wbArray(DNAM, 'Decapitate Armors', wbFormIDCk('Decapitate Armor', [ARMO]), ['Male', 'Female'], cpNormal, True),
    wbArray(HCLF, 'Default Hair Colors', wbFormIDCk('Default Hair Color', [CLFM]), ['Male', 'Female'], cpNormal, True),
    wbArrayS(TINL, 'Body Templates', wbByteArray('Unknown', 0)),
    wbByteArray(PNAM, 'FaceGen - Main clamp'),
    wbByteArray(UNAM, 'FaceGen - Face clamp'),
    wbByteArray(ATTR, 'Unknown'),
    wbRArray('Array ATKD, ATKE', wbRStruct('Unknown', [
			wbATKD,
			wbString(ATKE, 'Attack Event')
    ], [])),
    wbRStruct('Body Data', [
      wbByteArray(NAM1, 'Body Data Marker'),
      wbRStruct('Male Body Data', [
        wbByteArray(MNAM, 'Male Data Marker'),
        wbRArrayS('Parts', wbRStruct('Part', [
          wbByteArray(INDX, 'Index'),
          wbICON,
          wbMODLReq
        ], []))
      ], []),
      wbRStruct('Female Body Data', [
        wbByteArray(FNAM, 'Female Data Marker'),
        wbRArrayS('Parts', wbRStruct('Part', [
          wbByteArray(INDX, 'Index'),
          wbICON,
          wbMODLReq
        ], []))
      ], [])
    ], []),
    wbArrayS(HNAM, 'Hairs', wbFormIDCk('Hair', [HAIR]), 0, cpNormal, True),
    wbArrayS(ENAM, 'Eyes', wbFormIDCk('Eye', [EYES]),  0,  cpNormal, True),
    wbFormIDCk(GNAM, 'Body Part Data', [BPTD, NULL]),
	  wbByteArray(NAM2, 'Marker 2'),
	  wbByteArray(NAM3, 'Marker 3'),
    wbRStruct('Start Of Male', [
      wbByteArray(MNAM, 'Male Data Marker'),
      wbMODL
    ], [], cpNormal, True),
    wbRStruct('Start Of Female', [
      wbByteArray(FNAM, 'Female Data Marker'),
      wbMODL
    ], [], cpNormal, True),
    wbFormIDCk(NAM4, 'Material Type', [MATT, NULL]),
    wbFormIDCk(NAM5, 'Impact Data Set', [IPDS, NULL]),
		wbFormIDCk(NAM7, 'Decapitation FX', [ARTO, NULL]),
    wbFormIDCk(ONAM, 'Open Loot Sound', [SNDR, NULL]),
    wbFormIDCk(LNAM, 'Close Loot Sound', [SNDR, NULL]),
    wbRArray('Array NAME', wbRStruct('Unknown', [
      wbString(NAME, 'Unknown')
    ], [])),
    wbRArray('Array MTYP, SPED', wbRStruct('Unknown', [
      wbFormIDCk(MTYP, 'Movement Type', [MOVT, NULL]),
      wbUnknown(SPED)
    ], [])),
    wbUnknown(VNAM),
    wbRArray('Array QNAM', wbRStruct('Unknown', [
			wbFormIDCk(QNAM, 'Equip Slot', [EQUP, NULL])
    ], [])),
    wbFormIDCk(UNES, 'Unarmed Equip Slot', [EQUP, NULL]),
    wbRArray('Array PHTN', wbRStruct('Unknown', [
      wbString(PHTN, 'Unknown')
    ], [])),
    wbRArray('Array PHWT', wbRStruct('Unknown', [
      wbByteArray(PHWT, 'Unknown', 0)
    ], [])),
    // Start Head Data
    wbRStruct('Head Data', [
      wbByteArray(NAM0, 'Head Data Marker'),
      wbRStruct('Male Head Data', [
        wbByteArray(MNAM, 'Male Data Marker'),
          wbRArray('Array INDX, HEAD', wbRStruct('Unknown', [
            wbByteArray(INDX, 'Index'),
            wbFormIDCk(HEAD, 'Head', [HDPT, NULL])
          ], [])),
          wbRArray('Array MPAI, MPAV', wbRStruct('Unknown', [
            wbByteArray(MPAI, 'Unknown', 0),
            wbByteArray(MPAV, 'Unknown', 0)
          ], [])),
          wbRArray('Array RPRM', wbRStruct('Unknown', [
            wbFormIDCk(RPRM, 'Equip Slot', [NPC_, NULL])
          ], [])),
          wbRArray('Array AHCM', wbRStruct('Unknown', [
            wbFormIDCk(AHCM, 'Hair Color Male', [CLFM, NULL])
          ], [])),
          wbRArray('Array FTSM', wbRStruct('Unknown', [
            wbFormIDCk(FTSM, 'Hair Color Male', [TXST, NULL])
          ], [])),
          wbFormIDCk(DFTM, 'Head Feature Set', [TXST, NULL]),
          wbTintMasks,
          wbMODLReq,
          wbICON
      ], [], cpNormal, True),
      wbRStruct('Female Head Data', [
        wbByteArray(NAM0, 'Head Data Marker'),
        wbByteArray(FNAM, 'Female Data Marker'),
          wbRArray('Array INDX, HEAD', wbRStruct('Unknown', [
            wbByteArray(INDX, 'Index'),
            wbUnknown(HEAD)
          ], [])),
          wbRArray('Array MPAI, MPAV', wbRStruct('Unknown', [
            wbByteArray(MPAI, 'Unknown', 0),
            wbByteArray(MPAV, 'Unknown', 0)
          ], [])),
          wbRArray('Array RPRF', wbRStruct('Unknown', [
            wbFormIDCk(RPRF, 'Equip Slot', [NPC_, NULL])
          ], [])),
          wbRArray('Array AHCF', wbRStruct('Unknown', [
            wbFormIDCk(AHCF, 'Hair Color Female', [CLFM, NULL])
          ], [])),
          wbRArray('Array FTSF', wbRStruct('Unknown', [
            wbFormIDCk(FTSF, 'Hair Color Female', [TXST, NULL])
          ], [])),
          wbFormIDCk(DFTF, 'Head Feature Set', [TXST, NULL]),
          wbTintMasks,
          wbMODLReq,
          wbICON
      ], [], cpNormal, True)
    ], [], cpNormal, True),
    // End Head Data
    wbFormIDCk(NAM8, 'Morph race', [RACE, NULL]),
    wbFormIDCk(RNAM, 'Armor race', [RACE, NULL]),
		wbFormIDCk(WKMV, 'Movement', [MOVT, NULL]),
		wbFormIDCk(RNMV, 'Movement', [MOVT, NULL]),
		wbFormIDCk(SWMV, 'Movement', [MOVT, NULL]),
		wbFormIDCk(FLMV, 'Movement', [MOVT, NULL]),
		wbFormIDCk(SNMV, 'Movement', [MOVT, NULL])
  ], wbAllowUnordered);

//------------------------------------------------------------------------------
// Begin REFR
//------------------------------------------------------------------------------
// Pattern  1:           NAME XWCN XWCU                                              DATA
// Pattern  2:           NAME XWCN XWCU                                    XSCL      DATA
// Pattern  3:           NAME XLCM      XPRD XPPA INAM PDTO XLKR                     DATA
// Pattern  4:           NAME           XPRD XPPA INAM PDTO XLKR                     DATA
// Pattern  5: EDID      NAME XLKR      XPRD XPPA INAM PDTO                          DATA
// Pattern  6: EDID      NAME           XPRD XPPA INAM PDTO XLKR                     DATA
// Pattern  7: EDID      NAME           XPRD XPPA INAM PDTO                          DATA
// Pattern  8:      VMAD NAME                                              XSCL      DATA
// Pattern  9:           NAME                                    XLIB                DATA
// Pattern 10:           NAME XRDS      XLIG                                         DATA
// Pattern 11:           NAME           XLIG                                         DATA
// Pattern 12:           NAME                                    XALP      XSCL      DATA
// Pattern 13:           NAME XRDS XEMI XLIG                                         DATA
// Pattern 14:           NAME                                    XLIB XESP           DATA
// Pattern 15:           NAME                                         XLRT      XOWN DATA
// Pattern 16:           NAME XMBO XPRM XRMR LNAM                                    DATA
// Pattern 17:           NAME                                    XLIB                DATA
// Pattern 18:           NAME                                    XTEL XTNM XNDP      DATA
// Pattern 19:           NAME XMBO XPRM XRMR LNAM XLRM XLRM                          DATA
// Pattern 20: EDID      NAME                                              XIS2      DATA
// Pattern 21:           NAME XMBO XPRM XRMR LNAM INAM                               DATA
// Pattern 22:
// Pattern 23:
// Pattern 24: 					 NAME           XPRD XPPA INAM PDTO           XESP XIS2 XOWN DATA
// Pattern 25:           NAME           XPRD XPPA INAM PDTO                XIS2      DATA
// Pattern 26:           NAME 																						 XIS2      DATA
// Pattern 27:
// Pattern 28:
// Pattern 29:
// Pattern 30:
//------------------------------------------------------------------------------
  wbRecord(REFR, 'Placed Object', [
    wbEDID,
    wbUnknown(VMAD),
    wbFormIDCk(NAME, 'Base', [TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, LVLN, LVLC,
                              MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, CHIP,
                              MSTT, NOTE, PWAT, SCOL, TACT, TERM, TXST, CCRD], False, cpNormal, True),
    wbDataPosRot
  ], wbAllowUnordered);
//------------------------------------------------------------------------------
// End REFR
//------------------------------------------------------------------------------

  wbRecord(REGN, 'Region', [
    wbEDID,

    wbStruct(RCLR, 'Map Color', [
      wbInteger('Red', itU8),
      wbInteger('Green', itU8),
      wbInteger('Blue', itU8),
      wbByteArray('Unknown', 1)
    ]),
    wbFormIDCkNoReach(WNAM, 'Worldspace', [WRLD]),

    wbRArray('Region Areas', wbRStruct('Region Area', [
      wbByteArray(RPLI, 'Edge Fall-off'),
      wbArray(RPLD, 'Region Point List Data', wbStruct('Point', [
        wbFloat('X'),
        wbFloat('Y')
      ]))
    ], [])),

    wbRArray('Region Data Entries', wbRStruct('Region Data Entry', [
      {always starts with an RDAT}
      wbByteArray(RDAT),

      {--- Icon ---}
      wbICON,

      {--- Sound ---}
      wbByteArray(RDMD, 'Music Type'),
      wbFormIDCk(RDMO, 'Music', [MUSC]),
      wbFormIDCk(RDSI, 'Incidental MediaSet', [MSET]),
      wbRArray('Battle MediaSets', wbFormIDCk(RDSB, 'Battle MediaSet', [MSET])),
      wbRArrayS('Sounds', wbRStruct('Sound', [
				wbByteArray(RDSA, 'Sound')
			], [])),

			{--- Map ---}
      wbLString(RDMP, 'Map Name'),

      {followed by one of these: }

      {--- Objects ---}
      wbRArray('Objects', wbRStruct('Object', [
				wbByteArray(RDOT, 'Object')
			], [])),

      {--- Grass ---}
      wbRArray('Grasses', wbRStruct('Grass', [
        wbByteArray(RDGS, 'Unknown')
      ], [])),

      {--- Weather ---}
      wbRArray('Weather Types', wbRStruct('Weather Type', [
        wbByteArray(RDWT, 'Weather Type')
      ], [])),

      {--- Imposter ---}
      wbArrayS(RDID, 'Imposters', wbFormIDCk('Imposter', [REFR]))
    ], []))
  ], wbAllowUnordered);

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
    wbByteArray(SNDD,'Some Values'),
    wbFormIDCk(SDSC, 'Sound Descriptor', [SNDR, NULL])
  ], wbAllowUnordered);

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
      wbInteger('Cast Type', itU32, wbEnum([
        {0} 'Constant Effect',
        {1} 'Fire and Forget',
        {2} 'Concentration'
      ])),
      wbInteger('Type', itU32, wbEnum([
        {0} 'Self',
        {1} 'Touch',
        {2} 'Aimed',
        {3} 'Target Actor',
        {4} 'Target Location'
      ])),
      wbFloat('Cast Duration'),
      wbFloat('Range'),
      wbFormIDCk('Half-cost Perk', [PERK])
    ], cpNormal, True);

  wbRecord(SPEL, 'Actor Effect', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbKSIZ,
    wbKWDAs,
    wbMDOB,
    wbFormIDCk(ETYP, 'Equip Type', [EQUP, NULL]),
    wbDESCReq,
    wbByteArray(SPIT, 'Spell Effect'),
    wbEffectsReq // EFID, EFIT, CTDA
  ], wbAllowUnordered);

  wbRecord(SCRL, 'SCRL', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbKSIZ,
    wbKWDAs,
    wbMDOB,
    wbFormIDCK(ETYP, 'Equip Type', [EQUP, NULL]),
    wbDESC,
    wbMODL,
    wbUnknown(DATA),
    wbUnknown(SPIT),
    wbRArray('Array of EFID and EFIT', wbRStruct('Unknown', [
      wbFormIDCK(EFID, 'Magic Effect', [MGEF, NULL]),
      wbUnknown(EFIT),
      wbCTDAs
    ], []))
  ], wbAllowUnordered);

  wbRecord(STAT, 'Static', [
    wbEDIDReq,
    wbOBNDReq,
    wbMODL,
    wbUnknown(DNAM),
    wbUnknown(MNAM)
 ], wbAllowUnordered);

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
    wbByteArray(CNAM, 'Tree Data'),
    wbByteArray(BNAM, 'Billboard Dimensions')
  ], wbAllowUnordered);

  wbRecord(FLOR, 'Flora', [
    wbEDID,
    wbVMAD,
    wbOBND,
    wbFULL,
    wbMODL,
    wbSCRI,
    wbUnknown(PNAM),
    wbLString(RNAM, 'Unknown'),
    wbUnknown(FNAM),
    wbFormIDCk(PFIG, 'Ingredient', [INGR, ALCH, NULL]),
    wbFormIDCK(SNAM, 'Sound', [SNDR, NULL]),
    wbByteArray(PFPC, 'Seasonal ingredient production')
  ], wbAllowUnordered);
end;

procedure DefineTES5f;
begin

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
      wbByteArray(DNAM, 'Visual Data'),
      wbByteArray(DATA, 'Visual Data')
    ], []),
    wbByteArray(GNAM, 'Related Waters'),
    wbUnknown(NAM0),
    wbUnknown(NAM1),
    wbUnknown(NAM2),
    wbUnknown(NAM3),
    wbUnknown(NAM4)
  ], wbAllowUnordered);

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
    wbKSIZ,
    wbKWDAs,
    wbDESC,
    wbBIPL,
    wbYNAM,
    wbZNAM,
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
    wbByteArray(DATA, 'Data'),
    wbByteArray(DNAM, 'Data'),
    wbByteArray(CRDT, 'Critical Data'),
    wbByteArray(VATS, 'VATS'),
    wbByteArray(VNAM, 'Sound Level'),
    wbFormID(CNAM, 'Unknown')
  ], wbAllowUnordered);

  wbRecord(WRLD, 'Worldspace', [
    wbEDIDReq,
    wbRArray('Array RNAM', wbRStruct('Unknown', [
      wbUnknown(RNAM)
    ], [])),
    wbFULL,
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),
    wbRStruct('Parent', [
      wbFormIDCk(WNAM, 'Worldspace', [WRLD]),
      wbByteArray(PNAM, 'Data')
    ], []),
    wbFormIDCk(CNAM, 'Climate', [CLMT]),
    wbFormIDCk(NAM2, 'Water', [WATR]),
    wbFormIDCk(NAM3, 'LOD Water Type', [WATR]),
    wbByteArray(NAM4, 'LOD Water Height'),
    wbByteArray(DNAM, 'Land Data'),
    wbICON,
    wbByteArray(MNAM, 'Map Data'),
    wbByteArray(ONAM, 'World Map Offset Data'),
    wbFormIDCk(INAM, 'Image Space', [IMGS]),
    wbUnknown(NAMA),
    wbByteArray(DATA, 'Flags'),
    wbRStruct('Object Bounds', [
      wbByteArray(NAM0, 'Min'),
      wbByteArray(NAM9, 'Max')
    ], []),
    wbFormIDCk(ZNAM, 'Music', [MUSC]),
    wbString(NNAM, 'Canopy Shadow'),
    wbString(XNAM, 'Water Noise Texture'),
    wbRArrayS('Swapped Impacts', wbRStruct('Swapped Impact', [
			wbByteArray(IMPS, 'Swapped Impact')
    ], [])),
    wbByteArray(IMPF, 'Footstep Materials'),
    wbUnknown(TNAM),
    wbUnknown(UNAM),
    wbByteArray(OFST, 'Unknown', 0)
  ], wbAllowUnordered);

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
    wbUnknown(MNAM),
    wbUnknown(NNAM),
//    wbArray(ONAM, 'Cloud Speed', wbInteger('Layer', itU8{, wbDiv(2550)}), 4, nil, nil, cpNormal, True),
    wbUnknown(ONAM),
    wbUnknown(RNAM),
    wbUnknown(QNAM),
    wbUnknown(PNAM),
//    wbByteArray(PNAM, 'Unknown', 0, cpIgnore),
//    wbRArray('Unknown - PNAM', wbRStruct('Unknown', [
//      wbArray(PNAM, 'Unknown', wbFormID('Unknown'), 0, nil, nil, cpNormal, True)
//    ], [])),
    wbUnknown(JNAM),
//    wbRArray('Unknown - PNAM', wbRStruct('Unknown', [
//      wbArray(JNAM, 'Unknown', wbFormID('Unknown'), 0, nil, nil, cpNormal, True)
//    ], [])),
    wbUnknown(NAM0),
//    wbArray(NAM0, 'Colors by Types/Times',
//      wbArray('Type',
//        wbStruct('Time', [
//          wbInteger('Red', itU8),
//          wbInteger('Green', itU8),
//          wbInteger('Blue', itU8),
//          wbByteArray('Unknown', 1)
//        ]),
//        ['Sunrise', 'Day', 'Sunset', 'Night', 'High Noon', 'Midnight']
//      ),
//      ['Sky-Upper','Fog','Clouds-Lower','Ambient','Sunlight','Sun','Stars','Sky-Lower','Horizon','Clouds-Upper']
//    , cpNormal, True),
    wbRArray('Unknown - NAM0', wbRStruct('Unknown', [
      wbArray(NAM0, 'Unknown', wbFormID('Unknown'), 0, nil, nil, cpNormal, True)
    ], [])),
//    wbStruct(FNAM, 'Fog Distance', [
//      wbFloat('Day - Near'),
//      wbFloat('Day - Far'),
//      wbFloat('Night - Near'),
//      wbFloat('Night - Far'),
//      wbFloat('Day - Power'),
//      wbFloat('Night - Fower')
//    ], cpNormal, True),
    wbUnknown(FNAM),
//    wbByteArray(INAM, 'Unknown', 304, cpIgnore, True),
//    wbUnknown(INAM),
    wbByteArray(DATA, 'Data'),
    wbUnknown(NAM1),
    wbRArray('Sounds', wbRStruct('Unknown', [
      wbArray(SNAM, 'Sounds', wbFormIDCK('Sound', [SNDR, NULL]), 0, nil, nil, cpNormal, True)
    ], [])),
    wbRArray('Unknown - TNAM', wbRStruct('Unknown', [
      wbFormID(TNAM, 'Unknown')
    ], [])),
    wbUnknown(IMSP),
    wbRArray('Unknown - DALC', wbRStruct('Unknown', [
      wbArray(DALC, 'Unknown', wbByteArray('Unknown', 4), 0, nil, nil, cpNormal, True)
    ], [])),
    wbUnknown(NAM2),
    wbUnknown(NAM3),
    wbMODL
  ], wbAllowUnordered);

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
    wbByteArray(DATA, 'Data')
  ], wbAllowUnordered);

  wbRecord(ALOC, 'Media Location Controller', [
    wbEDIDReq,
    wbFULL,
    wbByteArray(NAM1, 'Flags and Enums, messily combined'),
    wbUnknown(NAM2),
    wbUnknown(NAM3),
    wbFloat(NAM4, 'Location Delay'),
    wbByteArray(NAM5, 'Day Start'),
    wbByteArray(NAM6, 'Night Start'),
    wbByteArray(NAM7, 'Retrigger Delay'),
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
  ], wbAllowUnordered);

  wbRecord(MSET, 'Media Set', [
    wbEDIDReq,
    wbFULL,
    wbByteArray(NAM1, 'Type'),
    wbString(NAM2, 'Loop (B) / Battle (D) / Day Outer (L)'),
    wbString(NAM3, 'Explore (D) / Day Middle (L)'),
    wbString(NAM4, 'Suspense (D) / Day Inner (L)'),
    wbString(NAM5, 'Night Outer (L)'),
    wbString(NAM6, 'Night Middle (L)'),
    wbString(NAM7, 'Night Inner (L)'),
    wbByteArray(NAM8, 'Loop dB (B) / Battle dB (D) / Day Outer dB (L)'),
    wbByteArray(NAM9, 'Explore dB (D) / Day Middle dB (L)'),
    wbByteArray(NAM0, 'Suspense dB (D) / Day Inner dB (L)'),
    wbByteArray(ANAM, 'Night Outer dB (L)'),
    wbByteArray(BNAM, 'Night Middle dB (L)'),
    wbByteArray(CNAM, 'Night Inner dB (L)'),
    wbByteArray(JNAM, 'Day Outer Boundary % (L)'),
    wbByteArray(KNAM, 'Day Middle Boundary % (L)'),
    wbByteArray(LNAM, 'Day Inner Boundary % (L)'),
    wbByteArray(MNAM, 'Night Outer Boundary % (L)'),
    wbByteArray(NNAM, 'Night Middle Boundary % (L)'),
    wbByteArray(ONAM, 'Night Inner Boundary % (L)'),
    wbByteArray(PNAM, 'Enable Flags'),
    wbByteArray(DNAM, 'Wait Time (B) / Minimum Time On (D,L) / Daytime Min (I)'),
    wbByteArray(ENAM, 'Loop Fade Out (B) / Looping/Random Crossfade Overlap (D,L) / Nighttime Min (I)'),
    wbByteArray(FNAM, 'Recovery Time (B) / Layer Crossfade Time (D,L) / Daytime Max (I)'),
    wbByteArray(GNAM, 'Nighttime Max (I)'),
    wbFormIDCk(HNAM, 'Intro (B,D) / Daytime (I)', [SOUN]),
    wbFormIDCk(INAM, 'Outro (B,D) / Nighttime (I)', [SOUN]),
    wbUnknown(DATA)
  ], wbAllowUnordered);

  wbRecord(AMEF, 'Ammo Effect', [
    wbEDIDReq,
    wbFULL,
    wbByteArray(DATA, 'Data')
  ], wbAllowUnordered);

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
      wbByteArray(INTV, 'Suit'),
      wbByteArray(INTV, 'Value')
    ], []),
    wbByteArray(DATA, 'Value')
  ], wbAllowUnordered);

  wbRecord(CDCK, 'Caravan Deck', [
    wbEDIDReq,
    wbFULL,
    wbRArrayS('Cards',
      wbFormIDCk(CARD, 'Card', [CCRD])
    ),
    wbByteArray(DATA, 'Count (broken)')
  ], wbAllowUnordered);

  wbRecord(CHAL, 'Challenge', [
    wbEDIDReq,
    wbFULL,
    wbSCRI,
    wbDESC,
    wbByteArray(DATA, 'Data'),
    wbFormID(SNAM, '(depends on type)'),
    wbFormID(XNAM, '(depends on type)')
  ], wbAllowUnordered);

  wbRecord(CHIP, 'Casino Chip', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbDEST,
    wbYNAM,
    wbZNAM
  ], wbAllowUnordered);

  wbRecord(CMNY, 'Caravan Money', [
    wbEDIDReq,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbYNAM,
    wbZNAM,
    wbInteger(DATA, 'Absolute Value', itU32)
  ], wbAllowUnordered);

  wbRecord(CSNO, 'Casino', [
    wbEDIDReq,
    wbFULL,
    wbByteArray(DATA, 'Data'),
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
  ], wbAllowUnordered);

  wbRecord(DEHY, 'Dehydration Stage', [
    wbEDIDReq,
    wbByteArray(DATA, 'Data')
  ], wbAllowUnordered);

  wbRecord(HUNG, 'Hunger Stage', [
    wbEDIDReq,
    wbByteArray(DATA, 'Data')
  ], wbAllowUnordered);

  wbRecord(LSCT, 'Load Screen Type', [
    wbEDIDReq,
    wbByteArray(DATA, 'Data')
  ], wbAllowUnordered);

  wbRecord(RCCT, 'Recipe Category', [
    wbEDIDReq,
    wbFULL,
    wbByteArray(DATA, 'Flags')
  ], wbAllowUnordered);

  wbRecord(RCPE, 'Recipe', [
    wbEDIDReq,
    wbFULL,
    wbCTDAs,
    wbByteArray(DATA, 'Data'),
    wbRStructs('Ingredients', 'Ingredient', [
      wbFormIDCk(RCIL, 'Item', [ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, NOTE, IMOD, CMNY, CCRD, CHIP, LIGH], False, cpNormal, True),
      wbByteArray(RCQY, 'Quantity')
    ], []),
    wbRStructs('Outputs', 'Output', [
      wbFormIDCk(RCOD, 'Item', [ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, NOTE, IMOD, CMNY, CCRD, CHIP, LIGH], False, cpNormal, True),
      wbByteArray(RCQY, 'Quantity')
    ], [])
  ], wbAllowUnordered);

  wbRecord(REPU, 'Reputation', [
    wbEDIDReq,
    wbFULL,
    wbICON,
    wbByteArray(DATA, 'Value')
  ], wbAllowUnordered);

  wbRecord(SLPD, 'Sleep Deprivation Stage', [
    wbEDIDReq,
    wbByteArray(DATA, 'Data')
  ], wbAllowUnordered);

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
end;

initialization
end.
