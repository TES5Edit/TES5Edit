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
  wbLocalization;

const
  _00_IAD: TwbSignature = #$00'IAD';
  _01_IAD: TwbSignature = #$01'IAD';
  _02_IAD: TwbSignature = #$02'IAD';
  _03_IAD: TwbSignature = #$03'IAD';
  _04_IAD: TwbSignature = #$04'IAD';
  _05_IAD: TwbSignature = #$05'IAD';
  _06_IAD: TwbSignature = #$06'IAD';
  _07_IAD: TwbSignature = #$07'IAD';
  _08_IAD: TwbSignature = #$08'IAD';
  _09_IAD: TwbSignature = #$09'IAD';
  _0A_IAD: TwbSignature = #$0A'IAD';
  _0B_IAD: TwbSignature = #$0B'IAD';
  _0C_IAD: TwbSignature = #$0C'IAD';
  _0D_IAD: TwbSignature = #$0D'IAD';
  _0E_IAD: TwbSignature = #$0E'IAD';
  _0F_IAD: TwbSignature = #$0F'IAD';
  _10_IAD: TwbSignature = #$10'IAD';
  _11_IAD: TwbSignature = #$11'IAD';
  _12_IAD: TwbSignature = #$12'IAD';
  _13_IAD: TwbSignature = #$13'IAD';
  _14_IAD: TwbSignature = #$14'IAD';
  _40_IAD: TwbSignature = #$40'IAD';
  _41_IAD: TwbSignature = #$41'IAD';
  _42_IAD: TwbSignature = #$42'IAD';
  _43_IAD: TwbSignature = #$43'IAD';
  _44_IAD: TwbSignature = #$44'IAD';
  _45_IAD: TwbSignature = #$45'IAD';
  _46_IAD: TwbSignature = #$46'IAD';
  _47_IAD: TwbSignature = #$47'IAD';
  _48_IAD: TwbSignature = #$48'IAD';
  _49_IAD: TwbSignature = #$49'IAD';
  _4A_IAD: TwbSignature = #$4A'IAD';
  _4B_IAD: TwbSignature = #$4B'IAD';
  _4C_IAD: TwbSignature = #$4C'IAD';
  _4D_IAD: TwbSignature = #$4D'IAD';
  _4E_IAD: TwbSignature = #$4E'IAD';
  _4F_IAD: TwbSignature = #$4F'IAD';
  _50_IAD: TwbSignature = #$50'IAD';
  _51_IAD: TwbSignature = #$51'IAD';
  _52_IAD: TwbSignature = #$52'IAD';
  _53_IAD: TwbSignature = #$53'IAD';
  _54_IAD: TwbSignature = #$54'IAD';

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
  ALPC : TwbSignature = 'ALPC'; { New To Skyrim }
  ALRT : TwbSignature = 'ALRT'; { New To Skyrim }
  ALSP : TwbSignature = 'ALSP'; { New To Skyrim }
  ALST : TwbSignature = 'ALST'; { New To Skyrim }
  ALUA : TwbSignature = 'ALUA'; { New To Skyrim }
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
  ATXT : TwbSignature = 'ATXT';
  AVIF : TwbSignature = 'AVIF';
  AVSK : TwbSignature = 'AVSK'; { New to Skyrim }
  BAMT : TwbSignature = 'BAMT'; { New to Skyrim }
  BIDS : TwbSignature = 'BIDS'; { New to Skyrim }
  BIPL : TwbSignature = 'BIPL';
  BMCT : TwbSignature = 'BMCT';
  BNAM : TwbSignature = 'BNAM';
  BOD2 : TwbSignature = 'BOD2'; { New to Skyrim 1.6.91 CK}
  BODT : TwbSignature = 'BODT'; { New to Skyrim }
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
  CIS1 : TwbSignature = 'CIS1'; { New to Skyrim }
  CIS2 : TwbSignature = 'CIS2'; { New to Skyrim }
  CITC : TwbSignature = 'CITC'; { New to Skyrim }
  CLAS : TwbSignature = 'CLAS';
  CLDC : TwbSignature = 'CLDC'; { New to Skyrim, but unused }
  CLFM : TwbSignature = 'CLFM';
  CLMT : TwbSignature = 'CLMT';
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
  CSCR : TwbSignature = 'CSCR';
  CSDC : TwbSignature = 'CSDC';
  CSDI : TwbSignature = 'CSDI';
  CSDT : TwbSignature = 'CSDT';
  CSFL : TwbSignature = 'CSFL'; { New to Skyrim }
  CSGD : TwbSignature = 'CSGD'; { New to Skyrim }
  CSLR : TwbSignature = 'CSLR'; { New to Skyrim }
  CSMD : TwbSignature = 'CSMD'; { New to Skyrim }
  CSME : TwbSignature = 'CSME'; { New to Skyrim }
  CSTY : TwbSignature = 'CSTY';
  CTDA : TwbSignature = 'CTDA';
  DALC : TwbSignature = 'DALC'; { New to Skyrim }
  DATA : TwbSignature = 'DATA';
  DEBR : TwbSignature = 'DEBR';
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
  HAIR : TwbSignature = 'HAIR'; { Unused in Skyrim, but contained in Skyrim.esm }
  HAZD : TwbSignature = 'HAZD';
  HCLF : TwbSignature = 'HCLF'; { New to Skyrim }
  HDPT : TwbSignature = 'HDPT';
  HEAD : TwbSignature = 'HEAD'; { New to Skyrim }
  HEDR : TwbSignature = 'HEDR';
  HNAM : TwbSignature = 'HNAM';
  HTID : TwbSignature = 'HTID'; { New to Skyrim }
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
  IMSP : TwbSignature = 'IMSP'; { New to Skyrim }
  INAM : TwbSignature = 'INAM';
  INCC : TwbSignature = 'INCC'; { New to Skyrim }
  INDX : TwbSignature = 'INDX';
  INFO : TwbSignature = 'INFO';
  INGR : TwbSignature = 'INGR';
  INTV : TwbSignature = 'INTV';
  IPCT : TwbSignature = 'IPCT';
  IPDS : TwbSignature = 'IPDS';
  ITXT : TwbSignature = 'ITXT';
  JAIL : TwbSignature = 'JAIL'; { New To Skyrim }
  JNAM : TwbSignature = 'JNAM';
  JOUT : TwbSignature = 'JOUT'; { New To Skyrim }
  KEYM : TwbSignature = 'KEYM';
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
  MICO : TwbSignature = 'MICO';
  MISC : TwbSignature = 'MISC';
  MNAM : TwbSignature = 'MNAM';
  MO2S : TwbSignature = 'MO2S';
  MO2T : TwbSignature = 'MO2T';
  MO3S : TwbSignature = 'MO3S';
  MO3T : TwbSignature = 'MO3T';
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
  MSTT : TwbSignature = 'MSTT';
  MTNM : TwbSignature = 'MTNM'; { New to Skyrim }
  MTYP : TwbSignature = 'MTYP'; { New To Skyrim }
  MUSC : TwbSignature = 'MUSC';
  MUST : TwbSignature = 'MUST';
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
  NNAM : TwbSignature = 'NNAM';
  NPC_ : TwbSignature = 'NPC_';
  NULL : TwbSignature = 'NULL';
  NVER : TwbSignature = 'NVER';
  NVMI : TwbSignature = 'NVMI';
  NVNM : TwbSignature = 'NVNM'; { New to Skyrim }
  NVPP : TwbSignature = 'NVPP'; { New to Skyrim }
  NVSI : TwbSignature = 'NVSI'; { New to Dawnguard }
  OBND : TwbSignature = 'OBND';
  OCOR : TwbSignature = 'OCOR'; { New to Skyrim }
  OFST : TwbSignature = 'OFST';
  ONAM : TwbSignature = 'ONAM';
  OTFT : TwbSignature = 'OTFT';
  PACK : TwbSignature = 'PACK';
  PARW : TwbSignature = 'PARW'; { New to Skyrim }
  PBAR : TwbSignature = 'PBAR'; { New to Skyrim }
  PBEA : TwbSignature = 'PBEA'; { New to Skyrim }
  PCON : TwbSignature = 'PCON'; { New to Skyrim }
  PDTO : TwbSignature = 'PDTO'; { New to Skyrim }
  PERK : TwbSignature = 'PERK';
  PFIG : TwbSignature = 'PFIG';
  PFLA : TwbSignature = 'PFLA'; { New to Skyrim }
  PFO2 : TwbSignature = 'PFO2'; { New to Skyrim }
  PFOR : TwbSignature = 'PFOR'; { New to Skyrim }
  PFPC : TwbSignature = 'PFPC';
  PGRE : TwbSignature = 'PGRE';
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
  PWAT : TwbSignature = 'PWAT'; { Unused in Skyrim, but contained in Skyrim.esm }
  QNAM : TwbSignature = 'QNAM';
  QOBJ : TwbSignature = 'QOBJ';
  QSDT : TwbSignature = 'QSDT';
  QSTA : TwbSignature = 'QSTA';
  QTGL : TwbSignature = 'QTGL'; { New To Skyrim }
  QUAL : TwbSignature = 'QUAL'; { New To Skyrim }
  QUST : TwbSignature = 'QUST';
  RACE : TwbSignature = 'RACE';
  RCEC : TwbSignature = 'RCEC'; { New To Skyrim }
  RCLR : TwbSignature = 'RCLR';
  RCPR : TwbSignature = 'RCPR'; { New to Dawnguard }
  RCSR : TwbSignature = 'RCSR'; { New To Skyrim }
  RCUN : TwbSignature = 'RCUN'; { New To Skyrim }
  RDAT : TwbSignature = 'RDAT';
  RDGS : TwbSignature = 'RDGS';
  RDMO : TwbSignature = 'RDMO';
  RDMP : TwbSignature = 'RDMP';
  RDOT : TwbSignature = 'RDOT';
  RDSA : TwbSignature = 'RDSA'; { New to Skyrim }
  RDWT : TwbSignature = 'RDWT';
  REFR : TwbSignature = 'REFR';
  REGN : TwbSignature = 'REGN';
  RELA : TwbSignature = 'RELA';
  REPL : TwbSignature = 'REPL';
  RGDL : TwbSignature = 'RGDL';{ Unused in Skyrim, but contained in Skyrim.esm }
  REVB : TwbSignature = 'REVB';
  RFCT : TwbSignature = 'RFCT';
  RNAM : TwbSignature = 'RNAM';
  RNMV : TwbSignature = 'RNMV'; { New to Skyrim }
  RPLD : TwbSignature = 'RPLD';
  RPLI : TwbSignature = 'RPLI';
  RPRF : TwbSignature = 'RPRF'; { New To Skyrim }
  RPRM : TwbSignature = 'RPRM'; { New To Skyrim }
  SCDA : TwbSignature = 'SCDA';
  SCEN : TwbSignature = 'SCEN';
  SCHR : TwbSignature = 'SCHR';
  SCOL : TwbSignature = 'SCOL'; { Unused in Skyrim, but contained in Skyrim.esm }
  SCPT : TwbSignature = 'SCPT'; { Unused in Skyrim, but contained in Skyrim.esm }
  SCRL : TwbSignature = 'SCRL';
  SCRN : TwbSignature = 'SCRN';
  SCRO : TwbSignature = 'SCRO';
  SCTX : TwbSignature = 'SCTX';
  SDSC : TwbSignature = 'SDSC'; { New to Skyrim }
  SHOU : TwbSignature = 'SHOU';
  SHRT : TwbSignature = 'SHRT'; { New to Skyrim }
  SLCP : TwbSignature = 'SLCP';
  SLGM : TwbSignature = 'SLGM';
  SMBN : TwbSignature = 'SMBN';
  SMEN : TwbSignature = 'SMEN';
  SMQN : TwbSignature = 'SMQN';
  SNAM : TwbSignature = 'SNAM';
  SNCT : TwbSignature = 'SNCT';
  SNDD : TwbSignature = 'SNDD';
  SNDR : TwbSignature = 'SNDR';
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
  TCLT : TwbSignature = 'TCLT';
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
  WNAM : TwbSignature = 'WNAM';
  WOOP : TwbSignature = 'WOOP';
  WRLD : TwbSignature = 'WRLD';
  WTHR : TwbSignature = 'WTHR';
  XACT : TwbSignature = 'XACT';
  XALP : TwbSignature = 'XALP'; { New To Skyrim }
  XAPD : TwbSignature = 'XAPD';
  XAPR : TwbSignature = 'XAPR';
  XATR : TwbSignature = 'XATR'; { New To Dawnguard }
  XCAS : TwbSignature = 'XCAS';
  XCCM : TwbSignature = 'XCCM';
  XCHG : TwbSignature = 'XCHG';
  XCIM : TwbSignature = 'XCIM';
  XCLC : TwbSignature = 'XCLC';
  XCLL : TwbSignature = 'XCLL';
  XCLP : TwbSignature = 'XCLP';
  XCLR : TwbSignature = 'XCLR';
  XCLW : TwbSignature = 'XCLW';
  XCMO : TwbSignature = 'XCMO';
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
  XRDS : TwbSignature = 'XRDS';
  XRGB : TwbSignature = 'XRGB';
  XRGD : TwbSignature = 'XRGD';
  XRMR : TwbSignature = 'XRMR';
  XRNK : TwbSignature = 'XRNK';
  XSCL : TwbSignature = 'XSCL';
  XSPC : TwbSignature = 'XSPC'; { New To Skyrim }
  XTEL : TwbSignature = 'XTEL';
  XTNM : TwbSignature = 'XTNM'; { New To Skyrim }
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
  wbEquipType: IwbFlagsDef;
  wbEmotionTypeEnum: IwbEnumDef;
  wbFurnitureAnimTypeEnum: IwbEnumDef;
  wbFurnitureEntryTypeFlags: IwbFlagsDef;
  wbWeaponAnimTypeEnum: IwbEnumDef;
  wbWardStateEnum: IwbEnumDef;
  wbMusicEnum: IwbEnumDef;
  wbSoundLevelEnum: IwbEnumDef;
//  wbHeadPartIndexEnum: IwbEnumDef;
  wbBodyPartIndexEnum: IwbEnumDef;
  wbAttackAnimationEnum: IwbEnumDef;
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
  wbDESC: IwbSubRecordDef;
  wbDESCReq: IwbSubRecordDef;
  wbXSCL: IwbSubRecordDef;
  wbDATAPosRot: IwbSubRecordDef;
  wbPosRot: IwbStructDef;
  wbMODD: IwbSubRecordDef;
  wbMOSD: IwbSubRecordDef;
  wbMODL: IwbSubRecordStructDef;
  wbMODS: IwbSubRecordDef;
  wbMO2S: IwbSubRecordDef;
  wbMO3S: IwbSubRecordDef;
  wbMO4S: IwbSubRecordDef;
  wbMODLActor: IwbSubRecordStructDef;
  wbMODLReq: IwbSubRecordStructDef;
  wbCTDA: IwbSubRecordStructDef;
  wbCTDAs: IwbSubRecordArrayDef;
  wbCTDAsReq: IwbSubRecordArrayDef;
  wbPGRP: IwbSubRecordDef;
  wbFaceGen: IwbSubRecordStructDef;
  wbFaceGenNPC: IwbSubRecordStructDef;
  wbENAM: IwbSubRecordDef;
  wbFGGS: IwbSubRecordDef;
  wbXLOD: IwbSubRecordDef;
  wbXESP: IwbSubRecordDef;
  wbICON: IwbSubRecordStructDef;
  wbICONReq: IwbSubRecordStructDef;
  wbICO2: IwbSubRecordStructDef;
  wbActorValue: IwbIntegerDef;
  wbCrimeTypeEnum: IwbEnumDef;
  wbVatsValueFunctionEnum: IwbEnumDef;
  wbSkillEnum: IwbEnumDef;
  wbETYP: IwbSubRecordDef;
  wbETYPReq: IwbSubRecordDef;
  wbFormTypeEnum: IwbEnumDef;
  wbMiscStatEnum: IwbEnumDef;
  wbAdvanceActionEnum: IwbEnumDef;
  wbAlignmentEnum: IwbEnumDef;
  wbAxisEnum: IwbEnumDef;
  wbCastingSourceEnum: IwbEnumDef;
  wbCriticalStageEnum: IwbEnumDef;
  wbSexEnum: IwbEnumDef;
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
  wbBODT: IwbSubRecordDef;
  wbBOD2: IwbSubRecordDef;
  wbFULLFact: IwbSubRecordDef;
  wbScriptEntry: IwbStructDef;
  wbPropTypeEnum: IwbEnumDef;
  wbScriptObject: IwbUnionDef;
  wbScriptFragments: IwbStructDef;
  wbScriptFragmentsQuest: IwbStructDef;
  wbScriptFragmentsInfo: IwbStructDef;
  wbScriptFragmentsPack: IwbStructDef;
  wbScriptFragmentsPerk: IwbStructDef;
  wbScriptFragmentsScen: IwbStructDef;
  wbEntryPointsEnum: IwbEnumDef;
  wbLocationEnum: IwbEnumDef;
  wbPLDT: IwbSubRecordDef;
  wbPLVD: IwbSubRecordDef;
  wbTargetData: IwbStructDef;
  wbAttackData: IwbSubRecordStructDef;
  wbLLCT: IwbSubRecordDef;
  wbLVLD: IwbSubRecordDef;
  wbVMAD: IwbSubRecordDef;
  wbCOCT: IwbSubRecordDef;
  wbKSIZ: IwbSubRecordDef;
  wbKWDAs: IwbSubRecordDef;
  wbCNAM: IwbSubRecordDef;
  wbCNAMReq: IwbSubRecordDef;
  wbCITC: IwbSubRecordDef;
  wbMGEFData: IwbSubRecordStructDef;
  wbMGEFType: IwbIntegerDef;
  wbCastEnum: IwbEnumDef;
  wbTargetEnum: IwbEnumDef;
  wbRNAM: IwbSubRecordDef;
  wbSNAM: IwbSubRecordDef;
  wbQNAM: IwbSubRecordDef;
  wbMDOB: IwbSubRecordDef;
  wbSPIT: IwbSubRecordDef;
  wbDMDSs: IwbSubRecordDef;
  wbMO5S: IwbSubRecordDef;
  wbDMDL: IwbSubRecordDef;
  wbSPCT: IwbSubRecordDef;
  wbTints: IwbSubRecordArrayDef;
  wbMODT: IwbSubRecordDef;
  wbDMDT: IwbSubRecordDef;
  wbOwnership: IwbSubRecordStructDef;
  wbAmbientColors: IwbStructDef;
  wbSMNodeFlags: IwbFlagsDef;
  wbBipedObjectEnum: IwbEnumDef;
  wbBipedObjectFlags: IwbFlagsDef;
  wbArmorTypeEnum: IwbEnumDef;
  wbRACE_DATAFlags01: IwbIntegerDef;
  wbPhonemeTargets: IwbSubRecordDef;
  wbNoseMorphFlags: IwbIntegerDef;
  wbBrowMorphFlags: IwbIntegerDef;
  wbEyesMorphFlags01: IwbIntegerDef;
  wbEyesMorphFlags02: IwbIntegerDef;
  wbLipMorphFlags: IwbIntegerDef;
  wbPHWT: IwbSubRecordStructDef;
  wbMorphs: IwbSubRecordStructDef;
  wbHeadPart: IwbSubRecordStructDef;
  wbTintMaskTypeEnum: IwbEnumDef;
  wbQUSTAliasFlags: IwbSubRecordDef;
  wbPKDTFlags: IwbFlagsDef;
  wbPKDTInterruptFlags: IwbFlagsDef;
  wbPDTO: IwbSubRecordDef;
  wbPDTOs: IwbSubRecordArrayDef;
  wbUNAMs: IwbSubRecordArrayDef;

//function wbNVTREdgeToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
//var
//  Index      : Integer;
//  Flags      : Cardinal;
//  IsExternal : Boolean;
//  Container  : IwbContainerElementRef;
//begin
//  Result := '';
//  IsExternal := False;
//  if Supports(aElement, IwbContainerElementRef, Container) then begin
//    Index := StrToIntDef(Copy(Container.Name, 11, 1), -1);
//    if (Index >= 0) and (Index <= 2) then begin
//      Flags := Container.ElementNativeValues['..\..\标志'];
//      IsExternal := Flags and (Cardinal(1) shl Index) <> 0;
//    end;
//  end;
//
//  if IsExternal then begin
//    case aType of
//      ctToStr: begin
//        Result := IntToStr(aInt);
//        if Container.ElementExists['..\..\..\..\NVEX\连接 #' + IntToStr(aInt)] then
//          Result := Result + ' (三角 #' +
//            Container.ElementValues['..\..\..\..\NVEX\连接 #' + IntToStr(aInt) + '\三角'] + ' in ' +
//            Container.ElementValues['..\..\..\..\NVEX\连接 #' + IntToStr(aInt) + '\导航模型'] + ')'
//        else
//          Result := Result + ' <Error: NVEX\连接 #' + IntToStr(aInt) + ' 丢失>';
//      end;
//      ctToSortKey:
//        if Container.ElementExists['..\..\..\..\NVEX\连接 #' + IntToStr(aInt)] then
//          Result :=
//            Container.ElementSortKeys['..\..\..\..\NVEX\连接 #' + IntToStr(aInt) + '\导航模型', True] + '|' +
//            Container.ElementSortKeys['..\..\..\..\NVEX\连接 #' + IntToStr(aInt) + '\三角', True];
//      ctCheck:
//        if Container.ElementExists['..\..\..\..\NVEX\连接 #' + IntToStr(aInt)] then
//          Result := ''
//        else
//          Result := 'NVEX\连接 #' + IntToStr(aInt) + ' 丢失';
//    end
//  end else
//    case aType of
//      ctToStr: Result := IntToStr(aInt);
//    end;
//end;

//function wbNVTREdgeToInt(const aString: string; const aElement: IwbElement): Int64;
//begin
//  Result := StrToInt64(aString);
//end;

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

{>>> Script stuff in VMAD now <<<}
//function wbCTDAParam2VariableNameToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
//var
//  Container  : IwbContainerElementRef;
//  //Container2 : IwbContainerElementRef;
//  Param1     : IwbElement;
//  MainRecord : IwbMainRecord;
//  BaseRecord : IwbMainRecord;
//  ScriptRef  : IwbElement;
//  Script     : IwbMainRecord;
//  Variables  : TStringList;
//  LocalVars  : IwbContainerElementRef;
//  LocalVar   : IwbContainerElementRef;
//  i, j       : Integer;
//  s          : string;
//begin
//  case aType of
//    ctToStr: Result := IntToStr(aInt) + ' <警告：无法解析参数 1>';
//    ctToEditValue: Result := IntToStr(aInt);
//    ctToSortKey: begin
//      Result := IntToHex64(aInt, 8);
//      Exit;
//    end;
//    ctCheck: Result := '<警告：无法解析参数 1>';
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
//  Param1 := Container.ElementByName['参数 #1'];
//
//  if not Assigned(Param1) then
//    Exit;
//
//  MainRecord := nil;
//  if not Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
//    Exit;
//{    if Param1.NativeValue = 0 then
//      if Supports(Container.Container, IwbContainerElementRef, Container) then
//        for i := 0 to Pred(Container.ElementCount) do
//          if Supports(Container.Elements[i], IwbContainerElementRef, Container2) then
//            if SameText(Container2.ElementValues['函数'], 'GetIsID') then begin
//              Param1 := Container2.ElementByName['参数 #1'];
//              if Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
//                Break;
//            end;}
//
//  if not Assigned(MainRecord) then
//    Exit;
//
//  BaseRecord := MainRecord.BaseRecord;
//  if Assigned(BaseRecord) then
//    MainRecord := BaseRecord;
//
//  ScriptRef := MainRecord.RecordBySignature['SCRI'];
//
//  if not Assigned(ScriptRef) then begin
//    case aType of
//      ctToStr: Result := IntToStr(aInt) + ' <Warning: "'+MainRecord.ShortName+'" does not contain a SCRI subrecord>';
//      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" does not contain a SCRI subrecord>';
//    end;
//    Exit;
//  end;
//
//  if not Supports(ScriptRef.LinksTo, IwbMainRecord, Script) then begin
//    case aType of
//      ctToStr: Result := IntToStr(aInt) + ' <Warning: "'+MainRecord.ShortName+'" does not have a valid script>';
//      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" does not have a valid script>';
//    end;
//    Exit;
//  end;
//
//  Script := Script.HighestOverrideOrSelf[aElement._File.LoadOrder];
//
//  case aType of
//    ctEditType: begin
//      Result := 'ComboBox';
//      Exit;
//    end;
//    ctEditInfo:
//      Variables := TStringList.Create;
//  else
//    Variables := nil;
//  end;
//  try
//    if Supports(Script.ElementByName['Local Variables'], IwbContainerElementRef, LocalVars) then begin
//      for i := 0 to Pred(LocalVars.ElementCount) do
//        if Supports(LocalVars.Elements[i], IwbContainerElementRef, LocalVar) then begin
//          j := LocalVar.ElementNativeValues['SLSD\索引'];
//          s := LocalVar.ElementNativeValues['SCVR'];
//          if Assigned(Variables) then
//            Variables.AddObject(s, TObject(j))
//          else if j = aInt then begin
//            case aType of
//              ctToStr, ctToEditValue: Result := s;
//              ctCheck: Result := '';
//            end;
//            Exit;
//          end;
//        end;
//    end;
//
//    case aType of
//      ctToStr: Result := IntToStr(aInt) + ' <Warning: Variable Index not found in "' + Script.Name + '">';
//      ctCheck: Result := '<Warning: Variable Index not found in "' + Script.Name + '">';
//      ctEditInfo: begin
//        Variables.Sort;
//        Result := Variables.CommaText;
//      end;
//    end;
//  finally
//    FreeAndNil(Variables);
//  end;
//end;

{>>> Script stuff in VMAD now <<<}
//function wbCTDAParam2VariableNameToInt(const aString: string; const aElement: IwbElement): Int64;
//var
//  Container  : IwbContainerElementRef;
//  Param1     : IwbElement;
//  MainRecord : IwbMainRecord;
//  BaseRecord : IwbMainRecord;
//  ScriptRef  : IwbElement;
//  Script     : IwbMainRecord;
//  LocalVars  : IwbContainerElementRef;
//  LocalVar   : IwbContainerElementRef;
//  i, j       : Integer;
//  s          : string;
//begin
//  Result := StrToInt64Def(aString, Low(Cardinal));
//  if Result <> Low(Cardinal) then
//    Exit;
//
//  if not Assigned(aElement) then
//    raise Exception.Create('aElement not specified');
//
//  if aElement.ElementType = etValue then
//    Supports(aElement.Container, IwbContainerElementRef, Container)
//  else
//    Supports(aElement, IwbContainerElementRef, Container);
//
//  if not Assigned(Container) then
//    raise Exception.Create('Container not assigned');
//
//  Param1 := Container.ElementByName['参数 #1'];
//
//  if not Assigned(Param1) then
//    raise Exception.Create('Could not find "Parameter #1"');
//
//  if not Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
//    raise Exception.Create('"Parameter #1" does not reference a valid main record');
//
//  BaseRecord := MainRecord.BaseRecord;
//  if Assigned(BaseRecord) then
//    MainRecord := BaseRecord;
//
//  ScriptRef := MainRecord.RecordBySignature['SCRI'];
//
//  if not Assigned(ScriptRef) then
//    raise Exception.Create('"'+MainRecord.ShortName+'" does not contain a SCRI subrecord');
//
//  if not Supports(ScriptRef.LinksTo, IwbMainRecord, Script) then
//    raise Exception.Create('"'+MainRecord.ShortName+'" does not have a valid script');
//
//  Script := Script.HighestOverrideOrSelf[aElement._File.LoadOrder];
//
//  if Supports(Script.ElementByName['Local Variables'], IwbContainerElementRef, LocalVars) then begin
//    for i := 0 to Pred(LocalVars.ElementCount) do
//      if Supports(LocalVars.Elements[i], IwbContainerElementRef, LocalVar) then begin
//        j := LocalVar.ElementNativeValues['SLSD\索引'];
//        s := LocalVar.ElementNativeValues['SCVR'];
//        if SameText(s, Trim(aString)) then begin
//          Result := j;
//          Exit;
//        end;
//      end;
//  end;
//
//  raise Exception.Create('Variable "'+aString+'" was not found in "'+MainRecord.ShortName+'"');
//end;

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
          j := Stage.ElementNativeValues['INDX\阶段索引'];
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
          j := Stage.ElementNativeValues['INDX\阶段索引'];
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
      {0x01} '或',
      {0x02} '使用别名',
      {0x04} '使用全局',
      {0x08} '使用AI包数据',
      {0x10} '切换主体和对象'
    ]);
{
    Compare operator (upper 3 bits)
    LGE
    000    0=Equal to
    001    1=Not equal to
    010    2=Greater than
    011    3=Greater than or equal to
    100    4=Less than
    101    5=Less than or equal to

    Flags (lower 5 bits)
        0x01=OR (default is to AND conditions together)
        0x02=Parameters (use aliases) : Force function parameters to use quest alias data (exclusive with "use pack data")
        0x04=Use global
        0x08=Use Pack Data : Force function parameters to use pack data (exclusive with "使用别名")
        0x10=Swap Subject and Target
}
  case aType of
    ctEditType:
      Result := 'CheckComboBox';
    ctEditInfo:
      Result := '等于,大于,小于,或者,"使用别名","使用全局","使用AI包数据","切换主体和对象"';
    ctToEditValue: begin
      Result := '00000000';
      case aInt and $E0 of
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
      if (aInt and $01) <> 0 then // Or
        Result[4] := '1';
      if (aInt and $02) <> 0 then // Use aliases
        Result[5] := '1';
      if (aInt and $04) <> 0 then // Use global
        Result[6] := '1';
      if (aInt and $08) <> 0 then // Use packdata
        Result[7] := '1';
      if (aInt and $10) <> 0 then // Swap Subject and Target
        Result[8] := '1';
    end;
    ctToStr: begin
      case aInt and $E0 of
        $00 : Result := '等于';
        $20 : Result := '不等于';
        $40 : Result := '大于';
        $60 : Result := '大于或等于';
        $80 : Result := '小于';
        $A0 : Result := '小于或等于';
      else
        Result := '<未知的比较操作符>'
      end;
      s := wbCtdaTypeFlags.ToString(aInt and $1F, aElement);
      if s <> '' then
        Result := Result + ' / ' + s;
    end;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2);
      Exit;
    end;
//    ctCheck: begin
//      case aInt shr 5 of
//        0, 1, 2, 3, 4, 5 : Result := '';
//      else
//        Result := '<未知的比较操作符>'
//      end;
//
//      s := wbCtdaTypeFlags.ToString(aInt and $1F, aElement);
//      if s <> '' then
//        Result := Result + ' / ' + s;
//    end;
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
  if s[5] = '1' then
    Result := Result or $02;
  // Use global
  if s[6] = '1' then
    Result := Result or $04;
  // Use packdata
  if s[7] = '1' then
    Result := Result or $08;
  // Swap Subject and Target
  if s[8] = '1' then
    Result := Result or $10;
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

  // reset value if "使用全局" has changed
  OldValue := aOldValue and $04;
  NewValue := aNewValue and $04;
  if OldValue <> NewValue then
    Container.ElementNativeValues['..\比较值'] := 0;

  {>>> "run on target", no such flag in Skyrim <<<}
//  if aNewValue and $02 then begin
//    Container.ElementNativeValues['..\运行于'] := 1;
//    if Integer(Container.ElementNativeValues['..\运行于']) = 1 then
//      aElement.NativeValue := Byte(aNewValue) and not $02;
//  end;
end;

procedure wbAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  Exit;
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
//function wbIdleAnam(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
//begin
//  Result := '';
//  case aType of
//    ctToStr: begin
//      case aInt and not $C0 of
//        0: Result := 'Idle';
//        1: Result := 'Movement';
//        2: Result := 'Left Arm';
//        3: Result := '左手';
//        4: Result := '武器';
//        5: Result := 'Weapon Up';
//        6: Result := 'Weapon Down';
//        7: Result := 'Special Idle';
//       20: Result := 'Whole Body';
//       21: Result := 'Upper Body';
//      else
//        Result := '<未知: '+IntToStr(aInt and not $C0)+'>';
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
//        Result := '<未知: '+IntToStr(aInt and not $C0)+'>';
//      end;
//    end;
//  end;
//end;

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

function wbCloudSpeedToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr, ctToEditValue: Result := FloatToStrF((aInt - 127)/127/10, ffFixed, 99, 4);
    ctCheck: Result := '';
  end;
end;

function wbCloudSpeedToInt(const aString: string; const aElement: IwbElement): Int64;
var
  f: Extended;
begin
  f := StrToFloat(aString);
  f := f*10*127 + 127;
  Result := Min(Round(f), 254);
end;

function wbShortXYtoStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  x, y: SmallInt;
begin
  y := aInt and $FFFF;
  x := aInt shr 16 and $FFFF;
  Result := '';
  case aType of
    ctToStr, ctToEditValue: Result := Format('%d, %d', [x, y]);
    ctCheck: Result := '';
  end;
end;

function wbStrToShortXY(const aString: string; const aElement: IwbElement): Int64;
var
  x, y: SmallInt;
  Value: Cardinal;
begin
  y := StrToIntDef(Copy(aString, 1, Pred(Pos(', ', aString))), 0);
  x := StrToIntDef(Copy(aString, Pos(', ', aString) + 2, Length(aString)), 0);
  PWord(@Value)^ := x;
  PWord(Cardinal(@Value) + SizeOf(SmallInt))^ := y;
  Result := Value;
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
        Ord('b'): Result := '布尔值';
      else
        Result := '<未知: '+IntToStr(aInt)+'>';
      end;
    end;
    ctToSortKey: Result := Chr(aInt);
    ctCheck: begin
      case aInt of
        Ord('s'), Ord('l'), Ord('f'), Ord('b'): Result := '';
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

  s := Trim(aMainRecord.ElementValues['QNAM']);
  if s <> '' then begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + '给 ' + s;
  end;
end;

function wbNAVMAddInfo(const aMainRecord: IwbMainRecord): string;
var
  Container: IwbContainer;
  s: string;
begin
  Result := '';

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

//function wbNAVMAddInfo(const aMainRecord: IwbMainRecord): string;
//var
//  Rec        : IwbRecord;
//  Element    : IwbElement;
//  s          : string;
//begin
//  Result := '';
//
//  Rec := aMainRecord.RecordBySignature['DATA'];
//  if Assigned(Rec) then begin
//    Element := Rec.ElementByName['场景'];
//    if Assigned(Element) then
//      Element := Element.LinksTo;
//    if Assigned(Element) then
//      s := Trim(Element.Name);
//    if s <> '' then
//      Result := 'for ' + s;
//  end;
//end;

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

//function wbIPDSDATACount(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
//begin
//  if Assigned(aBasePtr) and Assigned(aEndPtr) then
//    Result := (Cardinal(aBasePtr) - Cardinal(aBasePtr)) div 4
//  else
//    Result := 12;
//end;

//function wbNAVINAVMGetCount1(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
//var
//  DataContainer : IwbDataContainer;
//begin
//  Result := 0;
//
//  if Supports(aElement, IwbDataContainer, DataContainer) then begin
//    if DataContainer.ElementType = etArray then
//      if not Supports(DataContainer.Container, IwbDataContainer, DataContainer) then
//        Exit;
//    Assert(DataContainer.Name = '数据');
//    Result := PWord(Cardinal(DataContainer.DataBasePtr) + 3*3*4)^;
//  end;
//end;

//function wbNAVINAVMGetCount2(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
//var
//  DataContainer : IwbDataContainer;
//begin
//  Result := 0;
//
//  if Supports(aElement, IwbDataContainer, DataContainer) then begin
//    if DataContainer.ElementType = etArray then
//      if not Supports(DataContainer.Container, IwbDataContainer, DataContainer) then
//        Exit;
//    Assert(DataContainer.Name = '数据');
//    Result := PWord(Cardinal(DataContainer.DataBasePtr) + 3*3*4 + 2)^;
//  end;
//end;

procedure wbCTDARunOnAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  if aOldValue <> aNewValue then
    if aNewValue <> 2 then
      aElement.Container.ElementNativeValues['衍生'] := 0;
end;

{>>> Needs revision for Skyrim <<<}
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

function wbNPCLevelDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
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

function wbPHWTDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 2;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  if Container.DataSize = 64 then Result := 0
  else if Container.DataSize = 32 then Result := 1
end;

function wbMGEFAssocItemDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
  Archtype      : Variant;
  DataContainer : IwbDataContainer;
  Element       : IwbElement;
const
  OffsetArchtype = 56;

begin
  Result := 0;
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

procedure wbMGEFAssocItemAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container : IwbContainer;
  Element   : IwbElement;
begin
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;
  if (aNewValue <> 0) then begin
    Element := Container.ElementByName['原型'];
    if Assigned(Element) and (Element.NativeValue = 0) then
        Element.NativeValue := $FF; // Signals ArchType that it should not mess with us on the next change!
          // I assume this will alo protect 第二角色数值强度 (The two actor values are after ArchType)
  end;
end;

procedure wbMGEFAV2WeightAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container : IwbContainer;
  Element   : IwbElement;
begin
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;
  if (aNewValue <> 0.0) then begin
    Element := Container.ElementByName['原型'];
    if Assigned(Element) and (Element.NativeValue = 0) then
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
      06: Container.ElementNativeValues['..\角色数值'] := 00;//Agression
      07: Container.ElementNativeValues['..\角色数值'] := 01;//Confidence
      08: Container.ElementNativeValues['..\角色数值'] := 00;//Agression
      11: Container.ElementNativeValues['..\角色数值'] := 54;//Invisibility
      21: Container.ElementNativeValues['..\角色数值'] := 53;//Paralysis
      24: Container.ElementNativeValues['..\角色数值'] := 01;//Confidence
      38: Container.ElementNativeValues['..\角色数值'] := 01;//Confidence
      42: Container.ElementNativeValues['..\角色数值'] := 01;//Confidence
    else
      Container.ElementNativeValues['..\角色数值'] := -1;
    end;
    Container.ElementNativeValues['..\第二角色数值'] := -1;
    Container.ElementNativeValues['..\第二角色数值强度'] := 0.0;
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

function wbNAVIIslandDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container   : IwbContainer;
  SubRecord   : IwbMainRecord;
  Element     : IwbElement;
begin
  Result := 0;

  Container := aElement.Container;
  while Assigned(Container) and (Container.ElementType <> etsubRecord) do
    Container := Container.Container;

  if not Supports(Container, IwbSubRecord, SubRecord) then
    Exit;

  Element := SubRecord.ElementByName['是岛屿'];
  if not Assigned(Element) then
    Exit;

  Result := Element.NativeValue;
end;

function wbNAVIParentDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container   : IwbContainer;
  SubRecord   : IwbMainRecord;
  Element     : IwbElement;
begin
  Result := 0;

  Container := aElement.Container;
  while Assigned(Container) and (Container.ElementType <> etsubRecord) do
    Container := Container.Container;

  if not Supports(Container, IwbSubRecord, SubRecord) then
    Exit;

  Element := SubRecord.ElementByName['父系空间'];
  if not Assigned(Element) then
    Exit;

  if (Element.NativeValue = 0) then
    Result := 1;
end;

function wbNVNMParentDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container   : IwbContainer;
  Current     : IwbContainer;
  Parent      : IwbContainer;
  GroupRecord : IwbGroupRecord;
  MainRecord  : IwbMainRecord;
  rData       : IwbRecord;
  i           : integer;
begin
  Result := 0;

  Container := aElement.Container;
  while Assigned(Container) and (Container.ElementType <> etGroupRecord) do
    Container := Container.Container;

  if not Supports(Container, IwbGroupRecord, GroupRecord) then
    Exit;

  MainRecord := GroupRecord.ChildrenOf;     // This does NOT work while adding master!

  if not Assigned(MainRecord) then begin // we expect:
     //   plugin \ CELL group \ Block \ Sub Block \ CELL
     //                                           \ CELL Children group \ Permanent children group
     //                                                                 \ Temporary children group = GroupRecord = Container
    if Assigned(Container) and (Container.ElementType = etGroupRecord) then
      Container := Container.Container;
    if Assigned(Container) and (Container.ElementType = etGroupRecord) then
      Parent := Container.Container;
    i := 0;
    while (i < Parent.ElementCount) and Supports(Parent.Elements[i], IwbContainer, Current) and (Current <> Container) do
      Inc(i);
    if (i = 0) or (i = Parent.ElementCount) or not Supports(Parent.Elements[i-1], IwbMainRecord,MainRecord) then begin
      wbProgressCallback('Parent of a NVNM is not a MainRecord');
//      Assert(Assigned(MainRecord)); // Better an exception than to destroy the plugin.
      Exit;
    end;
  end;
  if (MainRecord.Signature<>CELL) then begin
    wbProgressCallback('Parent of a NVNM is not identified as a CELL');
    Assert(MainRecord.Signature=CELL); // Better an exception than to destroy the plugin.
    Exit;
  end;

  rDATA := MainRecord.RecordBySignature['DATA'];

  if not Assigned(rData) then
    Exit;

  i := rData.NativeValue;

  // is interior cell?
  if i and 1 <> 0 then
    Result := 1;
end;

//function wbNAVINVMIDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
//var
//  Container     : IwbContainer;
//begin
//  Result := 0;
//  if aElement.ElementType = etValue then
//    Container := aElement.Container
//  else
//    Container := aElement as IwbContainer;
//
//  if not Assigned(Container) then
//    Exit;
//
//  case Integer(Container.ElementNativeValues['类型']) of
//    $00: Result :=1;
//    $20: Result :=2;
//    $30: Result :=3;
//  end;
//end;

//function wbIMGSSkinDimmerDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
//var
//  Container     : IwbContainer;
//  DataContainer : IwbDataContainer;
//begin
//  Result := 0;
//  if not Assigned(aElement) then
//    Exit;
//
//  if aElement.ElementType = etValue then
//    Container := aElement.Container
//  else
//    Container := aElement as IwbContainer;
//  if Supports(Container.Container, IwbDataContainer, DataContainer) then begin
//    if DataContainer.DataSize in [132, 148] then
//      Result := 1;
//  end;
//end;

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

function wbFLSTLNAMIsSorted(const aContainer: IwbContainer): Boolean;
var
  rEDID      : IwbRecord;
  s          : string;
//  _File      : IwbFile;
//  MainRecord : IwbMainRecord;
const
  OrderedList = 'OrderedList';
begin
  Result := False; {>>> Should not be sorted according to Arthmoor and JustinOther <<<}
  rEDID := aContainer.RecordBySignature[EDID];
  if Assigned(rEDID) then begin
    s := rEDID.Value;
    if Length(s) > Length(OrderedList) then
      Delete(s, 1, Length(s)-Length(OrderedList));
    if SameText(s, OrderedList) then
      Result := False;
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
    case Integer(Container.ElementNativeValues['..\DATA\记录点\函数']) of
      5, 12, 13, 14: Result := 8;
    end;
end;

{>>> For VMAD <<<}
function wbScriptObjFormatDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  ObjFormat: Integer;
  Container: IwbContainer;
begin
  Result := 0;

  Container := aElement.Container;
  while Assigned(Container) and (Container.ElementType <> etSubRecord) do
    Container := Container.Container;

  if not Assigned(Container) then Exit;

  ObjFormat := Container.ElementNativeValues['目标格式'];

  if ObjFormat = 1 then
    Result := 1;
end;

{>>> For VMAD <<<}
function wbScriptPropertyDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  case Integer(Container.ElementNativeValues['类型']) of
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

{>>> For VMAD <<<}
function wbScriptFragmentExistsDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container  : IwbContainer;
  MainRecord : IwbMainRecord;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;
  while Assigned(Container) and (Container.ElementType <> etMainRecord) do
    Container := Container.Container;
  if not Assigned(Container) then Exit;

  Supports(Container, IwbMainRecord, MainRecord);
  if MainRecord.Signature = INFO then
    Result := 1
  else if MainRecord.Signature = PACK then
    Result := 2
  else if MainRecord.Signature = PERK then
    Result := 3
  else if MainRecord.Signature = QUST then
    Result := 4
  else if MainRecord.Signature = SCEN then
    Result := 5;
end;

{>>> For VMAD <<<}
function wbScriptFragmentsDontShow(const aElement: IwbElement): Boolean;
var
  Container: IwbContainer;
begin
  Result := True;
  if Assigned(aElement) then
    if Supports(aElement, IwbContainer, Container) then
      if Container.ElementCount > 0 then
        if Assigned(Container.Elements[0]) then
          Result := VarIsClear(Container.Elements[0].NativeValue);
end;

{>>> For VMAD <<<}
function wbScriptFragmentsQuestCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;

begin
  Result := 0;
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;
  if not Assigned(Container) then Exit;
  while Assigned(Container) and (Pos('脚本片段任务', Container.Name) <> 1) do
    Container := Container.Container;
  if not Assigned(Container) then Exit;

  Result := Integer(Container.ElementNativeValues['片段数']);
end;

{>>> For VMAD <<<}
function wbScriptFragmentsInfoCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
  F             : Integer;
  i             : Integer;
begin
  Result := 0;
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;
  if not Assigned(Container) then Exit;
  while Assigned(Container) and (Pos('脚本片段信息', Container.Name) <> 1) do
    Container := Container.Container;
  if not Assigned(Container) then Exit;

  F := Container.ElementByName['信息片段标志'].NativeValue;
  for i := 0 to 2 do begin
    if (F and 1) = 1 then
      Inc(Result);
    F := F shr 1;
  end;
  for i := 3 to 7 do begin
    if (F and 1) = 1 then begin
      Inc(Result);
    if Assigned(wbProgressCallback) then
      wbProgressCallback('==='+aElement.Name+'       ['+Container.Name+':'+Container.Path+'] = 未知的情报 VMAD 标志位 '+IntToStr(i));
  end;
    F := F shr 1;
  end;
end;

{>>> For VMAD <<<}
function wbScriptFragmentsSceneCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
  F             : Integer;
  i             : Integer;
begin
  Result := 0;
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;
  if not Assigned(Container) then Exit;
  while Assigned(Container) and (Pos('脚本片段场景', Container.Name) <> 1) do
    Container := Container.Container;
  if not Assigned(Container) then Exit;

  F := Container.ElementByName['场景片段标志'].NativeValue;
  for i := 0 to 2 do begin
    if (F and 1) = 1 then
      Inc(Result);
    F := F shr 1;
  end;
  for i := 3 to 7 do begin
    if (F and 1) = 1 then begin
      Inc(Result);
  if Assigned(wbProgressCallback) then
      wbProgressCallback('==='+aElement.Name+'       ['+Container.Name+':'+Container.Path+'] = 未知的场景 VMAD 标志位 '+IntToStr(i));
  end;
    F := F shr 1;
  end;
end;

{>>> For VMAD <<<}
function wbScriptFragmentsPackCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
  F             : Integer;
  i             : Integer;
begin
  Result := 0;
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;
  if not Assigned(Container) then Exit;
  while Assigned(Container) and (Pos('脚本片段AI包', Container.Name) <> 1) do
    Container := Container.Container;
  if not Assigned(Container) then Exit;

  F := Container.ElementByName['AI包片段标志'].NativeValue;
  for i := 0 to 7 do begin
    if (F and 1) = 1 then
      Inc(Result);
    F := F shr 1;
  end;
end;

function wbBOOKTeachesDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
  i: Int64;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  i := Container.ElementByName['标志'].NativeValue;
  if i and $00000004 <> 0 then Result := 1;
end;


type
  TCTDAFunctionParamType = (
    ptNone,
    ptInteger,
    ptFloat,
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
    ptObjectReference,    //REFR, ACHR
    ptInventoryObject,    //ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, ARMA, LIGH
    ptActor,              //ACHR
    ptVoiceType,          //VTYP
    ptIdleForm,           //IDLE
    ptFormList,           //FLST
    ptQuest,              //QUST
    ptFaction,            //FACT
    ptCell,               //CELL
    ptClass,              //CLAS
    ptRace,               //RACE
    ptActorBase,          //NPC_
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
    ptReferencableObject,
    ptRegion,             //REGN
    ptKeyword,            //KYWD
    ptAdvanceAction,      // ?? Enum
    ptCastingSource,      // ?? Enum
    ptShout,              //SHOU
    ptLocation,           //LCTN
    ptRefType,            //LCRT
    ptAlias,              // index into QUST quest aliases
    ptPackdata,           // index into PACK package data inputs
    ptAssociationType,    // ASTP
    ptFurnitureAnim,      // enum
    ptFurnitureEntry,     // flags
    ptScene,              // SCEN
    ptWardState           // enum
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
  wbCTDAFunctions : array[0..394] of TCTDAFunction = (
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
{V} (Index:  25; Name: 'IsMoving'),
{V} (Index:  26; Name: 'IsTurning'),
{V} (Index:  27; Name: 'GetLineOfSight'; ParamType1: ptObjectReference),
{V} (Index:  32; Name: 'GetInSameCell'; ParamType1: ptObjectReference),
{V} (Index:  35; Name: 'GetDisabled'),
{V} (Index:  36; Name: 'MenuMode'; ParamType1: ptInteger), // was ptMenuMode
{V} (Index:  39; Name: 'GetDisease'),
{V} (Index:  41; Name: 'GetClothingValue'),
{V} (Index:  42; Name: 'SameFaction'; ParamType1: ptActor),
{V} (Index:  43; Name: 'SameRace'; ParamType1: ptActor),
{V} (Index:  44; Name: 'SameSex'; ParamType1: ptActor),
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
{V} (Index:  62; Name: 'IsRaining'),
{V} (Index:  63; Name: 'GetAttacked'),
{V} (Index:  64; Name: 'GetIsCreature'),
{V} (Index:  65; Name: 'GetLockLevel'),
{V} (Index:  66; Name: 'GetShouldAttack'; ParamType1: ptActor),
{V} (Index:  67; Name: 'GetInCell'; ParamType1: ptCell),
{V} (Index:  68; Name: 'GetIsClass'; ParamType1: ptClass),
{V} (Index:  69; Name: 'GetIsRace'; ParamType1: ptRace),
{V} (Index:  70; Name: 'GetIsSex'; ParamType1: ptSex),
{V} (Index:  71; Name: 'GetInFaction'; ParamType1: ptFaction),
{V} (Index:  72; Name: 'GetIsID'; ParamType1: ptReferencableObject),
{V} (Index:  73; Name: 'GetFactionRank'; ParamType1: ptFaction),
{V} (Index:  74; Name: 'GetGlobalValue'; ParamType1: ptGlobal),
{V} (Index:  75; Name: 'IsSnowing'),
{V} (Index:  77; Name: 'GetRandomPercent'),
{V} (Index:  79; Name: 'GetQuestVariable'; ParamType1: ptQuest; ParamType2: ptVariableName),
{V} (Index:  80; Name: 'GetLevel'),
{N} (Index:  81; Name: 'IsRotating'),
{V} (Index:  84; Name: 'GetDeadCount'; ParamType1: ptActorBase),
{V} (Index:  91; Name: 'GetIsAlerted'),
{V} (Index:  98; Name: 'GetPlayerControlsDisabled'; ParamType1: ptInteger; ParamType2: ptInteger),
{V} (Index:  99; Name: 'GetHeadingAngle'; ParamType1: ptObjectReference),
{N} (Index: 101; Name: 'IsWeaponMagicOut'),
{V} (Index: 102; Name: 'IsTorchOut'),
{V} (Index: 103; Name: 'IsShieldOut'),
{V} (Index: 106; Name: 'IsFacingUp'),
{V} (Index: 107; Name: 'GetKnockedState'),
{V} (Index: 108; Name: 'GetWeaponAnimType'),
{V} (Index: 109; Name: 'IsWeaponSkillType'; ParamType1: ptActorValue),
{V} (Index: 110; Name: 'GetCurrentAIPackage'),
{V} (Index: 111; Name: 'IsWaiting'),
{V} (Index: 112; Name: 'IsIdlePlaying'),
{N} (Index: 116; Name: 'IsIntimidatebyPlayer'),
{N} (Index: 117; Name: 'IsPlayerInRegion'; ParamType1: ptRegion),
{V} (Index: 118; Name: 'GetActorAggroRadiusViolated'),
{V} (Index: 122; Name: 'GetCrime'; ParamType1: ptActor; ParamType2: ptCrimeType),
{V} (Index: 123; Name: 'IsGreetingPlayer'),
{V} (Index: 125; Name: 'IsGuard'),
{V} (Index: 127; Name: 'HasBeenEaten'),
{V} (Index: 128; Name: 'GetStaminaPercentage'),
{V} (Index: 129; Name: 'GetPCIsClass'; ParamType1: ptClass),
{V} (Index: 130; Name: 'GetPCIsRace'; ParamType1: ptRace),
{V} (Index: 131; Name: 'GetPCIsSex'; ParamType1: ptSex),
{V} (Index: 132; Name: 'GetPCInFaction'; ParamType1: ptFaction),
{V} (Index: 133; Name: 'SameFactionAsPC'),
{V} (Index: 134; Name: 'SameRaceAsPC'),
{V} (Index: 135; Name: 'SameSexAsPC'),
{V} (Index: 136; Name: 'GetIsReference'; ParamType1: ptObjectReference),
{V} (Index: 141; Name: 'IsTalking'),
{V} (Index: 142; Name: 'GetWalkSpeed'),
{V} (Index: 143; Name: 'GetCurrentAIProcedure'),
{V} (Index: 144; Name: 'GetTrespassWarningLevel'),
{V} (Index: 145; Name: 'IsTrespassing'),
{V} (Index: 146; Name: 'IsInMyOwnedCell'),
{V} (Index: 147; Name: 'GetWindSpeed'),
{V} (Index: 148; Name: 'GetCurrentWeatherPercent'),
{V} (Index: 149; Name: 'GetIsCurrentWeather'; ParamType1: ptWeather),
{V} (Index: 150; Name: 'IsContinuingPackagePCNear'),
{N} (Index: 152; Name: 'GetIsCrimeFaction'; ParamType1: ptFaction),
{V} (Index: 153; Name: 'CanHaveFlames'),
{V} (Index: 154; Name: 'HasFlames'),
{V} (Index: 157; Name: 'GetOpenState'),
{V} (Index: 159; Name: 'GetSitting'),
{V} (Index: 161; Name: 'GetIsCurrentPackage'; ParamType1: ptPackage),
{V} (Index: 162; Name: 'IsCurrentFurnitureRef'; ParamType1: ptObjectReference),
{V} (Index: 163; Name: 'IsCurrentFurnitureObj'; ParamType1: ptFurniture),
{V} (Index: 170; Name: 'GetDayOfWeek'),
{V} (Index: 172; Name: 'GetTalkedToPCParam'; ParamType1: ptActor),
{V} (Index: 175; Name: 'IsPCSleeping'),
{V} (Index: 176; Name: 'IsPCAMurderer'),
{N} (Index: 180; Name: 'HasSameEditorLocAsRef'; ParamType1: ptObjectReference; ParamType2: ptKeyword),
{N} (Index: 181; Name: 'HasSameEditorLocAsRefAlias'; ParamType1: ptAlias; ParamType2: ptKeyword),
{V} (Index: 182; Name: 'GetEquipped'; ParamType1: ptInventoryObject),
{V} (Index: 185; Name: 'IsSwimming'),
{V} (Index: 190; Name: 'GetAmountSoldStolen'),
{V} (Index: 192; Name: 'GetIgnoreCrime'),
{V} (Index: 193; Name: 'GetPCExpelled'; ParamType1: ptFaction),
{V} (Index: 195; Name: 'GetPCFactionMurder'; ParamType1: ptFaction),
{V} (Index: 197; Name: 'GetPCEnemyofFaction'; ParamType1: ptFaction),
{V} (Index: 199; Name: 'GetPCFactionAttack'; ParamType1: ptFaction),
{V} (Index: 203; Name: 'GetDestroyed'),
{V} (Index: 214; Name: 'HasMagicEffect'; ParamType1: ptMagicEffect),
{V} (Index: 215; Name: 'GetDefaultOpen'),
{V} (Index: 219; Name: 'GetAnimAction'),
{V} (Index: 223; Name: 'IsSpellTarget'; ParamType1: ptMagicItem),
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
{V} (Index: 247; Name: 'GetIsUsedItemType'; ParamType1: ptFormType),
{N} (Index: 248; Name: 'IsScenePlaying'; ParamType1: ptScene),
{N} (Index: 249; Name: 'IsInDialogueWithPlayer'),
{N} (Index: 250; Name: 'GetLocationCleared'; ParamType1: ptLocation),
{V} (Index: 254; Name: 'GetIsPlayableRace'),
{V} (Index: 255; Name: 'GetOffersServicesNow'),
{N} (Index: 258; Name: 'HasAssociationType'; ParamType1: ptActor; ParamType2: ptAssociationType),
{N} (Index: 259; Name: 'HasFamilyRelationship'; ParamType1: ptActor),
{N} (Index: 261; Name: 'HasParentRelationship'; ParamType1: ptActor),
{N} (Index: 262; Name: 'IsWarningAbout'; ParamType1: ptFormList),
{V} (Index: 263; Name: 'IsWeaponOut'),
{N} (Index: 264; Name: 'HasSpell'; ParamType1: ptMagicItem),
{V} (Index: 265; Name: 'IsTimePassing'),
{V} (Index: 266; Name: 'IsPleasant'),
{V} (Index: 267; Name: 'IsCloudy'),
{N} (Index: 274; Name: 'IsSmallBump'),
{V} (Index: 277; Name: 'GetBaseActorValue'; ParamType1: ptActorValue),
{V} (Index: 278; Name: 'IsOwner'; ParamType1: ptOwner),
{V} (Index: 280; Name: 'IsCellOwner'; ParamType1: ptCell; ParamType2: ptOwner),
{V} (Index: 282; Name: 'IsHorseStolen'),
{V} (Index: 285; Name: 'IsLeftUp'),
{V} (Index: 286; Name: 'IsSneaking'),
{V} (Index: 287; Name: 'IsRunning'),
{V} (Index: 288; Name: 'GetFriendHit'),
{V} (Index: 289; Name: 'IsInCombat'; ParamType1: ptInteger),
{V} (Index: 300; Name: 'IsInInterior'),
{V} (Index: 304; Name: 'IsWaterObject'),
{N} (Index: 305; Name: 'GetPlayerAction'),
{V} (Index: 306; Name: 'IsActorUsingATorch'),
{V} (Index: 309; Name: 'IsXBox'),
{V} (Index: 310; Name: 'GetInWorldspace'; ParamType1: ptWorldSpace),
{V} (Index: 312; Name: 'GetPCMiscStat'; ParamType1: ptMiscStat),
{N} (Index: 313; Name: 'GetPairedAnimation'),
{V} (Index: 314; Name: 'IsActorAVictim'),
{V} (Index: 315; Name: 'GetTotalPersuasionNumber'),
{V} (Index: 318; Name: 'GetIdleDoneOnce'),
{V} (Index: 320; Name: 'GetNoRumors'),
{N} (Index: 323; Name: 'GetCombatState'),
{N} (Index: 325; Name: 'GetWithinPackageLocation'; ParamType1: ptPackdata),
{V} (Index: 327; Name: 'IsRidingMount'),
{N} (Index: 329; Name: 'IsFleeing'),
{V} (Index: 332; Name: 'IsInDangerousWater'),
{V} (Index: 338; Name: 'GetIgnoreFriendlyHits'),
{V} (Index: 339; Name: 'IsPlayersLastRiddenMount'),
{V} (Index: 353; Name: 'IsActor'),
{V} (Index: 354; Name: 'IsEssential'),
{V} (Index: 358; Name: 'IsPlayerMovingIntoNewSpace'),
{N} (Index: 359; Name: 'GetInCurrentLoc'; ParamType1: ptLocation),
{N} (Index: 360; Name: 'GetInCurrentLocAlias'; ParamType1: ptAlias),
{V} (Index: 361; Name: 'GetTimeDead'),
{N} (Index: 362; Name: 'HasLinkedRef'; ParamType1: ptKeyword),
{V} (Index: 365; Name: 'IsChild'),
{N} (Index: 366; Name: 'GetStolenItemValueNoCrime'; ParamType1: ptFaction),
{V} (Index: 367; Name: 'GetLastPlayerAction'),
{V} (Index: 368; Name: 'IsPlayerActionActive'; ParamType1: ptInteger), // was ptPlayerAction
{V} (Index: 370; Name: 'IsTalkingActivatorActor'; ParamType1: ptActor),
{V} (Index: 372; Name: 'IsInList'; ParamType1: ptFormList),
{N} (Index: 373; Name: 'GetStolenItemValue'; ParamType1: ptFaction),
{N} (Index: 375; Name: 'GetCrimeGoldViolent'),
{N} (Index: 376; Name: 'GetCrimeGoldNonviolent'),
{N} (Index: 378; Name: 'HasShout'; ParamType1: ptShout),
{V} (Index: 381; Name: 'GetHasNote'; ParamType1: ptInteger), // was ptNote
{V} (Index: 390; Name: 'GetHitLocation'),
{V} (Index: 391; Name: 'IsPC1stPerson'),
{V} (Index: 396; Name: 'GetCauseofDeath'),
{V} (Index: 397; Name: 'IsLimbGone'; ParamType1: ptInteger), // was ptBodyLocation
{V} (Index: 398; Name: 'IsWeaponInList'; ParamType1: ptFormList),
{N} (Index: 402; Name: 'IsBribedbyPlayer'),
{V} (Index: 403; Name: 'GetRelationshipRank'; ParamType1: ptObjectReference),
{V} (Index: 407; Name: 'GetVATSValue'; ParamType1: ptVATSValueFunction; ParamType2: ptVATSValueParam),
{V} (Index: 408; Name: 'IsKiller'; ParamType1: ptActor),
{V} (Index: 409; Name: 'IsKillerObject'; ParamType1: ptFormList),
{V} (Index: 410; Name: 'GetFactionCombatReaction'; ParamType1: ptFaction; ParamType2: ptFaction),
{V} (Index: 414; Name: 'Exists'; ParamType1: ptObjectReference),
{V} (Index: 415; Name: 'GetGroupMemberCount'),
{V} (Index: 416; Name: 'GetGroupTargetCount'),
{V} (Index: 426; Name: 'GetIsVoiceType'; ParamType1: ptVoiceType),
{V} (Index: 427; Name: 'GetPlantedExplosive'),
{N} (Index: 429; Name: 'IsScenePackageRunning'),
{V} (Index: 430; Name: 'GetHealthPercentage'),
{V} (Index: 432; Name: 'GetIsObjectType'; ParamType1: ptFormType),
{V} (Index: 434; Name: 'GetDialogueEmotion'),
{V} (Index: 435; Name: 'GetDialogueEmotionValue'),
{V} (Index: 437; Name: 'GetIsCreatureType'; ParamType1: ptInteger),
{N} (Index: 444; Name: 'GetInCurrentLocFormList'; ParamType1: ptFormList),
{V} (Index: 445; Name: 'GetInZone'; ParamType1: ptEncounterZone),
{N} (Index: 446; Name: 'GetVelocity'; ParamType1: ptAxis),
{N} (Index: 447; Name: 'GetGraphVariableFloat'; ParamType1: ptVariableName),
{V} (Index: 448; Name: 'HasPerk'; ParamType1: ptPerk; ParamType2: ptInteger{Alt?}),
{V} (Index: 449; Name: 'GetFactionRelation'; ParamType1: ptActor),
{V} (Index: 450; Name: 'IsLastIdlePlayed'; ParamType1: ptIdleForm),
{V} (Index: 453; Name: 'GetPlayerTeammate'),
{V} (Index: 454; Name: 'GetPlayerTeammateCount'),
{V} (Index: 458; Name: 'GetActorCrimePlayerEnemy'),
{V} (Index: 459; Name: 'GetCrimeGold'),
{V} (Index: 463; Name: 'IsPlayerGrabbedRef'; ParamType1: ptObjectReference),
{N} (Index: 465; Name: 'GetKeywordItemCount'; ParamType1: ptKeyword),
{V} (Index: 470; Name: 'GetDestructionStage'),
{V} (Index: 473; Name: 'GetIsAlignment'; ParamType1: ptAlignment),
{N} (Index: 476; Name: 'IsProtected'),
{V} (Index: 477; Name: 'GetThreatRatio'; ParamType1: ptActor),
{V} (Index: 479; Name: 'GetIsUsedItemEquipType'; ParamType1: ptEquipType),
{N} (Index: 487; Name: 'IsCarryable'),
{V} (Index: 488; Name: 'GetConcussed'),
{V} (Index: 491; Name: 'GetMapMarkerVisible'),
{N} (Index: 493; Name: 'PlayerKnows'; ParamType1: ptMagicEffect),
{V} (Index: 494; Name: 'GetPermanentActorValue'; ParamType1: ptActorValue),
{V} (Index: 495; Name: 'GetKillingBlowLimb'),
{N} (Index: 497; Name: 'CanPayCrimeGold'),
{N} (Index: 499; Name: 'GetDaysInJail'),
{N} (Index: 500; Name: 'EPAlchemyGetMakingPoison'),
{N} (Index: 501; Name: 'EPAlchemyEffectHasKeyword'; ParamType1: ptKeyword),
{N} (Index: 503; Name: 'GetAllowWorldInteractions'),
{V} (Index: 508; Name: 'GetLastHitCritical'),
{N} (Index: 513; Name: 'IsCombatTarget'; ParamType1: ptActor),
{V} (Index: 515; Name: 'GetVATSRightAreaFree'; ParamType1: ptObjectReference),
{V} (Index: 516; Name: 'GetVATSLeftAreaFree'; ParamType1: ptObjectReference),
{V} (Index: 517; Name: 'GetVATSBackAreaFree'; ParamType1: ptObjectReference),
{V} (Index: 518; Name: 'GetVATSFrontAreaFree'; ParamType1: ptObjectReference),
{N} (Index: 519; Name: 'GetLockIsBroken'),
{N} (Index: 520; Name: 'IsPS3'),
{N} (Index: 521; Name: 'IsWin32'),
{V} (Index: 522; Name: 'GetVATSRightTargetVisible'; ParamType1: ptObjectReference),
{V} (Index: 523; Name: 'GetVATSLeftTargetVisible'; ParamType1: ptObjectReference),
{V} (Index: 524; Name: 'GetVATSBackTargetVisible'; ParamType1: ptObjectReference),
{V} (Index: 525; Name: 'GetVATSFrontTargetVisible'; ParamType1: ptObjectReference),
{V} (Index: 528; Name: 'IsInCriticalStage'; ParamType1: ptCriticalStage),
{N} (Index: 530; Name: 'GetXPForNextLevel'),
{N} (Index: 533; Name: 'GetInfamy'),
{N} (Index: 534; Name: 'GetInfamyViolent'),
{N} (Index: 535; Name: 'GetInfamyNonViolent'),
{V} (Index: 543; Name: 'GetQuestCompleted'; ParamType1: ptQuest),
{V} (Index: 547; Name: 'IsGoreDisabled'),
{N} (Index: 550; Name: 'IsSceneActionComplete'; ParamType1: ptScene; ParamType2: ptInteger),
{V} (Index: 552; Name: 'GetSpellUsageNum'; ParamType1: ptMagicItem),
{N} (Index: 554; Name: 'GetActorsInHigh'),
{V} (Index: 555; Name: 'HasLoaded3D'),
{N} (Index: 560; Name: 'HasKeyword'; ParamType1: ptKeyword),
{N} (Index: 561; Name: 'HasRefType'; ParamType1: ptRefType),
{N} (Index: 562; Name: 'LocationHasKeyword'; ParamType1: ptKeyword),
{N} (Index: 563; Name: 'LocationHasRefType'; ParamType1: ptRefType),
{N} (Index: 565; Name: 'GetIsEditorLocation'; ParamType1: ptLocation),
{N} (Index: 566; Name: 'GetIsAliasRef'; ParamType1: ptAlias),
{N} (Index: 567; Name: 'GetIsEditorLocAlias'; ParamType1: ptAlias),
{N} (Index: 568; Name: 'IsSprinting'),
{N} (Index: 569; Name: 'IsBlocking'),
{N} (Index: 570; Name: 'HasEquippedSpell'; ParamType1: ptCastingSource),
{N} (Index: 571; Name: 'GetCurrentCastingType'; ParamType1: ptCastingSource),
{N} (Index: 572; Name: 'GetCurrentDeliveryType'; ParamType1: ptCastingSource),
{N} (Index: 574; Name: 'GetAttackState'),
{N} (Index: 576; Name: 'GetEventData'; ParamType1: ptNone; ParamType2: ptNone; ParamType3: ptNone),
{N} (Index: 577; Name: 'IsCloserToAThanB'; ParamType1: ptObjectReference; ParamType2: ptObjectReference),
{N} (Index: 579; Name: 'GetEquippedShout'; ParamType1: ptShout),
{N} (Index: 580; Name: 'IsBleedingOut'),
{N} (Index: 584; Name: 'GetRelativeAngle'; ParamType1: ptObjectReference; ParamType2: ptAxis),
{N} (Index: 589; Name: 'GetMovementDirection'),
{N} (Index: 590; Name: 'IsInScene'),
{N} (Index: 591; Name: 'GetRefTypeDeadCount'; ParamType1: ptLocation; ParamType2: ptRefType),
{N} (Index: 592; Name: 'GetRefTypeAliveCount'; ParamType1: ptLocation; ParamType2: ptRefType),
{N} (Index: 594; Name: 'GetIsFlying'),
{N} (Index: 595; Name: 'IsCurrentSpell'; ParamType1: ptMagicItem; ParamType2: ptCastingSource),
{N} (Index: 596; Name: 'SpellHasKeyword'; ParamType1: ptCastingSource; ParamType2: ptKeyword),
{N} (Index: 597; Name: 'GetEquippedItemType'; ParamType1: ptCastingSource),
{N} (Index: 598; Name: 'GetLocationAliasCleared'; ParamType1: ptAlias),
{N} (Index: 600; Name: 'GetLocAliasRefTypeDeadCount'; ParamType1: ptAlias; ParamType2: ptRefType),
{N} (Index: 601; Name: 'GetLocAliasRefTypeAliveCount'; ParamType1: ptAlias; ParamType2: ptRefType),
{N} (Index: 602; Name: 'IsWardState'; ParamType1: ptWardState),
{N} (Index: 603; Name: 'IsInSameCurrentLocAsRef'; ParamType1: ptObjectReference; ParamType2: ptKeyword),
{N} (Index: 604; Name: 'IsInSameCurrentLocAsRefAlias'; ParamType1: ptAlias; ParamType2: ptKeyword),
{N} (Index: 605; Name: 'LocAliasIsLocation'; ParamType1: ptAlias; ParamType2: ptLocation),
{N} (Index: 606; Name: 'GetKeywordDataForLocation'; ParamType1: ptLocation; ParamType2: ptKeyword),
{N} (Index: 608; Name: 'GetKeywordDataForAlias'; ParamType1: ptAlias; ParamType2: ptKeyword),
{N} (Index: 610; Name: 'LocAliasHasKeyword'; ParamType1: ptAlias; ParamType2: ptKeyword),
{N} (Index: 611; Name: 'IsNullPackageData'; ParamType1: ptPackage),
{N} (Index: 612; Name: 'GetNumericPackageData'; ParamType1: ptInteger),
{N} (Index: 613; Name: 'IsFurnitureAnimType'; ParamType1: ptFurnitureAnim),
{N} (Index: 614; Name: 'IsFurnitureEntryType'; ParamType1: ptFurnitureEntry),
{N} (Index: 615; Name: 'GetHighestRelationshipRank'),
{N} (Index: 616; Name: 'GetLowestRelationshipRank'),
{N} (Index: 617; Name: 'HasAssociationTypeAny'; ParamType1: ptAssociationType),
{N} (Index: 618; Name: 'HasFamilyRelationshipAny'),
{N} (Index: 619; Name: 'GetPathingTargetOffset'; ParamType1: ptAxis),
{N} (Index: 620; Name: 'GetPathingTargetAngleOffset'; ParamType1: ptAxis),
{N} (Index: 621; Name: 'GetPathingTargetSpeed'),
{N} (Index: 622; Name: 'GetPathingTargetSpeedAngle'; ParamType1: ptAxis),
{N} (Index: 623; Name: 'GetMovementSpeed'),
{N} (Index: 624; Name: 'GetInContainer'; ParamType1: ptObjectReference),
{N} (Index: 625; Name: 'IsLocationLoaded'; ParamType1: ptLocation),
{N} (Index: 626; Name: 'IsLocAliasLoaded'; ParamType1: ptAlias),
{N} (Index: 627; Name: 'IsDualCasting'),
{N} (Index: 629; Name: 'GetVMQuestVariable'; ParamType1: ptQuest; ParamType2: ptVariableName),
{N} (Index: 630; Name: 'GetVMScriptVariable'; ParamType1: ptObjectReference; ParamType2: ptVariableName),
{N} (Index: 631; Name: 'IsEnteringInteractionQuick'),
{N} (Index: 632; Name: 'IsCasting'),
{N} (Index: 633; Name: 'GetFlyingState'),
{N} (Index: 635; Name: 'IsInFavorState'),
{N} (Index: 636; Name: 'HasTwoHandedWeaponEquipped'),
{N} (Index: 637; Name: 'IsExitingInstant'),
{N} (Index: 638; Name: 'IsInFriendStateWithPlayer'),
{N} (Index: 639; Name: 'GetWithinDistance'; ParamType1: ptObjectReference; ParamType2: ptFloat),
{N} (Index: 640; Name: 'GetActorValuePercent'; ParamType1: ptActorValue),
{N} (Index: 641; Name: 'IsUnique'),
{N} (Index: 642; Name: 'GetLastBumpDirection'),
{N} (Index: 644; Name: 'IsInFurnitureState'; ParamType1: ptFurnitureAnim),
{N} (Index: 645; Name: 'GetIsInjured'),
{N} (Index: 646; Name: 'GetIsCrashLandRequest'),
{N} (Index: 647; Name: 'GetIsHastyLandRequest'),
{N} (Index: 650; Name: 'IsLinkedTo'; ParamType1: ptObjectReference; ParamType2: ptKeyword),
{N} (Index: 651; Name: 'GetKeywordDataForCurrentLocation'; ParamType1: ptKeyword),
{N} (Index: 652; Name: 'GetInSharedCrimeFaction'; ParamType1: ptObjectReference),
{N} (Index: 654; Name: 'GetBribeSuccess'),
{N} (Index: 655; Name: 'GetIntimidateSuccess'),
{N} (Index: 656; Name: 'GetArrestedState'),
{N} (Index: 657; Name: 'GetArrestingActor'),
{N} (Index: 659; Name: 'EPTemperingItemIsEnchanted'),
{N} (Index: 660; Name: 'EPTemperingItemHasKeyword'; ParamType1: ptKeyword),
{N} (Index: 664; Name: 'GetReplacedItemType'; ParamType1: ptCastingSource),
{N} (Index: 672; Name: 'IsAttacking'),
{N} (Index: 673; Name: 'IsPowerAttacking'),
{N} (Index: 674; Name: 'IsLastHostileActor'),
{N} (Index: 675; Name: 'GetGraphVariableInt'; ParamType1: ptVariableName),
{N} (Index: 676; Name: 'GetCurrentShoutVariation'),
{N} (Index: 678; Name: 'ShouldAttackKill'; ParamType1: ptActor),
{N} (Index: 680; Name: 'GetActivatorHeight'),
{N} (Index: 681; Name: 'EPMagic_IsAdvanceSkill'; ParamType1: ptActorValue),
{N} (Index: 682; Name: 'WornHasKeyword'; ParamType1: ptKeyword),
{N} (Index: 683; Name: 'GetPathingCurrentSpeed'),
{N} (Index: 684; Name: 'GetPathingCurrentSpeedAngle'; ParamType1: ptAxis),
{N} (Index: 691; Name: 'EPModSkillUsage_AdvanceObjectHasKeyword'; ParamType1: ptKeyword),
{N} (Index: 692; Name: 'EPModSkillUsage_IsAdvanceAction'; ParamType1: ptAdvanceAction),
{N} (Index: 693; Name: 'EPMagic_SpellHasKeyword'; ParamType1: ptKeyword),
{N} (Index: 694; Name: 'GetNoBleedoutRecovery'),
{N} (Index: 696; Name: 'EPMagic_SpellHasSkill'; ParamType1: ptActorValue),
{N} (Index: 697; Name: 'IsAttackType'; ParamType1: ptKeyword),
{N} (Index: 698; Name: 'IsAllowedToFly'),
{N} (Index: 699; Name: 'HasMagicEffectKeyword'; ParamType1: ptKeyword),
{N} (Index: 700; Name: 'IsCommandedActor'),
{N} (Index: 701; Name: 'IsStaggered'),
{N} (Index: 702; Name: 'IsRecoiling'),
{N} (Index: 703; Name: 'IsExitingInteractionQuick'),
{N} (Index: 704; Name: 'IsPathing'),
{N} (Index: 705; Name: 'GetShouldHelp'; ParamType1: ptActor),
{N} (Index: 706; Name: 'HasBoundWeaponEquipped'; ParamType1: ptCastingSource),
{N} (Index: 707; Name: 'GetCombatTargetHasKeyword'; ParamType1: ptKeyword),
{N} (Index: 709; Name: 'GetCombatGroupMemberCount'),
{N} (Index: 710; Name: 'IsIgnoringCombat'),
{N} (Index: 711; Name: 'GetLightLevel'),
{N} (Index: 713; Name: 'SpellHasCastingPerk'; ParamType1: ptPerk),
{N} (Index: 714; Name: 'IsBeingRidden'),
{N} (Index: 715; Name: 'IsUndead'),
{N} (Index: 716; Name: 'GetRealHoursPassed'),
{N} (Index: 718; Name: 'IsUnlockedDoor'),
{N} (Index: 719; Name: 'IsHostileToActor'; ParamType1: ptActor),
{N} (Index: 720; Name: 'GetTargetHeight'; ParamType1: ptObjectReference),
{N} (Index: 721; Name: 'IsPoison'),
{N} (Index: 722; Name: 'WornApparelHasKeywordCount'; ParamType1: ptKeyword),
{N} (Index: 723; Name: 'GetItemHealthPercent'),
{N} (Index: 724; Name: 'EffectWasDualCast'),
{N} (Index: 725; Name: 'GetKnockedStateEnum'),
{N} (Index: 726; Name: 'DoesNotExist'),
{N} (Index: 730; Name: 'IsOnFlyingMount'),
{N} (Index: 731; Name: 'CanFlyHere'),
{N} (Index: 732; Name: 'IsFlyingMountPatrolQueud'),
{N} (Index: 733; Name: 'IsFlyingMountFastTravelling')
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

  // "使用全局" flag
  if Integer(Container.ElementByName['类型'].NativeValue) and $04 <> 0 then
    Result := 1;
end;

function wbCTDAParam1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Desc: PCTDAFunction;
  Container: IwbContainer;
  ParamFlag: Byte;
  ParamType: TCTDAFunctionParamType;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  Desc := wbCTDAParamDescFromIndex(Container.ElementByName['函数'].NativeValue);

  if Assigned(Desc) then begin
    ParamType := Desc.ParamType1;
    ParamFlag := Container.ElementByName['类型'].NativeValue;
    if ParamType in [ptObjectReference, ptActor, ptPackage] then begin
      if ParamFlag and $02 > 0 then ParamType := ptAlias else {>>> '使用别名' is set <<<}
      if ParamFlag and $08 > 0 then ParamType := ptPackdata;  {>>> '使用AI包数据' is set <<<}
    end;
    Result := Succ(Integer(ParamType));
  end;
end;

function wbCTDAParam2Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Desc: PCTDAFunction;
  Container: IwbContainer;
  ParamFlag: Byte;
  ParamType: TCTDAFunctionParamType;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  Desc := wbCTDAParamDescFromIndex(Container.ElementByName['函数'].NativeValue);

  if Assigned(Desc) then begin
    ParamType := Desc.ParamType2;
    ParamFlag := Container.ElementByName['类型'].NativeValue;
    if ParamType in [ptObjectReference, ptActor, ptPackage] then begin
      if ParamFlag and $02 > 0 then ParamType := ptAlias else {>>> '使用别名' is set <<<}
      if ParamFlag and $08 > 0 then ParamType := ptPackdata;  {>>> '使用AI包数据' is set <<<}
    end;
    Result := Succ(Integer(ParamType));
  end;
end;

function wbCTDAParam2VATSValueParamDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container : IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  Result := Container.ElementByName['参数 #1'].NativeValue;
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
//    (Count: 2; Caption1: 'Perk Owner'; Caption2: '物品'),
//    (Count: 2; Caption1: 'Perk Owner'; Caption2: '武器'),
//    (Count: 3; Caption1: 'Perk Owner'; Caption2: '武器'; Caption3: '目标'),
//    (Count: 2; Caption1: 'Perk Owner'; Caption2: '目标'),
//    (Count: 2; Caption1: 'Perk Owner'; Caption2: '攻击者'),
//    (Count: 3; Caption1: 'Perk Owner'; Caption2: '攻击者'; Caption3: 'Attackee'),
//    (Count: 3; Caption1: 'Perk Owner'; Caption2: '攻击者'; Caption3: 'Attacker Weapon')
//  );
//
//  wbPERKFunctions : array[0..9] of TPERKFunction = (
//    (Name: ''; FunctionType: epfUnknown; ParamType: epfpNone),
//    (Name: '设置数值'; FunctionType: epfFloat; ParamType: epfpFloat),
//    (Name: '添加数值（加）'; FunctionType: epfFloat; ParamType: epfpFloat),
//    (Name: '添加数值（乘）'; FunctionType: epfFloat; ParamType: epfpFloat),
//    (Name: '添加范围到数值'; FunctionType: epfFloat; ParamType: epfpFloatFloat),
//    (Name: '添加角色数值加乘'; FunctionType: epfFloat; ParamType: epfpFloatFloat),
//    (Name: '绝对值'; FunctionType: epfFloat; ParamType: epfpNone),
//    (Name: '负绝对值'; FunctionType: epfFloat; ParamType: epfpNone),
//    (Name: '添加等级列表'; FunctionType: epfLeveledItem; ParamType: epfpLeveledItem),
//    (Name: '添加激活选项'; FunctionType: epfScript; ParamType: epfpScript)
//  );
//
//  wbPERKEntryPoints : array[0..73] of TPERKEntryPoint = (
//    (Name: '计算武器伤害'; Condition: epcWeaponTarget),
//    (Name: '计算我的致命攻击概率'; Condition: epcWeaponTarget),
//    (Name: '计算我的致命攻击伤害'; Condition: epcWeaponTarget),
//    (Name: 'Calculate Weapon Attack AP Cost'; Condition: epcWeapon),
//    (Name: '计算地雷爆炸概率'; Condition: epcItem),
//    (Name: 'Adjust Range Penalty'; Condition: epcWeapon),
//    (Name: '调整肢体伤害'; Condition: epcAttackerAttackerWeapon),
//    (Name: 'Calculate Weapon Range'; Condition: epcWeapon),
//    (Name: 'Calculate To Hit Chance'; Condition: epcWeaponTarget),
//    (Name: 'Adjust Experience Points'),
//    (Name: 'Adjust Gained Skill Points'),
//    (Name: '调整书籍技能点'),
//    (Name: '修改生命恢复'),
//    (Name: 'Calculate Inventory AP Cost'),
//    (Name: 'Get Disposition'; Condition: epcTarget),
//    (Name: '获取肩膀攻击'; Condition: epcAttacker),
//    (Name: 'Get Should Assist'; Condition: epcAttackerAttackee),
//    (Name: 'Calculate Buy Price'; Condition: epcItem),
//    (Name: 'Get Bad Karma'),
//    (Name: 'Get Good Karma'),
//    (Name: 'Ignore Locked Terminal'),
//    (Name: '添加死亡等级列表'; Condition: epcTarget; FunctionType: epfLeveledItem),
//    (Name: '获取最大负重'),
//    (Name: '修改上瘾概率'),
//    (Name: '修改上瘾时长'),
//    (Name: '修改主动化学时长'),
//    (Name: 'Adjust Drinking Radiation'),
//    (Name: '激活'; Condition: epcTarget; FunctionType: epfScript),
//    (Name: 'Mysterious Stranger'),
//    (Name: 'Has Paralyzing Palm'),
//    (Name: 'Hacking Science Bonus'),
//    (Name: '侦测时忽略跑步'),
//    (Name: '忽略损坏的锁'),
//    (Name: 'Has Concentrated Fire'),
//    (Name: 'Calculate Gun Spread'; Condition: epcWeapon),
//    (Name: 'Player Kill AP Reward'; Condition: epcWeaponTarget),
//{36}(Name: '修改敌人致命攻击概率'; Condition: epcWeaponTarget),
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
//    '无',
//    '浮点数',
//    '浮点数, 浮点数',
//    '等级物品',
//    '脚本'
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
//    i := EntryPoint.ElementNativeValues['函数'];
//    if (i >= Low(wbPERKFunctions)) and (i <= High(wbPERKFunctions)) then
//      OldFunction := @wbPERKFunctions[i]
//    else
//      OldFunction := nil;
//    if not Assigned(OldFunction) or (OldFunction.FunctionType <> NewEntryPoint.FunctionType) then
//      for i := Low(wbPERKFunctions) to High(wbPERKFunctions) do
//        with wbPERKFunctions[i] do
//          if FunctionType = NewEntryPoint.FunctionType then begin
//            EntryPoint.ElementNativeValues['函数'] := i;
//            Break;
//          end;
//    EntryPoint.ElementNativeValues['天赋条件选项总数'] := NewCondition.Count;
//
//    if not Supports(EntryPoint.Container, IwbContainerElementRef, Container) then
//      Exit;
//    if not Supports(Container.Container, IwbContainerElementRef, Effect) then
//      Exit;
//
//    if not Supports(Effect.ElementByName['天赋条件'], IwbContainerElementRef, PerkConditions) then
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
//  EntryPointVar := Container.ElementNativeValues['..\..\..\DATA\记录点\记录点'];
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
//  EntryPointVar := Container.ElementNativeValues['..\..\..\DATA\记录点\记录点'];
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

{>>> Needs revision for Skyrim <<<}
//function wbPERKPRKCDontShow(const aElement: IwbElement): Boolean;
//var
//  Container: IwbContainerElementRef;
//begin
//  Result := False;
//  if aElement.Name <> '效果' then
//    Exit;
//  if not Supports(aElement, IwbContainerElementRef, Container) then
//    Exit;
//  if Integer(Container.ElementNativeValues['PRKE\类型']) <> 2 then
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
//  EntryPointVar := Container.ElementNativeValues['..\记录点'];
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
//  EntryPointVar := Container.ElementNativeValues['..\记录点'];
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
//  OldParamType := Container.ElementNativeValues['..\..\..\记录点函数参数\EPFT'];
//  NewParamType := Ord(wbPERKFunctions[NewFunction].ParamType);
//  if (OldParamType = NewParamType) and not VarSameValue(aOldValue, aNewValue) and (NewFunction in [4,5]) then
//    Container.ElementNativeValues['..\..\..\记录点函数参数\EPFT'] := 0;
//  Container.ElementNativeValues['..\..\..\记录点函数参数\EPFT'] := NewParamType;
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
//  FunctionTypeVar := Container.ElementNativeValues['..\..\DATA\记录点\函数'];
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
//  FunctionTypeVar := Container.ElementNativeValues['..\..\DATA\记录点\函数'];
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

procedure wbWRLDAfterLoad(const aElement: IwbElement);
var
  MainRecord: IwbMainRecord;
begin
  wbRemoveOFST(aElement);

  if wbBeginInternalEdit then try

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.ElementExists['未使用 RNAM'] then
      MainRecord.RemoveElement('未使用 RNAM');

  finally
    wbEndInternalEdit;
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

{>>> No "Run On Target" flag in Skyrim, disabled <<<}
//procedure wbCTDAAfterLoad(const aElement: IwbElement);
//var
//  Container  : IwbContainerElementRef;
//  //Size       : Cardinal;
//  TypeFlags  : Cardinal;
//begin
//  if wbBeginInternalEdit then try
//    if not Supports(aElement, IwbContainerElementRef, Container) then
//      Exit;
//
//    if Container.ElementCount < 1 then
//      Exit;
//
//    TypeFlags := Container.ElementNativeValues['类型'];
//    if (TypeFlags and $02) <> 0 then begin
//      if Container.DataSize = 20 then
//        Container.DataSize := 28;
//      Container.ElementNativeValues['类型'] := TypeFlags and not $02;
//      Container.ElementEditValues['运行于'] := '目标';
//    end;
//  finally
//    wbEndInternalEdit;
//  end;
//end;

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
//    OldActorValue := Container.ElementNativeValues['DATA - 数据\角色数值'];
//    NewActorValue := OldActorValue;
//    case Integer(Container.ElementNativeValues['DATA - 数据\原型']) of
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
//      Container.ElementNativeValues['DATA - 数据\角色数值'] := NewActorValue;
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
//    case Integer(Container.ElementNativeValues['PKDT - General\类型']) of
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
//             NewContainer.ElementEditValues['PLDT - Location 1\类型'] := '接近编辑器位置';
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
//             NewContainer.ElementEditValues['PLDT - Location 1\类型'] := '接近连接的衍生';
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

procedure wbRemoveEmptyKWDA(const aElement: IwbElement);
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

    if not Assigned(Container.ElementBySignature['KSIZ']) then
      if Assigned(Container.ElementBySignature['KWDA']) then
        Container.ElementBySignature['KWDA'].Remove;

  finally
    wbEndInternalEdit;
  end;
end;

procedure wbReplaceBODTwithBOD2(const aElement: IwbElement);
var
  MainRecord    : IwbMainRecord;
  ContainerBOD2 : IwbContainerElementRef;
  ContainerBODT : IwbContainerElementRef;
begin
  Exit; {>>> Looks like causes problems with Dawnguard.esm <<<}

  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if not Supports(MainRecord.ElementBySignature[BODT], IwbContainerElementRef, ContainerBODT) then
      Exit;

    if Supports(MainRecord.Add('BOD2', True), IwbContainerElementRef, ContainerBOD2) then begin
       ContainerBOD2.ElementNativeValues['第一人称标志'] := ContainerBODT.ElementNativeValues['第一人称标志'];
       ContainerBOD2.ElementNativeValues['盔甲类型'] := ContainerBODT.ElementNativeValues['盔甲类型'];
       MainRecord.RemoveElement(BODT);
    end;

  finally
    wbEndInternalEdit;
  end;
end;

procedure wbARMOAfterLoad(const aElement: IwbElement);
begin
  wbRemoveEmptyKWDA(aElement);
  wbReplaceBODTwithBOD2(aElement);
end;

procedure wbARMAAfterLoad(const aElement: IwbElement);
{var
  MainRecord    : IwbMainRecord;}
begin
  wbReplaceBODTwithBOD2(aElement);
  {if wbBeginInternalEdit then try
    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;
    if MainRecord.ElementNativeValues['DNAM\根据体重调整 - 男性'] = 0 then
      MainRecord.ElementNativeValues['DNAM\根据体重调整 - 男性'] := 2;
    if MainRecord.ElementNativeValues['DNAM\根据体重调整 - 女性'] = 0 then
      MainRecord.ElementNativeValues['DNAM\根据体重调整 - 女性'] := 2;
  finally
    wbEndInternalEdit;
  end;}
end;

procedure wbNPCAfterLoad(const aElement: IwbElement);
begin
  wbRemoveEmptyKWDA(aElement);
end;

procedure wbREFRAfterLoad(const aElement: IwbElement);
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

    if Container.ElementExists['XLOC'] then begin
      if Container.ElementNativeValues['XLOC - 锁数据\Level'] = 0 then
        Container.ElementNativeValues['XLOC - 锁数据\Level'] := 1;
    end;

    Container.RemoveElement('XPTL');
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbRACEAfterLoad(const aElement: IwbElement);
begin
  wbRemoveOFST(aElement);
  wbReplaceBODTwithBOD2(aElement);
end;

procedure wbWEAPAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
  Flags      : Cardinal;
begin
  wbRemoveEmptyKWDA(aElement);

  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    // clear IronSights flags which are randomly assigned in CK
    if Container.ElementExists['DNAM'] then begin
      Flags := Container.ElementNativeValues['DNAM - Data\标志'];
      Flags := Flags and ($FFFF xor $0040);
      Container.ElementNativeValues['DNAM - Data\标志'] := Flags;
      Flags := Container.ElementNativeValues['DNAM - Data\标志2'];
      Flags := Flags and ($FFFFFFFF xor $0100);
      Container.ElementNativeValues['DNAM - Data\标志2'] := Flags;
    end;

  finally
    wbEndInternalEdit;
  end;
end;

procedure wbCELLAfterLoad(const aElement: IwbElement);
var
  Container    : IwbContainerElementRef;
//  Container2   : IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
  HasWater     : Boolean;
//  IsInterior   : Boolean;
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

    if not Container.ElementExists['DATA'] then
      Exit;

//    IsInterior := (Container.ElementNativeValues['DATA'] and 1) <> 0;
    HasWater := (Container.ElementNativeValues['DATA'] and 2) <> 0;

    if HasWater then begin
      if not Container.ElementExists['XCLW'] then begin
        Container.Add('XCLW', True);
        Container.ElementEditValues['XCLW'] := '-2147483648.000000';
      end;
    end else begin
      if Container.ElementExists['XCLW'] then
        Container.ElementEditValues['XCLW'] := '-2147483648.000000';
    end;

//    if Supports(Container.ElementBySignature[XCLR], IwbContainerElementRef, Container2) then begin
//      for i := Pred(Container2.ElementCount) downto 0 do
//        if not Supports(Container2.Elements[i].LinksTo, IwbMainRecord, MainRecord) or (MainRecord.Signature <> 'REGN') then
//          Container2.RemoveElement(i);
//      if Container2.ElementCount < 1 then
//        Container2.Remove;
//    end;
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


{>>>
  Updated, but not called for Skyrim
  Why is it required to fix particle counts? Because 1 pass = 79 particles?
>>>}
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
//    FullParticleBirthRatio := Container.ElementNativeValues['DATA\粒子着色器 - 完整粒子产生比率'];
//    PersistantParticleCount := Container.ElementNativeValues['DATA\粒子着色器 - 固定粒子数'];
//
//    if ((FullParticleBirthRatio <> 0) and (FullParticleBirthRatio <= 1)) then begin
//      FullParticleBirthRatio := FullParticleBirthRatio * 78.0;
//      Container.ElementNativeValues['DATA\粒子着色器 - 完整粒子产生比率'] := FullParticleBirthRatio;
//    end;
//
//    if ((PersistantParticleCount <> 0) and (PersistantParticleCount <= 1)) then begin
//      PersistantParticleCount := PersistantParticleCount * 78.0;
//      Container.ElementNativeValues['DATA\粒子着色器 - 固定粒子数'] := PersistantParticleCount;
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

function wbPubPackCNAMDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  rANAM: IwbRecord;
  ctype: string;
begin
  Result := 0;
  rANAM := aElement.Container.RecordBySignature[ANAM];
  if Assigned(rANAM) then begin
    ctype := rANAM.NativeValue;
    // Do not translate.
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
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  Result := Container.ElementByName['类型'].NativeValue;
end;

procedure DefineTES5a;
begin
  wbLLCT := wbInteger(LLCT, '数量', itU8);
  wbCITC := wbInteger(CITC, '条件数', itU32);
  wbLVLD := wbInteger(LVLD, '空白概率', itU8, nil, cpNormal, True);

  wbSPCT := wbInteger(SPCT, '数量', itU32);
  wbSPLO := wbFormIDCk(SPLO, '魔法', [SPEL, SHOU, LVSP]);
  wbSPLOs := wbRArrayS('魔法', wbSPLO, cpNormal, False, nil, nil, nil{wbActorTemplateUseActorEffectList});

  wbKSIZ := wbInteger(KSIZ, '关键字数量', itU32);
  wbKWDAs := wbArrayS(KWDA, '关键字', wbFormIDCk('关键字', [KYWD, NULL]), 0, cpNormal);

  wbCOED := wbStructExSK(COED, [2], [0, 1], '额外数据', [
    {00} wbFormIDCkNoReach('所有者', [NPC_, FACT, NULL]),
    {04} wbUnion('全局变量 / 要求级别', wbCOEDOwnerDecider, [
           wbByteArray('未使用', 4, cpIgnore),
           wbFormIDCk('全局变量', [GLOB, NULL]),
           wbInteger('要求级别', itS32)
         ]),
    {08} wbFloat('物品状况')
  ]);

  wbCNTO :=
    wbRStructExSK([0], [1], '物品', [
      wbStructExSK(CNTO, [0], [1], '物品', [
        wbFormIDCk('物品', [ARMO, AMMO, APPA, MISC, WEAP, BOOK, LVLI, KEYM, ALCH, INGR, LIGH, SLGM, SCRL]),
        wbInteger('数量', itS32)
      ]),
      wbCOED
    ], []);
  wbCOCT := wbInteger(COCT, '数量', itU32);
  wbCNTOs := wbRArrayS('物品', wbCNTO);

  wbArmorTypeEnum := wbEnum([
    '轻甲',
    '重甲',
    '服装'
  ]);

  {>>> When Set to None this Equals FF FF FF FF <<<}
  {>>> When NAME is user defined these will be incorrect <<<}
  wbBipedObjectEnum := wbEnum([
    '头部',
    '发型',
    '身体',
    '手',
    '前臂',
    '项链',
    '戒指',
    '脚',
    '小腿',
    '盾牌',
    '身体扩展 1 / 尾巴',
    '长头发',
    '饰环',
    '身体扩展 2',
    '身体扩展 3',
    '身体扩展 4',
    '身体扩展 5',
    '身体扩展 6',
    '身体扩展 7',
    '身体扩展 8',
    '斩首',
    '无头',
    '身体扩展 9',
    '身体扩展 10',
    '身体扩展 11',
    '身体扩展 12',
    '身体扩展 13',
    '身体扩展 14',
    '身体扩展 15',
    '身体扩展 16',
    '身体扩展 17',
    'FX01'
  ], [
    -1, '无'
  ]);

  wbBipedObjectFlags := wbFlags([
    {0x00000001} '头部',
    {0x00000002} '发型',
    {0x00000004} '身体',
    {0x00000008} '手',
    {0x00000010} '前臂',
    {0x00000020} '项链',
    {0x00000040} '戒指',
    {0x00000080} '脚',
    {0x00000100} '小腿',
    {0x00000200} '盾牌',
    {0x00000400} '身体扩展 1 / 尾巴',
    {0x00000800} '长头发',
    {0x00001000} '饰环',
    {0x00002000} '身体扩展 2',
    {0x00004000} '身体扩展 3',
    {0x00008000} '身体扩展 4',
    {0x00010000} '身体扩展 5',
    {0x00020000} '身体扩展 6',
    {0x00040000} '身体扩展 7',
    {0x00080000} '身体扩展 8',
    {0x00100000} '斩首',
    {0x00200000} '无头',
    {0x00400000} '身体扩展 9',
    {0x00800000} '身体扩展 10',
    {0x01000000} '身体扩展 11',
    {0x02000000} '身体扩展 12',
    {0x03000000} '身体扩展 13',
    {0x08000000} '身体扩展 14',
    {0x10000000} '身体扩展 15',
    {0x20000000} '身体扩展 16',
    {0x40000000} '身体扩展 17',
    {0x80000000} 'FX01'
  ], True);

  wbBODT := wbStruct(BODT, '身体模板', [
    wbInteger('第一人称标志', itU32, wbBipedObjectFlags),
    wbInteger('一般标志', itU8, wbFlags([
      {0x00000001}'(ARMA)改变声音', {>>> From ARMA <<<}
      {0x00000002}'未知 2',
      {0x00000004}'未知 3',
      {0x00000008}'未知 4',
      {0x00000010}'(ARMO)玩家不可用', {>>> From ARMO <<<}
      {0x00000020}'未知 6',
      {0x00000040}'未知 7',
      {0x00000080}'未知 8'
    ], True)),
    wbByteArray('未使用', 3, cpIgnore),
    wbInteger('盔甲类型', itU32, wbArmorTypeEnum)
  ], cpNormal, False, nil, 3);
  wbBOD2 := wbStruct(BOD2, '双足动物身体模版', [
    wbInteger('第一人称标志', itU32, wbBipedObjectFlags),
    wbInteger('盔甲类型', itU32, wbArmorTypeEnum)
  ], cpNormal, False);

  wbDMDL := wbString(DMDL, '模型');
  wbSNAM := wbFormIDCk(SNAM, '音效 - 开启', [SOUN, SNDR]);
  wbQNAM := wbFormIDCk(QNAM, '音效 - 关闭', [SOUN, SNDR]);
  wbMDOB := wbFormID(MDOB, '菜单显示对象', cpNormal, False);
  wbCNAM := wbStruct(CNAM, '颜色', [
    wbInteger('红', itU8),
    wbInteger('绿', itU8),
    wbInteger('蓝', itU8),
    wbByteArray('未知', 1)
  ]);
  wbCNAMReq := wbStruct(CNAM, '颜色', [
    wbInteger('红', itU8),
    wbInteger('绿', itU8),
    wbInteger('蓝', itU8),
    wbByteArray('未知', 1)
  ], cpNormal, True);

  wbDODT := wbStruct(DODT, '贴花数据', [
    wbFloat('最小宽度'),
    wbFloat('最大宽度'),
    wbFloat('最小高度'),
    wbFloat('最大高度'),
    wbFloat('深度'),
    wbFloat('亮度'),
    wbStruct('视差', [
      wbFloat('范围'),
      wbInteger('通道', itU8) {>>> This can't be higher than 30 <<<}
    ]),
    wbInteger('标志', itU8, wbFlags([
      {0x01}'视差',
      {0x02}'Alpha - 混合',
      {0x04}'Alpha - 测试',
      {0x08}'无 MipMap 层'
    ], True)),
    wbByteArray('未知', 2),
    wbStruct('颜色', [
      wbInteger('红', itU8),
      wbInteger('绿', itU8),
      wbInteger('蓝', itU8),
      wbByteArray('未知', 1)
    ])
  ]);

  wbRecordFlags := wbInteger('记录标志', itU32, wbFlags([
    {>>> 0x00000000 ACTI: Collision Geometry (default) <<<}
    {0x00000001}'ESM',
    {0x00000002}'未知 2',
    {>>> 0x00000004 ARMO: Not playable <<<}
    {0x00000004}'玩家不可用',
    {0x00000008}'未知 4',
    {0x00000010}'未知 5',
    {0x00000020}'已删除',
    {>>> 0x00000040 ACTI: Has Tree LOD <<<}
    {>>> 0x00000040 REGN: Border Region <<<}
    {>>> 0x00000040 STAT: Has Tree LOD <<<}
    {>>> 0x00000040 REFR: Hidden From Local Map <<<}
    {0x00000040}'恒定 小地图隐藏 边界地区 含树木LOD',
    {>>> 0x00000080 TES4: Localized <<<}
    {>>> 0x00000080 PHZD: Turn Off Fire <<<}
    {>>> 0x00000080 SHOU: Treat Spells as Powers <<<}
    {>>> 0x00000080 STAT: Add-on LOD Object <<<}
    {0x00000080}'已本地化 IsPerch 附加LOD物体 关闭火 将魔法当成威能',
    {>>> 0x00000100 ACTI: Must Update Anims <<<}
    {>>> 0x00000100 REFR: Inaccessible <<<}
    {>>> 0x00000100 REFR for LIGH: Doesn't light water <<<}
    {0x00000100}'强制更新动作 无法碰触 不照亮水面',
    {>>> 0x00000200 ACTI: Local Map - Turns Flag Off, therefore it is Hidden <<<}
    {>>> 0x00000200 REFR: MotionBlurCastsShadows <<<}
    {0x00000200}'小地图隐藏 开始已死 动态模糊投射阴影',
    {>>> 0x00000400 LSCR: Displays in Main Menu <<<}
    {0x00000400}'固定衍生 任务物品 主菜单显示',
    {0x00000800}'初始禁用',
    {0x00001000}'已忽略',
    {0x00002000}'未知 14',
    {0x00004000}'未知 15',
    {>>> 0x00008000 STAT: Has Distant LOD <<<}
    {0x00008000}'远景可见',
    {>>> 0x00010000 ACTI: Random Animation Start <<<}
    {>>> 0x00010000 REFR light: Never fades <<<}
    {0x00010000}'随机开始动画 永不淡去',
    {>>> 0x00020000 ACTI: Dangerous <<<}
    {>>> 0x00020000 REFR light: Doesn't light landscape <<<}
    {>>> 0x00020000 SLGM: Can hold NPC's soul <<<}
    {>>> 0x00020000 STAT: Use High-Detail LOD Texture <<<}
    {0x00020000}'危险 禁止进入 不照亮景观 高清晰LOD 可持有NPC灵魂',
    {0x00040000}'已压缩',
    {>>> 0x00080000 STAT: Has Currents <<<}
    {0x00080000}'无法等待 HasCurrents',
    {>>> 0x00100000 ACTI: Ignore Object Interaction <<<}
    {0x00100000}'忽视物体交互',
    {0x00200000}'未知 22',
    {0x00400000}'未知 23',
    {>>> 0x00800000 ACTI: Is Marker <<<}
    {0x00800000}'标记',
    {0x01000000}'未知 25',
    {>>> 0x02000000 ACTI: Obstacle <<<}
    {>>> 0x02000000 REFR: No AI Acquire <<<}
    {0x02000000}'障碍 无AI要求',
    {>>> 0x04000000 ACTI: Filter <<<}
    {0x04000000}'NavMesh过滤器',
    {>>> 0x08000000 ACTI: Bounding Box <<<}
    {0x08000000}'NavMesh边界框',
    {>>> 0x10000000 STAT: Show in World Map <<<}
    {0x10000000}'必须存在以交谈 世界地图显示',
    {>>> 0x20000000 ACTI: Child Can Use <<<}
    {>>> 0x20000000 REFR: Don't Havok Settle <<<}
    {0x20000000}'小孩可以使用 无Havok处理',
    {>>> 0x40000000 ACTI: GROUND <<<}
    {>>> 0x40000000 REFR: NoRespawn <<<}
    {0x40000000}'NavMesh范围 不重生',
    {>>> 0x80000000 REFR: MultiBound <<<}
    {0x80000000}'多重边界'
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
     '细声',
     '非常大声'
    ]);

  wbEntryPointsEnum := wbEnum([
    { 0} '计算武器伤害',
    { 1} '计算我的致命攻击概率',
    { 2} '计算我的致命攻击伤害',
    { 3} '计算地雷爆炸概率',
    { 4} '调整肢体伤害',
    { 5} '调整书籍技能点',
    { 6} '修改生命恢复',
    { 7} '获取肩膀攻击',
    { 8} '修改购买价格',
    { 9} '添加死亡等级列表',
    {10} '获取最大负重',
    {11} '修改上瘾概率',
    {12} '修改上瘾时长',
    {13} '修改主动化学持续时长',
    {14} '激活',
    {15} '侦测时忽略跑步',
    {16} '忽略损坏的锁',
    {17} '修改敌人致命攻击概率',
    {18} '修改潜行攻击加成',
    {19} '修改最大可放置地雷',
    {20} '修改弓箭焦距',
    {21} '修改弓箭恢复概率',
    {22} '修改技能使用',
    {23} '修改隔空取物范围',
    {24} '修改隔空取物伤害加成',
    {25} '修改隔空取物伤害',
    {26} '修改重击伤害',
    {27} '修改猛击体耗',
    {28} '修改猛击伤害',
    {29} '修改魔法量级',
    {30} '修改魔法持续时长',
    {31} '修改第二数值重量',
    {32} '修改盔甲重量',
    {33} '修改引入摇晃',
    {34} '修改目标摇晃',
    {35} '修改攻击伤害',
    {36} '修改引入伤害',
    {37} '修改目标伤害抵抗',
    {38} '修改魔法消耗',
    {39} '修改被格挡百分比',
    {40} '修改盾牌弯曲弓箭概率',
    {41} '修改引入魔法量级',
    {42} '修改引入魔法持续时长',
    {43} '修改玩家恐吓',
    {44} '修改玩家声望',
    {45} '修改好感点',
    {46} '修改贿赂数量',
    {47} '修改探测光源',
    {48} '修改探测移动',
    {49} '修改灵魂石充能',
    {50} '设置扫荡攻击',
    {51} '应用战斗击中魔法',
    {52} '应用重击魔法',
    {53} '应用活尸魔法',
    {54} '设置布尔图像变量',
    {55} '修改魔法施放音效事件',
    {56} '修改扒窃概率',
    {57} '修改探测前行技能',
    {58} '修改坠落伤害',
    {59} '修改撬锁最佳点',
    {60} '修改出售价格',
    {61} '可以扒窃装备的物品',
    {62} '修改允许的撬锁等级',
    {63} '设置撬锁起始弧度',
    {64} '设置进度拾取',
    {65} '让开锁器不会损坏',
    {66} '修改炼金效果',
    {67} '应用武器挥舞魔法',
    {68} '修改受控角色限制',
    {69} '应用潜行魔法',
    {70} '修改玩家魔法减弱',
    {71} '修改保护魔法吸收百分比',
    {72} '修改初始习得原料效果',
    {73} '净化炼金原料',
    {74} '过滤激活',
    {75} '可以双手施放魔法',
    {76} '修改缓和生命',
    {77} '修改附魔强度',
    {78} '修改灵魂注入武器百分比',
    {79} '修改灵魂石附魔',
    {80} '允许修改 # 应用的附魔',
    {81} '设置激活标签',
    {82} '修改吼声 OK',
    {83} '修改毒药剂量',
    {84} '可以应用放置的物品',
    {85} '修改防御力',
    {86} '修改撬锁犯罪概率',
    {87} '修改采集的原料',
    {88} '修改魔法范围 (目标位置)',
    {89} '修改制作的药水',
    {90} '修改撬锁钥匙奖励概率',
    {91} '允许骑马角色'
  ]);

  wbLocationEnum := wbEnum([
    {0} '接近衍生',
    {1} '在场景内',
    {2} '接近AI包起始位置',
    {3} '接近编辑器位置',
    {4} '对象编号',
    {5} '对象类型',
    {6} '接近连接的衍生',
    {7} '在AI包位置',
    {8} '别名 (衍生)',
    {9} '别名 (位置)',
   {10} '未知 10',
   {11} '未知 11',
   {12} '接近自身'
  ]);

  wbEquipType := wbFlags([
    {0x00000001}'近身混战',
    {0x00000002}'单手剑',
    {0x00000004}'单手匕首',
    {0x00000008}'单手斧',
    {0x00000010}'单手锤',
    {0x00000020}'双手剑',
    {0x00000040}'双手斧',
    {0x00000080}'弓',
    {0x00000100}'法杖',
    {0x00000200}'法术',
    {0x00000400}'盾牌',
    {0x00000800}'火把',
    {0x00001000}'十字弓'
  ], True);

  wbEmotionTypeEnum := wbEnum([
    {0} '无表情',
    {1} '生气',
    {2} '厌恶',
    {3} '恐惧',
    {4} '伤心',
    {5} '高兴',
    {6} '惊讶',
    {7} '困惑'
  ]);

  wbFurnitureAnimTypeEnum := wbEnum([
    {0} '',
    {1} '坐',
    {2} '躺',
    {3} '',
    {4} '靠'
  ]);

  wbFurnitureEntryTypeFlags := wbFlags([
    {0x01} '前',
    {0x02} '后',
    {0x04} '右',
    {0x08} '左',
    {0x10} '上'
  ]);

  wbWardStateEnum := wbEnum([
    '无',
    '吸收',
    '休息'
  ]);

  wbWeaponAnimTypeEnum := wbEnum([
    {0} '近身混战',
    {1} '单手剑',
    {2} '单手匕首',
    {3} '单手斧',
    {4} '单手锤',
    {5} '双手剑',
    {6} '双手斧',
    {7} '弓',
    {8} '法杖',
    {9} '十字弓'
  ]);

  wbEDID := wbString(EDID, '编辑器标识', 0, cpNormal); // not cpBenign according to Arthmoor
  wbFULL := wbLStringKC(FULL, '名称', 0, cpTranslate);
  wbFULLActor := wbLStringKC(FULL, '名称', 0, cpTranslate, False, nil{wbActorTemplateUseBaseData});
  wbFULLReq := wbLStringKC(FULL, '名称', 0, cpNormal, True);
  wbDESC := wbLStringKC(DESC, '描述', 0, cpTranslate);
  wbDESCReq := wbLStringKC(DESC, '描述', 0, cpTranslate, True);
  wbXSCL := wbFloat(XSCL, '范围');

  wbOBND := wbStruct(OBND, '物体方位', [
    wbInteger('X1', itS16),
    wbInteger('Y1', itS16),
    wbInteger('Z1', itS16),
    wbInteger('X2', itS16),
    wbInteger('Y2', itS16),
    wbInteger('Z2', itS16)
  ]);

  wbOBNDReq := wbStruct(OBND, '物体方位', [
    wbInteger('X1', itS16),
    wbInteger('Y1', itS16),
    wbInteger('Z1', itS16),
    wbInteger('X2', itS16),
    wbInteger('Y2', itS16),
    wbInteger('Z2', itS16)
  ], cpNormal, True);

  wbPropTypeEnum := wbEnum([
    {00} '',
    {01} '对象',
    {02} '字符串',
    {03} '32位整型',
    {04} '浮点数',
    {05} '布尔值',
    {06} '',
    {07} '',
    {08} '',
    {09} '',
    {10} '',
    {11} '对象数组',
    {12} '字符串数组',
    {13} '32位整型数组',
    {14} '浮点数数组',
    {15} '布尔值数组'
  ]);

  wbScriptObject := wbUnion('对象集合', wbScriptObjFormatDecider, [
    wbStructSK([1], '对象 v2', [
      wbInteger('未知', itU16),
      wbInteger('别名序号', itS16),
      wbFormID('表单序号')
    ]),
    wbStructSK([1], '对象 v1', [
      wbFormID('表单序号'),
      wbInteger('别名序号', itS16),
      wbInteger('未知', itU16)
    ])
  ]);

  wbScriptEntry := wbStructSK([0], '脚本', [
    wbLenString('脚本', 2),
    wbInteger('未知', itU8),
    wbArrayS('属性', wbStructSK([0], '属性', [
      wbLenString('属性', 2),
      wbInteger('类型', itU8, wbPropTypeEnum),
      wbInteger('未知', itU8),
      wbUnion('数值', wbScriptPropertyDecider, [
        {00} wbByteArray('未知', 0, cpIgnore),
        {01} wbScriptObject,
        {02} wbLenString('字符串', 2),
        {03} wbInteger('32位整型', itS32),
        {04} wbFloat('浮点数'),
        {05} wbInteger('布尔值', itU8, wbEnum(['假', '真'])),
        {11} wbArray('对象数组', wbScriptObject, -1),
        {12} wbArray('字符串数组', wbLenString('Element', 2), -1),
        {13} wbArray('32位整型数组', wbInteger('Element', itS32), -1),
        {14} wbArray('浮点数数组', wbFloat('Element'), -1),
        {15} wbArray('布尔值数组', wbInteger('Element', itU8, wbEnum(['假', '真'])), -1)
      ])
    ]), -2, cpNormal, False, nil, nil, nil, False)
  ]);

  wbScriptFragmentsInfo := wbStruct('脚本片段信息', [
    wbInteger('未知', itS8),
    wbInteger('信息片段标志', itU8, wbFlags([
      {1} '开始',
      {2} '结束'
    ])),
    wbLenString('文件名', 2),
    wbArray('信息片段',  // Do NOT sort, ordered OnBegin, OnEnd
      wbStruct('信息片段', [
        wbInteger('未知', itS8),
        wbLenString('脚本', 2),
        wbLenString('片段名', 2)
      ]), [], wbScriptFragmentsInfoCounter)
  ], cpNormal, false, wbScriptFragmentsDontShow);

  wbScriptFragmentsPack := wbStruct('脚本片段AI包', [
    wbInteger('未知', itS8),
    wbInteger('AI包片段标志', itU8, wbFlags([
      {1} '开始',
      {2} '结束',
      {4} '变化'
    ])),
    wbLenString('文件名', 2),
    wbArray('AI包片段',  // Do NOT sort, ordered OnBegin, OnEnd, OnChange
      wbStruct('AI包片段', [
        wbInteger('未知', itS8),
        wbLenString('脚本', 2),
        wbLenString('片段名', 2)
      ]), [], wbScriptFragmentsPackCounter)
  ], cpNormal, false, wbScriptFragmentsDontShow);

  wbScriptFragmentsPerk := wbStruct('脚本片段天赋', [
    wbInteger('未知', itS8),
    wbLenString('文件名', 2),
    wbArrayS('天赋片段',
      wbStructSK([0], '天赋片段', [
        wbInteger('片段索引', itU16),
        wbInteger('未知', itS16),
        wbInteger('未知', itS8),
        wbLenString('脚本', 2),
        wbLenString('片段名', 2)
      ]), -2)
  ], cpNormal, false, wbScriptFragmentsDontShow);

  wbScriptFragmentsQuest := wbStruct('脚本片段任务', [
    wbInteger('未知', itS8),
    wbInteger('片段数', itU16),
    wbLenString('文件名', 2),
    wbArrayS('任务片段',
      wbStructSK([0, 2], '任务片段', [
        wbInteger('任务阶段', itU16),
        wbInteger('未知', itS16),
        wbInteger('任务阶段索引', itS32),
        wbInteger('未知', itS8),
        wbLenString('脚本', 2),
        wbLenString('片段名', 2)
      ]), wbScriptFragmentsQuestCounter),
    wbArrayS('别名', wbStructSK([0], '别名', [
      wbScriptObject,
      wbInteger('版本', itS16),
      wbInteger('目标格式', itS16),
	    wbArrayS('别名脚本', wbScriptEntry, -2)
	  ]), -2)
  ], cpNormal, false, wbScriptFragmentsDontShow);

  wbScriptFragmentsScen := wbStruct('脚本片段场景', [
    wbInteger('未知', itS8),
    wbInteger('场景片段标志', itU8, wbFlags([
      {1} '开始',
      {2} '结束'
    ])),
    wbLenString('文件名', 2),
    wbArray('场景片段',  // Do NOT sort, ordered OnBegin, OnEnd
      wbStruct('场景片段', [
        wbInteger('未知', itS8),
        wbLenString('脚本', 2),
        wbLenString('片段名', 2)
      ]), [], wbScriptFragmentsSceneCounter),
    wbArray('阶段片段',
      wbStructSK([0, 1], '阶段片段', [
        wbInteger('阶段标志', itU8, wbFlags([
          {1} '启动',
          {2} '完成'
        ])),
        wbInteger('阶段索引', itU8),
        wbInteger('未知', itS16),
        wbInteger('未知', itS8),
        wbInteger('未知', itS8),
        wbLenString('脚本', 2),
        wbLenString('片段名', 2)
      ]), -2)
  ], cpNormal, false, wbScriptFragmentsDontShow);

  {>>> http://www.uesp.net/wiki/Tes5Mod:Mod_File_Format/VMAD_Field <<<}
  wbVMAD := wbStruct(VMAD, '虚拟机适配器', [
    wbInteger('版本', itS16),
    wbInteger('目标格式', itS16),
    wbUnion('数据', wbScriptFragmentExistsDecider, [
      wbArrayS('脚本', wbScriptEntry, -2, cpNormal, False, nil, nil, nil, False),
      wbStruct('情报 VMAD', [
        wbArrayS('脚本', wbScriptEntry, -2, cpNormal, False, nil, nil, nil, False),
        wbScriptFragmentsInfo
      ], cpNormal, False, nil, 0),
      wbStruct('AI包 VMAD', [
        wbArrayS('脚本', wbScriptEntry, -2, cpNormal, False, nil, nil, nil, False),
        wbScriptFragmentsPack
      ], cpNormal, False, nil, 0),
      wbStruct('天赋 VMAD', [
        wbArrayS('脚本', wbScriptEntry, -2, cpNormal, False, nil, nil, nil, False),
        wbScriptFragmentsPerk
      ], cpNormal, False, nil, 0),
      wbStruct('任务 VMAD', [
        wbArrayS('脚本', wbScriptEntry, -2, cpNormal, False, nil, nil, nil, False),
        wbScriptFragmentsQuest
      ], cpNormal, False, nil, 0),
      wbStruct('场景 VMAD', [
        wbArrayS('脚本', wbScriptEntry, -2, cpNormal, False, nil, nil, nil, False),
        wbScriptFragmentsScen
      ], cpNormal, False, nil, 0)
    ])
  ], cpNormal, false, nil, -1);

  wbAttackData := wbRStructSK([1], '攻击', [
    wbStruct(ATKD, '攻击数据', [
      wbFloat('伤害加成'),
      wbFloat('攻击机率'),
      wbFormIDCk('攻击魔法', [SPEL, SHOU, NULL]),
      wbInteger('攻击标志', itU32, wbFlags([
        {0x00000001}'忽略武器',
        {0x00000002}'重击',
        {0x00000004}'猛击',
        {0x00000008}'左手攻击',
        {0x00000010}'旋转攻击',
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
        {0x00008000}'未知 16'
      ], True)),
      wbFloat('攻击角度'),
      wbFloat('撞击角度'),
      wbFloat('摇晃'),
      wbFormIDCk('攻击类型', [KYWD, NULL]),
      wbFloat('击倒'),
      wbFloat('恢复时间'),
      wbFloat('体力加成')
    ]),
    wbString(ATKE, '攻击事件')
  ], []);

  wbPLDT := wbStruct(PLDT, '位置', [
    wbInteger('类型', itS32, wbLocationEnum),
    wbUnion('位置数值', wbTypeDecider, [
      {0} wbFormIDCkNoReach('衍生', [NULL, DOOR, PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
      {1} wbFormIDCkNoReach('场景', [NULL, CELL]),
      {2} wbByteArray('接近AI包开始位置', 4, cpIgnore),
      {3} wbByteArray('接近编辑者位置', 4, cpIgnore),
      {4} wbFormIDCkNoReach('对象编号', [NULL, ACTI, DOOR, STAT, FURN, SPEL, SCRL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, FACT, FLST, IDLM, SHOU]),
      {5} wbInteger('对象类型', itU32, wbObjectTypeEnum),
      {6} wbFormIDCk('关键字', [NULL, KYWD]),
      {7} wbByteArray('未知', 4, cpIgnore),
      {8} wbInteger('别名序号', itU32),
      {9} wbFormIDCkNoReach('衍生', [NULL, DOOR, PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
     {10} wbByteArray('未知', 4, cpIgnore),
     {11} wbByteArray('未知', 4, cpIgnore),
     {12} wbByteArray('未知', 4, cpIgnore)
    ]),
    wbInteger('半径', itS32)
  ]);

  wbPLVD := wbStruct(PLVD, '位置', [
    wbInteger('类型', itS32, wbLocationEnum),
    wbUnion('位置数值', wbTypeDecider, [
      {0} wbFormIDCkNoReach('衍生', [NULL, DOOR, PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
      {1} wbFormIDCkNoReach('场景', [NULL, CELL]),
      {2} wbByteArray('接近AI包开始位置', 4, cpIgnore),
      {3} wbByteArray('接近编辑者位置', 4, cpIgnore),
      {4} wbFormIDCkNoReach('对象编号', [NULL, ACTI, DOOR, STAT, FURN, SPEL, SCRL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, INGR, LIGH, FACT, FLST, IDLM, SHOU]),
      {5} wbInteger('对象类型', itU32, wbObjectTypeEnum),
      {6} wbFormIDCk('关键字', [NULL, KYWD]),
      {7} wbByteArray('未知', 4, cpIgnore),
      {8} wbInteger('别名序号', itU32),
      {9} wbFormIDCkNoReach('衍生', [NULL, DOOR, PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
     {10} wbByteArray('未知', 4, cpIgnore),
     {11} wbByteArray('未知', 4, cpIgnore),
     {12} wbByteArray('未知', 4, cpIgnore)
    ]),
    wbInteger('半径', itS32)
  ]);

  wbTargetData := wbStruct('目标数据', [
    wbInteger('类型', itS32, wbEnum([
      {0} '特定衍生',
      {1} '对象编号',
      {2} '对象类型',
      {3} '连接的衍生',
      {4} '衍生别名',
      {5} '未知 5',
      {6} '自身'
    ]), cpNormal, False, nil, nil, 2),
    wbUnion('目标', wbTypeDecider, [
      {0} wbFormIDCkNoReach('衍生', [NULL, PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA], True),
      {1} wbFormIDCkNoReach('对象编号', [NULL, ACTI, DOOR, STAT, FURN, SPEL, SCRL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, INGR, LIGH, FACT, FLST, IDLM, SHOU, SOUN, TXST, PROJ]),
      {2} wbInteger('对象类型', itU32, wbObjectTypeEnum),
      {3} wbFormID('衍生'),
      {4} wbInteger('别名序号', itU32),
      {5} wbByteArray('未知', 4, cpIgnore),
      {6} wbByteArray('未知', 4, cpIgnore)
    ]),
    wbInteger('数量 / 距离', itS32)
  ]);

  wbREPL := wbFormIDCkNoReach(REPL, '修复列表', [FLST]);
  wbEITM := wbFormIDCk(EITM, '附魔', [ENCH, SPEL]);
  wbBIPL := wbFormIDCk(BIPL, '双足模型列表', [FLST]);

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
  wbMO5S :=
    wbArrayS(MO5S, '替换材质',
      wbStructSK([0, 2], '替换材质', [
        wbLenString('3D 名称'),
        wbFormIDCk('新版材质', [TXST]),
        wbInteger('3D 索引', itS32)
      ]),
    -1);

  wbMOSD :=
    wbInteger(MOSD, '脸部生成模型标志', itU8, wbFlags([
      '头部',
      '躯干',
      '右手',
      '左手'
    ]));

  wbMODS :=
    wbArrayS(MODS, '替换材质',
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

	wbMODT := wbByteArray(MODT, '材质文件哈希值', 0, cpIgnore, false, false, wbNeverShow);
	wbDMDT := wbByteArray(DMDT, '材质文件哈希值', 0, cpIgnore, false, false, wbNeverShow);

  wbMODL :=
    wbRStructSK([0], '模型', [
      wbString(MODL, '模型'),
      wbByteArray(MODB, '未知', 4, cpIgnore),
      wbMODT,
      wbMODS,
      wbMODD
    ], [], cpNormal, False, nil, True);

  wbMODLActor :=
    wbRStructSK([0], '模型', [
      wbString(MODL, '模型'),
      wbByteArray(MODB, '未知', 4, cpIgnore),
      wbMODT,
      wbMODS,
      wbMODD
    ], [], cpNormal, False, nil{wbActorTemplateUseModelAnimation}, True);

  wbMODLReq :=
    wbRStructSK([0], '模型', [
      wbString(MODL, '模型'),
      wbByteArray(MODB, '未知', 4, cpIgnore),
      wbMODT,
      wbMODS,
      wbMODD
    ], [], cpNormal, True, nil, True);

  wbDMDSs := wbArrayS(DMDS, '替换材质',
    wbStructSK([0, 2], '替换材质', [
      wbLenString('3D 名称'),
      wbFormIDCk('新版材质', [TXST]),
      wbInteger('3D 索引', itS32)
    ]),
  -1);

//------------------------------------------------------------------------------
// wbDEST DEST, DSTD, DMDL, DMDT, DMDS, DSTF
//------------------------------------------------------------------------------
  wbDEST := wbRStruct('可损坏', [
    wbStruct(DEST, '数据头', [
      wbInteger('生命', itS32),
      wbInteger('损坏统计', itU8),
      wbInteger('可被终结技', itU8, wbEnum(['假', '真'])),
      wbByteArray('未知', 2)
    ]),
    wbRArray('阶段',
      wbRStruct('阶段', [
        wbStruct(DSTD, '损坏阶段数据', [
          wbInteger('生命 %', itU8),
          wbInteger('索引', itU8),
          wbInteger('模型损坏阶段', itU8),
          wbInteger('标志', itU8, wbFlags([
            '损坏上限',
            '禁用',
            '破坏',
            '无视外界伤害'
          ])),
          wbInteger('每秒自身伤害', itS32),
          wbFormIDCk('爆炸', [EXPL, NULL]),
          wbFormIDCk('碎片', [DEBR, NULL]),
          wbInteger('碎片数', itS32)
        ], cpNormal, True),
        wbRStructSK([0], '模型', [
          wbString(DMDL, '模型'),
          wbDMDT,
          wbDMDSs
        ], [], cpNormal, False, nil),
        wbEmpty(DSTF, '结束标记', cpNormal, True)
      ], [], cpNormal, False, nil)
    )
  ], [], cpNormal, False, nil);

  wbDESTActor := wbRStruct('可损坏', [
    wbStruct(DEST, '数据头', [
      wbInteger('生命', itS32),
      wbInteger('数量', itU8),
      wbInteger('可被终结技', itU8, wbEnum(['假', '真'])),
      wbByteArray('未知', 2)
    ]),
    wbRArray('阶段',  // Begin Stage Array
      wbRStruct('阶段', [ // Begin Stage RStruct
        wbStruct(DSTD, '损坏阶段数据', [ // Begin DSTD
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
        ], cpNormal, True), // End DSTD
        wbRStructSK([0], '模型', [ // Begin DMDL
          wbString(DMDL, '模型')
        ], []), // End DMDL
        wbDMDT,
        wbDMDSs,
        wbEmpty(DSTF, '结束标记', cpNormal, True)
      ], []) // Begin Stage RStruct
    ) // End Stage Array
  ], [], cpNormal, False, nil{wbActorTemplateUseModelAnimation});

  wbENAM := wbFormIDCk(ENAM, '附魔', [ENCH]);
  wbXLOD := wbArray(XLOD, '远景细节数据', wbFloat('未知'), 3);

  wbXESP := wbStruct(XESP, '启用根源', [
    wbFormIDCk('衍生', [PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
    wbInteger('标志', itU8, wbFlags([
      '设置父系为相反状态',
      '突然出现'
    ])),
    wbByteArray('未使用', 3, cpIgnore)
  ]);

  wbPDTO :=
    wbStruct(PDTO, '话题数据', [
      wbInteger('类型', itU32, wbEnum([
        '话题衍生',
        '话题子类型'
      ])),
      wbUnion('数据', wbTypeDecider, [
        wbFormIDCk('话题', [DIAL, NULL]),
        wbString('子类型', 4)
      ])
    ]);

  wbPDTOs := wbRArray('话题', wbPDTO, cpNormal, False, nil);

  wbXLCM := wbInteger(XLCM, '等级调整', itS32, wbEnum([
    '简单',
    '中等',
    '困难',
    '非常困难'
  ]));

  wbOwnership := wbRStruct('所有权', [
    wbFormIDCkNoReach(XOWN, '所有者', [FACT, ACHR, NPC_]),
    wbInteger(XRNK, '派系等级', itS32)
  ], []);

  wbAmbientColors := wbStruct('指向环境', [
    wbArray('颜色',
      wbStruct('颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ]),
      ['X+', 'X-', 'Y+', 'Y-', 'Z+', 'Z-']
    ),
    wbStruct('镜面反射', [
      wbStruct('颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ]),
      wbFloat('菲涅耳指数')
    ])
  ], cpNormal, False, nil, 1);

  wbXGLB := wbFormIDCk(XGLB, '全局变量', [GLOB]);

end;

procedure DefineTES5b;
begin

  wbRecord(ACHR, 'Placed NPC', [
    wbEDID,
    wbVMAD,
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
      {>>> BEGIN leftover from earlier CK versions <<<}
      wbRStruct('未使用', [
        wbUnknown(SCHR),
        wbUnknown(SCDA),
        wbUnknown(SCTX),
        wbUnknown(QNAM),
        wbUnknown(SCRO)
      ], [], cpIgnore, false, wbNeverShow),
      {>>> END leftover from earlier CK versions <<<}
      wbPDTOs,
      wbFormIDCk(TNAM, '话题', [DIAL, NULL], False, cpNormal)
    ], []),

    {--- Leveled Actor ----}
    wbXLCM,

    {--- Merchant Container ----}
    wbFormIDCk(XMRC, '商人容器', [REFR], True),

    {--- Extra ---}
    wbInteger(XCNT, '数量', itS32),
    wbFloat(XRDS, '半径'),
    wbFloat(XHLP, '生命'),

    wbRArrayS('连接的衍生', wbStructSK(XLKR, [0], '连接的衍生', [
      wbFormIDCk('关键字/衍生', [KYWD, PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA, NULL]),
      wbFormIDCk('衍生', [PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA])
    ], cpNormal, False, nil, 1)),

    {--- Activate Parents ---}
    wbRStruct('激活根源', [
      wbInteger(XAPD, '标志', itU8, wbFlags([
        '仅激活根源'
      ], True)),
      wbRArrayS('激活根源衍生',
        wbStructSK(XAPR, [0], '激活根源衍生', [
          wbFormIDCk('衍生', [PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
          wbFloat('推延')
        ])
      )
    ], []),

    {--- Linked Ref ---}
    wbStruct(XCLP, '连结衍生颜色', [
      wbStruct('连结起始颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ]),
      wbStruct('连结结束颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ])
    ]),

    wbFormIDCk(XLCN, '固定方位', [LCTN]),
    wbFormIDCk(XLRL, '位置衍生', [LCRT, LCTN, NULL], False, cpBenignIfAdded),
    wbEmpty(XIS2, '被沙盒忽略'),
    wbArray(XLRT, '位置衍生类型', wbFormIDCk('衍生', [LCRT, NULL])),
		wbFormIDCk(XHOR, '马', [ACHR]),
    wbFloat(XHTW, '头部跟踪权重'),
    wbFloat(XFVC, '好感消耗'),

    {--- Enable Parent ---}
    wbXESP,

    {--- Ownership ---}
    wbOwnership,

    {--- Emittance ---}
    wbFormIDCk(XEMI, '辐射颜色', [LIGH, REGN]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, '多限制衍生', [REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),

    {--- Flags ---}
    wbEmpty(XIBS, '被沙盒忽略'),

    {--- 3D Data ---}
    wbXSCL,
    wbDATAPosRot
  ], True, wbPlacedAddInfo);


  {>>> wbRecordFlags: 0x00000000 ACTI: Collision Geometry (default) <<<}
  wbRecord(ACTI, 'Activator', [
    wbEDID,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbDEST,
    wbKSIZ,
    wbKWDAs,
    wbStruct(PNAM, '标识颜色', [
      wbInteger('红', itU8),
      wbInteger('绿', itU8),
      wbInteger('蓝', itU8),
      wbInteger('未使用', itU8)
    ]),
    wbFormIDCk(SNAM, '音效 - 循环', [SNDR, SOUN]),
    wbFormIDCk(VNAM, '音效 - 触发', [SNDR, SOUN]),
    wbFormIDCk(WNAM, '水质类型', [WATR]),
    wbLString(RNAM, '触发文本覆盖'),
    wbInteger(FNAM, '标志', itU16, wbFlags([
      '无水波',
      '被沙盒忽略'
    ])),
    wbFormIDCk(KNAM, '交互关键字', [KYWD])
  ]);

  wbRecord(TACT, 'Talking Activator', [
    wbEDID,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbDEST,
    wbKSIZ,
    wbKWDAs,
    wbUnknown(PNAM, cpIgnore, True),
    wbFormIDCk(SNAM, '循环音效', [SNDR, SOUN]),
    wbUnknown(FNAM, cpIgnore, True),
    wbFormIDCk(VNAM, '语音', [VTYP])
  ]);

  wbICON := wbRStruct('图标', [
    wbString(ICON, '大图标文件'),
    wbString(MICO, '小图标文件')
  ], [], cpNormal, False, nil, True);

  wbICONReq := wbRStruct('图标', [
    wbString(ICON, '大图标文件'),
    wbString(MICO, '小图标文件')
  ], [], cpNormal, True, nil, True);

  wbICO2 := wbRStruct('图标 2 (女性)', [
    wbString(ICO2, '大图标文件'),
    wbString(MIC2, '小图标文件')
  ], [], cpNormal, False, nil, True);

  wbVatsValueFunctionEnum :=
    wbEnum([
      { 0} '武器是',
      { 1} '武器在列表',
      { 2} '目标是',
      { 3} '目标在列表',
      { 4} '目标距离',
      { 5} '目标部分',
      { 6} '终结技操作',
      { 7} '成功',
      { 8} '致命',
      { 9} '致命效果是',
      {10} '致命效果在列表',
      {11} '毁灭',
      {12} '爆炸部分',
      {13} '肢解部分',
      {14} '残废部分',
      {15} '武器类型是',
      {16} '陌生人',
      {17} '迷魂拳',
      {18} '抛射物类型是',
      {19} '传送类型是',
      {20} '施放类型是'
    ]);

  wbActorValueEnum :=
    wbEnum([
    {00} '好战',
    {01} '信心',
    {02} '活力',
    {03} '品德',
    {04} '情绪',
    {05} '协助',
    {06} '单手',
    {07} '双手',
    {08} '箭术',
    {09} '格挡',
    {10} '锻造',
    {11} '重甲',
    {12} '轻甲',
    {13} '扒窃',
    {14} '开锁',
    {15} '潜行',
    {16} '炼金',
    {17} '口才',
    {18} '改变系',
    {19} '召唤系',
    {20} '毁灭系',
    {21} '幻术系',
    {22} '恢复系',
    {23} '附魔',
    {24} '生命',
    {25} '法力',
    {26} '体力',
    {27} '生命倍率',
    {28} '法术倍率',
    {29} '体力倍率',
    {30} '速度加成',
    {31} '装备栏重量',
    {32} '负重',
    {33} '致命概率',
    {34} '近战伤害',
    {35} '徒手伤害',
    {36} 'Mass',
    {37} '吼声点数',
    {38} '吼声比率',
    {39} '伤害抵抗',
    {40} '毒性抵抗',
    {41} '火焰抵抗',
    {42} '闪电抵抗',
    {43} '冰冻抵抗',
    {44} '魔法抵抗',
    {45} '疾病抵抗',
    {46} '未知 46',
    {47} '未知 47',
    {48} '未知 48',
    {49} '未知 49',
    {50} '未知 50',
    {51} '未知 51',
    {52} '未知 52',
    {53} '麻痹',
    {54} '隐形',
    {55} '夜视',
    {56} '生命检测范围',
    {57} '水下呼吸',
    {58} '水下行走',
    {59} '未知 59',
    {60} '名望',
    {61} '恶名',
    {62} '跳跃加值',
    {63} '守护能力',
    {64} '右手物品充能',
    {65} '盔甲天赋',
    {66} '盾牌天赋',
    {67} '守护偏转',
    {68} '变量01',
    {69} '变量02',
    {70} '变量03',
    {71} '变量04',
    {72} '变量05',
    {73} '变量06',
    {74} '变量07',
    {75} '变量08',
    {76} '变量09',
    {77} '变量10',
    {78} '弓箭速度加值',
    {79} '活跃好感',
    {80} '每天好感',
    {81} '每天计时器好感',
    {82} '左手物品充能',
    {83} '吸收概率',
    {84} '失明',
    {85} '武器速度加成',
    {86} '吼声恢复加成',
    {87} '弓箭蹒跚加值',
    {88} '隔空取物',
    {89} '好感点加值',
    {90} '最后被贿赂恐吓',
    {91} '最后被奉承',
    {92} '移动噪音加成',
    {93} '绕过商人赃物检查',
    {94} '绕过商人关键字检查',
    {95} '等待玩家',
    {96} '单手技能调节',
    {97} '双手技能调节',
    {98} '箭术技能调节',
    {99} '格挡技能调节',
   {100} '铁匠技能调节',
   {101} '重甲技能调节',
   {102} '轻甲技能调节',
   {103} '扒窃技能调节',
   {104} '开锁技能调节',
   {105} '潜行技能调节',
   {106} '炼金技能调节',
   {107} '口才技能调节',
   {108} '变化系技能调节',
   {109} '召唤系技能调节',
   {110} '破化系技能调节',
   {111} '幻术系技能调节',
   {112} '恢复系技能调节',
   {113} '附魔技能调节',
   {114} '单手武器技能提高',
   {115} '双手武器技能提高',
   {116} '箭术技能提高',
   {117} '格挡技能提高',
   {118} '铁匠技能提高',
   {119} '重甲技能提高',
   {120} '轻甲技能提高',
   {121} '扒窃技能提高',
   {122} '开锁技能提高',
   {123} '潜行技能提高',
   {124} '炼金技能提高',
   {125} '口才技能提高',
   {126} '变化系技能提高',
   {127} '召唤系技能提高',
   {128} '破化系技能提高',
   {129} '幻术系技能提高',
   {130} '恢复系技能提高',
   {131} '附魔技能提高',
   {132} '左手武器速度加成',
   {133} '龙魂',
   {134} '战斗中生命恢复加成',
   {135} '单手武器技能强度调节',
   {136} '双手武器技能强度调节',
   {137} '箭术技能强度调节',
   {138} '格挡技能强度调节',
   {139} '铁匠技能强度调节',
   {140} '重甲技能强度调节',
   {141} '轻甲技能强度调节',
   {142} '扒窃技能强度调节',
   {143} '开锁技能强度调节',
   {144} '潜行技能强度调节',
   {145} '炼金技能强度调节',
   {146} '口才技能强度调节',
   {147} '变化系技能强度调节',
   {148} '召唤系技能强度调节',
   {149} '破化系技能强度调节',
   {150} '幻术系技能强度调节',
   {151} '恢复系技能强度调节',
   {152} '附魔技能强度调节',
   {153} '龙裂',
   {154} '攻击伤害加成',
   {155} '生命倍率加成',
   {156} '法术倍率加成',
   {157} '体力倍率加成',
   {158} '狼人天赋',
   {159} '吸血鬼天赋',
   {160} '抓取角色补偿',
   {161} '被抓取',
   {162} '未知 162',
   {163} '反弹伤害'
      ], [
        -1, '无'
      ]);

  wbSkillEnum :=
    wbEnum([
      '未知 1',
      '未知 2',
      '未知 3',
      '未知 4',
      '未知 5',
      '未知 6',
      '单手',
      '双手',
      '箭术',
      '格挡',
      '锻造',
      '重甲',
      '轻甲',
      '扒窃',
      '开锁',
      '潜行',
      '炼金',
      '口才',
      '改变系',
      '召唤系',
      '毁灭系',
      '幻术系',
      '恢复系',
      '附魔'
    ], [
    -1, '无'
    ]);

  wbCastEnum := wbEnum([
    {0} '恒定效果',
    {1} '施放后忘记',
    {2} '集中',
    {3} '卷轴'
  ]);

  wbTargetEnum := wbEnum([
    {0} '自身',
    {1} '接触',
    {2} '目标',
    {3} '目标角色',
    {4} '目标位置'
  ]);

  wbCastingSourceEnum := wbEnum([
    '左',
    '右',
    '吼声',
    '瞬间'
  ]);

  wbCrimeTypeEnum :=
    wbEnum([
      '偷窃',
      '扒窃',
      '非法入侵',
      '攻击',
      '谋杀',
      '越狱',
      '狼人变身'
    ], [
      -1, '无'
    ]);

  wbActorValue := wbInteger('角色数值', itS32, wbActorValueEnum);

  wbETYP := wbFormIDCk(ETYP, '装备方式', [EQUP, NULL]);
  wbETYPReq := wbFormIDCk(ETYP, '装备方式', [EQUP, NULL], False, cpNormal, True);

  wbFormTypeEnum := wbEnum([], [
     0, 'Activator',
     1, 'Armor',
     2, 'Book',
     3, 'Container',
     4, 'Door',
     5, 'Ingredient',
     6, 'Light',
     7, 'MiscItem',
     8, 'Static',
     9, 'Grass',
    10, 'Tree',
    12, 'Weapon',
    13, 'Actor',
    14, 'LeveledCharacter',
    15, 'Spell',
    16, 'Enchantment',
    17, 'Potion',
    18, 'LeveledItem',
    19, 'Key',
    20, 'Ammo',
    21, 'Flora',
    22, 'Furniture',
    23, 'Sound Marker',
    24, 'LandTexture',
    25, 'CombatStyle',
    26, 'LoadScreen',
    27, 'LeveledSpell',
    28, 'AnimObject',
    29, 'WaterType',
    30, 'IdleMarker',
    31, 'EffectShader',
    32, 'Projectile',
    33, 'TalkingActivator',
    34, 'Explosion',
    35, 'TextureSet',
    36, 'Debris',
    37, 'MenuIcon',
    38, 'FormList',
    39, 'Perk',
    40, 'BodyPartData',
    41, 'AddOnNode',
    42, 'MovableStatic',
    43, 'CameraShot',
    44, 'ImpactData',
    45, 'ImpactDataSet',
    46, 'Quest',
    47, 'Package',
    48, 'VoiceType',
    49, 'Class',
    50, 'Race',
    51, 'Eyes',
    52, 'HeadPart',
    53, 'Faction',
    54, 'Note',
    55, 'Weather',
    56, 'Climate',
    57, 'ArmorAddon',
    58, 'Global',
    59, 'Imagespace',
    60, 'Imagespace Modifier',
    61, 'Encounter Zone',
    62, 'Message',
    63, 'Constructible Object',
    64, 'Acoustic Space',
    65, 'Ragdoll',
    66, 'Script',
    67, 'Magic Effect',
    68, 'Music Type',
    69, 'Static Collection',
    70, 'Keyword',
    71, 'Location',
    72, 'Location Ref Type',
    73, 'Footstep',
    74, 'Footstep Set',
    75, 'Material Type',
    76, 'Actor Action',
    77, 'Music Track',
    78, 'Word of Power',
    79, 'Shout',
    80, 'Relationship',
    81, 'Equip Slot',
    82, 'Association Type',
    83, 'Outfit',
    84, 'Art Object',
    85, 'Material Object',
    87, 'Lighting Template',
    88, 'Shader Particle Geometry',
    89, 'Visual Effect',
    90, 'Apparatus',
    91, 'Movement Type',
    92, 'Hazard',
    93, 'SM Event Node',
    94, 'Sound Descriptor',
    95, 'Dual Cast Data',
    96, 'Sound Category',
    97, 'Soul Gem',
    98, 'Sound Output Model',
    99, 'Collision Layer',
   100, 'Scroll',
   101, 'ColorForm',
   102, 'Reverb Parameters'
  ]);

  wbMiscStatEnum := wbEnum([], [
    Int64($FCDD5011), '动物被杀死',
    Int64($366D84CF), '盔甲提升',
    Int64($023497E6), '制得盔甲',
    Int64($8E20D7C9), '袭击',
    Int64($579FFA75), '自动操作被终止',
    Int64($B9B50725), '背刺',
    Int64($ED6A0EF2), '交易',
    Int64($CCB952CE), '读完书',
    Int64($317E8B4C), '争吵胜利',
    Int64($1D79006B), '贿赂',
    Int64($3602DE8F), '杀死小动物',
    Int64($53D9E9B5), '洗劫箱子',
    Int64($683C1980), '完成内战任务',
    Int64($66CCC50A), '完成冬堡学院任务',
    Int64($40B11EFE), '生物被杀死',
    Int64($22D5BA38), '致命攻击',
    Int64($A930980F), '迪德拉被杀死',
    Int64($3558374B), '完成魔神任务',
    Int64($37A76425), '完成黎明守卫任务',
    Int64($2BDAC36F), '身为吸血鬼的白天',
    Int64($6E684590), '身为狼人的白天',
    Int64($B6F118DB), '监禁的日子',
    Int64($3C626A90), '度过的日子',
    Int64($8556AD88), '感染疾病',
    Int64($46D6FBBC), '收集龙魂',
    Int64($AA444695), '地牢被清理',
    Int64($1A37F336), '东陲悬赏',
    Int64($5AC3A8ED), '佛克瑞斯悬赏',
    Int64($87B12ECC), '最爱学院',
    Int64($518BBC4E), '最爱吼声',
    Int64($41DD77A6), '最爱魔法',
    Int64($171C5391), '最爱武器',
    Int64($4F041AA2), '支付罚款',
    Int64($9311B22B), '食用食物',
    Int64($57C089F7), '找到金币',
    Int64($D20EDA4F), '海芬加悬赏',
    Int64($516C486D), '希雅陲悬赏',
    Int64($B0A1E32E), '拥有马匹',
    Int64($EBAE35E8), '偷窃马匹',
    Int64($FA024018), '睡觉小时',
    Int64($CAD2ECA1), '等待小时',
    Int64($527DF857), '拥有房屋',
    Int64($47B4A015), '食用原料',
    Int64($CE842356), '采集原料',
    Int64($7D2E57C0), '恐吓',
    Int64($C21702B5), '扒窃物品',
    Int64($82F190C2), '偷窃物品',
    Int64($6627464B), '越狱',
    Int64($3520E710), '最大悬赏',
    Int64($8A24FDE2), '发现地域',
    Int64($5829CC2E), '拾取锁',
    Int64($88089979), '制得魔法物品',
    Int64($7EA26C2D), '完成主线任务',
    Int64($7187A208), '殴打',
    Int64($98EE55DC), '完成杂项目标',
    Int64($FA06230B), '超负重',
    Int64($D37C6909), '谋杀',
    Int64($22C2CBD0), '咬脖子',
    Int64($BEEBCC87), '找到乃恩之根',
    Int64($56CCFC54), 'NumVampirePerks',
    Int64($76A1A5C0), 'NumWerewolfPerks',
    Int64($F22A8133), '杀死人物',
    Int64($47A78467), '劝说',
    Int64($F2BAC234), '拾取腰包',
    Int64($17C64668), '混合成毒药',
    Int64($7D8F2EA6), '混合成毒药',
    Int64($4228DE85), '混合成药水',
    Int64($9631EC11), '使用了药水',
    Int64($DE6C73FE), '完成任务线',
    Int64($0D7B8B16), '完成任务',
    Int64($BB39399E), '习得吼声',
    Int64($731B5333), '精通吼声',
    Int64($F921D8BA), '解锁吼声',
    Int64($B1AE4792), '完成支线任务',
    Int64($ACE470D7), '阅读技能书',
    Int64($F33130CE), '技能提升',
    Int64($B556CC52), '潜行攻击',
    Int64($A74CBE83), '使用灵魂石',
    Int64($C2C9E233), '捕获灵魂',
    Int64($5EC89F1A), '习得魔法',
    Int64($B251A346), '找到立石',
    Int64($05D45702), '投资商店',
    Int64($D0FE7031), '完成同伴任务',
    Int64($52BA68CB), '完成黑暗兄弟会任务',
    Int64($3E267D77), '帕尔悬赏',
    Int64($69B48177), '解放瑞驰悬赏',
    Int64($50A23F69), '裂谷悬赏',
    Int64($62B2E95D), '完成盗贼工会任务',
    Int64($944CEA93), '入牢次数',
    Int64($50AAB633), '被吼次数',
    Int64($99BB86D8), '总生命悬赏',
    Int64($4C252391), '训练对话',
    Int64($7AEA9C2B), '非法侵入',
    Int64($A67626F4), '部落兽人悬赏',
    Int64($41D4BC0F), '杀死不死生物',
    Int64($F39260A1), '治疗吸血鬼',
    Int64($61A5C5A9), '武器解除',
    Int64($1D3BA844), '武器提升',
    Int64($25F1EA25), '制得武器',
    Int64($38A2DD66), '狼人变声',
    Int64($4231FA4F), '雪漫城悬赏',
    Int64($92565767), '拉翅膀',
    Int64($C7FC518D), '东堡悬赏',
    Int64($949FA7BC), '习得威能符文',
    Int64($2C6E3FC0), '解锁威能符文'
  ]);

  wbAdvanceActionEnum := wbEnum([
    '普通使用',
    '猛击',
    '重击',
    '撬锁成功',
    '撬锁损坏'
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

  wbSexEnum := wbEnum(['男性','女性']);

  wbEFID := wbFormIDCk(EFID, '基本效果', [MGEF]);

  wbEFIT :=
    wbStructSK(EFIT, [3, 4], '', [
      wbFloat('量级', cpNormal, True),
      wbInteger('范围', itU32),
      wbInteger('持续时间', itU32)
    ], cpNormal, True, nil, -1, wbEFITAfterLoad);

  wbCTDA := wbRStruct('条件', [
    wbStruct(CTDA, '', [
      wbInteger('类型', itU8, wbCtdaTypeToStr, wbCtdaTypeToInt, cpNormal, False, nil, wbCtdaTypeAfterSet),
      wbByteArray('未知', 3, cpIgnore, False, wbNeverShow),
      wbUnion('比较值', wbCTDACompValueDecider, [
        wbFloat('比较值 - 浮点值'),
        wbFormIDCk('比较值 - 全局变量', [GLOB])
      ]),
      wbInteger('函数', itU16, wbCTDAFunctionToStr, wbCTDAFunctionToInt),
      wbByteArray('未知', 2, cpIgnore, False, wbNeverShow),
      wbUnion('参数 #1', wbCTDAParam1Decider, [
        wbByteArray('未知', 4),
        wbByteArray('无', 4, cpIgnore),
        wbInteger('整数', itS32),
        wbFloat('浮点数'),
        wbByteArray('变量名 (未使用)', 4, cpIgnore),
        wbInteger('性别', itU32, wbSexEnum),
        wbInteger('角色数值', itS32, wbActorValueEnum),
        wbInteger('犯罪类型', itU32, wbCrimeTypeEnum),
        wbInteger('坐标', itU32, wbAxisEnum),
        wbInteger('任务阶段 (未使用)', itS32),
        wbInteger('杂项状态', itU32, wbMiscStatEnum),
        wbInteger('队列', itU32, wbAlignmentEnum),
        wbFormIDCkNoReach('装备类型', [EQUP]),
        wbInteger('表单类型', itU32, wbFormTypeEnum),
        wbInteger('致命阶段', itU32, wbCriticalStageEnum),
        wbFormIDCkNoReach('衍生对象', [NULL, PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
        wbFormIDCkNoReach('装备栏对象', [ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, SCRL, SLGM, INGR, FLST, LIGH]),
        wbFormIDCkNoReach('角色', [NULL, PLYR, ACHR, REFR]),
        wbFormIDCkNoReach('语音', [VTYP, FLST]),
        wbFormIDCkNoReach('Idle', [IDLE]),
        wbFormIDCkNoReach('表单列表', [FLST]),
        wbFormIDCkNoReach('任务', [QUST]),
        wbFormIDCkNoReach('派系', [FACT]),
        wbFormIDCkNoReach('场景', [CELL]),
        wbFormIDCkNoReach('职业', [CLAS]),
        wbFormIDCkNoReach('种族', [RACE]),
        wbFormIDCkNoReach('角色基础', [NPC_]),
        wbFormIDCkNoReach('全局', [GLOB]),
        wbFormIDCkNoReach('天气', [WTHR]),
        wbFormIDCkNoReach('AI包', [PACK]),
        wbFormIDCkNoReach('遭遇区域', [ECZN]),
        wbFormIDCkNoReach('天赋', [PERK]),
        wbFormIDCkNoReach('所有者', [NULL, FACT, NPC_]),
        wbFormIDCkNoReach('家具', [FURN, FLST]),
        wbFormIDCkNoReach('效果物品', [SPEL, ENCH, ALCH, INGR, SCRL]),
        wbFormIDCkNoReach('基本效果', [MGEF]),
        wbFormIDCkNoReach('世界空间', [WRLD, FLST]),
        wbInteger('终结技数值函数', itU32, wbVATSValueFunctionEnum),
        wbInteger('终结技数值参数 (无效)', itU32),
        wbFormIDCkNoReach('衍生对象', [NULL, NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, TACT, FLST, LVLI, LVSP, SPEL, SCRL, SHOU, SLGM], [NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, TACT, LVLI, LVSP, SPEL, SCRL, SHOU, SLGM]),
        wbFormIDCkNoReach('地区', [REGN]),
        wbFormIDCkNoReach('关键字', [KYWD, NULL]),
        wbInteger('玩家行为', itU32, wbAdvanceActionEnum),
        wbInteger('施法类型', itU32, wbCastingSourceEnum),
        wbFormIDCkNoReach('吼声', [SHOU]),
        wbFormIDCkNoReach('位置', [LCTN]),
        wbFormIDCkNoReach('位置衍生类型', [LCRT]),
        wbInteger('别名序号', itU32),
        wbInteger('AI包数据序号', itU32),
        wbFormIDCk('关系类型', [ASTP]),
        wbInteger('家具动作', itU32, wbFurnitureAnimTypeEnum),
        wbInteger('家具记录', itU32, wbEnum([], [$010000, '前', $020000, '后', $040000, '右', $80000, '左', $100000, '上'])),
        wbFormIDCk('情景', [NULL, SCEN]),
        wbInteger('守护状态', itU32, wbWardStateEnum)
      ]),
      wbUnion('参数 #2', wbCTDAParam2Decider, [
        wbByteArray('未知', 4),
        wbByteArray('无', 4, cpIgnore),
        wbInteger('整数', itS32),
        wbFloat('浮点数'),
        wbByteArray('变量名 (未使用)', 4, cpIgnore),
        wbInteger('性别', itU32, wbSexEnum),
        wbInteger('角色数值', itS32, wbActorValueEnum),
        wbInteger('犯罪类型', itU32, wbCrimeTypeEnum),
        wbInteger('坐标', itU32, wbAxisEnum),
        wbInteger('任务阶段', itS32, wbCTDAParam2QuestStageToStr, wbCTDAParam2QuestStageToInt),
        wbInteger('杂项状态', itU32, wbMiscStatEnum),
        wbInteger('队列', itU32, wbAlignmentEnum),
        wbFormIDCkNoReach('装备类型', [EQUP]),
        wbInteger('表单类型', itU32, wbFormTypeEnum),
        wbInteger('致命阶段', itU32, wbCriticalStageEnum),
        wbFormIDCkNoReach('衍生对象', [NULL, PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
        wbFormIDCkNoReach('装备栏对象', [ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, SCRL, SLGM, INGR, FLST, LIGH]),
        wbFormIDCkNoReach('角色', [NULL, PLYR, ACHR, REFR]),
        wbFormIDCkNoReach('语音', [VTYP, FLST]),
        wbFormIDCkNoReach('Idle', [IDLE]),
        wbFormIDCkNoReach('表单列表', [FLST]),
        wbFormIDCkNoReach('任务', [QUST]),
        wbFormIDCkNoReach('派系', [FACT]),
        wbFormIDCkNoReach('场景', [CELL]),
        wbFormIDCkNoReach('职业', [CLAS]),
        wbFormIDCkNoReach('种族', [RACE]),
        wbFormIDCkNoReach('角色基础', [NPC_]),
        wbFormIDCkNoReach('全局', [GLOB]),
        wbFormIDCkNoReach('天气', [WTHR]),
        wbFormIDCkNoReach('AI包', [PACK]),
        wbFormIDCkNoReach('遭遇区域', [ECZN]),
        wbFormIDCkNoReach('天赋', [PERK]),
        wbFormIDCkNoReach('所有者', [NULL, FACT, NPC_]),
        wbFormIDCkNoReach('家具', [FURN, FLST]),
        wbFormIDCkNoReach('效果物品', [SPEL, ENCH, ALCH, INGR, SCRL]),
        wbFormIDCkNoReach('基本效果', [MGEF]),
        wbFormIDCkNoReach('世界空间', [WRLD, FLST]),
        wbInteger('终结技数值函数', itU32, wbVATSValueFunctionEnum),
        wbUnion('终结技数值参数', wbCTDAParam2VATSValueParamDecider, [
         { 0} wbFormIDCkNoReach('武器', [WEAP]),
         { 1} wbFormIDCkNoReach('武器列表', [FLST], [WEAP]),
         { 2} wbFormIDCkNoReach('目标', [NPC_]),
         { 3} wbFormIDCkNoReach('目标列表', [FLST], [NPC_]),
         { 4} wbByteArray('未知', 4, cpIgnore),
         { 5} wbInteger('目标部分', itS32, wbActorValueEnum),
         { 6} wbInteger('终结技操作', itU32, wbEnum([
                '徒手攻击',
                '单手近战攻击',
                '双手近战攻击',
                '魔法攻击',
                '远程攻击',
                '重载',
                '蹲伏',
                '站立',
                '切换武器',
                '收/拔武器',
                '治愈',
                '玩家死亡'
          ])),
         { 7} wbByteArray('未知', 4, cpIgnore),
         { 8} wbByteArray('未知', 4, cpIgnore),
         { 9} wbFormIDCkNoReach('致命效果', [SPEL]),
         {10} wbFormIDCkNoReach('致命效果列表', [FLST], [SPEL]),
         {11} wbByteArray('未知', 4, cpIgnore),
         {12} wbByteArray('未知', 4, cpIgnore),
         {13} wbByteArray('未知', 4, cpIgnore),
         {14} wbByteArray('未知', 4, cpIgnore),
         {15} wbInteger('武器类型', itU32, wbWeaponAnimTypeEnum),
         {16} wbByteArray('未知', 4, cpIgnore),
         {17} wbByteArray('未知', 4, cpIgnore),
         {18} wbInteger('抛射物类型', itU32, wbEnum([
                '直线型',
                '高投式',
                '散射式',
                '喷射式',
                '圆锥状',
                '障碍物',
                '弓箭'
              ])),
         {19} wbInteger('传送类型', itU32, wbTargetEnum),
         {20} wbInteger('施法类型', itU32, wbCastEnum)
        ]),
        wbFormIDCkNoReach('衍生对象', [NULL, NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, TACT, FLST, LVLI, LVSP, SPEL, SCRL, SHOU], [NPC_, PROJ, TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, MSTT, TACT, LVLI, LVSP, SPEL, SCRL, SHOU]),
        wbFormIDCkNoReach('地区', [REGN]),
        wbFormIDCkNoReach('关键字', [KYWD, NULL]),
        wbInteger('玩家行为', itU32, wbAdvanceActionEnum),
        wbInteger('施法类型', itU32, wbCastingSourceEnum),
        wbFormIDCkNoReach('吼声', [SHOU]),
        wbFormIDCkNoReach('位置', [LCTN]),
        wbFormIDCkNoReach('位置衍生类型', [LCRT]),
        wbInteger('别名序号', itU32),
        wbInteger('AI包数据序号', itU32),
        wbFormIDCk('关系类型', [ASTP]),
        wbInteger('家具动作', itU32, wbFurnitureAnimTypeEnum),
        wbInteger('家具记录', itU32, wbEnum([], [$010000, '前', $020000, '后', $040000, '右', $80000, '左', $100000, '上'])),
        wbFormIDCk('情景', [NULL, SCEN]),
        wbInteger('守护状态', itU32, wbWardStateEnum)
      ]),
      wbInteger('运行于', itU32, wbEnum([
        {0} '主体',
        {1} '目标',
        {2} '衍生',
        {3} '战斗目标',
        {4} '连接的衍生',
        {5} '任务别名',
        {6} 'AI包数据',
        {7} '事件数据'
      ]), cpNormal, False, nil, wbCTDARunOnAfterSet),
      wbUnion('衍生', wbCTDAReferenceDecider, [
        wbInteger('未使用', itU32, nil, cpIgnore),
        wbFormIDCkNoReach('衍生', [NULL, PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA], True)
      ]),
      wbInteger('参数 #3', itS32)
    ], cpNormal, False{, nil, 0, wbCTDAAfterLoad}),
    wbString(CIS1, '参数 #1'),
    wbString(CIS2, '参数 #2')
  ], [], cpNormal);

  wbCTDAs := wbRArray('条件', wbCTDA, cpNormal, False);
  wbCTDAsReq := wbRArray('条件', wbCTDA, cpNormal, True);

  wbEffects :=
    wbRStructs('效果', '效果', [
      wbEFID,
      wbEFIT,
      wbCTDAs
    ], []);

  wbEffectsReq :=
    wbRStructs('效果', '效果', [
      wbEFID,
      wbEFIT,
      wbCTDAs
    ], [], cpNormal, True);

  wbRecord(ALCH, 'Ingestible', [
    wbEDID,
    wbOBNDReq,
    wbFULL,
    wbKSIZ,
    wbKWDAs,
    wbDESC,
    wbMODL,
    wbDEST,
    wbICON,
    wbFormIDCk(YNAM, '音效 - 拾起', [SNDR, SOUN]),
    wbFormIDCk(ZNAM, '音效 - 丢弃', [SNDR, SOUN]),
    wbETYP,
    wbFloat(DATA, '重量', cpNormal, True),
    wbStruct(ENIT, '效果数据', [
      wbInteger('数值', itS32),
      wbInteger('标志', itU32, wbFlags([
        {0x00000001} '不自动计算 (未使用)',
        {0x00000002} '食物',
        {0x00000004} '未知 3',
        {0x00000008} '未知 4',
        {0x00000010} '未知 5',
				{0x00000020} '未知 6',
				{0x00000040} '未知 7',
				{0x00000080} '未知 8',
				{0x00000100} '未知 9',
				{0x00000200} '未知 10',
				{0x00000400} '未知 11',
				{0x00000800} '未知 12',
				{0x00001000} '未知 13',
				{0x00002000} '未知 14',
				{0x00004000} '未知 15',
				{0x00008000} '未知 16',
				{0x00010000} '药物',
				{0x00020000} '毒药'
      ])),
      wbFormID('上瘾'),
      wbFloat('上瘾概率'),
      wbFormIDCk('音效  - 食用', [SNDR, NULL])
    ], cpNormal, True),
    wbEffectsReq
  ], False, nil, cpNormal, False, wbRemoveEmptyKWDA);

  wbRecord(AMMO, 'Ammunition', [
    wbEDID,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbDEST,
    wbFormIDCk(YNAM, '音效 - 拾起', [SNDR, SOUN]),
    wbFormIDCk(ZNAM, '音效 - 丢弃', [SNDR, SOUN]),
    wbDESC,
    wbKSIZ,
    wbKWDAs,
    wbStruct(DATA, '数据', [
      wbFormIDCk('抛射物', [PROJ, NULL]),
        wbInteger('标志', itU32, wbFlags([
          '无视普通武器抗性',
          '玩家不可用',
          '非矢'
        ])),
      wbFloat('伤害'),
      wbInteger('价值', itU32)
    ], cpNormal, True),
    wbString(ONAM, '简称')
  ], False, nil, cpNormal, False, wbRemoveEmptyKWDA);

  wbRecord(ANIO, 'Animated Object', [
    wbEDID,
    wbMODL,
    wbString(BNAM, '类型')
  ]);

  wbRecord(ARMO, 'Armor', [
    wbEDID,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbEITM,
    wbInteger(EAMT, '附魔数量', itU16),
//    wbRStruct('Male biped model', [
//      wbString(MODL, '模型'),
//      wbByteArray(MODT, '材质文件哈希值', 0, cpIgnore),
//      wbMODS,
//      wbMODD
//    ], [], cpNormal, False, nil, True),
    wbRStruct('男性世界模型', [
      wbString(MOD2, '模型'),
      wbByteArray(MO2T, '材质文件哈希值', 0, cpIgnore, false, false, wbNeverShow),
      wbMO2S
    ], []),
    wbICON,
    wbRStruct('女性世界模型', [
      wbString(MOD4, '模型'),
      wbByteArray(MO4T, '材质文件哈希值', 0, cpIgnore, false, false, wbNeverShow),
      wbMO4S
    ], []),
    wbICO2,
    wbBODT,
    wbBOD2,
    wbDEST,
    wbFormIDCk(YNAM, '音效 - 拾起', [SNDR, SOUN]),
    wbFormIDCk(ZNAM, '音效 - 丢弃', [SNDR, SOUN]),
    wbString(BMCT, '布娃娃约束模版'),
    wbETYP,
    wbFormIDCk(BIDS, '重击冲击数据集', [IPDS]),
    wbFormIDCk(BAMT, '格挡替换材料', [MATT]),
    wbFormIDCk(RNAM, '种族', [RACE]),
    wbKSIZ,
    wbKWDAs,
    wbDESC,
    wbRArray('盔甲部件', wbFormIDCK(MODL, '模型', [ARMA, NULL])),
    wbStruct(DATA, '数据', [
      wbInteger('价值', itS32),
      wbFloat('重量')
    ], cpNormal, True),
    wbInteger(DNAM, '防御力', itS32, wbDiv(100), cpNormal, True),
    wbFormIDCk(TNAM, '模版盔甲', [ARMO])
  ], False, nil, cpNormal, False, wbARMOAfterLoad);

  wbRecord(ARMA, 'Armor Addon', [
    wbEDID,
    wbBODT,
    wbBOD2,
    wbFormIDCk(RNAM, '种族', [RACE]),
    wbStruct(DNAM, '数据', [
      wbInteger('男性优先级', itU8),
      wbInteger('女性优先级', itU8),
      wbInteger('根据体重调整 - 男性', itU8, wbFlags([
        {0x01} '',
        {0x02} '开启'
      ])),
      wbInteger('根据体重调整 - 女性', itU8, wbFlags([
        {0x01} '',
        {0x02} '开启'
      ])),
      wbByteArray('未知', 2),
      wbInteger('检测完整度', itU8),
      wbByteArray('未知', 1),
      wbFloat('武器调整')
    ], cpNormal, True),
    wbRStruct('男性世界模型', [
      wbString(MOD2, '模型'),
      wbByteArray(MO2T, '材质文件哈希值', 0, cpIgnore, false, false, wbNeverShow),
      wbMO2S
    ], [], cpNormal, False),
    wbRStruct('女性世界模型', [
      wbString(MOD3, '模型'),
      wbByteArray(MO3T, '材质文件哈希值', 0, cpIgnore, false, false, wbNeverShow),
      wbMO3S
    ], []),
    wbRStruct('男性第一人称', [
      wbString(MOD4, '模型'),
      wbByteArray(MO4T, '材质文件哈希值', 0, cpIgnore, false, false, wbNeverShow),
      wbMO4S
    ], []),
    wbRStruct('女性第一人称', [
      wbString(MOD5, '模型'),
      wbByteArray(MO5T, '材质文件哈希值', 0, cpIgnore, false, false, wbNeverShow),
      wbMO5S
    ], []),
    wbFormIDCK(NAM0, '男性皮肤材质', [TXST, NULL]),
    wbFormIDCK(NAM1, '女性皮肤材质', [TXST, NULL]),
    wbFormIDCK(NAM2, '男性皮肤材质替换列表', [FLST, NULL]),
    wbFormIDCK(NAM3, '女性皮肤材质替换列表', [FLST, NULL]),
    wbRArrayS('追加种族', wbFormIDCK(MODL, '种族', [RACE, NULL])),
    wbFormIDCk(SNDD, '脚步声', [FSTS, NULL]),
    wbFormIDCk(ONAM, '视觉效果', [ARTO])
  ], False, nil, cpNormal, False, wbARMAAfterLoad);

  wbRecord(BOOK, 'Book', [
    wbEDID,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbLStringKC(DESC, '书籍内容', 0, cpNormal, True),
    wbDEST,
    wbFormIDCk(YNAM, '音效 - 拾起', [SNDR, SOUN]),
    wbFormIDCk(ZNAM, '音效 - 丢弃', [SNDR, SOUN]),
    wbKSIZ,
    wbKWDAs,
    wbStruct(DATA, '数据', [
      wbInteger('标志', itU8, wbFlags([
       {0x01} '传授技能',
       {0x02} '无法带走',
       {0x04} '传授魔法',
       {0x08} '未知 4',
       {0x10} '未知 5',
       {0x20} '未知 6',
       {0x40} '未知 7',
       {0x80} '未知 8'
      ])),
      wbInteger('类型', itU8, wbEnum([], [
        0, '书籍/书册', 255, '笔记/卷轴'
      ])),
      wbByteArray('未使用', 2),
      wbUnion('传授', wbBOOKTeachesDecider, [
        wbInteger('技能', itS32, wbSkillEnum),
        wbFormIDCk('法术', [SPEL, NULL])
      ]),
      wbInteger('价值', itU32),
      wbFloat('重量')
    ], cpNormal, True),
    wbFormIDCk(INAM, '装备栏外观', [STAT]),
    wbLString(CNAM, '描述')
  ]);
end;

procedure DefineTES5c;

  procedure ReferenceRecord(aSignature: TwbSignature; const aName: string);
  begin
    wbRecord(aSignature, aName, [
      wbVMAD,
      wbFormIDCk(NAME, '抛射物', [PROJ, HAZD]),
      wbFormIDCk(XEZN, '遭遇区域', [ECZN]),
      wbOwnership,
      wbFloat(XHTW, '头部跟踪权重'),
      wbFloat(XFVC, '好感消耗'),
      wbRArrayS('反射/折射',
        wbStructSK(XPWR, [0], '水源', [
          wbFormIDCk('衍生', [REFR]),
          wbInteger('类型', itU32, wbFlags([
            '反射',
            '折射'
          ]))
        ], cpNormal, False, nil, 1)
      ),
      wbRArrayS('连接的衍生', wbStructSK(XLKR, [0], '连接的衍生', [
        wbFormIDCk('关键字/衍生', [KYWD, PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA, NULL]),
        wbFormIDCk('衍生', [PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA])
      ], cpNormal, False, nil, 1)),
      wbRStruct('激活根源', [
        wbInteger(XAPD, '标志', itU8, wbFlags([
          '仅激活根源'
        ], True)),
        wbRArrayS('激活根源衍生',
          wbStructSK(XAPR, [0], '激活根源衍生', [
            wbFormIDCk('衍生', [PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
            wbFloat('推延')
          ])
        )
      ], []),
      wbXESP,
      wbFormIDCk(XEMI, '辐射颜色', [LIGH, REGN]),
      wbFormIDCk(XMBR, '多限制衍生', [REFR]),
      wbEmpty(XIS2, '被沙盒忽略'),
      wbArray(XLRT, '位置衍生类型', wbFormIDCk('衍生', [LCRT, NULL])),
      wbFormIDCk(XLRL, '位置衍生', [LCRT, LCTN, NULL], False, cpBenignIfAdded),
      wbXLOD,
      wbXSCL,
      wbDataPosRot
    ], True, wbPlacedAddInfo);
  end;

begin
{>>>
  Skrim has its own ref record for every projectile type
  PARW '弓箭'
  PBEA '散射式'
  PFLA '喷射式'
  PCON '圆锥状' (voice)
  PBAR '障碍物'
  PGRE 'Traps'
  PHZD 'Hazards'
  I guess all of them have the same structure
<<<}
  ReferenceRecord(PARW, 'Placed Arrow');
  ReferenceRecord(PBAR, 'Placed Barrier');
  ReferenceRecord(PBEA, 'Placed Beam');
  ReferenceRecord(PCON, 'Placed Cone/Voice');
  ReferenceRecord(PFLA, 'Placed Flame');
  ReferenceRecord(PGRE, 'Placed Projectile');
  ReferenceRecord(PHZD, 'Placed Hazard');

  wbRecord(CELL, 'Cell', [
    wbEDID,
    wbFULL,
    {>>>
    Flags can be itU8, but CELL\DATA has a critical role in various wbImplementation.pas routines
    and replacing it with wbUnion generates error when setting for example persistent flag in REFR.
    So let it be always itU16
    <<<}
    wbInteger(DATA, '标志', itU16, wbFlags([
      {0x0001} '室内场景',
      {0x0002} '存在水源',
      {0x0004} '无法快速旅行到这边',
      {0x0008} '无LOD水',
      {0x0010} '未知 5',
      {0x0020} '公共场所',
      {0x0040} '已手动修改',
      {0x0080} '显示天空',
      {0x0100} '使用天空光源'
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
        wbByteArray('未知', 1)
      ]),
      wbStruct('指向颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ]),
      wbStruct('雾近距离颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ]),
      wbFloat('雾近距离'),
      wbFloat('雾远距离'),
      wbInteger('指向角度 XY', itS32),
      wbInteger('指向角度 Z', itS32),
      wbFloat('指向淡出'),
      wbFloat('雾裁剪距离'),
      wbFloat('雾浓度'),
      wbAmbientColors,
      wbStruct('雾远距离颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ]),
      wbFloat('雾最大值'),
      wbFloat('光照开始淡出'),
      wbFloat('光照结束淡出'),
      wbInteger('继承', itU32, wbFlags([
        {0x00000001}'环境颜色',
        {0x00000002}'指向颜色',
        {0x00000004}'雾颜色',
        {0x00000008}'雾近距离',
        {0x00000010}'雾远距离',
        {0x00000020}'指向角度',
        {0x00000040}'指向淡出',
        {0x00000080}'裁剪距离',
        {0x00000100}'雾浓度',
        {0x00000200}'雾最大值',
        {0x00000400}'光照淡出范围'
      ]))
    ], cpNormal, False, nil, 11),

		wbByteArray(TVDT, '未知', 0, cpNormal),
		wbByteArray(MHDT, '最大高度数据', 0, cpNormal),
    wbFormIDCk(LTMP, '光照模版', [LGTM, NULL], False, cpNormal, True),
    wbByteArray(LNAM, '未知', 0, cpIgnore), // leftover flags, they are now in XCLC

    {>>> XCLW sometimes has $FF7FFFFF and causes invalid floation point <<<}
    wbFloat(XCLW, '水面高度'),
    //wbByteArray(XCLW, '水面高度', 4),
    wbString(XNAM, '水面噪波纹理'),
    wbArrayS(XCLR, '地区', wbFormIDCk('地区', [REGN])),
    wbFormIDCk(XLCN, '位置', [LCTN]),
    wbByteArray(XWCN, '未知', 0, cpIgnore), // leftover
    wbByteArray(XWCS, '未知', 0, cpIgnore), // leftover
    wbStruct(XWCU, '水流速度', [
      wbFloat('X 偏移'),
      wbFloat('Y 偏移'),
      wbFloat('Z 偏移'),
      wbByteArray('未知', 4),
      wbFloat('X 角度'),
      wbFloat('Y 角度'),
      wbFloat('Z 角度'),
      wbByteArray('未知', 0)
    ]),
    wbFormIDCk(XCWT, '水源', [WATR]),

    {--- Ownership ---}
    wbOwnership,
		wbFormIDCk(XILL, '锁定列表', [FLST, NPC_]),

    wbString(XWEM, '水面环境贴图'),
    wbFormIDCk(XCCM, '来源于地区的天空/气候', [REGN]),
    wbFormIDCk(XCAS, '声学空间', [ASPC]),
    wbFormIDCk(XEZN, '遭遇区域', [ECZN]),
    wbFormIDCk(XCMO, '音乐类型', [MUSC]),
    wbFormIDCk(XCIM, '图像空间', [IMGS])
  ], True, wbCellAddInfo, cpNormal, False, wbCELLAfterLoad);

  wbRecord(CLAS, 'Class', [
    wbEDID,
    wbFULLReq,
    wbDESCReq,
    wbICON,
    wbStruct(DATA, '', [
      wbByteArray('未知', 4),
      wbInteger('传授', itS8, wbEnum([
        '单手',
        '双手',
        '箭术',
        '格挡',
        '锻造',
        '重甲',
        '轻甲',
        '扒窃',
        '开锁',
        '潜行',
        '炼金',
        '口才',
        '改变系',
        '召唤系',
        '毁灭系',
        '幻术系',
        '恢复系',
        '附魔'
      ])),
      wbInteger('最大训练等级', itU8),
      wbArray('技能权重', wbInteger('权重', itU8), [
        '单手',
        '双手',
        '箭术',
        '格挡',
        '锻造',
        '重甲',
        '轻甲',
        '扒窃',
        '开锁',
        '潜行',
        '炼金',
        '口才',
        '改变系',
        '召唤系',
        '毁灭系',
        '幻术系',
        '恢复系',
        '附魔'
      ]),
      wbFloat('重伤默认值'),
      wbInteger('吼声点数', itU32),
      wbArray('属性权重', wbInteger('权重', itU8), [
        '生命',
        '法力',
        '体力',
        '未知'
      ])
    ], cpNormal, True)
  ]);

  wbRecord(CLMT, 'Climate', [
    wbEDID,
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

  wbRecord(SPGD, 'Shader Particle Geometry', [
    wbEDID,
    wbStruct(DATA, '数据', [
      wbFloat('向心速度'),
      wbFloat('旋转速度'),
      wbFloat('颗粒尺寸 X'),
      wbFloat('颗粒尺寸 Y'),
      wbFloat('最小中心偏移'),
      wbFloat('最小中心偏移'),
      wbFloat('初始角度范围'),
      wbInteger('# / 子材质 X', itU32),
      wbInteger('# / 子材质 Y', itU32),
      wbInteger('类型', itU32, wbEnum([
        '雨',
        '雪'
      ])),
      wbInteger('容器尺寸', itU32),
      wbFloat('颗粒密度')
    ], cpNormal, True, nil, 10),
    wbString(ICON, '颗粒材质')
  ]);

  wbRecord(RFCT, 'Visual Effect', [
    wbEDID,
    wbStruct(DATA, '效果数据', [
			wbFormIDCK('视觉效果', [ARTO, NULL]),
      wbFormIDCK('渲染', [EFSH, NULL]),
      wbInteger('标志', itU32, wbFlags([
        {0x00000001}'旋转到面对目标',
        {0x00000002}'附属到摄像机',
        {0x00000004}'继承旋转'
      ]))
    ], cpNormal, True)
  ]);

  wbRecord(CONT, 'Container', [
    wbEDID,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbCOCT,
    wbCNTOs,
    wbDEST,
    wbStruct(DATA, '', [
      wbInteger('标志', itU8, wbFlags([
        {0x01} '支持动画音效',
        {0x02} '重生',
        {0x04} '显示所有者'
      ])),
      wbFloat('重量')
    ], cpNormal, True),
    wbSNAM,
    wbQNAM
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
      wbFormIDCk(CSDI, '音效', [SOUN, SNDR, NULL], False, cpNormal, True),
      wbInteger(CSDC, '声音概率', itU8, nil, cpNormal, True)
    ], []), cpNormal, True)
  ], []);

  wbCSDTs := wbRArrayS('声音类型', wbCSDT, cpNormal, False, nil, nil, nil{wbActorTemplateUseModelAnimation});

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
     {03} wbInteger('品德', itU8, wbEnum([
            '任何罪行',
            '对敌人实行暴力',
            '仅涉财犯罪',
            '无罪行'
          ])),
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
          wbInteger('协助', itU8, wbEnum([
            '不帮助',
            '帮助盟友',
            '帮助朋友和盟友'
          ])),
          wbStruct('注意力', [
            wbInteger('感应半径', itU8, wbEnum(['假', '真'])),
            wbInteger('未知', itU8),
            wbInteger('警告', itU32),
            wbInteger('警告/攻击', itU32),
            wbInteger('攻击', itU32)
          ])
    ], cpNormal, True, nil{wbActorTemplateUseAIData});

  wbAttackAnimationEnum := wbEnum([], [
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
    255, ' DEFAULT'
  ]);

  wbRecord(CSTY, 'Combat Style', [
    wbEDID,
    wbStruct(CSGD, '常规', [
      wbFloat('攻击加成'),
      wbFloat('防御加成'),
      wbFloat('群组攻击加成'),
      // keep as separate floats, some elements can be omitted
      wbFloat('装备点数加成 - 近战'),
      wbFloat('装备点数加成 - 魔法'),
      wbFloat('装备点数加成 - 远程'),
      wbFloat('装备点数加成 - 吼声'),
      wbFloat('装备点数加成 - 徒手'),
      wbFloat('装备点数加成 - 法杖'),
      wbFloat('躲开威胁概率')
    ], cpNormal, True, nil, 0),
    wbUnknown(CSMD, cpIgnore),
    wbStruct(CSME, '近战', [
      wbFloat('摇晃攻击加成'),
      wbFloat('摇晃猛击加成'),
      wbFloat('格挡猛击加成'),
      wbFloat('重击加成'),
      wbFloat('后退重击加成'),
      wbFloat('重击攻击加成'),
      wbFloat('重击猛击加成'),
      wbFloat('特殊攻击加成')
    ], cpNormal, False, nil, 0),
    wbStruct(CSCR, '近距离 ', [
      wbFloat('环绕加成'),
      wbFloat('撤退加成'),
      wbFloat('侧面距离'),
      wbFloat('跟踪时间')
    ], cpNormal, False, nil, 0),
    wbStruct(CSLR, '远距离', [
      wbFloat('扫射加成')
    ], cpNormal, False),
    wbStruct(CSFL, '飞行', [
      wbFloat('盘旋机率'),
      wbFloat('俯冲攻击机率'),
      wbFloat('地面攻击概率'),
      wbFloat('盘旋时间'),
      wbFloat('地面攻击时间'),
      wbFloat('高地攻击机率'),
      wbFloat('高地攻击时间'),
      wbFloat('飞行攻击机率')
    ], cpNormal, False, nil, 0),
    wbInteger(DATA, '标志', itU32, wbFlags([
      {0x01} '决斗',
      {0x02} '侧面攻击',
      {0x04} '允许双持'
    ]), cpNormal, False)
  ]);
end;

procedure DefineTES5d;
begin
  wbRecord(DIAL, 'Dialog Topic', [
    wbEDID,
    wbFULL,
    wbFloat(PNAM, '优先级', cpNormal, True, 1, -1, nil, nil, 50.0),
    wbFormIDCk(BNAM, '分支', [DLBR, NULL]),
    wbFormIDCk(QNAM, '任务', [QUST, NULL], False, cpNormal, False),
    wbStruct(DATA, '数据', [
      // this should not be named Flags since TwbFile.BuildReachable
      // expects Top-Level flag here from FNV
      wbInteger('话题标志', itU8, wbFlags([
        '重复前全部执行'
      ]), cpNormal, True),
      wbByteArray('未知', 1),
      wbInteger('子类型', itU16, wbEnum([], [
         0, 'Custom',
         1, 'ForceGreet',
         2, 'Rumors',
         3, 'Custom?',
         4, 'Intimidate',
         5, 'Flatter',
         6, 'Bribe',
         7, 'Ask Gift',
         8, 'Gift',
         9, 'Ask Favor',
        10, 'Favor',
        11, 'Show Relationships',
        12, 'Folow',
        13, 'Reject',
        14, 'Scene',
        15, 'Show',
        16, 'Agree',
        17, 'Refuse',
        18, 'ExitFavorState',
        19, 'MoralRefusal',
        20, 'FlyingMountLand',
        21, 'FlyingMountCancelLand',
        22, 'FlyingMountAcceptTarget',
        23, 'FlyingMountRejectTarget',
        24, 'FlyingMountNoTarget',
        25, 'FlyingMountDestinationReached',
        26, 'Attack',
        27, 'PowerAttack',
        28, 'Bash',
        29, 'Hit',
        30, 'Flee',
        31, 'Bleedout',
        32, 'AvoidThreat',
        33, 'Death',
        34, 'GroupStrategy',
        35, 'Block',
        36, 'Taunt',
        37, 'AllyKilled',
        38, 'Steal',
        39, 'Yield',
        40, 'AcceptYield',
        41, 'PickpocketCombat',
        42, 'Assault',
        43, 'Murder',
        44, 'AssaultNC',
        45, 'MurderNC',
        46, 'PickpocketNC',
        47, 'StealFromNC',
        48, 'TrespassAgainstNC',
        49, 'Trespass',
        50, 'WereTransformCrime',
        51, 'VoicePowerStartShort',
        52, 'VoicePowerStartLong',
        53, 'VoicePowerEndShort',
        54, 'VoicePowerEndLong',
        55, 'AlertIdle',
        56, 'LostIdle',
        57, 'NormalToAlert',
        58, 'AlertToCombat',
        59, 'NormalToCombat',
        60, 'AlertToNormal',
        61, 'CombatToNormal',
        62, 'CombatToLost',
        63, 'LostToNormal',
        64, 'LostToCombat',
        65, 'DetectFriendDie',
        66, 'ServiceRefusal',
        67, 'Repair',
        68, 'Travel',
        69, 'Training',
        70, 'BarterExit',
        71, 'RepairExit',
        72, 'Recharge',
        73, 'RechargeExit',
        74, 'TrainingExit',
        75, 'ObserveCombat',
        76, 'NoticeCorpse',
        77, 'TimeToGo',
        78, 'GoodBye',
        79, 'Hello',
        80, 'SwingMeleeWeapon',
        81, 'ShootBow',
        82, 'ZKeyObject',
        83, '跳动',
        84, 'KnockOverObject',
        85, 'DestroyObject',
        86, 'StandonFurniture',
        87, 'LockedObject',
        88, 'PickpocketTopic',
        89, 'PursueIdleTopic',
        90, 'SharedInfo',
        91, 'PlayerCastProjectileSpell',
        92, 'PlayerCastSelfSpell',
        93, 'PlayerShout',
        94, 'Idle',
        95, 'EnterSprintBreath',
        96, 'EnterBowZoomBreath',
        97, 'ExitBowZoomBreath',
        98, 'ActorCollidewithActor',
        99, 'PlayerinIronSights',
       100, 'OutofBreath',
       101, 'CombatGrunt',
       102, 'LeaveWaterBreath'
      ]))
    ]),
    wbString(SNAM, '子类型名称', 4),
    wbInteger(TIFC, '情报数量', itU32)
  ]);

  wbRecord(DOOR, 'Door', [
    wbEDID,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbDEST,
    wbFormIDCk(SNAM, '音效 - 开启', [SOUN, SNDR]),
    wbFormIDCk(ANAM, '音效 - 关闭', [SOUN, SNDR]),
    wbFormIDCk(BNAM, '音效 - 循环', [SOUN, SNDR]),
    wbInteger(FNAM, '标志', itU8, wbFlags([
      '',
      '自动',
      '隐藏',
      '最小使用',
      '推拉门',
      '战斗搜索中部开启'
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
    wbString(NAM8, '表面调色板材质'),
    wbString(NAM9, '粒子调色板材质'),
    wbStruct(DATA, '', [
      wbByteArray('未知', 4),
      wbInteger('表面着色器 - 源混合模式', itU32, wbBlendModeEnum),
      wbInteger('表面着色器 - 混合操作', itU32, wbBlendOpEnum),
      wbInteger('表面着色器 - Z测试函数', itU32, wbZTestFuncEnum),
      wbStruct('填充/材质效果 - 颜色检索1', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
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
        wbByteArray('未知', 1)
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
      wbFloat('粒子着色器 - 固定粒子数'),
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
        wbByteArray('未知', 1)
      ]),
      wbStruct('颜色检索2 - 颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ]),
      wbStruct('颜色检索3 - 颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
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
        wbByteArray('未知', 1)
      ]),
      wbFloat('爆炸风速度'),
      wbInteger('材质数量 U', itU32),
      wbInteger('材质数量 V', itU32),
      wbFloat('附加模型 - 淡入时间'),
      wbFloat('附加模型 - 淡出时间'),
      wbFloat('附加模型 - 扩展开始'),
      wbFloat('附加模型 - 扩展结束'),
      wbFloat('附加模型 - 向内扩展时间'),
      wbFloat('附加模型 - 向外扩展时间'),
      wbFormIDCk('环境音效', [SNDR, SOUN, NULL]),
      wbStruct('填充/材质效果 - 颜色检索2', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ]),
      wbStruct('填充/材质效果 - 颜色检索3', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ]),
      wbStruct('填充/材质效果 - 颜色检索规模/时间', [
        wbFloat('颜色检索1 - 规模'),
        wbFloat('颜色检索2 - 规模'),
        wbFloat('颜色检索3 - 规模'),
        wbFloat('颜色检索1 - 时间'),
        wbFloat('颜色检索2 - 时间'),
        wbFloat('颜色检索3 - 时间')
      ]),
      wbFloat('颜色规模(色度)'),
      wbFloat('出生位置偏移'),
      wbFloat('出生位置偏移范围 +/-'),
      wbStruct('粒子着色器动画', [
        wbInteger('起始帧', itU32),
        wbInteger('起始帧变换', itU32),
        wbInteger('结束帧', itU32),
        wbInteger('循环起始帧', itU32),
        wbInteger('循环起始变换', itU32),
        wbInteger('帧数量', itU32),
        wbInteger('帧数量变换', itU32)
      ]),
      wbInteger('标志', itU32, wbFlags([
        '无表面着色器',
        '表面灰度颜色',
        '表面灰度 Alpha',
        '无粒子着色器',
        '边缘效果反转',
        '仅影响表面',
        '忽略 Alpha',
        'UV 工程化',
        '忽略基本几何 Alpha',
        '光照',
        '无武器',
        '未知 11',
        '未知 12',
        '未知 13',
        '未知 14',
        '运动粒子',
        '粒子灰度颜色',
        '粒子灰度 Alpha',
        '未知 18',
        '未知 19',
        '未知 20',
        '未知 21',
        '未知 22',
        '未知 23',
        '使用血液几何'
      ])),
      wbFloat('填充/材质效果 - 材质规模 (U)'),
      wbFloat('填充/材质效果 - 材质规模 (V)'),
      wbInteger('场景图放射深度限制 (未使用)', itU32)
    ], cpNormal, True, nil, 0)
  ], False, nil, cpNormal, False, nil {wbEFSHAfterLoad});

  wbRecord(ENCH, 'Object Effect', [
    wbEDID,
    wbOBNDReq,
    wbFULL,
    wbStruct(ENIT, '效果数据', [
      wbInteger('附魔消耗', itS32),
      wbInteger('标志', itU32, wbFlags([
        '不自动计算',
        '',
        '再次施放时增加持续时间'
      ])),
      wbInteger('施法类型', itU32, wbCastEnum),
      wbInteger('附魔数量', itS32),
      wbInteger('目标类型', itU32, wbTargetEnum),
      wbInteger('附魔类型', itU32, wbEnum([], [
        $06, '附魔',
        $0C, '法杖附魔'
      ])),
      wbFloat('充能时长'),
      wbFormIDCk('基本附魔', [ENCH, NULL]),
      wbFormIDCk('破坏限制', [FLST, NULL])
    ], cpNormal, True, nil, 8),
    wbEffectsReq
  ]);

  wbRecord(EYES, 'Eyes', [
    wbEDID,
    wbFULLReq,
    wbString(ICON, '材质', 0, cpNormal, True),
    wbInteger(DATA, '标志', itU8, wbFlags([
      {0x01}'玩家可用',
      {0x02}'非男性',
      {0x04}'非女性',
      {0x08}'未知 4',
      {0x10}'未知 5',
      {0x20}'未知 6',
      {0x40}'未知 7',
      {0x80}'未知 8'
    ]), cpNormal, True)
  ]);

  wbXNAM :=
    wbStructSK(XNAM, [0], '关系', [
      wbFormIDCkNoReach('派系', [FACT, RACE]),
      wbInteger('修正', itS32),
      wbInteger('集团作战反应', itU32, wbEnum([
      {0x00000001}'中立',
      {0x00000002}'敌人',
      {0x00000004}'同伴',
      {0x00000008}'好友'
    ]))
  ]);

  wbRecord(FACT, 'Faction', [
    wbEDID,
    wbFULL,
    wbRArrayS('关系', wbXNAM),
    wbStruct(DATA, '标志', [
      wbInteger('标志', itU32, wbFlags([
        {0x00000001}'从 NPC 隐藏',
        {0x00000002}'特殊战斗',
        {0x00000004}'未知 3',
        {0x00000008}'未知 4',
        {0x00000010}'未知 5',
        {0x00000020}'未知 6',
        {0x00000040}'跟踪罪行',
        {0x00000080}'忽略罪行: 谋杀',
        {0x00000100}'忽略罪行: 攻击',
        {0x00000200}'忽略罪行: 偷窃',
        {0x00000400}'忽略罪行: 非法入侵',
        {0x00000800}'不向成员举报罪行',
        {0x00001000}'犯罪罚金 - 使用默认',
        {0x00002000}'忽略罪行: 扒窃',
        {0x00004000}'商人',
        {0x00008000}'可以是所有者',
        {0x00010000}'忽略罪行: 狼人变身',
        {0x00020000}'未知 18',
        {0x00040000}'未知 19',
        {0x00080000}'未知 20',
        {0x00100000}'未知 21',
        {0x00200000}'未知 22',
        {0x00400000}'未知 23',
        {0x00800000}'未知 24',
        {0x01000000}'未知 25',
        {0x02000000}'未知 26',
        {0x04000000}'未知 27',
        {0x08000000}'未知 28',
        {0x10000000}'未知 29',
        {0x20000000}'未知 30',
        {0x40000000}'未知 31',
        {0x80000000}'未知 32'
      ]))
    ], cpNormal, True, nil, 1),
    wbFormIDCk(JAIL, '室外监狱标记', [REFR]),
    wbFormIDCk(WAIT, '追随者等待标记', [REFR]),
    wbFormIDCk(STOL, '偷窃商品容器', [REFR]),
    wbFormIDCk(PLCN, '玩家装备栏容器', [REFR]),
    wbFormIDCk(CRGR, '共享犯罪派系列表', [FLST]),
    wbFormIDCk(JOUT, '监狱穿着', [OTFT]),
    wbStruct(CRVA, '罪行数值', [
      {01} wbInteger('逮捕', itU8, wbEnum(['假', '真'])),
      {02} wbInteger('看到就攻击', itU8, wbEnum(['假', '真'])),
      {02} wbInteger('谋杀', itU16),
      {02} wbInteger('攻击', itU16),
      {02} wbInteger('非法入侵', itU16),
      {02} wbInteger('扒窃', itU16),
      {02} wbInteger('未知', itU16),
      {02} wbFloat('偷窃加成'),
      {02} wbInteger('越狱', itU16),
      {02} wbInteger('狼人', itU16)
      ], cpNormal, False, nil, 7),
    wbRStructsSK('等级', '等级', [0], [
      wbInteger(RNAM, '等级#', itU32),
      wbLString(MNAM, '男性头衔'),
      wbLString(FNAM, '女性头衔'),
      wbString(INAM, '记号 未使用')
    ], []),
    wbFormIDCk(VEND, '商人购买/出售列表', [FLST]),
    wbFormIDCk(VENC, '商人容器', [REFR]),
    wbStruct(VENV, '商人参数', [
      {01} wbInteger('起始时间', itU16),
      {02} wbInteger('结束时间', itU16),
      {02} wbInteger('半径', itU16),
      {02} wbByteArray('未知 1', 2),
           wbInteger('仅购买偷窃物品', itU8, wbEnum(['假', '真'])),
           wbInteger('不/销售买入', itU8, wbEnum(['假', '真'])),
      {02} wbByteArray('未知 2', 2)
      ]),
    wbPLVD,
    wbCITC,
    wbCTDAs
  ], False, nil, cpNormal, False, nil {wbFACTAfterLoad});

  wbRecord(FURN, 'Furniture', [
    wbEDID,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbDEST,
    wbKSIZ,
    wbKWDAs,
    wbUnknown(PNAM),
    wbInteger(FNAM, '标志', itU16, wbFlags([
      {0x0001} '未知 0',
      {0x0002} '被沙盒忽略'
    ])),
    wbFormIDCk(KNAM, '交互关键字', [KYWD, NULL]),
    wbInteger(MNAM, '激活标记 / 标志', itU32, wbFlags([
      {0x00000001} '坐 0',
      {0x00000002} '坐 1',
      {0x00000004} '坐 2',
      {0x00000008} '坐 3',
      {0x00000010} '坐 4',
      {0x00000020} '坐 5',
      {0x00000040} '坐 6',
      {0x00000080} '坐 7',
      {0x00000100} '坐 8',
      {0x00000200} '坐 9',
      {0x00000400} '坐 10',
      {0x00000800} '坐 11',
      {0x00001000} '坐 12',
      {0x00002000} '坐 13',
      {0x00004000} '坐 14',
      {0x00008000} '坐 15',
      {0x00010000} '坐 16',
      {0x00020000} '坐 17',
      {0x00040000} '坐 18',
      {0x00080000} '坐 19',
      {0x00100000} '坐 20',
      {0x00200000} '坐 21',
      {0x00400000} '坐 22',
      {0x00800000} '坐 23',
      {0x01000000} '未知 25',
      {0x02000000} '关闭激活器',
      {0x04000000} 'Is Perch',
      {0x08000000} '必须离开才能交谈',
      {0x10000000} '未知 29',
      {0x20000000} '未知 30',
      {0x40000000} '未知 31',
      {0x80000000} '未知 32'
    ])),
    wbStruct(WBDT, '工作台数据', [
      wbInteger('工作台类型', itU8, wbEnum([
        {0} '无',
        {1} '创建对象',
        {2} '锻造武器',
        {3} '附魔',
        {4} '附魔实验',
        {5} '炼金',
        {6} '炼金实验',
        {7} '锻造盔甲'
      ])),
      wbInteger('使用技能', itS8, wbSkillEnum)
    ]),
    wbFormIDCk(NAM1, '相关联魔法', [SPEL]),
    wbRArray('标记', wbRStruct('标记', [
      wbInteger(ENAM, '标记索引', itU32),
      wbStruct(NAM0, '关闭记录点', [
        wbByteArray('未知', 2),
        wbInteger('已关闭关闭记录点', itU16, wbFurnitureEntryTypeFlags)
      ]),
      wbFormIDCk(FNMK, '标记关键字', [KYWD, NULL])
    ], [])),
    wbRArray('标记记录点', wbStruct(FNPR, '标记', [
      wbInteger('类型', itU16, wbFurnitureAnimTypeEnum),
      wbInteger('记录点', itU16, wbFurnitureEntryTypeFlags)
    ])),
    wbString(XMRK, '模型')
  ]);

//----------------------------------------------------------------------------
// For expansion to use wbGLOBUnionDecider to display Short, Long, Float
// correctly without making a signed float by default
//----------------------------------------------------------------------------
  wbRecord(GLOB, 'Global', [
    wbEDID,
    wbInteger(FNAM, '类型', itU8, wbGLOBFNAM, nil, cpNormal, True),
    wbFloat(FLTV, '数值', cpNormal, True)
  ]);

  wbRecord(GMST, 'Game Setting', [
    wbString(EDID, '编辑器标识', 0, cpCritical, True, nil, wbGMSTEDIDAfterSet),
    wbUnion(DATA, '数值', wbGMSTUnionDecider, [
      wbLString('名称'),
      wbInteger('整数', itS32),
      wbFloat('浮点数'),
      wbInteger('布尔值', itU32, wbEnum(['假', '真']))
    ], cpNormal, True)
  ]);

  wbRecord(KYWD, 'Keyword', [
    wbEDID,
    wbCNAM
  ]);
end;

procedure DefineTES5e;
begin
  wbRecord(LCRT, 'Location Reference Type', [
    wbEDID,
    wbCNAM
  ]);

  wbRecord(AACT, 'Action', [
    wbEDID,
    wbCNAM
  ]);

  wbRecord(TXST, 'Texture Set', [
    wbEDID,
    wbOBNDReq,
    wbRStruct('材质 (RGB/A)', [
      wbString(TX00,'颜色贴图'),
      wbString(TX01,'法线/光泽贴图'),
      wbString(TX02,'环境遮罩/暗色调'),
      wbString(TX03,'辉光/细节贴图'),
      wbString(TX04,'高度贴图'),
      wbString(TX05,'环境贴图'),
      wbString(TX06,'多层贴图'),
      wbString(TX07,'背光遮罩/高光色')
    ], []),
    wbDODT,
    wbInteger(DNAM, '标志', itU16, wbFlags([
      {0x0001}'无高光贴图',
      {0x0002}'面部构建模型材质',
      {0x0004}'含模型空间法线贴图'
    ]), cpNormal, False)
  ]);

  wbRecord(HDPT, 'Head Part', [
    wbEDID,
    wbFULL,
    wbMODL,
    wbInteger(DATA, '标志', itU8, wbFlags([
      {0x01} '玩家可用',
      {0x02} '男性',
      {0x04} '女性',
      {0x10} '是额外部分',
      {0x20} '使用纯色色调'
    ]), cpNormal, True),
    wbInteger(PNAM, '类型', itU32, wbEnum([
      '杂项',
      '脸部',
      '眼睛',
      '发型',
      '胡须',
      '疤痕',
      '睫毛'
    ])),
    wbRArrayS('额外部分',
      wbFormIDCk(HNAM, '部分', [HDPT])
    ),
    wbRStructs('部分', '部分', [
      wbInteger(NAM0, '部分类型', itU32, wbEnum([
        '种族型变',
        'Tri',
        '角色构造型变'
      ])),
      wbString(NAM1, '文件', 0, cpTranslate, True)
    ], []),
    wbFormIDCk(TNAM, '材质集', [TXST, NULL]),
    wbFormIDCk(CNAM, '颜色', [CLFM, NULL]),
    wbFormIDCk(RNAM, '可用种族', [FLST, NULL])
  ]);

  wbRecord(ASPC, 'Acoustic Space', [
    wbEDID,
    wbOBNDReq,
    wbFormIDCk(SNAM, '环境音效', [SNDR]),
    wbFormIDCk(RDAT, '来源于地区的音效 (仅室内)', [REGN]),
    wbFormIDCk(BNAM, '环境类型 (混响)', [REVB])
  ]);

  wbRecord(MSTT, 'Moveable Static', [
    wbEDID,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbDEST,
    wbInteger(DATA, '标志', itU8, wbFlags([
      '在小地图',
      '未知 2'
    ]), cpNormal, True),
    wbFormIDCk(SNAM, '循环音效', [SNDR])
  ]);
end;

procedure DefineTES5f;
begin
  wbRecord(IDLM, 'Idle Marker', [
    wbEDID,
    wbOBNDReq,
    wbInteger(IDLF, '标志', itU8, wbFlags([
      '按顺序运行',
      '未知 1',
      '运行一次',
      '未知 3',
      '被沙盒忽略'
    ]), cpNormal, False),
    wbInteger(IDLC, '动作数量', itU8),
    wbFloat(IDLT, '动作计时器设定', cpNormal, False),
    wbArray(IDLA, '动作', wbFormIDCk('动作', [IDLE]), 0, nil, nil, cpNormal, False),
    wbMODL
  ]);

  wbRecord(PROJ, 'Projectile', [
    wbEDID,
    wbOBNDReq,
    wbFULL,
    wbMODL,
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
        '禁用战斗目标修正',
        '旋转'
      ])),
      {02} wbInteger('类型', itU16, wbEnum([], [
        $01, '直线型',
        $02, '高投式',
        $04, '散射式',
        $08, '喷射式',
        $10, '圆锥状',
        $20, '障碍物',
        $40, '弓箭'
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
      {40} wbFormIDCk('音效', [SOUN, SNDR, NULL]),
      {44} wbFloat('开火闪光 - 持续时间'),
      {48} wbFloat('淡出持续时间'),
      {52} wbFloat('冲击强度'),
      {56} wbFormIDCk('音效 - 倒计时', [SOUN, SNDR, NULL]),
      {60} wbFormIDCk('音效 - 禁止', [SOUN, SNDR, NULL]),
      {64} wbFormIDCk('默认武器源', [WEAP, NULL]),
      {68} wbFloat('锥形传播'),
      {72} wbFloat('碰撞半径'),
      {76} wbFloat('寿命'),
      {80} wbFloat('再发射间隔'),
           wbFormIDCk('贴花数据', [TXST, NULL]),
           wbFormIDCk('碰撞层', [COLL, NULL])
    ], cpNormal, True, nil, 22),
    wbRStructSK([0], '开火闪光模型', [
      wbString(NAM1, '模型'),
      wbByteArray(NAM2, '材质文件哈希值', 0, cpIgnore, false, false, wbNeverShow)
    ], [], cpNormal, True),
    wbInteger(VNAM, '音量级别', itU32, wbSoundLevelEnum, cpNormal, True)
  ]);

  wbRecord(HAZD, 'Hazard', [
    wbEDID,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbFormIDCk(MNAM, '图像空间变换', [IMAD, NULL]),
    wbStruct(DATA, '数据', [
      wbInteger('限制', itU32),
      wbFloat('半径'),
      wbFloat('寿命'),
      wbFloat('图像空间半径'),
      wbFloat('目标间隔'),
      wbInteger('标志', itU32, wbFlags([
        {0x01} '仅影响玩家',
        {0x02} '从重生魔法继承持续时间',
        {0x04} '对齐到冲击法线',
        {0x08} '从重生魔法继承半径',
        {0x10} '下降到地面'
      ])),
      wbFormIDCk('法术', [SPEL, NULL]),
      wbFormIDCk('光效', [LIGH, NULL]),
      wbFormIDCk('冲击数据集', [IPDS, NULL]),
      wbFormIDCk('音效', [SNDR, NULL])
    ])
  ]);

  wbSoulGemEnum := wbEnum([
    {0} '无',
    {1} '微小',
    {2} '较小',
    {3} '普通',
    {4} '较大',
    {5} '巨大'
  ]);

  wbRecord(SLGM, 'Soul Gem', [
    wbEDID,
    wbOBND,
    wbFULL,
    wbMODL,
    wbICON,
    wbDEST,
    wbFormIDCk(YNAM, '音效 - 拾起', [SNDR, SOUN]),
    wbFormIDCk(ZNAM, '音效 - 丢弃', [SNDR, SOUN]),
    wbKSIZ,
    wbKWDAs,
    wbICON,
    wbStruct(DATA, '', [
      wbInteger('价值', itU32),
      wbFloat('重量')
    ], cpNormal, True),
    wbInteger(SOUL, '所含灵魂', itU8, wbSoulGemEnum, cpNormal, True),
    wbInteger(SLCP, '最大容量', itU8, wbSoulGemEnum, cpNormal, True),
    wbFormIDCk(NAM0, '链接到', [SLGM])
  ]);

  if wbSimpleRecords then begin

    wbRecord(NAVI, 'Navigation Mesh Info Map', [
      wbEDID,
      wbInteger(NVER, '版本', itU32),
      wbRArray('导航地图信息',
        wbStruct(NVMI, '导航地图信息', [
          wbFormIDCk('导航模型', [NAVM]),
          wbByteArray('数据', 20),
          wbArray('整合到', wbFormIDCk('模型', [NAVM]), -1),
          wbArray('优先整合', wbFormIDCk('模型', [NAVM]), -1),
          wbArray('连接的门', wbStruct('门', [
            wbByteArray('未知', 4),
            wbFormIDCk('门衍生', [REFR])
          ]), -1),
          wbInteger('是岛屿', itU8, wbEnum(['假', '真'])),
          wbUnion('岛屿', wbNAVIIslandDataDecider, [
            wbStruct('未使用', [
            ]),
            wbStruct('岛屿数据', [
              wbByteArray('未知', 24),
              wbArray('三角', wbByteArray('三角', 6), -1),
              wbArray('顶点', wbByteArray('顶点', 12), -1)
            ])
          ]),
          wbByteArray('未知', 4),
          wbFormIDCk('父系空间', [WRLD, NULL]),
          wbUnion('父系', wbNAVIParentDecider, [
            wbStruct('坐标', [
              wbInteger('网格Y', itS16),
              wbInteger('网格X', itS16)
            ]),
            wbFormIDCk('父系场景', [CELL])
          ])
        ])
      ),
      wbStruct(NVPP, '优先路径', [
        wbArray('NavMeshes', wbArray('集合', wbFormIDCk('', [NAVM]), -1), -1),
        wbArray('NavMesh 树?', wbStruct('', [
          wbFormIDCk('NavMesh', [NAVM]),
          wbInteger('索引/节点', itU32)
        ]), -1)
      ]),
      //wbArray(NVSI, '未知', wbFormIDCk('导航模型', [NAVM]))
      wbUnknown(NVSI)
    ]);

    wbRecord(NAVM, 'Navigation Mesh', [
      wbEDID,
      wbStruct(NVNM, '几何学', [
        wbByteArray('未知', 8),
        wbFormIDCk('父系空间', [WRLD, NULL]),
        wbUnion('父系', wbNVNMParentDecider, [
          wbStruct('坐标', [
            wbInteger('网格Y', itS16),
            wbInteger('网格X', itS16)
          ]),
          wbFormIDCk('父系场景', [CELL])
        ]),
        wbArray('顶点', wbByteArray('顶点', 12), -1),
        wbArray('三角', wbByteArray('三角', 16), -1),
        wbArray('外部连接',
          wbStruct('连接', [
            wbByteArray('未知', 4),
            wbFormIDCk('模型', [NAVM]),
            wbInteger('三角', itS16)
          ])
        , -1),
        wbArray('门三角',
          wbStruct('门三角', [
            wbInteger('门前三角', itS16),
            wbByteArray('未知', 4),
            wbFormIDCk('门', [REFR])
          ])
        , -1),
        wbUnknown
      ]),
      wbUnknown(ONAM),
      wbUnknown(PNAM),
      wbUnknown(NNAM)
    ], False, wbNAVMAddInfo);

  end else begin

    wbRecord(NAVI, 'Navigation Mesh Info Map', [
      wbEDID,
      wbInteger(NVER, '版本', itU32),
      wbRArray('导航地图信息',
        wbStruct(NVMI, '导航地图信息', [
          wbFormIDCk('导航模型', [NAVM]),
          wbByteArray('未知', 4),
          wbFloat('X'),
          wbFloat('Y'),
          wbFloat('Z'),
          wbInteger('优先整合标志', itU32),
          wbArray('整合到', wbFormIDCk('模型', [NAVM]), -1),
          wbArray('优先整合', wbFormIDCk('模型', [NAVM]), -1),
          wbArray('连接的门', wbStruct('门', [
            wbByteArray('未知', 4),
            wbFormIDCk('门衍生', [REFR])
          ]), -1),
          wbInteger('是岛屿', itU8, wbEnum(['假', '真'])),
          wbUnion('岛屿', wbNAVIIslandDataDecider, [
            wbStruct('未使用', [
            ]),
            wbStruct('岛屿数据', [
              wbFloat('最小 X'),
              wbFloat('最小 Y'),
              wbFloat('最小 Z'),
              wbFloat('最大 X'),
              wbFloat('最大 Y'),
              wbFloat('最大 Z'),
              wbArray('三角',
                wbStruct('三角', [
                  wbArray('顶点', wbInteger('顶点', itS16), 3)
                ])
              , -1),
              wbArray('顶点', wbStruct('顶点', [
                wbFloat('X'),
                wbFloat('Y'),
                wbFloat('Z')
              ]), -1)
            ])
          ]),
          wbByteArray('未知', 4),
          wbFormIDCk('父系空间', [WRLD, NULL]),
          wbUnion('父系', wbNAVIParentDecider, [
            wbStruct('坐标', [
              wbInteger('网格Y', itS16),
              wbInteger('网格X', itS16)
            ]),
            wbFormIDCk('父系场景', [CELL])
          ])
        ])
      ),
      wbStruct(NVPP, '优先路径', [
        wbArray('NavMeshes', wbArray('集合', wbFormIDCk('', [NAVM]), -1), -1),
        wbArray('NavMesh 树?', wbStruct('', [
          wbFormIDCk('NavMesh', [NAVM]),
          wbInteger('索引/节点', itU32)
        ]), -1)
      ]),
      wbArray(NVSI, '未知', wbFormIDCk('导航模型', [NAVM]))
    ]);

    wbRecord(NAVM, 'Navigation Mesh', [
      wbEDID,
      wbStruct(NVNM, '几何学', [
        wbInteger('未知', itU32),
        wbByteArray('未知', 4),
        wbFormIDCk('父系空间', [WRLD, NULL]),
        wbUnion('父系', wbNVNMParentDecider, [
          wbStruct('坐标', [
            wbInteger('网格Y', itS16),
            wbInteger('网格X', itS16)
          ]),
          wbFormIDCk('父系场景', [CELL])
        ]),
        wbArray('顶点', wbStruct('顶点', [
          wbFloat('X'),
          wbFloat('Y'),
          wbFloat('Z')
        ]), -1),
        wbArray('三角',
          wbStruct('三角', [
            wbArray('顶点', wbInteger('顶点', itS16), 3),
            wbArray('边缘', wbInteger('三角', itS16), [
              '0 <-> 1',
              '1 <-> 2',
              '2 <-> 0'
            ]),
            wbByteArray('覆盖标记?', 2),
            wbInteger('覆盖边缘 #1 标志', itU8),
            wbInteger('覆盖边缘 #2 标志', itU8)
          ])
        , -1),
        wbArray('外部连接',
          wbStruct('连接', [
            wbByteArray('未知', 4),
            wbFormIDCk('模型', [NAVM]),
            wbInteger('三角', itS16)
          ])
        , -1),
        wbArray('门三角',
          wbStruct('门三角', [
            wbInteger('门前三角', itS16),
            wbByteArray('未知', 4),
            wbFormIDCk('门', [REFR])
          ])
        , -1),
        wbArray('覆盖三角', wbInteger('三角', itS16), -1),
        wbInteger('因子?', itU32),
        wbFloat('最大 X 距离'),
        wbFloat('最大 Y 距离'),
        wbFloat('最小 X'),
        wbFloat('最小 Y'),
        wbFloat('最小 Z'),
        wbFloat('最大 X'),
        wbFloat('最大 Y'),
        wbFloat('最大 Z'),
        wbArray('(未知) 三角', wbInteger('三角', itS16), -1),
        wbUnknown
      ]),
      wbUnknown(ONAM),
      wbUnknown(PNAM),
      wbUnknown(NNAM)
    ], False, wbNAVMAddInfo);

  end;

end;

procedure DefineTES5g;
begin

   wbRecord(EXPL, 'Explosion', [
    wbEDID,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbEITM,
    wbFormIDCk(MNAM, '图像空间变换', [IMAD]),
    wbStruct(DATA, '数据', [  // Contradicted by FireStormExplosion02 [EXPL:000877F9]
      wbFormIDCk('光效', [LIGH, NULL]),
      wbFormIDCk('音效 1', [SNDR, NULL]),
      wbFormIDCk('音效 2', [SNDR, NULL]),
      wbFormIDCk('冲击数据集', [IPDS, NULL]),
      wbFormID('放置对象'),
      wbFormIDCk('产生抛射物', [PROJ, NULL]),
      wbFloat('威力'),
      wbFloat('伤害'),
      wbFloat('半径'),
      wbFloat('图像空间半径'),
      wbFloat('垂直补偿加成'),
      wbInteger('标志', itU32, wbFlags([
        '未知 0',
        '始终使用世界定位',
        '击倒 - 始终',
        '击倒 - 依公式',
        '忽略直线对穿检查',
        '仅推动爆炸源衍生',
        '忽略图像空间交换',
        '链式',
        '控制器不振动'
      ])),
      wbInteger('音量级别', itU32, wbSoundLevelEnum, cpNormal, True)
    ], cpNormal, True, nil, 10)
  ]);

  wbRecord(DEBR, 'Debris', [
    wbEDID,
    wbRStructs('模型', '模型', [
      wbStruct(DATA, '数据', [
        wbInteger('百分比', itU8),
        wbString('模型'),
        wbInteger('标志', itU8, wbFlags([
          '存在碰撞数据'
        ]))
      ], cpNormal, True),
      wbMODT
    ], [], cpNormal, True)
  ]);

  wbRecord(IMGS, 'Image Space', [
    wbEDID,
    wbUnknown(ENAM, cpIgnore),
    wbStruct(HNAM, 'HDR', [
      wbFloat('眼睛适应速度'),
      wbFloat('Bloom 模糊半径'),
      wbFloat('Bloom 临界值'),
      wbFloat('Bloom 等级'),
      wbFloat('接受 Bloom 临界值'),
      wbFloat('白光'),
      wbFloat('太阳光比例'),
      wbFloat('天空比例'),
      wbFloat('眼睛适应强度')
    ]),
    wbStruct(CNAM, '电影效果', [
      wbFloat('饱和度'),
      wbFloat('亮度'),
      wbFloat('对比度')
    ]),
    wbStruct(TNAM, '色调', [
      wbFloat('数量'),
      wbStruct('颜色', [
        wbFloat('红', cpNormal, True, 255, 0),
        wbFloat('绿', cpNormal, True, 255, 0),
        wbFloat('蓝', cpNormal, True, 255, 0)
      ])
    ]),
    wbStruct(DNAM, '景深', [
      wbFloat('强度'),
      wbFloat('距离'),
      wbFloat('规模'),
      wbByteArray('未知', 2),
      wbInteger('天空 / 模糊半径', itU16, wbEnum([], [
        16384, '半径 0',
        16672, '半径 1',
        16784, '半径 2',
        16848, '半径 3',
        16904, '半径 4',
        16936, '半径 5',
        16968, '半径 6',
        17000, '半径 7',
        16576, '无天空, 半径 0',
        16736, '无天空, 半径 1',
        16816, '无天空, 半径 2',
        16880, '无天空, 半径 3',
        16920, '无天空, 半径 4',
        16952, '无天空, 半径 5',
        16984, '无天空, 半径 6',
        17016, '无天空, 半径 7'
      ]))
    ], cpNormal, False, nil, 3)
  ]);

  {>>> Most wbUnknowns here are a series of floats that don't have values in CK <<<}
  wbRecord(IMAD, 'Image Space Adapter', [
    wbEDID,
    wbStruct(DNAM, '数据', [
      wbInteger('标志', itU32, wbFlags(['动画'])),
      wbFloat('持续时间'),
      wbByteArray('未知', 4*48),
      wbInteger('径向模糊标志', itU32, wbFlags(['使用目标'])),
      wbFloat('径向模糊中心 X'),
      wbFloat('径向模糊中心 Y'),
      wbArray('未知', wbByteArray('未知', 4), 3),
      wbInteger('景深标志', itU32, wbFlags([
        {0x00000001}'使用目标',
        {0x00000002}'未知 2',
        {0x00000004}'未知 3',
        {0x00000008}'未知 4',
        {0x00000010}'未知 5',
        {0x00000020}'未知 6',
        {0x00000040}'未知 7',
        {0x00000080}'未知 8',
        {0x00000100}'模式 - 前面',
        {0x00000200}'模式 - 后面',
        {0x00000400}'无天空',
        {0x00000800}'模糊半径节 2',
        {0x00001000}'模糊半径节 1',
        {0x00002000}'模糊半径节 0'
      ])),
      wbUnknown
    ]),
    wbStruct(BNAM, '模糊', [
      wbFloat('未知'),
      wbFloat('半径'),
      wbUnknown
    ]),
    wbStruct(VNAM, '复视', [
      wbFloat('未知'),
      wbFloat('强度'),
      wbUnknown
    ]),
    wbRStruct('电影效果颜色', [
      wbStruct(TNAM, '色调', [
        wbFloat('未知'),
        wbStruct('色调', [
          wbFloat('红', cpNormal, True, 255, 0),
          wbFloat('绿', cpNormal, True, 255, 0),
          wbFloat('蓝', cpNormal, True, 255, 0),
          wbFloat('Alpha', cpNormal, True, 255, 0)
        ]),
        wbUnknown
      ]),
      wbStruct(NAM3, '渐显', [
        wbFloat('未知'),
        wbStruct('渐显', [
          wbFloat('红', cpNormal, True, 255, 0),
          wbFloat('绿', cpNormal, True, 255, 0),
          wbFloat('蓝', cpNormal, True, 255, 0),
          wbFloat('Alpha', cpNormal, True, 255, 0)
        ]),
        wbUnknown
      ])
    ], []),
    wbRStruct('径向模糊', [
      wbStruct(RNAM, '', [
        wbFloat('未知'),
        wbFloat('强度'),
        wbUnknown
      ]),
      wbStruct(SNAM, '', [
        wbFloat('未知'),
        wbFloat('渐升'),
        wbUnknown
      ]),
      wbStruct(UNAM, '', [
        wbFloat('未知'),
        wbFloat('开始'),
        wbUnknown
      ]),
      wbStruct(NAM1, '', [
        wbFloat('未知'),
        wbFloat('渐降'),
        wbUnknown
      ]),
      wbStruct(NAM2, '', [
        wbFloat('未知'),
        wbFloat('结束'),
        wbUnknown
      ])
    ], []),
    wbRStruct('景深', [
      wbStruct(WNAM, '景深', [
        wbFloat('未知'),
        wbFloat('强度'),
        wbUnknown
      ]),
      wbStruct(XNAM, '景深', [
        wbFloat('未知'),
        wbFloat('距离'),
        wbUnknown
      ]),
      wbStruct(YNAM, '景深', [
        wbFloat('未知'),
        wbFloat('规模'),
        wbUnknown
      ])
    ], []),
    wbStruct(NAM4, '全屏动态模糊', [
      wbFloat('未知'),
      wbFloat('强度'),
      wbUnknown
    ]),
    wbRStruct('HDR', [
      wbStruct(_00_IAD, '眼睛适应速度', [
        wbFloat('未知'),
        wbFloat('翻倍'),
        wbUnknown
      ]),
      wbStruct(_40_IAD, '眼睛适应速度', [
        wbFloat('未知'),
        wbFloat('增加'),
        wbUnknown
      ]),
      wbStruct(_01_IAD, 'Bloom 模糊半径', [
        wbFloat('未知'),
        wbFloat('翻倍'),
        wbUnknown
      ]),
      wbStruct(_41_IAD, 'Bloom 模糊半径', [
        wbFloat('未知'),
        wbFloat('增加'),
        wbUnknown
      ]),
      wbStruct(_02_IAD, 'Bloom 临界值', [
        wbFloat('未知'),
        wbFloat('翻倍'),
        wbUnknown
      ]),
      wbStruct(_42_IAD, 'Bloom 临界值', [
        wbFloat('未知'),
        wbFloat('增加'),
        wbUnknown
      ]),
      wbStruct(_03_IAD, 'Bloom 等级', [
        wbFloat('未知'),
        wbFloat('翻倍'),
        wbUnknown
      ]),
      wbStruct(_43_IAD, 'Bloom 等级', [
        wbFloat('未知'),
        wbFloat('增加'),
        wbUnknown
      ]),
      wbStruct(_04_IAD, '目标亮度(最小)', [
        wbFloat('未知'),
        wbFloat('翻倍'),
        wbUnknown
      ]),
      wbStruct(_44_IAD, '目标亮度(最小)', [
        wbFloat('未知'),
        wbFloat('增加'),
        wbUnknown
      ]),
      wbStruct(_05_IAD, '目标亮度(最大)', [
        wbFloat('未知'),
        wbFloat('翻倍'),
        wbUnknown
      ]),
      wbStruct(_45_IAD, '目标亮度(最大)', [
        wbFloat('未知'),
        wbFloat('增加'),
        wbUnknown
      ]),
      wbStruct(_06_IAD, '太阳光比例', [
        wbFloat('未知'),
        wbFloat('翻倍'),
        wbUnknown
      ]),
      wbStruct(_46_IAD, '太阳光比例', [
        wbFloat('未知'),
        wbFloat('增加'),
        wbUnknown
      ]),
      wbStruct(_07_IAD, '天空比例', [
        wbFloat('未知'),
        wbFloat('翻倍'),
        wbUnknown
      ]),
      wbStruct(_47_IAD, '天空比例', [
        wbFloat('未知'),
        wbFloat('增加'),
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
    wbRStruct('电影效果', [
      wbStruct(_11_IAD, '饱和度', [
        wbFloat('未知'),
        wbFloat('翻倍'),
        wbUnknown
      ]),
      wbStruct(_51_IAD, '饱和度', [
        wbFloat('未知'),
        wbFloat('增加'),
        wbUnknown
      ]),
      wbStruct(_12_IAD, '亮度', [
        wbFloat('未知'),
        wbFloat('翻倍'),
        wbUnknown
      ]),
      wbStruct(_52_IAD, '亮度', [
        wbFloat('未知'),
        wbFloat('增加'),
        wbUnknown
      ]),
      wbStruct(_13_IAD, '对比度', [
        wbFloat('未知'),
        wbFloat('翻倍'),
        wbUnknown
      ]),
      wbStruct(_53_IAD, '对比度', [
        wbFloat('未知'),
        wbFloat('增加'),
        wbUnknown
      ])
    ], []),
    wbUnknown(_14_IAD),
    wbUnknown(_54_IAD)
  ]);

  wbRecord(FLST, 'FormID List', [
    wbString(EDID, '编辑器标识', 0, cpBenign, True, nil, wbFLSTEDIDAfterSet),
    wbRArrayS('表单序号', wbFormID(LNAM, '表单序号'), cpNormal, False, nil, nil, nil, wbFLSTLNAMIsSorted)
  ]);

  wbRecord(PERK, 'Perk', [
    wbEDID,
    wbVMAD,
    wbFULL,
    wbDESCReq,
    wbICON,
    wbCTDAs,
    wbStruct(DATA, '数据', [
      wbInteger('特征', itU8, wbEnum(['假', '真'])),
      wbInteger('等级', itU8),
      wbInteger('等级数', itU8),
      wbInteger('玩家可用', itU8, wbEnum(['假', '真'])),
      wbInteger('隐藏', itU8, wbEnum(['假', '真']))
    ], cpNormal, True{, nil, 4}),
    wbFormIDCK(NNAM, '下级天赋', [PERK, NULL]),

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
          wbInteger('记录点', itU8, wbEntryPointsEnum, cpNormal, True, nil{, wbPERKEntryPointAfterSet}),
          wbInteger('函数', itU8, wbEnum([
            {0} '未知 0',
            {1} '设置数值', // EPFT=1
            {2} '添加数值（加）', // EPFT=1
            {3} '添加数值（乘）', // EPFT=1
            {4} '添加范围到数值', // EPFT=2
            {5} '添加角色数值加乘', // EPFT=2
            {6} '绝对值', // no params
            {7} '负绝对值', // no params
            {8} '添加等级列表', // EPFT=3
            {9} '添加激活选项', // EPFT=4
           {10} '选择魔法', // EPFT=5
           {11} '选择文本', // EPFT=6
           {12} '设置为角色数值加乘', // EPFT=2
           {13} '倍增角色数值加乘', // EPFT=2
           {14} '倍增 1 + 角色数值加乘', // EPFT=2
           {15} '设置文本' // EPFT=7
          ])),
          wbInteger('天赋条件选项总数', itU8, nil, cpIgnore)
        ])
      ], cpNormal, True),

      wbRStructsSK('天赋条件', '天赋条件', [0], [
        wbInteger(PRKC, '运行于 (选项索引)', itS8{, wbPRKCToStr, wbPRKCToInt}),
        wbCTDAsReq
      ], [], cpNormal, False{, nil, nil, wbPERKPRKCDontShow}),

      wbRStruct('函数参数', [
        wbInteger(EPFT, '类型', itU8, wbEnum([
          {0} '无',
          {1} '浮点数',
          {2} '浮点数/角色数值,浮点数',
          {3} '等级物品',
          {4} '法术,lstring,标志',
          {5} '法术',
          {6} '字符串',
          {7} 'lstring'
        ])),
        // case(EPFT) of
        // 1: EPFD=float
        // 2: EPFD=float,float
        // 3: EPFD=LVLI
        // 4: EPFD=SPEL, EPF2=lstring, EPF3=int32 flags
        // 5: EPFD=SPEL
        // 6: EPFD=string
        // 7: EPFD=lstring
        wbLString(EPF2, '按钮文本'),
        wbStruct(EPF3, '脚本标志', [
          wbInteger('脚本标志', itU8, wbFlags([
            '立即执行',
            '替换默认'
          ])),
          wbByteArray('未知', 3)
        ]),
        wbUnion(EPFD, '数据', wbEPFDDecider, [
          {0} wbByteArray('未知'),
          {1} wbFloat('浮点数'),
          {2} wbStruct('浮点数, 浮点数', [
                wbFloat('浮点数 1'),
                wbFloat('浮点数 2')
              ]),
          {3} wbFormIDCk('等级物品', [LVLI]),
          {4} wbFormIDCk('法术', [SPEL]),
          {5} wbFormIDCk('法术', [SPEL]),
          {6} wbString('文本'),
          {7} wbLString('文本'),
          {8} wbStruct('角色数值, 浮点数', [
                wbInteger('角色数值', itU32, wbEPFDActorValueToStr, wbEPFDActorValueToInt),
                wbFloat('浮点数')
              ])
        ], cpNormal, False{, wbEPFDDontShow})
      ], [], cpNormal, False{, wbPERKPRKCDontShow}),
      wbEmpty(PRKF, '结束标记', cpIgnore, True)
    ], [])
  ]);

  wbRecord(BPTD, 'Body Part Data', [
    wbEDID,
    wbMODL,
    wbRStructsSK('身体部分', '身体部分', [2], [
      wbLString(BPTN, '部分名称', 0, cpNormal, True),
      wbString(PNAM, '姿势匹配', 0, cpNormal, False),
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
               '头部',
               '眼睛',
               'LookAt',
               'Fly Grab',
               '鞍座'
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
        {76} wbByteArray('未知', 2),
        {80} wbFloat('肢体替换规模')
      ], cpNormal, True),
      wbString(NAM1, '肢体替换模型', 0, cpNormal, True),
      wbString(NAM4, '凝血效果 - 目标骨架', 0, cpNormal, True),
      wbByteArray(NAM5, '材质文件哈希值', 0, cpNormal)
    ], [], cpNormal, True)
  ]);

  wbRecord(ADDN, 'Addon Node', [
    wbEDID,
    wbOBNDReq,
    wbMODL,
    wbInteger(DATA, '节点索引', itS32, nil, cpNormal, True),
    wbFormIDCk(SNAM, '音效', [SOUN, SNDR, NULL]),
    wbStruct(DNAM, '数据', [
      wbInteger('Master 体系系统限制', itU16),
      wbInteger('标志', itU16, wbEnum([], [
        {>>> Value Must be 1 or 3 <<<}
        1, '未知 1',    // {0x0001}'未知 0', : The Check-Box is Unchecked in the CK
        3, '始终加载' // {0x0002}'Always Loaded' : The Check-Box is Unchecked in the CK
      ]))
    ], cpNormal, True)
  ]);
end;

procedure DefineTES5h;
begin
  wbRecord(AVIF, 'Actor Value Information', [
    wbEDID,
    wbFULL,
    wbDESCReq,
    wbString(ANAM, '缩写'),
    wbUnknown(CNAM),
    wbStruct(AVSK, '技能', [
      wbFloat('技能使用加成'),
      wbFloat('技能补偿加成'),
      wbFloat('技能提升加成'),
      wbFloat('技能提升补偿')
    ]),
    wbRArray('天赋树',
      wbRStruct('节点', [
        wbFormIDCk(PNAM, '天赋', [PERK, NULL]),
        wbUnknown(FNAM),
        wbInteger(XNAM, '天赋网 X', itU32),
        wbInteger(YNAM, '天赋网 Y', itU32),
        wbFloat(HNAM, '水平方向'),
        wbFloat(VNAM, '竖直方向'),
        wbFormIDCk(SNAM, '相关联技能', [AVIF, NULL]),
        wbRArray('连接', wbInteger(CNAM, '与索引的连线', itU32)),
        wbInteger(INAM, '索引', itU32)
      ], [])
    )
  ]);

  wbRecord(CAMS, 'Camera Shot', [
    wbEDID,
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
        '目标',
        '主角'
      ])),
      {08} wbInteger('目标', itU32, wbEnum([
        '攻击者',
        '抛射物',
        '目标',
        '主角'
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
      {36} wbFloat('目标 % 与角色之间'),
      {40} wbFloat('接近目标距离')
    ], cpNormal, True, nil, 8),
    wbFormIDCk(MNAM, '图像空间变换', [IMAD])
  ]);

  wbRecord(CPTH, 'Camera Path', [
    wbEDID,
    wbCTDAs,
    wbArray(ANAM, '相关摄像机路径', wbFormIDCk('相关摄像机路径', [CPTH, NULL]), ['上一级', '上一个同级对象'], cpNormal, True),
    wbInteger(DATA, '摄像机焦距', itU8, wbEnum([], [
      0, '默认, 必须存在摄像',
      1, '禁用, 必须存在摄像',
      2, '拍摄列表, 必须存在摄像',
      128, '默认',
      129, '禁用',
      130, '拍摄列表'
    ]), cpNormal, True),
    wbRArray('摄像', wbFormIDCk(SNAM, '摄像', [CAMS]))
  ]);

  wbRecord(VTYP, 'Voice Type', [
    wbEDID,
    wbInteger(DNAM, '标志', itU8, wbFlags([
      '允许默认对话',
      '女性'
    ]), cpNormal, True)
  ]);

  wbRecord(MATT, 'Material Type', [
    wbEDID,
    wbFormIDCk(PNAM, '材料根源', [MATT, NULL]),
    wbString(MNAM, '材料名称'),
    wbStruct(CNAM, 'Havok 显示颜色', [
      wbFloat('红', cpNormal, True, 255, 0),
      wbFloat('绿', cpNormal, True, 255, 0),
      wbFloat('蓝', cpNormal, True, 255, 0)
    ]),
    wbFloat(BNAM, '浮力'),
    wbInteger(FNAM, '标志', itU32, wbFlags([
      '阶梯材料',
      '弓箭黏着'
    ], False)),
    wbFormIDCk(HNAM, 'Havok 冲击数据集', [IPDS, NULL])
  ]);

  wbRecord(IPCT, 'Impact', [
    wbEDID,
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
      wbInteger('标志', itU8, wbFlags([
        {0x01} '无贴花数据'
      ])),
      wbInteger('冲击结果', itU8, wbEnum([
         {0} '默认',
         {1} '损坏',
         {2} '反弹',
         {3} '刺穿',
         {4} '刺'
      ])),
      wbByteArray('未知', 2)
    ], cpNormal, True, nil, 4),
    wbDODT,
    wbFormIDCk(DNAM, '材质集', [TXST]),
    wbFormIDCk(ENAM, '第二材质集', [TXST]),
    wbFormIDCk(SNAM, '音效 1', [SNDR, SOUN, NULL]),
    wbFormIDCk(NAM1, '音效 2', [SNDR, SOUN, NULL]),
    wbFormIDCk(NAM2, '危险源', [HAZD, NULL])
  ]);

  wbRecord(IPDS, 'Impact Data Set', [
    wbEDID,
    wbRArrayS('数据', wbStructSK(PNAM, [0], '', [
      wbFormIDCk('材料', [MATT]),
      wbFormIDCk('冲击', [IPCT])
    ]))
  ]);

  wbRecord(ECZN, 'Encounter Zone', [
    wbEDID,
    wbStruct(DATA, '', [
      wbFormIDCkNoReach('所有者', [NPC_, FACT, NULL]),
      wbFormIDCk('位置', [LCTN, NULL]),
      wbInteger('等级', itS8),
      wbInteger('最小等级', itS8),
      wbInteger('标志', itU8, wbFlags([
        '从不重置',
        '最小等级以下匹配玩家',
        '关闭战斗界限'
      ])),
      wbInteger('最大等级', itS8)
    ], cpNormal, True, nil, 2)
  ]);

  wbRecord(LCTN, 'Location', [
    wbEDID,

    wbArray(ACPR, '角色固定衍生', wbStruct('', [
      wbFormIDCk('角色', [ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
      wbFormIDCk('位置', [WRLD, CELL]),
      wbInteger('网格X', itS16),
      wbInteger('网格Y', itS16)
    ])),
    wbArray(LCPR, '位置固定衍生', wbStruct('', [
      wbFormIDCk('角色', [ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
      wbFormIDCk('位置', [WRLD, CELL]),
      wbInteger('网格X', itS16),
      wbInteger('网格Y', itS16)
    ])),
    {>>> From Danwguard.esm, Does not follow similar previous patterns <<<}
    wbArray(RCPR, '角色固定衍生', wbFormIDCk('衍生', [ACHR, REFR])),

    wbArray(ACUN, '角色基础独立衍生', wbStruct('', [
      wbFormIDCk('角色', [NPC_]),
      wbFormIDCk('衍生', [ACHR]),
      wbFormIDCk('位置', [LCTN, NULL])
    ])),
    wbArray(LCUN, '位置独立衍生', wbStruct('', [
      wbFormIDCk('角色', [NPC_]),
      wbFormIDCk('衍生', [ACHR]),
      wbFormIDCk('位置', [LCTN, NULL])
    ])),
    {>>> Not See Yet but suspect it has same format <<<}
    wbArray(RCUN, '角色基础独立衍生', wbStruct('', [
      wbFormIDCk('角色', [NPC_]),
      wbFormIDCk('衍生', [ACHR]),
      wbFormIDCk('位置', [LCTN, NULL])
    ])),

    wbArray(ACSR, '角色基础静态衍生', wbStruct('', [
      wbFormIDCk('位置衍生类型', [LCRT]),
      wbFormIDCk('标记', [ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
      wbFormIDCk('位置', [WRLD, CELL]),
      wbInteger('网格X', itS16),
      wbInteger('网格Y', itS16)
    ])),
    wbArray(LCSR, '位置静态衍生', wbStruct('', [
      wbFormIDCk('位置衍生类型', [LCRT]),
      wbFormIDCk('标记', [ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
      wbFormIDCk('位置', [WRLD, CELL]),
      wbInteger('网格X', itS16),
      wbInteger('网格Y', itS16)
    ])),
    {>>> Seen in Open Cities <<<}
    wbArray(RCSR, '角色基础静态衍生', wbFormIDCk('衍生', [ACHR, REFR])),

    wbRArray('角色基础遭遇衍生',
      wbStruct(ACEC, '未知', [
        wbFormIDCk('位置', [WRLD, CELL]),
        wbArray('坐标', wbStruct('', [
          wbInteger('网格X', itS16),
          wbInteger('网格Y', itS16)
        ]))
      ])
    ),
    wbRArray('位置遭遇衍生',
      wbStruct(LCEC, '未知', [
        wbFormIDCk('位置', [WRLD, CELL]),
        wbArray('坐标', wbStruct('', [
          wbInteger('网格X', itS16),
          wbInteger('网格Y', itS16)
        ]))
      ])
    ),
    {>>> Seen in Open Cities <<<}
    wbRArray('角色基础遭遇衍生',
      wbStruct(RCEC, '未知', [
        wbFormIDCk('位置', [WRLD, CELL]),
        wbArray('坐标', wbStruct('', [
          wbInteger('网格X', itS16),
          wbInteger('网格Y', itS16)
        ]))
      ])
    ),

    wbArray(ACID, '角色基础标记衍生', wbFormIDCk('衍生', [ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA])),
    wbArray(LCID, '位置标记衍生', wbFormIDCk('衍生', [ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA])),

    wbArray(ACEP, '角色基础激活点', wbStruct('', [
      wbFormIDCk('角色', [ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
      wbFormIDCk('衍生', [ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
      wbInteger('网格X', itS16),
      wbInteger('网格Y', itS16)
    ])),
    wbArray(LCEP, '位置激活点', wbStruct('', [
      wbFormIDCk('角色', [ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
      wbFormIDCk('衍生', [ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
      wbInteger('网格X', itS16),
      wbInteger('网格Y', itS16)
    ])),

    wbFULL,
    wbKSIZ,
    wbKWDAs,
    wbFormIDCk(PNAM, '父系位置', [LCTN, NULL]),
    wbFormIDCk(NAM1, '音乐', [MUSC, NULL]),
    wbFormIDCk(FNAM, '不举报的犯罪派系', [FACT]),
    wbFormIDCk(MNAM, '世界位置标记衍生', [REFR, ACHR]),
    wbFloat(RNAM, '世界位置范围'),
    wbFormIDCk(NAM0, '马匹标记衍生', [REFR]),
    wbCNAM
  ]);

end;

procedure DefineTES5i;
begin
  wbRecord(MESG, 'Message', [
    wbEDID,
    wbDESCReq,
    wbFULL,
    wbFormIDCk(INAM, '图标(未使用)', [NULL], False, cpIgnore, True), // leftover
    wbFormIDCk(QNAM, '归属任务', [QUST]),
    wbInteger(DNAM, '标志', itU32, wbFlags([
      '信息框',
      '自动显示'
    ]), cpNormal, True, False, nil, wbMESGDNAMAfterSet),
    wbInteger(TNAM, '显示时长', itU32, nil, cpNormal, False, False, wbMESGTNAMDontShow),
    wbRStructs('菜单按钮', '菜单按钮', [
      wbLString(ITXT, '按钮文本'),
      wbCTDAs
    ], [])
  ], False, nil, cpNormal, False, wbMESGAfterLoad);

  wbRecord(DOBJ, 'Default Object Manager', [
    wbArray(DNAM, '对象',
      wbStruct('对象', [
        wbString('使用', 4),
        wbFormID('对象编号')
      ]), 0, nil, nil, cpNormal, True
    )
  ]);

  wbRecord(LGTM, 'Lighting Template', [
    wbEDID,
    wbStruct(DATA, '光照', [
      wbStruct('环境颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ]),
      wbStruct('指向颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ]),
      wbStruct('雾近距离颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ]),
      wbFloat('雾近距离'),
      wbFloat('雾远距离'),
      wbInteger('指向角度 XY', itS32),
      wbInteger('指向角度 Z', itS32),
      wbFloat('指向淡出'),
      wbFloat('雾裁剪距离'),
      wbFloat('雾浓度'),
      wbByteArray('未知', 32),		// WindhelmLightingTemplate [LGTM:0007BA87] only find 24 !
      wbStruct('雾远距离颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ]),
      wbFloat('雾最大值'),
      wbStruct('光源淡出范围', [
        wbFloat('开始'),
        wbFloat('结束')
      ]),
      wbByteArray('未知', 4)
    ], cpNormal, True, nil, 11),
    wbStruct(DALC, '定向环境照明颜色', [wbAmbientColors], cpNormal, True)
  ]);

  wbRecord(MUSC, 'Music Type', [
    wbEDID,
    wbInteger(FNAM, '标志', itU32, wbFlags([
      {0x01} '仅播放一项',
      {0x02} '突然过渡',
      {0x04} '循环播放',
      {0x08} '维持轨道顺序',
      {0x10} '未知 5',
      {0x20} '闪避当前轨道'
    ]), cpNormal, True),
    wbStruct(PNAM, '数据', [
      wbInteger('优先级', itU16),
      wbInteger('降音 (dB)', itU16, wbDiv(100))
    ]),
    wbFloat(WNAM, '淡出持续时间'),
    wbArray(TNAM, '音轨', wbFormIDCk('轨道', [MUST, NULL]))
  ]);

  wbRecord(FSTP, 'Footstep', [
    wbEDID,
    wbFormIDCk(DATA, '冲击数据集', [IPDS, NULL], False, cpNormal, True),
    wbString(ANAM, '标签', 0, cpNormal, True)
  ]);

  wbRecord(FSTS, 'Footstep Set', [
    wbEDID,
    wbStruct(XCNT, '数量', [
      wbInteger('向前走集', itU32),
      wbInteger('向前跑集', itU32),
      wbInteger('向前走替换集', itU32),
      wbInteger('向前跑替换集', itU32),
      wbInteger('向前走替换集2', itU32)
    ], cpNormal, True),
    wbArray(DATA, '足迹集', wbFormIDCk('足迹', [FSTP]), 0, nil, nil, cpNormal, True)
  ]);

  wbSMNodeFlags := wbFlags([
    '随机',
    '如果无子任务启动则警告'
  ]);

  wbRecord(SMBN, 'Story Manager Branch Node', [
    wbEDID,
    wbFormIDCk(PNAM, '父系 ', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCk(SNAM, '子系 ', [SMQN, SMBN, SMEN, NULL]),
    wbCITC,
    wbCTDAs,
    wbInteger(DNAM, '标志', itU32, wbSMNodeFlags),
    wbUnknown(XNAM)
  ]);

  wbRecord(SMQN, 'Story Manager Quest Node', [
    wbEDID,
    wbFormIDCk(PNAM, '父系 ', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCk(SNAM, '子系 ', [SMQN, SMBN, SMEN, NULL]),
    wbCITC,
    wbCTDAs,
    wbStruct(DNAM, '标志', [
      wbInteger('节点标志', itU16, wbSMNodeFlags),
      wbInteger('任务标志', itU16, wbFlags([
        '重复前全部执行',
        '共享事件',
        '运行任务数'
      ]))
    ]),
    wbInteger(XNAM, '最多并发任务', itU32),
    wbInteger(MNAM, '运行任务数', itU32),
    wbInteger(QNAM, '任务数量', itU32),
    wbRArray('任务', wbRStructSK([0], '任务', [
      wbFormIDCk(NNAM, '任务', [QUST]),
      wbUnknown(FNAM),
      wbFloat(RNAM, '重置等待时间', cpNormal, False, 1/24)
    ], []))
  ]);

  wbRecord(SMEN, 'Story Manager Event Node', [
    wbEDID,
    wbFormIDCk(PNAM, '父系 ', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCk(SNAM, '子系 ', [SMQN, SMBN, SMEN, NULL]),
    wbCITC,
    wbCTDAs,
    wbInteger(DNAM, '标志', itU32, wbSMNodeFlags),
    wbUnknown(XNAM),
    wbString(ENAM, '类型', 4)
  ]);
end;

procedure DefineTES5j;
begin
  wbRecord(DLBR, 'Dialog Branch', [
    wbEDID,
    wbFormIDCk(QNAM, '任务', [QUST], False, cpNormal, True),
    wbInteger(TNAM, '未知', itU32),
    wbInteger(DNAM, '标志', itU32, wbFlags([
      {0x01} '顶级',
      {0x02} '封闭',
      {0x04} '独占'
    ])),
    wbFormIDCk(SNAM, '起始主题', [DIAL], False, cpNormal, True)
  ]);

  wbRecord(MUST, 'Music Track', [
    wbEDID,
    wbInteger(CNAM, '轨道类型', itU32, wbEnum([], [
      Int64($23F678C3), '调音',
      Int64($6ED7E048), '单声道',
      Int64($A1A9C4D5), '静默声道'
    ]), cpNormal, True),
    wbFloat(FLTV, '持续时间'),
    wbFloat(DNAM, '淡出'),
    wbString(ANAM, '音轨文件名'),
    wbString(BNAM, '尾声文件名'),
    wbArray(FNAM, '录音暗点', wbFloat('暗点')),
    wbStruct(LNAM, '循环数据', [
      wbFloat('循环起始'),
      wbFloat('循环终止'),
      wbInteger('循环次数', itU32)
    ]),
    wbCITC,
    wbCTDAs,
    wbArray(SNAM, '轨道', wbFormIDCk('轨道', [MUST, NULL]))
  ]);

  wbRecord(DLVW, 'Dialog View', [
    wbEDID,
    wbFormIDCk(QNAM, '任务', [QUST], False, cpNormal, True),
    wbRArray('分支', wbFormIDCk(BNAM, '分支', [DLBR])),
    wbRArray('未知 TNAM', wbRStruct('未知', [
      wbUnknown(TNAM)
    ], [])),
    wbUnknown(ENAM),
    wbUnknown(DNAM)
  ]);

  wbRecord(WOOP, 'Word of Power', [
    wbEDID,
    wbFULL,
    wbLString(TNAM, '翻译', 0, cpNormal, True)
  ]);

  wbRecord(SHOU, 'Shout', [
    wbEDID,
    wbFULL,
    wbMDOB,
    wbDESC,
    {>>> Don't sort <<<}
    wbRArray('威能符文',
      wbStruct(SNAM, '', [
        wbFormIDCk('符文', [WOOP, NULL]),
        wbFormIDCk('法术', [SPEL, NULL]),
        wbFloat('恢复时间')
      ])
    )
  ]);

  wbRecord(EQUP, 'Equip Type', [
    wbEDID,
    wbArray(PNAM, '位置根源', wbFormID('可以装备'), 0, nil, nil, cpNormal, False),
    wbInteger(DATA, '使用所有根源', itU32, wbEnum(['假', '真']))
  ]);

  wbRecord(RELA, 'Relationship', [
    wbEDID,
    wbStruct(DATA, '数据', [
      wbFormIDCk('父系', [NPC_, NULL]),
      wbFormIDCk('子系', [NPC_, NULL]),
      wbInteger('等级', itU16, wbEnum([
        '爱人',
        '同伴',
        '知己',
        '好友',
        '熟人',
        '竞争者',
        '反对者',
        '敌人',
        '死敌'
      ])),
      wbByteArray('未知', 1),
      wbInteger('标志', itU8, wbFlags([
        {0x01} '未知 1',
        {0x02} '未知 2',
        {0x04} '未知 3',
        {0x08} '未知 4',
        {0x10} '未知 5',
        {0x20} '未知 6',
        {0x40} '未知 7',
        {0x80} '秘密'
      ])),
      wbFormIDCk('关系类型', [ASTP, NULL])
    ])
  ]);

  wbRecord(SCEN, 'Scene', [
    wbEDID,
    wbVMAD,
    wbInteger(FNAM, '标志', itU32, wbFlags([
      '任务开始时启动',
      '任务结束时停止',
      '未知 3',
      '满足条件时重复',
      '可中断的'
    ])),
    wbRArray('阶段',
      wbRStruct('阶段', [
        wbEmpty(HNAM, '标记阶段启动'),
        wbString(NAM0, '名称'),
        // CTDA before or after next
        //wbEmpty(NEXT, '标记'),
        wbRStruct('启动条件', [wbCTDAs], []),
        wbEmpty(NEXT, '标记'),
        wbRStruct('完成条件', [wbCTDAs], []),
        {>>> BEGIN leftover from earlier CK versions <<<}
        wbRStruct('未使用', [
          wbUnknown(SCHR),
          wbUnknown(SCDA),
          wbUnknown(SCTX),
          wbUnknown(QNAM),
          wbUnknown(SCRO)
        ], [], cpIgnore, false, wbNeverShow),
        wbEmpty(NEXT, '标记'),
        wbRStruct('未使用', [
          wbUnknown(SCHR),
          wbUnknown(SCDA),
          wbUnknown(SCTX),
          wbUnknown(QNAM),
          wbUnknown(SCRO)
        ], [], cpIgnore, false, wbNeverShow),
        {>>> END leftover from earlier CK versions begin <<<}
        wbInteger(WNAM, '编辑者宽度', itU32),
        wbEmpty(HNAM, '标记阶段结束')
      ], [])
    ),
    wbRArray('角色', wbRStruct('角色', [
      wbInteger(ALID, '角色序号', itU32),
      wbInteger(LNAM, '标志', itU32, wbFlags([
        '无玩家激活',
        '可选'
      ])),
      wbInteger(DNAM, '行为标志', itU32, wbFlags([
        '死亡暂停 (未使用)',
        '死亡结束',
        '战斗暂停',
        '战斗结束',
        '对话暂停',
        '对话结束',
        '观察战斗暂停',
        '观察战斗结束'
      ]))
    ], [])),
    wbRArray('操作', wbRStruct('操作', [
      wbInteger(ANAM, '类型', itU16, wbEnum([
        '对话',
        'AI包',
        '计时器'
      ])),
      wbString(NAM0, '名称'),
      wbInteger(ALID, '角色序号', itS32),
      wbUnknown(LNAM),
      wbInteger(INAM, '索引', itU32),
      wbInteger(FNAM, '标志', itU32, wbFlags([
        {0x00000001} '未知 1',
        {0x00000002} '未知 2',
        {0x00000004} '未知 3',
        {0x00000008} '未知 4',
        {0x00000010} '未知 5',
        {0x00000020} '未知 6',
        {0x00000040} '未知 7',
        {0x00000080} '未知 8',
        {0x00000100} '未知 9',
        {0x00000200} '未知 10',
        {0x00000400} '未知 11',
        {0x00000800} '未知 12',
        {0x00001000} '未知 13',
        {0x00002000} '未知 14',
        {0x00003000} '未知 15',
        {0x00004000} '面对目标',
        {0x00010000} '循环',
        {0x00020000} '头部追踪玩家'
      ])),
      wbInteger(SNAM, '启动阶段', itU32),
      wbInteger(ENAM, '结束阶段', itU32),
      wbFloat(SNAM, '计时器秒数'),
      wbRArray('AI包', wbFormIDCk(PNAM, 'AI包', [PACK])),
      wbFormIDCk(DATA, '话题', [DIAL, NULL]),
      wbInteger(HTID, '头部追踪角色序号', itS32),
      wbFloat(DMAX, '循环 - 最大'),
      wbFloat(DMIN, '循环 - 最小'),
      wbInteger(DEMO, '表情类型', itU32, wbEmotionTypeEnum),
      wbInteger(DEVA, '表情数值', itU32),
      {>>> BEGIN leftover from earlier CK versions <<<}
      wbRStruct('未使用', [
        wbUnknown(SCHR),
        wbUnknown(SCDA),
        wbUnknown(SCTX),
        wbUnknown(QNAM),
        wbUnknown(SCRO)
      ], [], cpIgnore, false, wbNeverShow),
      {>>> END leftover from earlier CK versions <<<}
      wbEmpty(ANAM, '结束标记')
    ], [])),
    {>>> BEGIN leftover from earlier CK versions <<<}
    wbRStruct('未使用', [
      wbUnknown(SCHR),
      wbUnknown(SCDA),
      wbUnknown(SCTX),
      wbUnknown(QNAM),
      wbUnknown(SCRO)
    ], [], cpIgnore, false, wbNeverShow),
    wbEmpty(NEXT, '标记'),
    wbRStruct('未使用', [
      wbUnknown(SCHR),
      wbUnknown(SCDA),
      wbUnknown(SCTX),
      wbUnknown(QNAM),
      wbUnknown(SCRO)
    ], [], cpIgnore, false, wbNeverShow),
    {>>> END leftover from earlier CK versions <<<}
    wbFormIDCk(PNAM, '任务', [QUST]),
    wbInteger(INAM, '操作数', itU32),
    wbUnknown(VNAM),
    wbCTDAs
  ]);

  wbRecord(ASTP, 'Association Type', [
    wbEDID,
    wbString(MPRT, '父亲头衔'),
    wbString(FPRT, '母亲头衔'),
    wbString(MCHT, '男孩头衔'),
    wbString(FCHT, '女孩头衔'),
    wbInteger(DATA, '标志', itU32, wbFlags([
      '相关'
    ]))
  ]);
end;

procedure DefineTES5k;
begin

  wbRecord(OTFT, 'Outfit', [
    wbEDID,
    wbArrayS(INAM, '物品', wbFormIDCk('物品', [ARMO, LVLI]))
  ]);

  wbRecord(ARTO, 'Art Object', [
    wbEDID,
    wbOBNDReq,
    wbMODL,
    wbInteger(DNAM, '视觉类型', itU32, wbEnum([
      '魔法施放',
      '魔法击中效果',
      '附魔效果'
    ]))
  ]);

  wbRecord(MATO, 'Material Object', [
    wbEDID,
    wbMODL,
    wbRArray('属性数据',
      wbByteArray(DNAM, '数据', 0, cpIgnore, False, False, wbNeverShow)
    ),
    wbStruct(DATA, '方向材料数据', [
      wbFloat('衰减比例'),
      wbFloat('衰减偏差'),
      wbFloat('噪波 UV 规模'),
      wbFloat('材料 UV 规模'),
      wbStruct('抛射矢量', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]),
      wbFloat('法线阻尼'),
      wbStruct('单通道颜色', [
        wbFloat('红', cpNormal, True, 255, 0),
        wbFloat('绿', cpNormal, True, 255, 0),
        wbFloat('蓝', cpNormal, True, 255, 0)
      ]),
      wbInteger('标志', itU32, wbFlags(['单通道']))
    ], cpNormal, True, nil, 5)
  ]);

  wbRecord(MOVT, 'Movement Type', [
    wbEDID,
    wbString(MNAM, '名称'),
    wbStruct(SPED, '默认数据', [
      wbFloat('向左走'),
      wbFloat('向左跑'),
      wbFloat('向右走'),
      wbFloat('向右跑'),
      wbFloat('向前走'),
      wbFloat('向前跑'),
      wbFloat('向后走'),
      wbFloat('向后跑'),
      wbFloat('走，定点旋转', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
      wbFloat('跑，定点旋转', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
      wbFloat('边跑边旋转', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
    ], cpNormal, True, nil, 10),
    wbStruct(INAM, '动作变化临界值', [
      wbFloat('方向', cpNormal, True, 180/Pi),
      wbFloat('移动速度'),
      wbFloat('旋转速度', cpNormal, True, 180/Pi)
    ])
  ]);

  wbRecord(SNDR, 'Sound Descriptor', [
    wbEDID,
    wbUnknown(CNAM),
    wbFormID(GNAM, '分类'),
    wbFormIDCk(SNAM, '...的替补音乐', [SNDR, NULL]),
    wbRArray('音效',
      wbRStruct('音效文件', [
        wbString(ANAM, '文件名')
      ],[])
    ),
    wbFormIDCk(ONAM, '输出模型', [SOPM, NULL]),
    wbLString(FNAM, '字符', 0, cpIgnore),
    wbCTDAs,
    wbStruct(LNAM, '音值', [
      wbByteArray('未知', 1),
      wbInteger('循环', itU8, wbEnum([], [
        $00 , '无',
        $08 , '循环',
        $10 , '速封',
        $20 , '慢封'
      ])),
      wbByteArray('未知', 1),
      wbInteger('隆隆声传送音值 = (小 / 7) + ((大 / 7) * 16)', itU8)
    ]),
    wbStruct(BNAM, '音值', [
      wbInteger('% 频移', itU8),
      wbInteger('% 频差', itU8),
      wbInteger('优先级', itU8),
      wbInteger('db 差异', itU8),
      wbInteger('静态衰减 (db)', itU16, wbdiv(100))
    ])
  ]);

  wbRecord(DUAL, 'Dual Cast Data', [
    wbEDID,
    wbOBNDReq,
    wbStruct(DATA, '数据', [
      wbFormIDCk('抛射物', [PROJ, NULL]),
      wbFormIDCk('爆炸', [EXPL, NULL]),
      wbFormIDCk('效果渲染', [EFSH, NULL]),
      wbFormIDCk('命中效果外观', [ARTO, NULL]),
      wbFormIDCk('冲击数据集', [IPDS, NULL]),
      wbInteger('继承规模', itU32, wbFlags([
        '命中效果外观',
        '抛射物',
        '爆炸'
      ]))
    ], cpNormal, True)
  ]);

  wbRecord(SNCT, 'Sound Category', [
    wbEDID,
    wbFULL,
    wbInteger(FNAM, '标志', itU32, wbFlags([
      '水中减弱',
      '显示在菜单栏'
    ]), cpNormal, True),
    wbFormIDCk(PNAM, '父系', [SNCT]),
    wbInteger(VNAM, '静态音量加成', itU16, wbDiv(65535)),
    wbInteger(UNAM, '默认菜单栏数值', itU16, wbDiv(65535))
  ]);

  wbRecord(SOPM, 'Sound Output Model', [
    wbEDID,
    wbStruct(NAM1, '数据', [
      wbInteger('标志', itU8, wbFlags([
        '随距离变弱',
        '允许震动'
      ])),
      wbByteArray('未知', 2),
      wbInteger('混响发送 %', itU8)
    ]),
    wbUnknown(FNAM), // leftover, unused
    wbInteger(MNAM, '类型', itU32, wbEnum([
      '使用 HRTF',
      '已定义扬声器输出'
    ])),
    wbUnknown(CNAM), // leftover, unused
    wbUnknown(SNAM), // leftover, unused
    wbStruct(ONAM, '输出值', [
      wbArray('声道', wbStruct('', [
        wbInteger('左声道', itU8),
        wbInteger('右声道', itU8),
        wbInteger('中央声道', itU8),
        wbInteger('低频效果', itU8),
        wbInteger('左环绕声道', itU8),
        wbInteger('右环绕声道', itU8),
        wbInteger('左后方环绕声道', itU8),
        wbInteger('右后方环绕声道', itU8)
      ]), [
        '声道 0',
        '声道 1',
        '声道 2? (未使用)'
      ])
    ]),
    wbStruct(ANAM, '衰减值', [
      wbByteArray('未知', 4),
      wbFloat('最小距离'),
      wbFloat('最大距离'),
      wbArray('曲线', wbInteger('数值', itU8), 5),
      wbByteArray('未知')
    ])
  ]);

  wbRecord(COLL, 'Collision Layer', [
    wbEDID,
    wbDESCReq,
    wbInteger(BNAM, '序号?', itU32, nil, cpNormal, True),
    wbStruct(FNAM, '调试颜色', [
      wbInteger('红', itU8),
      wbInteger('绿', itU8),
      wbInteger('蓝', itU8),
      wbInteger('未使用', itU8)
    ], cpNormal, True),
    wbInteger(GNAM, '标志', itU32, wbFlags([
      {0x00000001} '触发器',
      {0x00000002} '传感器',
      {0x00000004} 'Navmesh 障碍物'
    ]), cpNormal, True),
    wbString(MNAM, '名称', 0, cpNormal, True),
    wbInteger(INTV, '相互作用表数量', itU32, nil, cpNormal, True),
    wbArrayS(CNAM, '与……碰撞', wbFormIDCk('表单', [COLL]), 0, cpNormal, False)
  ]);

  wbRecord(CLFM, 'Color', [
    wbEDID,
    wbFULL,
    wbCNAMReq,
    wbInteger(FNAM, '玩家可用', itU32, wbEnum(['假', '真']), cpNormal, True)
  ]);
end;

procedure DefineTES5l;
begin
  wbRecord(REVB, 'Reverb Parameters', [
    wbEDID,
    wbStruct(DATA, '数据', [
      wbInteger('衰减时间 (ms)', itU16),
      wbInteger('高频参考 (Hz)', itU16),
      wbInteger('空间过滤', itS8),
      wbInteger('空间高频参考', itS8),
      wbInteger('回声', itS8),
      wbInteger('混响强度', itS8),
      wbInteger('高频衰减比例', itU8, wbDiv(100)),
      wbInteger('回声延迟 (ms)', itU8),
      wbInteger('混响延迟 (ms)', itU8),
      wbInteger('扩散 %', itU8),
      wbInteger('密度 %', itU8),
      wbInteger('未知', itU8)
    ], cpNormal, True)
  ]);

  wbRecord(GRAS, 'Grass', [
    wbEDID,
    wbOBNDReq,
    wbMODL,
    wbStruct(DATA, '', [
      wbInteger('密度', itU8),
      wbInteger('最小坡度', itU8),
      wbInteger('最大坡度', itU8),
      wbByteArray('未知', 1),
      wbInteger('距离水面的单位', itU16),
      wbByteArray('未知', 2),
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
      wbByteArray('未知', 3)
    ], cpNormal, True)
  ]);

  wbRecord(IDLE, 'Idle Animation', [
    wbEDID,
    wbCTDAs,
    wbString(DNAM, '文件'),
    wbString(ENAM, '动作事件'),
    wbArray(ANAM, '相关待机动作', wbFormIDCk('相关待机动作', [AACT, IDLE, NULL]), ['上一级', '上一个同级对象'], cpNormal, True),
    wbStruct(DATA, '数据 (未使用)', [
      wbStruct('循环时间 (皆永远为 255 )', [
        wbInteger('最小值', itU8),
        wbInteger('最大值', itU8)
      ]),
      wbInteger('标志', itU8, wbFlags([
        {0x01} '根源',
        {0x02} '顺序',
        {0x04} '无攻击',
        {0x04} '格挡'
      ], True)),
      wbInteger('动作群组分组', itU8{, wbIdleAnam}),
      wbInteger('重播延迟', itU16)
    ], cpIgnore, True)
  ]);

  wbRecord(INFO, 'Dialog response', [
    wbEDID,
    wbVMAD,
    wbUnknown(DATA),
    wbStruct(ENAM, '回复标志', [
      wbInteger('标志', itU16, wbFlags([
        {0x0001} '再见',
        {0x0002} '随机',
        {0x0004} '说一次',
        {0x0008} '未知 4',
        {0x0010} '未知 5',
        {0x0020} '随机结束',
        {0x0040} '看不到继续',
        {0x0080} '离开',
        {0x0100} '菜单栏看不到离开',
        {0x0200} '强制字幕',
        {0x0400} '问候时可以移动',
        {0x0800} '无假音文件',
        {0x1000} '需要后期处理',
        {0x2000} '音频输出覆盖',
        {0x4000} '消耗好感度',
        {0x8000} '未知 16'
      ])),
      wbInteger('重置时间', itU16, wbDiv(2730))
    ]),
    wbFormIDCk(TPIC, '话题', [DIAL]),
    wbFormIDCkNoReach(PNAM, '前一个情报', [INFO, NULL]),
    wbInteger(CNAM, '好感等级', itU8, wbEnum([
      '无',
      '小',
      '中',
      '大'
    ])),

    wbRArray('连接到', wbFormIDCk(TCLT, '回复', [DIAL, INFO, NULL])),
    wbFormID(DNAM, '回复数据'),
    wbCTDAs,

    {>>> Unordered, CTDA can appear before or after LNAM <<<}
    wbRArray('回复', wbRStruct('回复', [ // Begin Array
      wbStruct(TRDT, '回复数据', [
        wbInteger('表情类型', itU32, wbEmotionTypeEnum),
        wbInteger('表情数值', itU32),
        wbByteArray('未使用', 4),
        wbInteger('回复数', itU8),
        wbByteArray('未使用', 3),
        wbFormIDCk('音效', [SNDR, NULL]),
        wbInteger('标志', itU8, wbFlags([
          '使用表情动作'
        ])),
        wbByteArray('未使用', 3)
      ]),
      wbLString(NAM1, '回复文本', 0),
      wbString(NAM2, '脚本注释', 0),
      wbString(NAM3, '编辑', 0),
      wbFormIDCk(SNAM, '空闲动作：说话者', [IDLE]),
      wbCTDAs,
      wbFormIDCk(LNAM, '空闲动作：聆听者', [IDLE]),
      wbCTDAs
    ], [])),
    {>>> BEGIN leftover from earlier CK versions <<<}
    wbRArray('未知',
      wbRStruct('未知', [
        wbUnknown(SCHR),
        wbFormID(QNAM, '未知'),
        wbEmpty(NEXT, '标记')
      ], []), cpIgnore, false, wbNeverShow
    ),
    {>>> END leftover from earlier CK versions <<<}
    wbLString(RNAM, '提示'),
    wbFormIDCk(ANAM, '说话者', [NPC_]),
    wbFormIDCk(TWAT, '离开主题', [DIAL]),
    wbFormIDCk(ONAM, '音频输出覆盖', [SOPM])
  ], False, wbINFOAddInfo, cpNormal, False, nil{wbINFOAfterLoad});

  wbRecord(INGR, 'Ingredient', [
    wbEDID,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbKSIZ,
    wbKWDAs,
    wbMODL,
    wbICON,
    wbETYP,
    wbFormIDCk(YNAM, '音效 - 拾起', [SNDR, SOUN]),
    wbFormIDCk(ZNAM, '音效 - 丢弃', [SNDR, SOUN]),
    wbStruct(DATA, '', [
      wbInteger('价值', itS32),
      wbFloat('重量')
    ], cpNormal, True),
    wbStruct(ENIT, '效果数据', [
      wbInteger('原料价值', itS32),
      wbInteger('标志', itU32, wbFlags([
        {0x00000001} '不自动计算',
        {0x00000002} '食物',
        {0x00000004} '未知 3',
        {0x00000008} '未知 4',
        {0x00000010} '未知 5',
        {0x00000020} '未知 6',
        {0x00000040} '未知 7',
        {0x00000080} '未知 8',
        {0x00000100} '固定衍生'
      ]))
    ], cpNormal, True),
    wbEffectsReq
  ]);

  wbRecord(KEYM, 'Key', [
    wbEDID,
    wbVMAD,
    wbOBNDReq,
    wbFULLReq,
    wbMODL,
    wbICON,
    wbDEST,
    wbFormIDCk(YNAM, '音效 - 拾起', [SNDR, SOUN]),
    wbFormIDCk(ZNAM, '音效 - 丢弃', [SNDR, SOUN]),
    wbKSIZ,
    wbKWDAs,
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
            wbByteArray('未知', 1),
            wbInteger('图层', itS16)
          ])
        ], []),
        wbRStructSK([0],'Alpha 图层', [
          wbStructSK(ATXT, [1, 3], 'Alpha 图层头部', [
            wbFormIDCk('材质', [LTEX, NULL]),
            wbInteger('象限', itU8, wbQuadrantEnum),
            wbByteArray('未知', 1),
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
        wbByteArray('未知', 3)
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
            wbByteArray('未知', 1),
            wbInteger('图层', itS16)
          ])
        ], []),
        wbRStructSK([0],'Alpha 图层', [
          wbStructSK(ATXT, [1, 3], 'Alpha 图层头部', [
            wbFormIDCk('材质', [LTEX, NULL]),
            wbInteger('象限', itU8, wbQuadrantEnum),
            wbByteArray('未知', 1),
            wbInteger('图层', itS16)
          ]),
          wbArrayS(VTXT, 'Alpha 图层数据', wbStructSK([0], '场景', [
            wbInteger('方位', itU16, wbAtxtPosition),
            wbByteArray('未知', 2),
            wbFloat('透明度')
          ]))
        ], [])
      ], [])),

      wbArray(VTEX, '材质', wbFormIDCk('材质', [LTEX, NULL]))
    ]);

  end;

  wbRecord(LIGH, 'Light', [
    wbEDID,
    wbVMAD,
    wbOBNDReq,
    wbMODL,
    wbDEST,
    wbFULL,
    wbICON,
    wbStruct(DATA, '', [
      wbInteger('时间', itS32),
      wbInteger('半径', itU32),
      wbStruct('颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbInteger('未知', itU8)
      ]),
      wbInteger('标志', itU32, wbFlags([
        {0x00000001} '动态的',
        {0x00000002} '可以携带',
        {0x00000004} '背光',
        {0x00000008} '闪烁',
        {0x00000010} '未知',
        {0x00000020} '默认熄灭',
        {0x00000040} '微弱闪烁',
        {0x00000080} '跳动',
        {0x00000100} '微弱跳动',
        {0x00000200} '点光源',
        {0x00000400} '点阴影',
        {0x00000800} '半球阴影',
        {0x00001000} '全方向阴影',
        {0x00002000} '通道严格的'
      ])),
      wbFloat('衰减指数'),
      wbFloat('视场'),
      wbFloat('近距离消减'),
      wbStruct('闪烁效果', [
        wbFloat('周期', cpNormal, False, 0.01),
        wbFloat('强度振幅'),
        wbFloat('运动振幅')
      ]),
      wbInteger('数值', itU32),
      wbFloat('重量')
    ], cpNormal, True),
    wbFloat(FNAM, '渐显数值', cpNormal, True),
    wbFormIDCk(SNAM, '音效', [SNDR])
  ], False, nil, cpNormal, False, wbLIGHAfterLoad);
end;

procedure DefineTES5m;
begin

  wbRecord(LSCR, 'Load Screen', [
    wbEDID,
    wbICON,
    wbDESCReq,
    wbCTDAs,
    wbFormIDCk(NNAM, '读档画面NIF', [STAT, NULL], False, cpNormal, True),
    wbFloat(SNAM, '初始尺寸'),
    wbStruct(RNAM, '初始角度', [
      wbInteger('X', itS16),
      wbInteger('Y', itS16),
      wbInteger('Z', itS16)
    ]),
    wbStruct(ONAM, '旋转补偿限制', [
      wbInteger('最小值', itS16),
      wbInteger('最大值', itS16)
    ]),
    wbStruct(XNAM, '初始平移补偿', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ]),
    wbString(MOD2, '镜头路径', 0, cpNormal, False)
  ]);

  wbRecord(LTEX, 'Landscape Texture', [
    wbEDID,
    wbFormIDCk(TNAM, '材质集', [TXST], False, cpNormal, False),
    wbFormIDCk(MNAM, '材料类型', [MATT, NULL], False, cpNormal, True),
    wbStruct(HNAM, 'Havok 数据', [
      wbInteger('摩擦', itU8),
      wbInteger('弹力', itU8)
    ], cpNormal, True),
    wbInteger(SNAM, '纹理高光指数', itU8, nil, cpNormal, True),
    wbRArrayS('草地', wbFormIDCk(GNAM, '草地', [GRAS]))
  ]);

  wbRecord(LVLN, 'Leveled NPC', [
    wbEDID,
    wbOBNDReq,
    wbLVLD,
    wbInteger(LVLF, '标志', itU8, wbFlags([
      {0x01} '计算自所有低于玩家等级的',
      {0x02} '计算每一个物品的数量'
    ]), cpNormal, True),
    wbLLCT,
    wbRArrayS('等级列表记录',
      wbRStructExSK([0], [1], '等级列表记录', [
        wbStructExSK(LVLO , [0, 2], [3], '基础数据', [
          wbInteger('等级', itS16),
          wbByteArray('未知', 2, cpIgnore, false, wbNeverShow),
          wbFormIDCk('衍生', [NPC_, LVLN]),
          wbInteger('数量', itS16),
          wbByteArray('未知', 2, cpIgnore, false, wbNeverShow)
        ]),
				wbCOED
      ], []),
    cpNormal, True),
    wbMODL
  ]);

  wbRecord(LVLI, 'Leveled Item', [
    wbEDID,
    wbOBNDReq,
    wbLVLD,
    wbInteger(LVLF, '标志', itU8, wbFlags([
      {0x01} '计算自所有低于玩家等级的',
      {0x02} '计算每一个物品的数量',
      {0x04} '全部使用',
      {0x08} '特殊战利品'
    ]), cpNormal, True),
    wbFormIDCk(LVLG, '全局', [GLOB]),
    wbLLCT,
    wbRArrayS('等级列表记录',
      wbRStructExSK([0], [1], '等级列表记录', [
        wbStructExSK(LVLO , [0, 2], [3], '基础数据', [
          wbInteger('等级', itU16),
          wbByteArray('未知', 2, cpIgnore, false, wbNeverShow),
          wbFormIDCk('衍生', [ARMO, AMMO, APPA, MISC, WEAP, BOOK, LVLI, KEYM, ALCH, LIGH, INGR, SLGM, SCRL]),
          wbInteger('数量', itU16),
          wbByteArray('未知', 2, cpIgnore, false, wbNeverShow)
        ]),
        wbCOED
      ], [])
    )
  ]);

   wbRecord(LVSP, 'Leveled Spell', [
    wbEDID,
    wbOBNDReq,
    wbLVLD,
    wbInteger(LVLF, '标志', itU8, wbFlags([
      {0x01} '计算自所有低于玩家等级的',
      {0x02} '计算每一个物品的数量',
      {0x04} '使用所有魔法'
    ]), cpNormal, True),
    wbLLCT,
    wbRArrayS('等级列表记录',
      wbRStructSK([0], '等级列表记录', [
        wbStructExSK(LVLO , [0, 2], [3], '基础数据', [
        wbInteger('等级', itU16),
        wbByteArray('未知', 2, cpIgnore, false, wbNeverShow),
        wbFormIDCk('衍生', [SPEL, LVSP]),
        wbInteger('数量', itU16),
        wbByteArray('未知', 2, cpIgnore, false, wbNeverShow)
      ])
      ], [])
    )
  ]);

  wbMGEFType := wbInteger('原型', itU32, wbEnum([
    {00} '数值调整',
    {01} '脚本',
    {02} '驱散',
    {03} '治愈疾病',
    {04} '吸收',
    {05} '双手数值调整',
    {06} '安抚',
    {07} '挫志',
    {08} '狂暴',
    {09} '缴械',
    {10} '命令召唤物',
    {11} '隐形',
    {12} '光效',
    {13} '未知 13',
    {14} '未知 14',
    {15} '上锁',
    {16} '打开',
    {17} '召唤武器',
    {18} '召唤生物',
    {19} '生命探测',
    {20} '隔空取物',
    {21} '麻痹',
    {22} '活尸',
    {23} '吸魂',
    {24} '驱散亡灵',
    {25} '引导',
    {26} '狼人喂食',
    {27} '治愈麻痹',
    {28} '治愈上瘾',
    {29} '治愈中毒',
    {30} '震荡',
    {31} '数值和部分',
    {32} '累加大小',
    {33} '摇晃',
    {34} '天赋数值调整',
    {35} '覆盖',
    {36} '狼人',
    {37} '时间减速',
    {38} '团结',
    {39} '武器附魔',
    {40} '生成危险源',
    {41} '灵化',
    {42} '驱逐',
    {43} '生成脚本化衍生',
    {44} '伪装',
    {45} '抓取角色',
    {46} '吸血鬼伯爵'
  ]), cpNormal, False, nil, wbMGEFArchtypeAfterSet);

  wbMGEFData := wbRStruct('魔法效果数据', [
    wbStruct(DATA, '数据', [
      wbInteger('标志', itU32, wbFlags([
        {0x00000001}  '敌对的',
        {0x00000002}  '恢复',
        {0x00000004}  '有害的',
        {0x00000008}  '对齐到 Navmesh',
        {0x00000010}  '无命中事件',
				{0x00000020}  '未知 6',
				{0x00000040}  '未知 7',
				{0x00000080}  '未知 8',
				{0x00000100}  '与关键字取消关联',
				{0x00000200}  '不持续',
				{0x00000400}  '无量级',
				{0x00000800}  '无范围',
				{0x00001000}  '持续视觉特效',
				{0x00002000}  '未知 14',
				{0x00004000}  '血块外观',
				{0x00008000}  '界面不显示',
				{0x00010000}  '未知 17',
				{0x00020000}  '无法再施放',
				{0x00040000}  '未知 19',
				{0x00080000}  '未知 20',
				{0x00100000}  '未知 21',
				{0x00200000}  '重击量级',
				{0x00400000}  '重击持续',
				{0x00800000}  '未知 24',
				{0x01000000}  '未知 25',
				{0x02000000}  '未知 26',
				{0x04000000}  '不痛的',
				{0x08000000}  '无命中效果',
				{0x10000000}  '无死亡消除',
				{0x20000000}  '未知 30',
				{0x40000000}  '未知 31',
				{0x80000000}  '未知 32'
			])),
      wbFloat('基本消耗'),
      wbUnion('关联道具', wbMGEFAssocItemDecider, [
        wbFormID('未使用', cpIgnore),
        wbFormIDCk('关联道具', [LIGH, NULL]),
        wbFormIDCk('关联道具', [WEAP, ARMO, NULL]),
        wbFormIDCk('关联道具', [NPC_, NULL]),
        wbFormIDCk('关联道具', [HAZD, NULL]),
        wbFormIDCk('关联道具', [SPEL, NULL]),
        wbFormIDCk('关联道具', [RACE, NULL]),
        wbFormIDCk('关联道具', [ENCH, NULL]),
        wbFormIDCk('关联道具', [KYWD, NULL])
      ], cpNormal, False, nil, wbMGEFAssocItemAfterSet),
      wbInteger('魔法技能', itS32, wbActorValueEnum),
      wbInteger('抵抗值', itS32, wbActorValueEnum),
      wbByteArray('未知', 4),
      wbFormIDCk('施法光效', [LIGH, NULL]),
      wbFloat('减弱强度'),
      wbFormIDCk('命中渲染', [EFSH, NULL]),
      wbFormIDCk('附魔渲染', [EFSH, NULL]),
      wbInteger('最小技能等级', itU32),
      wbStruct('自制魔法', [
        wbInteger('范围', itU32),
        wbFloat('施法时长')
      ]),
      wbFloat('减弱速率'),
      wbFloat('减弱时长'),
      wbFloat('第二角色数值强度', cpNormal, False, nil, wbMGEFAV2WeightAfterSet),
      wbMGEFType,
      wbActorValue,
      wbFormIDCk('抛射物', [PROJ, NULL]),
      wbFormIDCk('爆炸', [EXPL, NULL]),
      wbInteger('施法类型', itU32, wbCastEnum),
      wbInteger('传递', itU32, wbTargetEnum),
      wbInteger('第二角色数值', itS32, wbActorValueEnum),
      wbFormIDCk('施法外观', [ARTO, NULL]),
      wbFormIDCk('命中效果外观', [ARTO, NULL]),
      wbFormIDCk('冲击数据', [IPDS, NULL]),
      wbFloat('技能消耗加成'),
      wbStruct('双手施法', [
        wbFormIDCk('外观', [DUAL, NULL]),
        wbFloat('范围')
      ]),
      wbFormIDCk('附魔外观', [ARTO, NULL]),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbFormIDCk('装备能力', [SPEL, NULL]),
      wbFormIDCk('图像空间变换', [IMAD, NULL]),
      wbFormIDCk('应用的天赋', [PERK, NULL]),
      wbInteger('施法音效等级', itU32, wbSoundLevelEnum),
      wbStruct('脚本效果AI', [
        wbFloat('点数'),
        wbFloat('延迟时间')
      ])
    ], cpNormal, True)
  ], []);

  wbRecord(MGEF, 'Magic Effect', [
    wbEDID,
    wbVMAD,
    wbFULL,
    wbMDOB,
    wbKSIZ,
    wbKWDAs,
    wbMGEFData,
    wbRArrayS('消除效果', wbFormIDCk(ESCE, '效果', [MGEF])),
    wbArray(SNDD, '音效', wbStruct('', [
      wbInteger('类型', itU32, wbEnum([
        '入鞘/拔剑',
        '充能',
        '就绪',
        '释放',
        '集中循环施放',
        '击中'
      ])),
      wbFormIDCk('音效', [SNDR])
    ])),
    wbLStringKC(DNAM, '魔法物品描述'),
    wbCTDAs
  ], False, nil, cpNormal, False, nil {wbMGEFAfterLoad});

  wbRecord(MISC, 'Misc. Item', [
    wbEDID,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbDEST,
    wbFormIDCk(YNAM, '音效 - 拾起', [SNDR, SOUN]),
    wbFormIDCk(ZNAM, '音效 - 丢弃', [SNDR, SOUN]),
    wbKSIZ,
    wbKWDAs,
    wbStruct(DATA, '数据', [
      wbInteger('价值', itS32),
      wbFloat('重量')
    ], cpNormal, True)
  ], False, nil, cpNormal, False, wbRemoveEmptyKWDA);

  wbRecord(APPA, 'Alchemical Apparatus', [
    wbEDID,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbDEST,
    wbFormIDCk(YNAM, '音效 - 拾起', [SNDR, SOUN]),
    wbFormIDCk(ZNAM, '音效 - 丢弃', [SNDR, SOUN]),
    wbInteger(QUAL, '质量', itS32, wbEnum([], [
      0, '新手',
      1, '学徒',
      2, '熟手',
      3, '专家',
      4, '大师'
    ])),
    wbDESC,
    wbStruct(DATA, '数据', [
      wbInteger('价值', itU32),
      wbFloat('重量')
    ])
  ]);

  wbRecord(COBJ, 'Constructible Object', [
    wbEDID,
    wbCOCT,
    wbCNTOs,
    wbCTDAs,
    wbFormID(CNAM, '造出的对象'),
    wbFormIDCk(BNAM, '工作台关键字', [KYWD]),
    wbInteger(NAM1, '造出的对象数量', itU16)
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
  ], [], cpNormal, True, nil{wbActorTemplateUseModelAnimation});

  wbRecord(NPC_, 'Non-Player Character (Actor)', [
    wbEDID,
    wbVMAD,
    wbOBNDReq,
    wbStruct(ACBS, '构造', [
      wbInteger('标志', itU32, wbFlags([
        {0x00000001} '女性',
        {0x00000002} '不死',
        {0x00000004} '默认脸型',
        {0x00000008} '重生',
        {0x00000010} '自动计算属性',
        {0x00000020} '独特',
        {0x00000040} '不影响潜行计',
        {0x00000080} '玩家等级加成',
        {0x00000100} '使用模版?',
        {0x00000200} '未知 9',
        {0x00000400} '未知 10',
        {0x00000800} '受保护',
        {0x00001000} '未知 12',
        {0x00002000} '未知 13',
        {0x00004000} '可召唤',
        {0x00008000} '未知 15',
        {0x00010000} '不流血',
        {0x00020000} '未知 17',
        {0x00040000} '重伤覆盖',
        {0x00080000} '异性动物',
        {0x00100000} '普通角色',
        {0x00200000} '循环脚本?',
        {0x00400000} '',
        {0x00800000} '',
        {0x01000000} '',
        {0x02000000} '',
        {0x04000000} '',
        {0x08000000} '',
        {0x10000000} '循环音效?',
        {0x20000000} '鬼魂',
        {0x40000000} '',
        {0x80000000} '无法伤害'
      ])),
      wbInteger('法力补偿', itU16, nil, cpNormal, True, nil{wbActorTemplateUseStats}),
      wbInteger('体力补偿', itU16, nil, cpNormal, False, nil{wbActorTemplateUseAIData}),
      wbUnion('等级', wbNPCLevelDecider, [
        wbInteger('等级', itS16, nil, cpNormal, True, nil{wbActorTemplateUseStats}),
        wbInteger('等级加成', itS16, wbDiv(1000), cpNormal, True, nil{wbActorTemplateUseStats})
      ], cpNormal, True, nil{wbActorTemplateUseStats}),
      wbInteger('最小等级', itU16, nil, cpNormal, True, nil{wbActorTemplateUseStats}),
      wbInteger('最大等级', itU16, nil, cpNormal, True, nil{wbActorTemplateUseStats}),
      wbInteger('速度加成', itU16, nil, cpNormal, True, nil{wbActorTemplateUseStats}),
      wbInteger('基本性格 (未使用)', itS16, nil, cpIgnore, True, nil{wbActorTemplateUseTraits}),
      wbInteger('模版标志', itU16, wbFlags([
        {0x0001} '使用特征',
        {0x0002} '使用属性',
        {0x0004} '使用派系',
        {0x0008} '使用魔法列表',
        {0x0010} '使用AI数据',
        {0x0020} '使用AI包',
        {0x0040} '使用模型/动作?',
        {0x0080} '使用基本数据',
        {0x0100} '使用物品栏',
        {0x0200} '使用脚本',
        {0x0400} '使用默认AI包列表',
        {0x0800} '使用攻击数据',
        {0x1000} '使用关键字'
      ])),
      wbInteger('生命补偿', itU16, nil, cpNormal, True, nil{wbActorTemplateUseStats}),
      wbInteger('重伤覆盖', itU16, nil, cpNormal, True, nil{wbActorTemplateUseStats})
    ], cpNormal, True),
    wbRArrayS('派系',
      wbStructSK(SNAM, [0], '派系', [
        wbFormIDCk('派系', [FACT]),
        wbInteger('等级', itU8),
        wbByteArray('未使用', 3, cpIgnore)
      ]), cpNormal, False, nil, nil, nil{wbActorTemplateUseFactions}
    ),
    wbFormIDCk(INAM, '死亡物品', [LVLI], False, cpNormal, False, nil{wbActorTemplateUseTraits}),
    wbFormIDCk(VTCK, '语音', [VTYP], False, cpNormal, False, nil{wbActorTemplateUseTraits}),
    wbFormIDCk(TPLT, '模版', [LVLN, NPC_]),
    wbFormIDCk(RNAM, '种族', [RACE], False, cpNormal, True, nil{wbActorTemplateUseTraits}),
    wbSPCT,
    wbSPLOs,
    wbDEST,
    wbFormIDCk(WNAM, '装备盔甲', [ARMO], False, cpNormal, False),
    wbFormIDCk(ANAM, '远离模型', [ARMO], False, cpNormal, False, nil{wbActorTemplateUseTraits}),
    wbFormIDCk(ATKR, '攻击种族', [RACE], False, cpNormal, False),
    wbRArrayS('攻击', wbAttackData),
    wbFormIDCk(SPOR, '旁观时覆盖AI包', [FLST], False, cpNormal, False),
    wbFormIDCk(OCOR, '观察尸体时覆盖AI包', [FLST], False, cpNormal, False),
    wbFormIDCk(GWOR, '守卫警告时覆盖AI包', [FLST], False, cpNormal, False),
    wbFormIDCk(ECOR, '战斗时覆盖AI包', [FLST], False, cpNormal, False),
    wbInteger(PRKZ, '天赋数量', itU32),
    wbRArrayS('天赋',
      wbStructSK(PRKR, [0], '天赋', [
        wbFormIDCk('天赋', [PERK]),
        wbInteger('等级', itU8),
        wbByteArray('未使用', 3, cpIgnore)
      ])
    ),
    wbCOCT,
    wbCNTOs,
    wbAIDT,
    wbRArray('AI包', wbFormIDCk(PKID, 'AI包', [PACK]), cpNormal, False, nil{wbActorTemplateUseAIPackages}),
    wbKSIZ,
    wbKWDAs,
    wbFormIDCk(CNAM, '职业', [CLAS], False, cpNormal, True),
    wbFULL,
    wbLString(SHRT, '简称'),
    wbByteArray(DATA, '标记'),
    wbStruct(DNAM, '玩家技能', [
      wbArray('技能值', wbInteger('技能', itU8), [
        '单手',
        '双手',
        '箭术',
        '格挡',
        '锻造',
        '重甲',
        '轻甲',
        '扒窃',
        '开锁',
        '潜行',
        '炼金',
        '口才',
        '改变系',
        '召唤系',
        '毁灭系',
        '幻术系',
        '恢复系',
        '附魔'
      ]),
      wbArray('技能补偿', wbInteger('技能', itU8), [
        '单手',
        '双手',
        '箭术',
        '格挡',
        '锻造',
        '重甲',
        '轻甲',
        '扒窃',
        '开锁',
        '潜行',
        '炼金',
        '口才',
        '改变系',
        '召唤系',
        '毁灭系',
        '幻术系',
        '恢复系',
        '附魔'
      ]),
      //wbByteArray('未知', 4),
      wbInteger('生命', itU16),
      wbInteger('法力', itU16),
      wbInteger('体力', itU16),
      wbByteArray('未知', 2, cpIgnore),
      wbFloat('远离模型距离'),
      wbInteger('装备武器', itU8),
      wbByteArray('未使用', 3, cpIgnore)
    ], cpNormal, False, nil{wbActorTemplateUseStatsAutoCalc}),
    wbRArrayS('头部部分', wbFormIDCk(PNAM, '头部部分', [HDPT]), cpNormal, False, nil, nil, nil{wbActorTemplateUseModelAnimation}),
    wbFormIDCk(HCLF, '头发颜色', [CLFM], False, cpNormal, False),
    wbFormIDCk(ZNAM, '战斗风格', [CSTY], False, cpNormal, False),
    wbFormIDCk(GNAM, '礼物过滤', [FLST], False, cpNormal, False),
    wbUnknown(NAM5, cpNormal, True),
    wbFloat(NAM6, '身高', cpNormal, True),
    wbFloat(NAM7, '重量', cpNormal, True),
    wbInteger(NAM8, '音量级别', itU32, wbSoundLevelEnum, cpNormal, True),
    wbCSDTs,
    // When CSCR exists CSDT, CSDI, CSDC are not present
    wbFormIDCk(CSCR, '声音继承来源', [NPC_], False, cpNormal, False),
    wbFormIDCk(DOFT, '日常穿着', [OTFT], False, cpNormal, False),
    wbFormIDCk(SOFT, '睡觉穿着', [OTFT], False, cpNormal, False),
    wbFormIDCk(DPLT, '默认AI包列表', [FLST], False, cpNormal, False),
    wbFormIDCk(CRIF, '犯罪派系', [FACT], False, cpNormal, False),
    wbFormIDCk(FTST, '头部材质', [TXST], False, cpNormal, False),
    wbStruct(QNAM, '材质光效', [
      wbFloat('红'),
      wbFloat('绿'),
      wbFloat('蓝')
    ]),
    wbStruct(NAM9, '面部外形', [
      wbFloat('鼻子长/短'),
      wbFloat('鼻子上/下'),
      wbFloat('下颌上/下'),
      wbFloat('下颌窄/宽'),
      wbFloat('下颌前/后'),
      wbFloat('面颊上/下'),
      wbFloat('面颊前/后'),
      wbFloat('眼睛上/下'),
      wbFloat('眼睛内/外'),
      wbFloat('眉毛上/下'),
      wbFloat('眉毛内/外'),
      wbFloat('眉毛前/后'),
      wbFloat('嘴唇上/下'),
      wbFloat('嘴唇内/外'),
      wbFloat('下巴窄/宽'),
      wbFloat('下巴上/下'),
      wbFloat('下/上颌前突'),
      wbFloat('眼睛前/后'),
      wbFloat('未知')
    ], cpNormal, False),
    wbStruct(NAMA, '脸部部分', [
      wbInteger('鼻子', itU32),
      wbInteger('未知', itS32),
      wbInteger('眼睛', itU32),
      wbInteger('嘴巴', itU32)
    ]),
    wbRArrayS('色层',
      wbRStructSK([0], '图层', [
        wbInteger(TINI, '色调索引', itU16),
        wbStruct(TINC, '色调颜色', [
          wbInteger('红', itU8),
          wbInteger('绿', itU8),
          wbInteger('蓝', itU8),
          wbInteger('Alpha', itU8)
        ]),
        wbInteger(TINV, '插值强度', itU32, wbDiv(100)),
        wbInteger(TIAS, '最佳设置', itS16)
      ], []))
  ], False, nil, cpNormal, False, wbNPCAfterLoad);

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
    '角色: 任意'
  ]);

  wbPKDTSpecificFlagsUnused := False;

  wbPKDTFlags := wbFlags([
    {0x00000001} '提供服务',
    {0x00000002} '未知 2',
    {0x00000004} '必须完成',
    {0x00000008} '接近目标时不改变速度',
    {0x00000010} '未知 5',
    {0x00000020} '未知 6',
    {0x00000040} '开始时开门',
    {0x00000080} '结束时开门',
    {0x00000100} '未知 9',
    {0x00000200} '玩家接近时继续',
    {0x00000400} '每天一次',
    {0x00000800} '未知 12',
    {0x00001000} '未知 13',
    {0x00002000} '优先速度',
    {0x00004000} '未知 15',
    {0x00008000} '未知 16',
    {0x00010000} '未知 17',
    {0x00020000} '始终潜行',
    {0x00040000} '始终游泳',
    {0x00080000} '未知 20',
    {0x00100000} '忽略战斗',
    {0x00200000} '武器不装备',
    {0x00400000} '未知 23',
    {0x00800000} '拔出武器',
    {0x01000000} '未知 25',
    {0x02000000} '未知 26',
    {0x04000000} '未知 27',
    {0x08000000} '无战斗警备',
    {0x10000000} '未知 29',
    {0x20000000} '使用睡觉穿着 (未使用)',
    {0x40000000} '未知 31',
    {0x80000000} '未知 32'
  ]);

  wbPKDTInterruptFlags := wbFlags([
    {0x0001}'向玩家问好',
    {0x0002}'随机对话',
    {0x0004}'观战',
    {0x0008}'向死者致敬',
    {0x0010}'对玩家动作有反应',
    {0x0020}'友谊之火评论',
    {0x0040}'感应半径',
    {0x0080}'允许空闲唠叨',
    {0x0100}'未知 9',
    {0x0200}'世界互动',
    {0x0400}'未知 11',
    {0x0800}'未知 12',
    {0x1000}'未知 13',
    {0x2000}'未知 14',
    {0x4000}'未知 15',
    {0x8000}'未知 16'
  ]);
end;

procedure DefineTES5n;
begin

  wbUNAMs:= wbRArray('数据输入', wbRStruct('数据输入', [
    wbInteger(UNAM, '索引', itS8),
    wbString(BNAM, '名称'),
    wbInteger(PNAM, '标志', itU32, wbFlags([
      '共用'
    ]))
  ], []));

  wbRecord(PACK, 'Package', [
    wbEDID,
    wbVMAD,

    wbStruct(PKDT, 'AI包数据', [
      wbInteger('一般标志', itU32, wbPKDTFlags),
      wbInteger('类型', itU8, wbEnum ([], [
        18, 'AI包',
        19, '模版包'
      ])),
      wbInteger('打断覆盖', itU8, wbEnum([
        '无',
        '旁观者',
        '观察死物',
        '警卫警告',
        '战斗'
      ])),
      wbInteger('优先速度', itU8, wbEnum([
        '步行',
        '慢跑',
        '跑步',
        '快速移动'
      ])),
      wbByteArray('未知', 1),
      wbInteger('中断标志', itU16, wbPKDTInterruptFlags),
      wbByteArray('未知', 2)
    ], cpNormal, True),

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
      wbInteger('时', itS8),
      wbInteger('分', itS8),
      wbByteArray('未使用', 3, cpIgnore),
      wbInteger('持续时间 (分钟)', itS32)
    ], cpNormal, True),
    wbCTDAs,

    wbRStruct('待机动作', [
      wbInteger(IDLF, '标志', itU8, wbEnum([], [
         0, '未知',
         8, '随机',
         9, '按顺序运行',
        12, '随机, 运行一次',
        13, '按顺序运行, 运行一次'
      ]), cpNormal, True),
      wbStruct(IDLC, '', [
        wbInteger( '动作数量', itU8),
        wbByteArray('未知', 3)
      ], cpNormal, True, nil, 1),
      wbFloat(IDLT, '动作计时器设定', cpNormal, True),
      wbArray(IDLA, '动作', wbFormIDCk('动作', [IDLE]), 0, nil, nil, cpNormal, True),
      wbByteArray(IDLB, '未知', 4, cpIgnore)
    ], []),

    wbFormIDCk(CNAM, '战斗风格', [CSTY]),
    wbFormIDCk(QNAM, '归属任务', [QUST]),
    wbStruct(PKCU, '计数器', [
      wbInteger('数据输入计数', itU32),
      wbFormIDCk('AI包模版', [PACK, NULL]),
      wbInteger('版本计数器 (自动增加)', itU32)
    ], cpNormal, True),

    wbRStruct('AI包数据', [
      wbRArray('数据输入值', wbRStruct('数值', [
        wbString(ANAM, '类型'),
        wbUnion(CNAM, '数值', wbPubPackCNAMDecider, [
          {0} wbByteArray('未知'),
          {1} wbInteger('布尔值', itU8, wbEnum(['假', '真'])),
          {2} wbInteger('整数', itU32),
          {3} wbFloat('浮点数')
        ]),
        wbUnknown(BNAM),
        wbPDTOs,
        wbPLDT,
        wbStruct(PTDA, '目标', [wbTargetData]),
        wbUnknown(TPIC)
      ], [], cpNormal, False)),
      wbUNAMs
    ], []),
    wbByteArray(XNAM, '标记'),

    wbRStruct('进程树', [
      wbRArray('分支', wbRStruct('分支', [
        wbString(ANAM, '分支类型'),
        wbInteger(CITC, '条件数', itU32),
        wbCTDAs,
        wbStruct(PRCB, '根', [
          wbInteger('分支数', itU32),
          wbInteger('标志', itU32, wbFlags([
            '完成时重复',
            '未知 1'
          ]))
        ]),
        wbString(PNAM, '进程类型'),
        wbInteger(FNAM, '标志', itU32, wbFlags(['成功完成AI包'])),
        wbRArray('数据输入索引', wbInteger(PKC2, '索引', itU8)),
        {>>> PFO2 should be single, there is only 1 PACK [00095F46] <PatrolAndHunt> in Skyrim.esm with 2xPFO2 <<<}
        wbRArray('标志覆盖',
          wbStruct(PFO2, '数据', [
            wbInteger('设置常规标志', itU32, wbPKDTFlags),
            wbInteger('清除常规标志', itU32, wbPKDTFlags),
            wbInteger('设置中断标志', itU16, wbPKDTInterruptFlags),
            wbInteger('清除中断标志', itU16, wbPKDTInterruptFlags),
            wbInteger('优先速度覆盖', itU8, wbEnum([
              '步行',
              '慢跑',
              '跑步',
              '快速移动'
            ])),
            wbByteArray('未知', 3)
          ])
        ),
        wbRArray('未知', wbUnknown(PFOR), cpIgnore)
      ], [], cpNormal, False))
    ], []),
    wbUNAMs,
    wbRStruct('开始', [
      wbEmpty(POBA, '开始标记', cpNormal, True),
      wbFormIDCk(INAM, '空闲动作', [IDLE, NULL], False, cpNormal, True),
      {>>> BEGIN leftover from earlier CK versions <<<}
      wbByteArray(SCHR, '未使用', 0, cpIgnore, false, false, wbNeverShow),
      wbByteArray(SCTX, '未使用', 0, cpIgnore, false, false, wbNeverShow),
      wbByteArray(QNAM, '未使用', 0, cpIgnore, false, false, wbNeverShow),
      wbByteArray(TNAM, '未使用', 0, cpIgnore, false, false, wbNeverShow),
      {>>> END leftover from earlier CK versions <<<}
      wbPDTOs
    ], []),
    wbRStruct('结束', [
      wbEmpty(POEA, '结束标记', cpNormal, True),
      wbFormIDCk(INAM, '空闲动作', [IDLE, NULL], False, cpNormal, True),
      {>>> BEGIN leftover from earlier CK versions <<<}
      wbByteArray(SCHR, '未使用', 0, cpIgnore, false, false, wbNeverShow),
      wbByteArray(SCTX, '未使用', 0, cpIgnore, false, false, wbNeverShow),
      wbByteArray(QNAM, '未使用', 0, cpIgnore, false, false, wbNeverShow),
      wbByteArray(TNAM, '未使用', 0, cpIgnore, false, false, wbNeverShow),
      {>>> END leftover from earlier CK versions <<<}
      wbPDTOs
    ], []),
    wbRStruct('改变', [
      wbEmpty(POCA, '改变标记', cpNormal, True),
      wbFormIDCk(INAM, '空闲动作', [IDLE, NULL], False, cpNormal, True),
      {>>> BEGIN leftover from earlier CK versions <<<}
      wbByteArray(SCHR, '未使用', 0, cpIgnore, false, false, wbNeverShow),
      wbByteArray(SCDA, '未使用', 0, cpIgnore, false, false, wbNeverShow),
      wbByteArray(SCTX, '未使用', 0, cpIgnore, false, false, wbNeverShow),
      wbByteArray(QNAM, '未使用', 0, cpIgnore, false, false, wbNeverShow),
      wbByteArray(TNAM, '未使用', 0, cpIgnore, false, false, wbNeverShow),
      {>>> END leftover from earlier CK versions <<<}
      wbPDTOs
    ], [])
  ], False, nil, cpNormal, False, nil {wbPACKAfterLoad});

  wbQUSTAliasFlags :=
    wbStruct(FNAM, '别名标志', [
      wbInteger('标志', itU16, wbFlags([
        {0x0001}'保留位置/衍生',
        {0x0002}'可选',
        {0x0004}'任务对象',
        {0x0008}'允许任务中重复使用',
        {0x0010}'允许已死亡',
        {0x0020}'匹配衍生 - 在加载的区域',
        {0x0040}'不死',
        {0x0080}'允许已禁止',
        {0x0100}'存储文本',
        {0x0200}'允许保留',
        {0x0400}'受保护',
        {0x0800}'被别名强制?',
        {0x1000}'允许已毁坏',
        {0x2000}'匹配衍生 - 最近的',
        {0x4000}'使用存储的文本',
        {0x8000}'初始禁用'
      ])),
      wbInteger('额外标志', itU16, wbFlags([
        {0x0001}'允许已清除',
        {0x0002}'被移除时清除名字'
      ]))
    ], cpNormal, False, nil, 1);

  wbRecord(QUST, 'Quest', [
    wbEDID,
    wbVMAD,
    wbFULL,
    wbStruct(DNAM, '常规', [
      wbInteger('标志', itU16, wbFlags([
        {0x0001} '游戏启动时开始',
        {0x0002} '未知 2',
        {0x0004} '未知 3',
        {0x0008} '允许重复的阶段',
        {0x0010} '未知 5',
        {0x0020} '未知 6',
        {0x0040} '未知 7',
        {0x0080} '未知 8',
        {0x0100} '执行一次',
        {0x0200} '拒绝导出对话',
        {0x0400} '别名填充失败时警告',
        {0x0800} '未知 12',
        {0x1000} '未知 13'
      ])),
      wbInteger('优先级', itU8),
      wbInteger('表单版本', itU8, nil, cpIgnore),
      wbByteArray('未知', 4),
      wbInteger('类型', itU32, wbEnum([
        {0} '无',
        {1} '主线任务',
        {2} '法师工会',
        {3} '盗贼工会',
        {4} '黑暗兄弟会',
        {5} '同伴任务',
        {6} '杂项',
        {7} '魔神',
        {8} '支线任务',
        {9} '内战',
       {10} 'DLC01 - 吸血鬼',
       {11} 'DLC02?'
      ]))
    ]),
    wbString(ENAM, '事件', 4),
    wbRArray('文本显示全局变量', wbFormIDCk(QTGL, '全局', [GLOB])),
    wbString(FLTR, '对象窗口过滤器', 0, cpTranslate),
    wbRStruct('任务对话条件', [wbCTDAs], [], cpNormal, False),
    wbEmpty(NEXT, '标记'),
    wbCTDAs, {>>> Unknown, doesn't show up in CK <<<}
    wbRArrayS('阶段', wbRStructSK([0], '阶段', [
      wbStructSK(INDX, [0], '阶段索引', [
        wbInteger('阶段索引', itU16),
        wbInteger('标志', itU8, wbFlags([
          {0x01} '未知 1',
          {0x02} '启动阶段',
          {0x04} '结束阶段',
          {0x08} '从此保存实例数据'
        ])),
        wbInteger('未知', itU8)
      ]),
      wbRArray('日志记录', wbRStruct('日志记录', [
        wbInteger(QSDT, '阶段标志', itU8, wbFlags([
          {0x01} '完成任务',
          {0x02} '任务失败'
        ])),
        wbCTDAs,
        wbLString(CNAM, '日志记录', 0, cpTranslate),
        wbFormIDCk(NAM0, '下一个任务', [QUST]),
        {>>> BEGIN leftover from earlier CK versions <<<}
        wbByteArray(SCHR, '未使用', 0, cpIgnore, false, false, wbNeverShow),
        wbByteArray(SCTX, '未使用', 0, cpIgnore, false, false, wbNeverShow),
        wbByteArray(QNAM, '未使用', 0, cpIgnore, false, false, wbNeverShow)
        {>>> END leftover from earlier CK versions <<<}
      ], []))
    ], [])),
    wbRArray('目标', wbRStruct('目标', [
      wbInteger(QOBJ, '目标索引', itU16),
      wbInteger(FNAM, '标志', itU32, wbFlags(['与上一个“或”'])),
      wbLString(NNAM, '显示文本', 0, cpNormal, True),
      wbRArray('目标', wbRStruct('目标', [
        wbStruct(QSTA, '目标', [
          wbInteger('别名', itU32),
          wbInteger('标志', itU8, wbFlags([
            {0x01} '指南标记忽略锁定'
          ])),
          wbByteArray('未使用', 3)
        ]),
        wbCTDAs
      ], []))
    ], [])),
    wbByteArray(ANAM, '别名标记', 4),
    wbRArray('别名',
      wbRUnion('别名', [

        // Reference Alias
        wbRStruct('别名', [
          wbInteger(ALST, '衍生别名序号', itU32),
          wbString(ALID, '别名名称'),
          wbQUSTAliasFlags,
          wbInteger(ALFI, '满了后强制为别名', itU32),
          wbFormIDCk(ALFL, '特定位置', [LCTN]),
          wbFormID(ALFR, '强制的衍生'),
          wbFormIDCk(ALUA, '独特角色', [NPC_]),
          wbRStruct('位置别名衍生', [
            wbInteger(ALFA, '别名', itU32),
            wbFormIDCk(KNAM, '关键字', [KYWD]),
            wbFormIDCk(ALRT, '衍生类型', [LCRT])
          ], []),
          wbRStruct('外部别名衍生', [
            wbFormIDCk(ALEQ, '任务', [QUST]),
            wbInteger(ALEA, '别名', itU32)
          ], []),
          wbRStruct('创建衍生到对象', [
            wbFormID(ALCO, '对象'),
            wbStruct(ALCA, '别名', [
              wbInteger('别名', itU16),
              wbInteger('创建', itU16, wbEnum([] ,[
                $0000, '在',
                $8000, '在内部'
              ]))
            ]),
            wbInteger(ALCL, '等级', itU32, wbEnum([
              '简单',
              '中等',
              '困难',
              '非常困难',
              '无'
            ]))
          ], []),
          wbRStruct('在别名附近查找匹配的衍生', [
            wbInteger(ALNA, '接近别名', itU32),
            wbInteger(ALNT, '接近类型', itU32, wbEnum([
              '连接的衍生子对象'
            ]))
          ], []),
          wbRStruct('从时间查找匹配的衍生', [
            wbString(ALFE, '从事件', 4),
            wbByteArray(ALFD, '事件数据')
          ], []),
          wbCTDAs,
          wbKSIZ,
          wbKWDAs,
          wbInteger(COCT, '数量', itU32),
          wbCNTOs,
          wbFormIDCk(SPOR, '旁观时覆盖AI包', [FLST], False, cpNormal, False),
          wbFormIDCk(OCOR, '观察尸体时覆盖AI包', [FLST], False, cpNormal, False),
          wbFormIDCk(GWOR, '守卫警告时覆盖AI包', [FLST], False, cpNormal, False),
          wbFormIDCk(ECOR, '战斗时覆盖AI包', [FLST], False, cpNormal, False),
          wbFormIDCk(ALDN, '显示名称', [MESG]),
          wbRArray('别名法术', wbFormIDCk(ALSP, '法术', [SPEL])),
          wbRArray('别名派系', wbFormIDCk(ALFC, '派系', [FACT])),
          wbRArray('别名AI包数据', wbFormIDCk(ALPC, 'AI包', [PACK])),
          wbFormIDCk(VTCK, '语音', [NPC_, FLST, NULL]),
          wbEmpty(ALED, '别名结束', cpNormal, True)
        ], []),

        // Location Alias
        wbRStruct('别名', [
          wbInteger(ALLS, '位置别名序号', itU32),
          wbString(ALID, '别名名称'),
          wbQUSTAliasFlags,
          wbInteger(ALFI, '满了后强制为别名', itU32),
          wbFormIDCk(ALFL, '特定位置', [LCTN]),
          wbFormID(ALFR, '强制的衍生'),
          wbFormIDCk(ALUA, '独特角色', [NPC_]),
          wbRStruct('位置别名衍生', [
            wbInteger(ALFA, '别名', itU32),
            wbFormIDCk(KNAM, '关键字', [KYWD]),
            wbFormIDCk(ALRT, '衍生类型', [LCRT])
          ], []),
          wbRStruct('外部别名衍生', [
            wbFormIDCk(ALEQ, '任务', [QUST]),
            wbInteger(ALEA, '别名', itU32)
          ], []),
          wbRStruct('创建衍生到对象', [
            wbFormID(ALCO, '对象'),
            wbStruct(ALCA, '别名', [
              wbInteger('别名', itU16),
              wbInteger('创建', itU16, wbEnum([] ,[
                $0000, '在',
                $8000, '在内部'
              ]))
            ]),
            wbInteger(ALCL, '等级', itU32, wbEnum([
              '简单',
              '中等',
              '困难',
              '非常困难',
              '无'
            ]))
          ], []),
          wbRStruct('在别名附近查找匹配的衍生', [
            wbInteger(ALNA, '接近别名', itU32),
            wbInteger(ALNT, '接近类型', itU32, wbEnum([
              '连接的衍生子对象'
            ]))
          ], []),
          wbRStruct('从时间查找匹配的衍生', [
            wbString(ALFE, '从事件', 4),
            wbByteArray(ALFD, '事件数据')
          ], []),
          wbCTDAs,
          wbKSIZ,
          wbKWDAs,
          wbInteger(COCT, '数量', itU32),
          wbCNTOs,
          wbFormIDCk(SPOR, '旁观时覆盖AI包', [FLST], False, cpNormal, False),
          wbFormIDCk(OCOR, '观察尸体时覆盖AI包', [FLST], False, cpNormal, False),
          wbFormIDCk(GWOR, '守卫警告时覆盖AI包', [FLST], False, cpNormal, False),
          wbFormIDCk(ECOR, '战斗时覆盖AI包', [FLST], False, cpNormal, False),
          wbFormIDCk(ALDN, '显示名称', [MESG]),
          wbRArray('别名法术', wbFormIDCk(ALSP, '法术', [SPEL])),
          wbRArray('别名派系', wbFormIDCk(ALFC, '派系', [FACT])),
          wbRArray('别名AI包数据', wbFormIDCk(ALPC, 'AI包', [PACK])),
          wbFormIDCk(VTCK, '语音', [NPC_, FLST, NULL]),
          wbEmpty(ALED, '别名结束', cpNormal, True)
        ], [])
      ], [])
    ),
    wbString(NNAM, '描述', 0, cpNormal, False),
    wbRArray('目标', wbRStruct('目标', [
      wbStruct(QSTA, '目标', [
        wbFormIDCkNoReach('目标', [ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA], True),
        wbInteger('标志', itU8, wbFlags([
          {0x01} '指南标记忽略锁定'
        ])),
        wbByteArray('未知', 3)
      ]),
      wbCTDAs
    ], []))
  ]);

  wbBodyPartIndexEnum := wbEnum([
    '身体材质'
  ]);

  wbNoseMorphFlags := wbInteger('鼻子变型标志', itU32, wbFlags([
    {0x00000001}'鼻子类型0',
    {0x00000002}'鼻子类型1',
    {0x00000004}'鼻子类型2',
    {0x00000008}'鼻子类型3',
    {0x00000010}'鼻子类型4',
    {0x00000020}'鼻子类型5',
    {0x00000040}'鼻子类型6',
    {0x00000080}'鼻子类型7',
    {0x00000100}'鼻子类型8',
    {0x00000200}'鼻子类型9',
    {0x00000400}'鼻子类型10',
    {0x00000800}'鼻子类型11',
    {0x00001000}'鼻子类型12',
    {0x00002000}'鼻子类型13',
    {0x00004000}'鼻子类型14',
    {0x00008000}'鼻子类型15',
    {0x00010000}'鼻子类型16',
    {0x00020000}'鼻子类型17',
    {0x00040000}'鼻子类型18',
    {0x00080000}'鼻子类型19',
    {0x00100000}'鼻子类型20',
    {0x00200000}'鼻子类型21',
    {0x00400000}'鼻子类型22',
    {0x00800000}'鼻子类型23',
    {0x01000000}'鼻子类型24',
    {0x02000000}'鼻子类型25',
    {0x04000000}'鼻子类型26',
    {0x08000000}'鼻子类型27',
    {0x10000000}'鼻子类型28',
    {0x20000000}'鼻子类型29',
    {0x40000000}'鼻子类型30',
    {0x80000000}'鼻子类型31'
  ]));

  wbBrowMorphFlags := wbInteger('眉毛变型标志', itU32, wbFlags([
    {0x00000001}'眉毛类型0',
    {0x00000002}'眉毛类型1',
    {0x00000004}'眉毛类型2',
    {0x00000008}'眉毛类型3',
    {0x00000010}'眉毛类型4',
    {0x00000020}'眉毛类型5',
    {0x00000040}'眉毛类型6',
    {0x00000080}'眉毛类型7',
    {0x00000100}'眉毛类型8',
    {0x00000200}'眉毛类型9',
    {0x00000400}'眉毛类型10',
    {0x00000800}'眉毛类型11',
    {0x00001000}'眉毛类型12',
    {0x00002000}'眉毛类型13',
    {0x00004000}'眉毛类型14',
    {0x00008000}'眉毛类型15',
    {0x00010000}'眉毛类型16',
    {0x00020000}'眉毛类型17',
    {0x00040000}'眉毛类型18',
    {0x00080000}'眉毛类型19',
    {0x00100000}'眉毛类型20'
  ], True));

  wbEyesMorphFlags01 := wbInteger('眼睛变型标志 1', itU32, wbFlags([
    {0x00000001}'眼睛类型0',
    {0x00000002}'眼睛类型1',
    {0x00000004}'眼睛类型2',
    {0x00000008}'眼睛类型3',
    {0x00000010}'眼睛类型4',
    {0x00000020}'眼睛类型5',
    {0x00000040}'眼睛类型6',
    {0x00000080}'眼睛类型7',
    {0x00000100}'眼睛类型8',
    {0x00000200}'眼睛类型9',
    {0x00000400}'眼睛类型10',
    {0x00000800}'眼睛类型11',
    {0x00001000}'眼睛类型12',
    {0x00002000}'眼睛类型13',
    {0x00004000}'眼睛类型14',
    {0x00008000}'眼睛类型15',
    {0x00010000}'眼睛类型16',
    {0x00020000}'眼睛类型17',
    {0x00040000}'眼睛类型18',
    {0x00080000}'眼睛类型19',
    {0x00100000}'眼睛类型20',
    {0x00200000}'眼睛类型21',
    {0x00400000}'眼睛类型22',
    {0x00800000}'眼睛类型23',
    {0x01000000}'眼睛类型24',
    {0x02000000}'眼睛类型25',
    {0x04000000}'眼睛类型26',
    {0x08000000}'眼睛类型27',
    {0x10000000}'眼睛类型28',
    {0x20000000}'眼睛类型29',
    {0x40000000}'眼睛类型30',
    {0x80000000}'眼睛类型31'
  ]));

  wbEyesMorphFlags02 := wbInteger('眼睛变型标志 2', itU8, wbFlags([
    {0x00000001}'眼睛类型32',
    {0x00000002}'眼睛类型33',
    {0x00000004}'眼睛类型34',
    {0x00000008}'眼睛类型35',
    {0x00000010}'眼睛类型36',
    {0x00000020}'眼睛类型37',
    {0x00000040}'眼睛类型38'
  ], True));

  wbLipMorphFlags := wbInteger('嘴唇变型标志', itU32, wbFlags([
    {0x00000001}'嘴唇类型0',
    {0x00000002}'嘴唇类型1',
    {0x00000004}'嘴唇类型2',
    {0x00000008}'嘴唇类型3',
    {0x00000010}'嘴唇类型4',
    {0x00000020}'嘴唇类型5',
    {0x00000040}'嘴唇类型6',
    {0x00000080}'嘴唇类型7',
    {0x00000100}'嘴唇类型8',
    {0x00000200}'嘴唇类型9',
    {0x00000400}'嘴唇类型10',
    {0x00000800}'嘴唇类型11',
    {0x00001000}'嘴唇类型12',
    {0x00002000}'嘴唇类型13',
    {0x00004000}'嘴唇类型14',
    {0x00008000}'嘴唇类型15',
    {0x00010000}'嘴唇类型16',
    {0x00020000}'嘴唇类型17',
    {0x00040000}'嘴唇类型18',
    {0x00080000}'嘴唇类型19',
    {0x00100000}'嘴唇类型20',
    {0x00200000}'嘴唇类型21',
    {0x00400000}'嘴唇类型22',
    {0x00800000}'嘴唇类型23',
    {0x01000000}'嘴唇类型24',
    {0x02000000}'嘴唇类型25',
    {0x04000000}'嘴唇类型26',
    {0x08000000}'嘴唇类型27',
    {0x10000000}'嘴唇类型28',
    {0x20000000}'嘴唇类型29',
    {0x40000000}'嘴唇类型30',
    {0x80000000}'嘴唇类型31'
  ]));

  wbTintMaskTypeEnum := wbEnum([
    '无',
    '嘴唇颜色',
    '面颊颜色',
    '眼线',
    '上部眼窝',
    '下部眼窝',
    '皮肤色调',
    '涂料',
    '笑纹',
    '面颊下部颜色',
    '鼻子',
    '下巴',
    '脖子',
    '前额',
    '污物',
    '未知 16'
  ]);

  wbTints := wbRArray('色调掩模', wbRStruct('有用色调', [
    wbRArray('色调图层', wbRStruct('材质', [
      wbInteger(TINI, '未知', itU16),
      wbString(TINT, '文件名'),
      {>>> When set to None TINP does not exist Needs routine to add when
      changing the Mask Type <<<}
      wbInteger(TINP, '掩模类型', itU16, wbTintMaskTypeEnum),
      wbFormIDCk(TIND, '预设', [CLFM, NULL])
    ], [])),
    wbRArray('最佳设置', wbRStruct('最佳设置', [
      wbFormIDCk(TINC, '颜色', [CLFM, NULL]),
			wbFloat(TINV, '默认值'),
      wbInteger(TIRS, '未知', itU16)
    ], []))
  ], []));

  wbRACE_DATAFlags01 := wbInteger('标志', itU32, wbFlags([
    {0x00000001}'玩家可用',
    {0x00000002}'脸部生成头部',
    {0x00000004}'小孩',
    {0x00000008}'前后倾斜',
    {0x00000010}'左右倾斜',
    {0x00000020}'没有影子',
    {0x00000040}'游泳',
    {0x00000080}'飞行',
    {0x00000100}'步行',
    {0x00000200}'固定的',
    {0x00000400}'不可推动',
    {0x00000800}'在水中不战斗',
    {0x00001000}'对头部追踪器不旋转',
    {0x00002000}'不显示喷血',
    {0x00004000}'不显示血贱',
    {0x00008000}'使用头部追踪器动作',
    {0x00010000}'法术与魔法节点对齐',
    {0x00020000}'对FootIK使用世界射线投射',
    {0x00040000}'允许布娃娃碰撞',
    {0x00080000}'战斗中恢复生命',
    {0x00100000}'无法开门',
    {0x00200000}'允许玩家对话',
    {0x00400000}'无法击倒',
    {0x00800000}'允许扒窃',
    {0x01000000}'始终使用代理控制器',
    {0x02000000}'不显示武器血液',
    {0x04000000}'叠加头部部分列表', {>>>Only one can be active<<<}
    {0x08000000}'覆盖头部部分列表', {>>>Only one can be active<<<}
    {0x10000000}'可以拾取物品',
    {0x20000000}'允许多个表面着色器',
    {0x40000000}'允许双持',
    {0x80000000}'避开道路'
  ]));

  wbPhonemeTargets := wbStruct(PHWT, '语音目标重量', [
    wbFloat('Aah / LipBigAah'),
    wbFloat('BigAah / LipDST'),
    wbFloat('BMP / LipEee'),
    wbFloat('ChJsh / LipFV'),
    wbFloat('DST / LipK'),
    wbFloat('Eee / LipL'),
    wbFloat('Eh / LipR'),
    wbFloat('FV / LipTh'),
    wbFloat('I'),
    wbFloat('K'),
    wbFloat('N'),
    wbFloat('Oh'),
    wbFloat('OohQ'),
    wbFloat('R'),
    wbFloat('TH'),
    wbFloat('W')
  ], cpNormal, False, nil, 8);

  wbPHWT := wbRStruct('FaceFX 语音', [
    wbRStruct('IY', [wbPhonemeTargets], []),
    wbRStruct('IH', [wbPhonemeTargets], []),
    wbRStruct('EH', [wbPhonemeTargets], []),
    wbRStruct('EY', [wbPhonemeTargets], []),
    wbRStruct('AE', [wbPhonemeTargets], []),
    wbRStruct('AA', [wbPhonemeTargets], []),
    wbRStruct('AW', [wbPhonemeTargets], []),
    wbRStruct('AY', [wbPhonemeTargets], []),
    wbRStruct('AH', [wbPhonemeTargets], []),
    wbRStruct('AO', [wbPhonemeTargets], []),
    wbRStruct('OY', [wbPhonemeTargets], []),
    wbRStruct('OW', [wbPhonemeTargets], []),
    wbRStruct('UH', [wbPhonemeTargets], []),
    wbRStruct('UW', [wbPhonemeTargets], []),
    wbRStruct('ER', [wbPhonemeTargets], []),
    wbRStruct('AX', [wbPhonemeTargets], []),
    wbRStruct('S',  [wbPhonemeTargets], []),
    wbRStruct('SH', [wbPhonemeTargets], []),
    wbRStruct('Z',  [wbPhonemeTargets], []),
    wbRStruct('ZH', [wbPhonemeTargets], []),
    wbRStruct('F',  [wbPhonemeTargets], []),
    wbRStruct('TH', [wbPhonemeTargets], []),
    wbRStruct('V',  [wbPhonemeTargets], []),
    wbRStruct('DH', [wbPhonemeTargets], []),
    wbRStruct('M',  [wbPhonemeTargets], []),
    wbRStruct('N',  [wbPhonemeTargets], []),
    wbRStruct('NG', [wbPhonemeTargets], []),
    wbRStruct('L',  [wbPhonemeTargets], []),
    wbRStruct('R',  [wbPhonemeTargets], []),
    wbRStruct('W',  [wbPhonemeTargets], []),
    wbRStruct('Y',  [wbPhonemeTargets], []),
    wbRStruct('HH', [wbPhonemeTargets], []),
    wbRStruct('B',  [wbPhonemeTargets], []),
    wbRStruct('D',  [wbPhonemeTargets], []),
    wbRStruct('JH', [wbPhonemeTargets], []),
    wbRStruct('G',  [wbPhonemeTargets], []),
    wbRStruct('P',  [wbPhonemeTargets], []),
    wbRStruct('T',  [wbPhonemeTargets], []),
    wbRStruct('K',  [wbPhonemeTargets], []),
    wbRStruct('CH', [wbPhonemeTargets], []),
    wbRStruct('SIL', [wbPhonemeTargets], []),
    wbRStruct('SHOTSIL', [wbPhonemeTargets], []),
    wbRStruct('FLAP', [wbPhonemeTargets], [])
  ], []);

  wbMorphs := wbRStruct('可用变型', [
    wbByteArray(MPAI, '未知', 0),
    wbStruct(MPAV, '鼻子变量', [
      wbNoseMorphFlags,
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4)
    ]),
    wbByteArray(MPAI, '未知', 0),
    wbStruct(MPAV, '眉毛变量', [
      wbBrowMorphFlags,
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4)
    ]),
    wbByteArray(MPAI, '未知', 0),
    wbStruct(MPAV, '眼睛变量', [
      wbEyesMorphFlags01,
      wbEyesMorphFlags02,
      wbByteArray('未知', 3),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4)
    ]),
    wbByteArray(MPAI, '未知', 0),
    wbStruct(MPAV, '嘴唇变量', [
      wbLipMorphFlags,
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4),
      wbByteArray('未知', 4)
    ])
  ], []);

  wbHeadPart := wbRStructSK([0],'头部部分', [
    wbInteger(INDX, '头部部分编号', itU32),
    wbFormIDCk(HEAD, '头部', [HDPT, NULL])
  ], []);

  wbRecord(RACE, 'Race', [
    wbEDID,
    wbFULL,
    wbDESCReq,
    wbSPCT,
    wbSPLOs,
    wbFormIDCk(WNAM, '皮肤', [ARMO, NULL]),
    wbBODT,
    wbBOD2,
    wbKSIZ,
    wbKWDAs,
    wbStruct(DATA, '', [
      wbArrayS('技能加强', wbStructSK([0], '技能加强', [
        wbInteger('技能', itS8, wbActorValueEnum),
        wbInteger('加强', itS8)
      ]), 7),
      wbByteArray('未知', 2),
      wbFloat('男性身高'),
      wbFloat('女性身高'),
      wbFloat('男性体重'),
      wbFloat('女性体重'),
      wbRACE_DATAFlags01,
      wbFloat('初始生命'),
      wbFloat('初始魔力'),
      wbFloat('初始体力'),
      wbFloat('基础负重'),
      wbFloat('基础质量'),
      wbFloat('加速率'),
      wbFloat('减速率'),
      wbInteger('尺寸', itU32, wbEnum([
        '小',
        '中等',
        '大',
        '特大'
      ])),
      wbInteger('头部双足对象', itS32, wbBipedObjectEnum),
      wbInteger('发型双足对象', itS32, wbBipedObjectEnum),
      wbFloat('受伤生命比例'),
      wbInteger('盾牌双足对象', itS32, wbBipedObjectEnum),
      wbFloat('生命恢复'),
      wbFloat('魔力恢复'),
      wbFloat('体力恢复'),
      wbFloat('徒手伤害'),
      wbFloat('徒手范围'),
      wbInteger('身体双足对象', itS32, wbBipedObjectEnum),
      wbFloat('对准角容限'),
      wbFloat('飞行半径'),
      wbFloat('角加速度'),
      wbFloat('角容限'),
      wbInteger('标志 2', itU32, wbFlags([
        {0x00000001} '使用高级回避',
        {0x00000002} '非敌对',
        {0x00000004} '未知 2',
        {0x00000008} '未知 3',
        {0x00000010} '允许骑砍'
      ])),
      wbStruct('坐骑数据', [
        wbFloat('偏移 X', cpNormal, False, 1, -1, nil, nil, -63.479000),
        wbFloat('偏移 Y'),
        wbFloat('未知'),
        wbFloat('未知', cpNormal, False, 1, -1, nil, nil, -50.0),
        wbFloat('未知'),
        wbFloat('未知', cpNormal, False, 1, -1, nil, nil, 65.0),
        wbFloat('未知'),
        wbFloat('未知', cpNormal, False, 1, -1, nil, nil, -300.0),
        wbFloat('未知')
      ])
      //wbByteArray('未知', 4*7)
    ], cpNormal, True, nil, 29),
    wbEmpty(MNAM, '标记'),
    wbString(ANAM, '骨骼模型'),
    wbMODT,
    wbEmpty(FNAM, '标记'),
    wbString(ANAM, '骨骼模型'),
    wbMODT,
    wbEmpty(NAM2, '标记 NAM2 #1'),
    wbRArrayS('运动类型名称', wbString(MTNM, '名称')),
    wbArray(VTCK, '语音', wbFormIDCk('语音', [VTYP]), ['男性', '女性'], cpNormal, True),
    wbArray(DNAM, '去头盔甲', wbFormIDCk('去头盔甲', [NULL, ARMO]), ['男性', '女性'], cpNormal, False),
    wbArray(HCLF, '默认头发颜色', wbFormIDCk('默认头发颜色', [NULL, CLFM]), ['男性', '女性'], cpNormal, False),
    wbInteger(TINL, '列表中色调总数', itU16, nil, nil, cpNormal, False), {>>> Needs Count Updated <<<}
    wbFloat(PNAM, '脸部生成 - 主要钳位', cpNormal, True),
    wbFloat(UNAM, '脸部生成 - 脸部钳位', cpNormal, True),
    wbFormIDCk(ATKR, '攻击种族', [RACE], False, cpNormal, False),
    wbRArrayS('攻击', wbAttackData),
    wbRStruct('身体数据', [
      wbEmpty(NAM1, '身体数据标记', cpNormal, True),
      wbRStruct('男性身体数据', [
        wbEmpty(MNAM, '男性数据标记'),
        wbRArrayS('部分', wbRStructSK([0], '部分', [
          wbInteger(INDX, '索引', itU32, wbBodyPartIndexEnum),
          wbMODL
        ], []), cpNormal, True)
      ], [], cpNormal, True),
      wbRStruct('女性身体数据', [
        wbEmpty(FNAM, '女性数据标记', cpNormal, True),
        wbRArrayS('部分', wbRStructSK([0], '部分', [
          wbInteger(INDX, '索引', itU32, wbBodyPartIndexEnum),
          wbMODL
        ], []), cpNormal, True)
      ], [], cpNormal, True)
    ], [], cpNormal, True),
    wbArrayS(HNAM, '发型', wbFormIDCk('发型', [HDPT, NULL]), 0, cpNormal),
    wbArrayS(ENAM, '眼睛', wbFormIDCk('眼睛', [EYES, NULL]),  0,  cpNormal),
    wbFormIDCk(GNAM, '身体部分数据', [BPTD, NULL]),
	  wbEmpty(NAM2, '标记 NAM2 #2', cpNormal),
	  wbEmpty(NAM3, '标记 NAM3 #3', cpNormal, True),
    wbRStruct('男性行为图表', [
      wbEmpty(MNAM, '男性数据标记'),
      wbMODL
    ], [], cpNormal, True),
    wbRStruct('女性行为图表', [
      wbEmpty(FNAM, '女性数据标记', cpNormal, True),
      wbMODL
    ], [], cpNormal, True),
    wbFormIDCk(NAM4, '材料类型', [MATT, NULL]),
    wbFormIDCk(NAM5, '冲击数据集', [IPDS, NULL]),
		wbFormIDCk(NAM7, '去头 FX', [ARTO, NULL]),
    wbFormIDCk(ONAM, '打开战利品声音', [SNDR, NULL]),
    wbFormIDCk(LNAM, '关闭战利品声音', [SNDR, NULL]),
    {>>> When NAME is user defined wbBipedObjectEnum will be incorrect <<<}
    wbRArray('双足对象名称', wbString(NAME, '名称')),
    wbRArrayS('行动类型', wbRStructSK([0], '行动类型', [
      wbFormIDCk(MTYP, '行动类型', [MOVT, NULL]),
      wbStruct(SPED, '覆盖数值', [
        wbFloat('向左 - 步行'),
        wbFloat('向左 - 跑步'),
        wbFloat('向右 - 步行'),
        wbFloat('向右 - 跑步'),
        wbFloat('向前 - 步行'),
        wbFloat('向前 - 跑步'),
        wbFloat('向后 - 步行'),
        wbFloat('向后 - 跑步'),
        wbFloat('旋转 - 步行'),
        wbFloat('旋转 - 跑步'),
        wbFloat('未知')
      ])
    ], [])),
    wbInteger(VNAM, '装备标志', itU32, wbEquipType),
    wbRArrayS('装备位置', wbFormIDCk(QNAM, '装备位置', [EQUP, NULL])),
    wbFormIDCk(UNES, '徒手装备位置', [EQUP, NULL]),
    wbRArray('语音目标名称', wbString(PHTN, '名称')),
    wbPHWT,
    wbFormIDCk(WKMV, '默认基本行动 - 步行', [MOVT, NULL]),
    wbFormIDCk(RNMV, '默认基本行动 - 跑步', [MOVT, NULL]),
    wbFormIDCk(SWMV, '默认基本行动 - 游泳', [MOVT, NULL]),
    wbFormIDCk(FLMV, '默认基本行动 - 飞行', [MOVT, NULL]),
    wbFormIDCk(SNMV, '默认基本行动 - 潜行', [MOVT, NULL]),
    wbFormIDCk(SPMV, '默认基本行动 - 冲刺', [MOVT, NULL]),
    // Start Head Data
    wbRStruct('头部数据', [
      wbEmpty(NAM0, '头部数据标记', cpNormal, True),
      wbRStruct('男性头部数据', [
        wbEmpty(MNAM, '男性数据标记', cpNormal, True),
          wbRArrayS('头部部分', wbHeadPart),
          wbMorphs,
          wbRArrayS('种族预设(男)', wbFormIDCk(RPRM, '预设 NPC', [NPC_, NULL])),
          wbRArrayS('可用头发颜色(男)', wbFormIDCk(AHCM, '头发颜色', [CLFM, NULL])),
          wbRArrayS('脸部细节材质集列表(男)', wbFormIDCk(FTSM, '材质集', [TXST, NULL])),
          wbFormIDCk(DFTM, '默认脸部材质(男)', [TXST, NULL]),
          wbTints,
          wbMODL
      ], [], cpNormal, True),
      wbRStruct('女性头部数据', [
        wbEmpty(NAM0, '头部数据标记', cpNormal, True),
        wbEmpty(FNAM, '女性数据标记', cpNormal, True),
          wbRArrayS('头部部分', wbHeadPart),
          wbMorphs,
          wbRArrayS('种族预设(女)', wbFormIDCk(RPRF, '预设 NPC', [NPC_, NULL])),
          wbRArrayS('可用头发颜色(女)', wbFormIDCk(AHCF, '头发颜色', [CLFM, NULL])),
          wbRArrayS('脸部细节材质集列表(女)', wbFormIDCk(FTSF, '材质集', [TXST, NULL])),
          wbFormIDCk(DFTF, '默认脸部材质(女)', [TXST, NULL]),
          wbTints,
          wbMODL
      ], [], cpNormal, True)
    ], [], cpNormal, False),
    // End Head Data
    wbFormIDCk(NAM8, '型变种族', [RACE, NULL]),
    wbFormIDCk(RNAM, '装甲种族', [RACE, NULL])
  ], False, nil, cpNormal, False, wbRACEAfterLoad);


  wbRecord(REFR, 'Placed Object', [
    wbEDID,
    wbVMAD,
    wbFormIDCk(NAME, '基础', [TREE, SNDR, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, LVLN, LVLC,
                              MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, INGR,
                              MSTT, TACT, TXST, FLOR, SLGM, SCRL, SOUN, APPA, SPEL], False, cpNormal, True),

    {--- Bound Contents ---}
    {--- Bound Data ---}
    wbStruct(XMBO, '范围限制', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ]),

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
        '传送箱',
        '未知 4'
      ]))
    ]),
    wbUnknown(XORD),
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

    wbArray(XPOD, '传送数据', wbStruct('衍生', [
      wbFormIDCk('原点', [REFR, NULL]),
      wbFormIDCk('目的地', [REFR, NULL])
    ])),
    wbStruct(XPTL, '空间传送 (未使用)', [
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
    ], cpIgnore), // removed by CK

    wbRStruct('限制数据', [
      wbStruct(XRMR, '数据头', [
        //wbInteger('连接的空间数目', itU16),
        wbByteArray('未知', 1),
        wbInteger('标志', itU8, wbFlags([
          '未知 1',
          '未知 2',
          '未知 3',
          '未知 4',
          '未知 5',
          '未知 6',
          '存在图像空间',
          '存在光照模版'
        ])),
        wbByteArray('未知', 2)
      ]),
      wbFormIDCk(LNAM, '光照模版', [LGTM]),
      wbFormIDCk(INAM, '图像空间', [IMGS]),
      wbRArrayS('连接的空间',
        wbFormIDCk(XLRM, '连接的空间', [REFR])
      )
    ], []),
    wbEmpty(XMBP, '多限制基元标志', cpIgnore),

    wbXRGD,
    wbXRGB,
    wbFloat(XRDS, '半径'),

    {--- Reflected By / Refracted By ---}
    wbRArrayS('反射/折射',
      wbStructSK(XPWR, [0], '水源', [
        wbFormIDCk('衍生', [REFR]),
        wbInteger('类型', itU32, wbFlags([
          '反射',
          '折射'
        ]))
      ], cpNormal, False, nil, 1)
    ),

    {--- Lit Water ---}
    wbRArrayS('发光水源',
      wbFormIDCk(XLTW, '水源', [REFR])
    ),

    {--- Emittance ---}
    wbFormIDCk(XEMI, '辐射颜色', [LIGH, REGN]),
		wbStruct(XLIG, '光照数据', [
      wbFloat('视场 90+/-'),
      wbFloat('渐显 1.35+/-'),
      wbByteArray('未知', 4),
      wbFloat('阴影深度偏差'),
      wbByteArray('未知', 4) // optional
    ], cpNormal, False, nil, 4),
		wbStruct(XALP, 'Alpha', [
      wbInteger('截断', itU8),
      wbInteger('基础', itU8)
    ]),

    {--- Teleport ---}
    wbStruct(XTEL, '传送目的地', [
      wbFormIDCk('门', [REFR], True),
      wbPosRot,
      wbInteger('标志', itU32, wbFlags([
        '无警报'
      ]))
    ]),
    wbFormIDCk(XTNM, '传送信息框', [MESG]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, '多限制衍生', [REFR]),

    wbByteArray(XWCN, '未知', 0, cpIgnore), // leftover
    wbByteArray(XWCS, '未知', 0, cpIgnore), // leftover
    wbStruct(XWCU, '水流速度', [
      wbFloat('X 偏移'),
      wbFloat('Y 偏移'),
      wbFloat('Z 偏移'),
      wbByteArray('未知', 4),
      wbFloat('X 角度'),
      wbFloat('Y 角度'),
      wbFloat('Z 角度'),
      wbByteArray('未知', 0)
    ]),

    wbStruct(XCVL, '未知', [
			wbByteArray('未知', 4),
			wbFloat('X 角度'),
			wbByteArray('未知', 4)
    ]),
		wbUnknown(XCZA),
    wbFormIDCk(XCZC, '未知', [CELL, NULL]),
    wbXSCL,
    wbFormIDCk(XSPC, '重生容器', [REFR]),

    {--- Activate Parents ---}
    wbRStruct('激活根源', [
      wbInteger(XAPD, '标志', itU8, wbFlags([
        '仅激活根源'
      ], True)),
      wbRArrayS('激活根源衍生',
        wbStructSK(XAPR, [0], '激活根源衍生', [
          wbFormIDCk('衍生', [PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
          wbFloat('推延')
        ])
      )
    ], []),

    wbFormIDCk(XLIB, '等级列表基本对象', [LVLI]),
    wbXLCM,
    wbFormIDCk(XLCN, '固定方位', [LCTN]),

    {>>> Has some int values, but in CK it is assigned a COLL formid <<<}
    wbInteger(XTRI, '碰撞层', itU32),
//    wbInteger(XTRI, '碰撞层', itU32, wbEnum([], [
//      12, 'L_TRIGGER',
//      22, 'L_ACTORZONE',
//      23, 'L_PROJECTILEZONE',
//      24, 'L_GASTRAP',
//      47, 'L_DEADACTORZONE',
//      48, 'L_TRIGGER_FALLINGTRAP',
//      51, 'L_SPELLTRIGGER',
//      54, 'L_TRAPTRIGGER',
//      52, 'L_LIVING_AND_DEAD_ACTORS'
//    ])),

    {--- Lock ---}
    {>>Lock Tab for REFR when 'Locked' is Unchecked this record is not present <<<}
    wbStruct(XLOC, '锁数据', [
      wbInteger('等级', itU8, wbEnum([], [
         1, '新手',
        25, '学徒',
        50, '能手',
        75, '专家',
       100, '大师',
       255, '需要钥匙'
      ])),
      wbByteArray('未使用', 3, cpIgnore),
      wbFormIDCkNoReach('钥匙', [KEYM, NULL]),
      wbInteger('标志', itU8, wbFlags(['', '', '等级锁'])),
      wbByteArray('未使用', 3, cpIgnore),
      wbByteArray('未使用', 8, cpIgnore)
    ], cpNormal, False, nil, 4),

    wbFormIDCk(XEZN, '遭遇区域', [ECZN]),

    {--- Generated Data ---}
    wbStruct(XNDP, '导航门连接', [
      wbFormIDCk('导航模型', [NAVM]),
      wbInteger('传送三角标记', itS16),
      wbByteArray('未知', 2)
    ]),

    wbArray(XLRT, '位置衍生类型', wbFormIDCk('衍生', [LCRT, NULL])),
    wbEmpty(XIS2, '被沙盒忽略'),

    {--- Ownership ---}
    wbOwnership,

    wbInteger(XCNT, '物品数量', itS32),
    wbFloat(XCHG, '费用'),
    wbFormIDCk(XLRL, '位置衍生', [LCRT, LCTN, NULL], False, cpBenignIfAdded),

    wbXESP,
    wbRArray('连接的衍生', wbStruct(XLKR, '连接的衍生', [
      wbFormIDCk('关键字/衍生', [KYWD, PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA, NULL]),
      wbFormIDCk('衍生', [PLYR, ACHR, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA])
    ], cpNormal, False, nil, 1)),

    wbRArray('巡逻', wbRStruct('数据', [
      wbFloat(XPRD, '空闲时间', cpNormal, True),
      wbEmpty(XPPA, '巡逻脚本标记', cpNormal, True),
      wbFormIDCk(INAM, '空闲动作', [IDLE, NULL], False, cpNormal, True),
      wbByteArray(SCHR, '未使用', 0, cpIgnore, false, false, wbNeverShow),
      wbByteArray(SCTX, '未使用', 0, cpIgnore, false, false, wbNeverShow),
      wbPDTOs
    ], [])),

    {--- Flags ---}
    wbInteger(XACT, '动作标记', itU32, wbFlags([
      '使用默认',
      '激活',
      '打开',
      '默认打开'
    ])),

    wbFloat(XHTW, '头部跟踪权重'),
    wbFloat(XFVC, '好感消耗'),

    wbEmpty(ONAM, '默认打开'),

    {--- Map Data ---}
    wbRStruct('地图标记', [
      wbEmpty(XMRK, '地图标记起始标记'),
      wbInteger(FNAM, '地图标志', itU8, wbFlags([
        {0x01} '可见',
        {0x02} '可以旅行到',
        {0x04} '隐藏"全部显示"'
      ]), cpNormal, True),
      wbFULLReq,
      wbInteger(TNAM, '类型', itU16, wbEnum([], [
        1, '城市',
        2, '小镇',
        3, '村落',
        4, '洞穴',
        5, '营地',
        6, '堡垒',
        7, '诺德废墟',
        8, '锻摩废墟',
        9, '遇难船',
        10, '小树林',
        11, '地标',
        12, '龙穴',
        13, '农场',
        14, '木作坊',
        15, '矿山',
        16, '帝国防御塔',
        17, '暴风斗篷军营',
        18, '守护之石',
        19, '小麦磨坊',
        20, '熔炉',
        21, '马厩',
        22, '帝国大厦',
        23, '荒地',
        24, '关隘',
        25, '神龛',
        26, '岩石',
        27, '灯塔',
        28, '兽人要塞',
        29, '巨人营地',
        30, '小屋',
        31, '诺德防御塔',
        32, '诺德住所',
        33, '码头',
        34, '圣坛',
        35, '裂谷城城堡',
        36, '裂谷城首府',
        37, '风盔城城堡',
        38, '风盔城首府',
        39, '雪漫城城堡',
        40, '雪漫城首府',
        41, '孤独城城堡',
        42, '孤独城首府',
        43, '马卡斯城城堡',
        44, '马卡斯城首府',
        45, '东堡城堡',
        46, '东堡首府',
        47, '莫撒尔城堡',
        48, '莫撒尔首府',
        49, '福克瑞斯城堡',
        50, '福克瑞斯首府',
        51, '晨星城城堡',
        52, '晨星城首府',
        53, 'DLC02 - 米拉克之殿',
        54, 'DLC02 - 鸦岩',
        55, 'DLC02 - 兽石',
        56, 'DLC02 - 泰尔 · 米斯瑞恩',
        57, 'DLC02 - 通往天际',
        58, 'DLC02 - 通往索尔斯塞姆'
      ]), cpNormal, True)
    ], []),
    {--- Attach reference ---}
    wbFormIDCk(XATR, '依附衍生', [REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
    wbXLOD,
    wbDataPosRot
  ], True, wbPlacedAddInfo, cpNormal, False, wbREFRAfterLoad);


  {>>> Almost no changes here, seems to be working as is <<<}
  wbRecord(REGN, 'Region', [
    wbEDID,
    wbStruct(RCLR, '地图颜色', [
      wbInteger('红', itU8),
      wbInteger('绿', itU8),
      wbInteger('蓝', itU8),
      wbByteArray('未知', 1)
    ], cpNormal, True),
    {>>> Skyrim.esm has some incorrect FormIDs here, probably leftover <<<}
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
          {0} '未知 0',
          {1} '未知 1',
          {2} '对象',
          {3} '天气',
          {4} '地图',
          {5} '土地',
          {6} '草地',
          {7} '音效',
          {8} '顶替',
          {9} '未知 10',
          {10}'未知 11',
          {11}'未知 12',
          {12}'未知 13',
          {13}'未知 14',
          {14}'未知 15',
          {15}'未知 16'
        ])),
        wbInteger('标志', itU8, wbFlags([
          '覆盖'
        ])),
        wbInteger('优先级', itU8),
        wbByteArray('未知')
      ], cpNormal, True),

      {--- Icon ---}
      wbICON,

      {--- Sound ---}
      wbFormIDCk(RDMO, '音乐', [MUSC], False, cpNormal, False, wbREGNSoundDontShow),
      wbArrayS(RDSA, '音效', wbStructSK([0], '音效', [
        wbFormIDCk('音效', [SOUN, SNDR, NULL]),
        wbInteger('标志', itU32, wbFlags([
          {0x00000001}'晴朗',
          {0x00000002}'多云',
          {0x00000004}'下雨',
          {0x00000008}'下雪'
        ])),
        wbFloat('概率')
      ]), 0, cpNormal, False, nil, nil, wbREGNSoundDontShow),

			{--- Map ---}
      wbLString(RDMP, '地图名称', 0, cpTranslate, False, wbREGNMapDontShow),

      {followed by one of these: }

      {--- Objects ---}
      wbArray(RDOT, '对象', wbStruct('对象', [
        wbFormIDCk('对象', [TREE, STAT, LTEX, MSTT]),
        wbInteger('父系索引', itU16, wbHideFFFF),
        wbByteArray('未知', 2),
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
        wbByteArray('未知', 2),
        wbByteArray('未知', 4)
      ]), 0, nil, nil, cpNormal, False, wbREGNObjectsDontShow),

      {--- Grass ---}
      wbArrayS(RDGS, '草地', wbStructSK([0], '草地', [
        wbFormIDCk('草地', [GRAS]),
        wbByteArray('未知',4)
      ]), 0, cpNormal, False, nil, nil, wbREGNGrassDontShow),

      {--- Weather ---}
      wbArrayS(RDWT, '天气类型', wbStructSK([0], '天气类型', [
        wbFormIDCk('天气', [WTHR]),
        wbInteger('概率', itU32),
        wbFormIDCk('全局', [GLOB, NULL])
      ]), 0, cpNormal, False, nil, nil, wbREGNWeatherDontShow)

    ], []))
  ], True);

  wbRecord(SOUN, 'Sound Marker', [
    wbEDID,
    wbOBNDReq,
    wbUnknown(FNAM, cpIgnore), // leftover, unused
    wbUnknown(SNDD, cpIgnore), // leftover, unused
    wbFormIDCk(SDSC, '音效描述', [SNDR, NULL])
  ]);

  wbSPIT := wbStruct(SPIT, '数据', [
    wbInteger('基本消耗', itU32),
    wbInteger('标志', itU32, wbFlags([
      {0x00000001} '手动消耗计算',
      {0x00000002} '未知 2',
      {0x00000004} '未知 3',
      {0x00000008} '未知 4',
      {0x00000010} '未知 5',
      {0x00000020} '未知 6',
      {0x00000040} '未知 7',
      {0x00000080} '未知 8',
      {0x00000100} '未知 9',
      {0x00000200} '未知 10',
      {0x00000400} '未知 11',
      {0x00000800} '未知 12',
      {0x00001000} '未知 13',
      {0x00002000} '未知 14',
      {0x00004000} '未知 15',
      {0x00008000} '未知 16',
      {0x00010000} '未知 17',
      {0x00020000} '玩家初始魔法',
      {0x00040000} '未知 19',
      {0x00080000} '影响范围不受视角限制',
      {0x00100000} '无视抗性',
      {0x00200000} '不吸收/反射',
      {0x00400000} '未知 23',
      {0x00800000} '无双手施法加成',
      {0x01000000} '未知 25',
      {0x02000000} '未知 26',
      {0x04000000} '未知 27',
      {0x08000000} '未知 28',
      {0x10000000} '未知 29',
      {0x20000000} '未知 30',
      {0x40000000} '未知 31',
      {0x80000000} '未知 32'
    ])),
    wbInteger('类型', itU32, wbEnum([
      {0} '法术',
      {1} '疾病',
      {2} '威能',
      {3} '次级威能',
      {4} '能力',
      {5} '毒药',
      {6} '未知 6',
      {7} '未知 7',
      {8} '未知 8',
      {9} '未知 9',
     {10} '上瘾',
     {11} '吼声'
    ])),
    wbFloat('充能时长'),
    wbInteger('施法类型', itU32, wbCastEnum),
    wbInteger('类型', itU32, wbTargetEnum),
    wbFloat('施法时长'),
    wbFloat('规模'),
    wbFormIDCk('半消耗天赋', [NULL, PERK])
  ], cpNormal, True);

  wbRecord(SPEL, 'Spell', [
    wbEDID,
    wbOBNDReq,
    wbFULL,
    wbKSIZ,
    wbKWDAs,
    wbMDOB,
    wbETYP,
    wbDESCReq,
    wbSPIT,
    wbEffectsReq
  ]);

  wbRecord(SCRL, 'Scroll', [
    wbEDID,
    wbOBNDReq,
    wbFULL,
    wbKSIZ,
    wbKWDAs,
    wbMDOB,
    wbETYP,
    wbDESC,
    wbMODL,
    wbDEST,
    wbFormIDCk(YNAM, '音效 - 拾起', [SNDR, SOUN]),
    wbFormIDCk(ZNAM, '音效 - 丢弃', [SNDR, SOUN]),
    wbStruct(DATA, '物品', [
      wbInteger('价值', itU32),
      wbFloat('重量')
    ], cpNormal, True),
    wbSPIT,
    wbEffectsReq
  ]);

  wbRecord(STAT, 'Static', [
    wbEDID,
    wbOBNDReq,
    wbMODL,
    wbStruct(DNAM, '方向材料', [
      wbFloat('最大角度 (30-120)'),
      wbFormIDCk('材料', [MATO, NULL])
    ], cpNormal, True),
    wbArray(MNAM, '远景 LOD',
      wbStruct('LOD', [
        {>>> Contains null-terminated mesh filename followed by random data up to 260 bytes <<<}
        wbByteArray('模型', 260, cpIgnore)
      ]), [
        '等级 0',
        '等级 1',
        '等级 2',
        '等级 3'
      ],
      cpNormal, False
    )
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
      wbByteArray(DATA, '未知', 8, cpIgnore, True)
    ], [ONAM])),
    wbArray(ONAM, '覆盖的表单',
      wbFormIDCk('表单', [ACHR, LAND, NAVM, REFR, PGRE, PHZD, PARW, PBAR, PBEA, PCON, PFLA]),
      0, nil, nil, cpNormal, False, wbTES4ONAMDontShow),
    wbByteArray(SCRN, '截图'),
    wbUnknown(INTV),
    wbUnknown(INCC)
  ], True, nil, cpNormal, True, wbRemoveOFST);
end;

procedure DefineTES5o;
begin

  wbRecord(TREE, 'Tree', [
    wbEDID,
    wbOBNDReq,
    wbMODL,
    wbFormIDCK(PFIG, '原料', [INGR, ALCH, MISC, LVLI, NULL]),
    wbFormIDCK(SNAM, '采集音效', [SNDR, NULL]),
    wbStruct(PFPC, '原料生产率', [
      wbInteger('春季', itU8),
      wbInteger('夏季', itU8),
      wbInteger('秋季', itU8),
      wbInteger('冬季', itU8)
    ]),
    wbFULL,
    wbStruct(CNAM, '树木数据', [
      wbFloat('树干灵活性'),
      wbFloat('分支灵活性'),
      wbByteArray('未知', 32),
      wbFloat('叶子幅度'),
      wbFloat('叶子频率')
    ], cpNormal, True)
  ]);

  wbRecord(FLOR, 'Flora', [
    wbEDID,
    wbVMAD,
    wbOBNDReq,
    wbFULLReq,
    wbMODL,
    wbDEST,
    wbKSIZ,
    wbKWDAs,
    wbUnknown(PNAM),
    wbLString(RNAM, '触发文本覆盖'),
    wbUnknown(FNAM),
    wbFormIDCk(PFIG, '原料', [INGR, ALCH, LVLI, MISC, NULL]),
    wbFormIDCK(SNAM, '音效', [SNDR, SOUN, NULL]),
    wbStruct(PFPC, '季节性原料生产率', [
      wbInteger('春季', itU8),
      wbInteger('夏季 ', itU8),
      wbInteger('秋季', itU8),
      wbInteger('冬季', itU8)
    ], cpNormal, True)
  ]);

  wbRecord(WATR, 'Water', [
    wbEDID,
    wbFULL,
    wbRArray('未使用', wbByteArray(NNAM, '未使用', 0, cpIgnore, False)), // leftover
    wbInteger(ANAM, '透明度', itU8, nil, cpNormal, True),
    wbInteger(FNAM, '标志', itU8, wbFlags(['造成伤害']), cpNormal, True),
    wbByteArray(MNAM, '未使用', 0, cpIgnore, False),  // leftover
    wbFormIDCk(TNAM, '材料', [MATT]),
    wbFormIDCk(SNAM, '开启音效', [SNDR, NULL]),
    wbFormIDCk(XNAM, '法术', [SPEL]),
    wbFormIDCk(INAM, '图像空间', [IMGS]),
    wbInteger(DATA, '每秒伤害', itU16, nil, cpNormal, True, True),
    wbStruct(DNAM, '可视化数据', [
      wbFloat('未知'),
      wbFloat('未知'),
      wbFloat('未知'),
      wbFloat('未知'),
      wbFloat('反射属性 - 太阳反射强度'),
      wbFloat('水面属性 - 反射指数'),
      wbFloat('水面属性 - 菲涅耳指数'),
      wbByteArray('未知', 4),
      wbFloat('水雾属性 - 水上部分 - 水雾距离 - 接近地面'),
      wbFloat('水雾属性 - 水上部分 - 水雾距离 - 远离地面'),
      wbStruct('潜水颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ]),
      wbStruct('深水颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ]),
      wbStruct('反射颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8),
        wbByteArray('未知', 1)
      ]),
      wbByteArray('未知', 4),
      wbFloat('未知'),
      wbFloat('未知'),
      wbFloat('未知'),
      wbFloat('未知'),
      wbFloat('水纹模拟器 - 起始尺寸'),
      wbFloat('水纹模拟器 - 推力'),
      wbFloat('水纹模拟器 - 速度'),
      wbFloat('水纹模拟器 - 衰减'),
      wbFloat('水纹模拟器 - 阻尼'),
      wbFloat('未知'),
      wbFloat('噪波属性 - 噪波减弱'),
      wbFloat('噪波属性 - 图层一 - 风向'),
      wbFloat('噪波属性 - 图层二 - 风向'),
      wbFloat('噪波属性 - 图层三 - 风向'),
      wbFloat('噪波属性 - 图层一 - 风速'),
      wbFloat('噪波属性 - 图层二 - 风速'),
      wbFloat('噪波属性 - 图层三 - 风速'),
      wbFloat('未知'),
      wbFloat('未知'),
      wbFloat('水雾属性 - 水上部分 - 水雾数量'),
      wbFloat('未知'),
      wbFloat('水雾属性 - 水下部分 - 水雾数量'),
      wbFloat('水雾属性 - 水下部分 - 水雾距离 - 接近地面'),
      wbFloat('水雾属性 - 水下部分 - 水雾距离 - 远离地面'),
      wbFloat('水面属性 - 折射能级'),
      wbFloat('反射属性 - 反射强度'),
      wbFloat('未知'),
      wbFloat('反射属性 - 反射半径'),
      wbFloat('反射属性 - 反射亮度'),
      wbFloat('噪波属性 - 图层一 - UV 规模'),
      wbFloat('噪波属性 - 图层二 - UV 规模'),
      wbFloat('噪波属性 - 图层三 - UV 规模'),
      wbFloat('噪波属性 - 图层一 - 振幅规模'),
      wbFloat('噪波属性 - 图层二 - 振幅规模'),
      wbFloat('噪波属性 - 图层三 - 振幅规模'),
      wbFloat('水面属性 - 反射能级'),
      wbFloat('反射属性 - 太阳耀眼能级'),
      wbFloat('反射属性 - 太阳反射能级'),
      wbFloat('深度属性 - 反射'),
      wbFloat('深度属性 - 折射'),
      wbFloat('深度属性 - 法线'),
      wbFloat('深度属性 - 反射亮度'),
      wbFloat('反射属性 - 太阳耀眼强度')
    ]),
    wbByteArray(GNAM, '未使用', 0, cpNormal, True),  // leftover
    wbStruct(NAM0, '线速度', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ], cpNormal, False),
    wbStruct(NAM1, '角速度', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ], cpNormal, False),
    wbString(NAM2, '噪波纹理', 0, cpNormal, False),
    wbString(NAM3, '未使用', 0, cpNormal),  // leftover
    wbString(NAM4, '未使用', 0, cpNormal)  // leftover
  ], False, nil, cpNormal, False);

  wbRecord(WEAP, 'Weapon', [
    wbEDID,
    wbVMAD,
    wbOBNDReq,
    wbFULL,
    wbMODL,
    wbICON,
    wbEITM,
    wbInteger(EAMT, '附魔数量', itU16),
    wbDEST,
    wbETYP,
    wbFormIDCk(BIDS, '格挡重击冲击数据集', [IPDS, NULL]),
    wbFormIDCk(BAMT, '格挡替换材料', [MATT, NULL]),
    wbFormIDCk(YNAM, '音效 - 拾起', [SNDR, SOUN]),
    wbFormIDCk(ZNAM, '音效 - 丢弃', [SNDR, SOUN]),
    wbKSIZ,
    wbKWDAs,
    wbDESC,
    wbRStruct('子弹视角', [
      wbString(MOD3, '模型'),
      wbByteArray(MO3T, '材质文件哈希值', 0, cpIgnore, false, false, wbNeverShow),
      wbMO3S
    ], []),
    wbByteArray(NNAM, '未使用', 0, cpIgnore, False), // leftover
    wbFormIDCk(INAM, '冲击数据集', [IPDS, NULL]),
    wbFormIDCk(WNAM, '第一人称模型主体', [STAT, NULL]),
    wbFormIDCk(SNAM, '攻击声音', [SNDR]),
    wbFormIDCk(XNAM, '攻击声音 2D', [SNDR]),
    wbFormIDCk(NAM7, '攻击循环声音', [SNDR]),
    wbFormIDCk(TNAM, '攻击失败声音', [SNDR]),
    wbFormIDCk(UNAM, '待机声音', [SNDR]),
    wbFormIDCk(NAM9, '装甲声音', [SNDR]),
    wbFormIDCk(NAM8, '卸甲声音', [SNDR]),
    wbStruct(DATA, '游戏数据', [
      wbInteger('价值', itU32),
      wbFloat('重量'),
      wbInteger('伤害', itU16)
    ]),
    wbStruct(DNAM, '数据', [
      wbInteger('动作类型', itU8, wbWeaponAnimTypeEnum),
      wbByteArray('未使用', 3, cpIgnore),
      wbFloat('速度'),
      wbFloat('范围'),
      wbInteger('标志', itU16, wbFlags([
        {0x0001}'无视普通武器抗性',
        {0x0002}'自动 (未使用)',
        {0x0004}'子弹视野 (未使用)',
        {0x0008}'无法丢弃',
        {0x0010}'隐藏背包 (未使用)',
        {0x0020}'捆绑的武器 (未使用)',
        {0x0040}'第一人称不使用子弹视角 (未使用)',
        {0x0080}'玩家不可用'
      ])),
      wbByteArray('未使用', 2, cpIgnore),
      wbFloat('视场'),
      wbByteArray('未知', 4),
      wbInteger('基本终结技击中概率', itU8),
      wbInteger('攻击动作', itU8, wbAttackAnimationEnum),
      wbInteger('# 抛射物', itU8),
      wbInteger('捆绑武器角色数值 (未使用)', itU8),
      wbFloat('最小范围'),
      wbFloat('最大范围'),
      wbInteger('击中', itU32, wbEnum([
        '正常',
        '仅肢解',
        '仅爆炸',
        '无肢解/爆炸'
      ])),
      wbInteger('标志2', itU32, wbFlags([
        {0x00000001}'仅玩家可用',
        {0x00000002}'NPC会使用',
        {0x00000004}'再装备不拥挤 (未使用)',
        {0x00000008}'未知 4',
        {0x00000010}'轻罪',
        {0x00000020}'范围修复',
        {0x00000040}'一般战斗不使用',
        {0x00000080}'未知 8',
        {0x00000100}'第三人称不使用子弹视角 (未使用)',
        {0x00000200}'未知 10',
        {0x00000400}'震动 - 替换物',
        {0x00000800}'未知 12',
        {0x00001000}'非敌对',
        {0x00002000}'召唤武器'
      ])),
      wbFloat('动作攻击加成'),
      wbFloat('未知'),
      wbFloat('震动 - 左马达强度'),
      wbFloat('震动 - 右马达强度'),
      wbFloat('震动 - 持续时间'),
      wbByteArray('未知', 12),
      wbInteger('技能', itS32, wbSkillEnum),
      wbByteArray('未知', 8),
      wbInteger('抗性', itS32, wbActorValueEnum),
      wbByteArray('未知', 4),
      wbFloat('摇晃')
    ]),
    wbStruct(CRDT, '临界数据', [
      wbInteger('伤害', itU16),
      wbByteArray('未使用', 2, cpIgnore),
      wbFloat('% 加成'),
      wbInteger('标志', itU8, wbFlags([
        '死亡时'
      ])),
      wbByteArray('未使用', 3, cpIgnore),
      wbFormIDCk('效果', [SPEL, NULL])
    ]),
    wbInteger(VNAM, '检测音效等级', itU32, wbSoundlevelEnum),
    wbFormIDCk(CNAM, '模版', [WEAP])
  ], False, nil, cpNormal, False, wbWEAPAfterLoad);

  wbRecord(WRLD, 'Worldspace', [
    wbEDID,
    {>>> BEGIN leftover from earlier CK versions <<<}
    wbRArray('未使用 RNAM', wbUnknown(RNAM), cpIgnore, False{, wbNeverShow}),
    {>>> END leftover from earlier CK versions <<<}
    wbByteArray(MHDT, '最大高度数据', 0, cpNormal),
    wbFULL,
    wbStruct(WCTR, '大小固定的中心场景', [
      wbInteger('X', itU16),
      wbInteger('Y', itU16)
    ]),
    wbFormIDCk(LTMP, '内部光源', [LGTM]),
    wbFormIDCk(XEZN, '遭遇区域', [ECZN, NULL]),
    wbFormIDCk(XLCN, '位置', [LCTN, NULL]),
    wbFormIDCk(WNAM, '父系空间', [WRLD]),
    wbInteger(PNAM, '使用标志', itU16, wbFlags([
      {0x0001}'使用土地数据',
      {0x0002}'使用LOD数据',
      {0x0004}'不使用地图数据',
      {0x0008}'使用水源数据',
      {0x0010}'使用气候数据',
      {0x0020}'未知 6',
      {0x0040}'使用天空场景',
      {0x0080}'未知 8',
      {0x0100}'未知 9',
      {0x0200}'未知 10',
      {0x0400}'未知 11',
      {0x0800}'未知 12',
      {0x1000}'未知 13',
      {0x2000}'未知 14',
      {0x4000}'未知 15',
      {0x8000}'未知 16'
    ], True)),
    wbFormIDCk(CNAM, '气候', [CLMT]),
    wbFormIDCk(NAM2, '水源', [WATR]),
    wbFormIDCk(NAM3, 'LOD 水源类型', [WATR]),
    wbFloat(NAM4, 'LOD 水源高度'),
    wbStruct(DNAM, '土地数据', [
      wbFloat('默认土地高度'),
      wbFloat('默认水源高度')
    ]),
    wbString(ICON, '地图图像'),
    wbRStruct('云层模型', [wbMODL], []),
    wbStruct(MNAM, '地图数据', [
      wbStruct('可使用范围', [
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
      ]),
      wbStruct('镜头数据', [
        wbFloat('最小高度'),
        wbFloat('最大高度'),
        wbFloat('初始间距')
      ])
      //wbByteArray('未知')
    ], cpNormal, False, nil, 2),
    wbStruct(ONAM, '世界地图补偿数据', [
      wbFloat('世界地图规模'),
      wbFloat('场景 X 偏移', cpNormal, False, 1/4096),
      wbFloat('场景 Y 偏移', cpNormal, False, 1/4096),
      wbFloat('场景 Z 偏移', cpNormal, False, 1/4096)
    ], cpNormal, True),
    wbFloat(NAMA, '远景细节强化率'),
    wbInteger(DATA, '标志', itU8, wbFlags([
      {0x01} '小世界',
      {0x02} '无法快速旅行',
      {0x04} '未知 3',
      {0x08} '无LOD水',
      {0x10} '无景观',
      {0x20} '未知 6',
      {0x40} '大小固定',
      {0x80} '无草'
    ]), cpNormal, True),
    {>>> Object Bounds doesn't show up in CK <<<}
    wbRStruct('对象范围 (未使用?)', [
      wbStruct(NAM0, '最小值', [
        wbFloat('X', cpNormal, False, 1/4096),
        wbFloat('Y', cpNormal, False, 1/4096)
      ], cpIgnore, True),
      wbStruct(NAM9, '最大值', [
        wbFloat('X', cpNormal, False, 1/4096),
        wbFloat('Y', cpNormal, False, 1/4096)
      ], cpIgnore, True)
    ], []),
    wbFormIDCk(ZNAM, '音乐', [MUSC]),
    wbString(NNAM, '树冠阴影 (未使用)', 0, cpIgnore),
    wbString(XNAM, '水面噪波纹理'),
    wbString(TNAM, 'HD LOD 漫反射材质'),
    wbString(UNAM, 'HD LOD 法线材质'),
    wbString(XWEM, '水面环境贴图 (未使用)', 0, cpIgnore),
    wbByteArray(OFST, '未知')
  ], False, nil, cpNormal, False, wbWRLDAfterLoad);

  wbRecord(WTHR, 'Weather', [
    wbEDID,
    wbString(_00_0TX, '云层材质图层 #0'),
    wbString(_10_0TX, '云层材质图层 #1'),
    wbString(_20_0TX, '云层材质图层 #2'),
    wbString(_30_0TX, '云层材质图层 #3'),
    wbString(_40_0TX, '云层材质图层 #4'),
    wbString(_50_0TX, '云层材质图层 #5'),
    wbString(_60_0TX, '云层材质图层 #6'),
    wbString(_70_0TX, '云层材质图层 #7'),
    wbString(_80_0TX, '云层材质图层 #8'),
    wbString(_90_0TX, '云层材质图层 #9'),
    wbString(_3A_0TX, '云层材质图层 #10'),
    wbString(_3B_0TX, '云层材质图层 #11'),
    wbString(_3C_0TX, '云层材质图层 #12'),
    wbString(_3D_0TX, '云层材质图层 #13'),
    wbString(_3E_0TX, '云层材质图层 #14'),
    wbString(_3F_0TX, '云层材质图层 #15'),
    wbString(_40h_0TX, '云层材质图层 #16'),
    wbString(A0TX, '云层材质图层 #17'),
    wbString(B0TX, '云层材质图层 #18'),
    wbString(C0TX, '云层材质图层 #19'),
    wbString(D0TX, '云层材质图层 #20'),
    wbString(E0TX, '云层材质图层 #21'),
    wbString(F0TX, '云层材质图层 #22'),
    wbString(G0TX, '云层材质图层 #23'),
    wbString(H0TX, '云层材质图层 #24'),
    wbString(I0TX, '云层材质图层 #25'),
    wbString(J0TX, '云层材质图层 #26'),
    wbString(K0TX, '云层材质图层 #27'),
    wbString(L0TX, '云层材质图层 #28'),
    wbByteArray(DNAM, '未使用', 0, cpIgnore),
    wbByteArray(CNAM, '未使用', 0, cpIgnore),
    wbByteArray(ANAM, '未使用', 0, cpIgnore),
    wbByteArray(BNAM, '未使用', 0, cpIgnore),
    wbUnknown(LNAM),
    wbFormIDCK(MNAM, '颗粒类型', [SPGD, NULL]),
    wbFormIDCK(NNAM, '视觉效果', [RFCT, NULL], False, cpNormal, True),
    wbByteArray(ONAM, '未使用', 0, cpIgnore),
    wbRStruct('云层速度', [
      wbArray(RNAM, 'Y 速度', wbInteger('图层', itU8, wbCloudSpeedToStr, wbCloudSpeedToInt)),
      wbArray(QNAM, 'X 速度', wbInteger('图层', itU8, wbCloudSpeedToStr, wbCloudSpeedToInt))
    ], []),
    wbStruct(PNAM, '云层图层', [
      wbArray('颜色',
        wbStruct('时间', [
          wbInteger('红', itU8),
          wbInteger('绿', itU8),
          wbInteger('蓝', itU8),
          wbByteArray('未知', 1)
        ]),
        ['日出', '白天', '日落', '夜晚']
      ),
      wbArray('未知', wbByteArray('未知', 4))
    ]),
    wbArray(JNAM, '云层', wbStruct('图层', [
      wbFloat('Alpha'),
      wbFloat('未知'),
      wbFloat('未知'),
      wbFloat('未知')
    ])),
    {>>> not as an array since last entries are omitted in skyrim.esm <<<}
    wbStruct(NAM0, '天气颜色', [
      wbArray('天空高层',         wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚']),
      wbArray('雾近距离',          wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚']),
      wbArray('未知',           wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚']),
      wbArray('环境',           wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚']),
      wbArray('日光',          wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚']),
      wbArray('太阳',               wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚']),
      wbArray('星星',             wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚']),
      wbArray('天空低层',         wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚']),
      wbArray('地平线',           wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚']),
      wbArray('效果光',   wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚']),
      wbArray('云层 LOD 漫反射', wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚']),
      wbArray('云层 LOD 环境光', wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚']),
      wbArray('雾远距离',           wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚']),
      wbArray('天空静物',       wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚']),
      wbArray('液态增强',  wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚']),
      wbArray('太阳眩光',         wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚']),
      wbArray('月亮眩光',        wbStruct('颜色', [wbInteger('红', itU8), wbInteger('绿', itU8), wbInteger('蓝', itU8), wbByteArray('未知', 1)]), ['日出', '白天', '日落', '夜晚'])
    ], cpNormal, True, nil, 13),
    wbStruct(FNAM, '水雾距离', [
      wbFloat('白天 - 接近'),
      wbFloat('白天 - 远离'),
      wbFloat('夜晚 - 接近'),
      wbFloat('夜晚 - 远离'),
      wbFloat('白天 - 倍率'),
      wbFloat('夜晚 - 倍率'),
      wbFloat('白天 - 最大'),
      wbFloat('夜晚 - 最大')
    ], cpNormal, True),
    wbStruct(DATA, '数据', [
      wbInteger('风速', itU8), // scaled 0..1
      wbByteArray('未知', 2),
      wbInteger('过渡时长', itU8), // scaled 0..0,25
      wbInteger('太阳眩光', itU8), // scaled 0..1
      wbInteger('太阳伤害', itU8), // scaled 0..1
      wbInteger('颗粒 - 开始淡入', itU8), // scaled 0..1
      wbInteger('颗粒 - 结束淡出', itU8), // scaled 0..1
      wbInteger('雷电 - 开始淡入', itU8),
      wbInteger('雷电 - 结束淡出', itU8),
      wbInteger('雷电 - 频率', itU8),
      wbInteger('标志', itU8, wbFlags([
        {0x01} '天气 - 晴朗',
        {0x02} '天气 - 阴天',
        {0x04} '天气 - 下雨',
        {0x08} '天气 - 下雪',
        {0x10} '天空静物 - 始终可见',
        {0x20} '天空静物 - 位置追随太阳'
      ])),
      wbStruct('闪电颜色', [
        wbInteger('红', itU8),
        wbInteger('绿', itU8),
        wbInteger('蓝', itU8)
      ]),
      wbInteger('视觉效果 - 开始', itU8), // scaled 0..1
      wbInteger('视觉效果 - 结束', itU8), // scaled 0..1
      wbInteger('风向', itU8), // scaled 0..360
      wbInteger('风向范围', itU8) // scaled 0..180
    ], cpNormal, True),
    wbInteger(NAM1, '禁用云层图层', itU32, wbFlags(['0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'])),
    wbRArray('音效',
      wbStruct(SNAM, '音效', [
        wbFormIDCK('音效', [SOUN, SNDR, NULL]),
        wbInteger('类型', itU32, wbEnum([
          {0x01} '默认',
          {0x02} '颗粒',
          {0x04} '风',
          {0x08} '闪电'
        ]))
      ])
    ),
    wbRArrayS('天空静物', wbFormIDCk(TNAM, '静物', [STAT, NULL])),
    wbStruct(IMSP, '图像空间', [
      wbFormIDCK('日出', [IMGS, NULL]),
      wbFormIDCK('白天', [IMGS, NULL]),
      wbFormIDCK('日落', [IMGS, NULL]),
      wbFormIDCK('夜晚', [IMGS, NULL])
    ]),
    wbRArray('定向环境照明颜色',
      wbStruct(DALC, '白天/夜晚/日出/日落顺序', [wbAmbientColors], cpNormal, True)
    ),
    wbByteArray(NAM2, '未使用', 0, cpIgnore),
    wbByteArray(NAM3, '未使用', 0, cpIgnore),
    wbRStruct('极光', [wbMODL], [])
  ]);
end;

{>>> Unused records, they have empty GRUP in skyrim.esm <<<}
procedure DefineTES5p;
begin
  wbRecord(CLDC, 'CLDC', [
    wbEDID
  ]);
  wbRecord(HAIR, 'HAIR', [
    wbEDID
  ]);
  wbRecord(PWAT, 'PWAT', [
    wbEDID
  ]);
  wbRecord(RGDL, 'RGDL', [
    wbEDID
  ]);
  wbRecord(SCOL, 'SCOL', [
    wbEDID
  ]);
  wbRecord(SCPT, 'SCPT', [
    wbEDID
  ]);
end;

procedure DefineTES5q;
begin
   wbAddGroupOrder(GMST);
   wbAddGroupOrder(KYWD);
   wbAddGroupOrder(LCRT);
   wbAddGroupOrder(AACT);
   wbAddGroupOrder(TXST);
   wbAddGroupOrder(GLOB);
   wbAddGroupOrder(CLAS);
   wbAddGroupOrder(FACT);
   wbAddGroupOrder(HDPT);
   wbAddGroupOrder(HAIR);{>>> Unused in Skyrim, but contained in Skyrim.esm <<<}
   wbAddGroupOrder(EYES);
   wbAddGroupOrder(RACE);
   wbAddGroupOrder(SOUN);
   wbAddGroupOrder(ASPC);
   wbAddGroupOrder(MGEF);
   wbAddGroupOrder(SCPT);{>>> Unused in Skyrim, but contained in Skyrim.esm <<<}
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
   wbAddGroupOrder(SCOL);{>>> Unused in Skyrim, but contained in Skyrim.esm <<<}
   wbAddGroupOrder(MSTT);
   wbAddGroupOrder(PWAT);{>>> Unused in Skyrim, but contained in Skyrim.esm <<<}
   wbAddGroupOrder(GRAS);
   wbAddGroupOrder(TREE);
   wbAddGroupOrder(CLDC);{>>> Unused in Skyrim, but contained in Skyrim.esm <<<}
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
   wbAddGroupOrder(PACK);
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
   wbAddGroupOrder(PERK);
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
   wbAddGroupOrder(RGDL);{>>> Unused in Skyrim, but contained in Skyrim.esm <<<}
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
