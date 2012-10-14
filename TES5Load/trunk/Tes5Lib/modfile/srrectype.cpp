/*===========================================================================
 *
 * File:		SrRecType.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srrectype.h"


/*===========================================================================
 *
 * Begin Standard Record Names
 *
 *=========================================================================*/

		/* Special names */
	const srrectype_t SR_NAME_NULL = "\0\0\0\0";
	const srrectype_t SR_NAME_all = "all\0";
	const srrectype_t SR_NAME_SCRI = "SCRI";

		/* Special group name */
	const srrectype_t SR_NAME_GRUP = "GRUP";  
  
		/* Known record names */
	const srrectype_t SR_NAME_AACT = "AACT";
	const srrectype_t SR_NAME_ACHR = "ACHR";
	const srrectype_t SR_NAME_ACTI = "ACTI";
	const srrectype_t SR_NAME_ADDN = "ADDN";
	const srrectype_t SR_NAME_ALCH = "ALCH";
	const srrectype_t SR_NAME_AMMO = "AMMO";
	const srrectype_t SR_NAME_ANIO = "ANIO";
	const srrectype_t SR_NAME_APPA = "APPA";
	const srrectype_t SR_NAME_ARMA = "ARMA";
	const srrectype_t SR_NAME_ARMO = "ARMO";
	const srrectype_t SR_NAME_ARTO = "ARTO";
	const srrectype_t SR_NAME_ASPC = "ASPC";
	const srrectype_t SR_NAME_ASTP = "ASTP";
	const srrectype_t SR_NAME_AVIF = "AVIF";
	const srrectype_t SR_NAME_BOOK = "BOOK";
	const srrectype_t SR_NAME_BPTD = "BPTD";
	const srrectype_t SR_NAME_CAMS = "CAMS";
	const srrectype_t SR_NAME_CELL = "CELL";
	const srrectype_t SR_NAME_CLAS = "CLAS";
	const srrectype_t SR_NAME_CLFM = "CLFM";
	const srrectype_t SR_NAME_CLMT = "CLMT";
	const srrectype_t SR_NAME_COBJ = "COBJ";
	const srrectype_t SR_NAME_COLL = "COLL";
	const srrectype_t SR_NAME_CONT = "CONT";
	const srrectype_t SR_NAME_CPTH = "CPTH";
	const srrectype_t SR_NAME_CSTY = "CSTY";
	const srrectype_t SR_NAME_DEBR = "DEBR";
	const srrectype_t SR_NAME_DIAL = "DIAL";
	const srrectype_t SR_NAME_DLBR = "DLBR";
	const srrectype_t SR_NAME_DLVW = "DLVW";
	const srrectype_t SR_NAME_DOBJ = "DOBJ";
	const srrectype_t SR_NAME_DOOR = "DOOR";
	const srrectype_t SR_NAME_DUAL = "DUAL";
	const srrectype_t SR_NAME_ECZN = "ECZN";
	const srrectype_t SR_NAME_EFSH = "EFSH";
	const srrectype_t SR_NAME_ENCH = "ENCH";
	const srrectype_t SR_NAME_EQUP = "EQUP";
	const srrectype_t SR_NAME_EXPL = "EXPL";
	const srrectype_t SR_NAME_EYES = "EYES";
	const srrectype_t SR_NAME_FACT = "FACT";
	const srrectype_t SR_NAME_FLOR = "FLOR";
	const srrectype_t SR_NAME_FLST = "FLST";
	const srrectype_t SR_NAME_FSTP = "FSTP";
	const srrectype_t SR_NAME_FSTS = "FSTS";
	const srrectype_t SR_NAME_FURN = "FURN";
	const srrectype_t SR_NAME_GLOB = "GLOB";
	const srrectype_t SR_NAME_GMST = "GMST";
	const srrectype_t SR_NAME_GRAS = "GRAS";
	const srrectype_t SR_NAME_HAZD = "HAZD";
	const srrectype_t SR_NAME_HDPT = "HDPT";
	const srrectype_t SR_NAME_IAD = "IAD";
	const srrectype_t SR_NAME_IDLE = "IDLE";
	const srrectype_t SR_NAME_IDLM = "IDLM";
	const srrectype_t SR_NAME_IMAD = "IMAD";
	const srrectype_t SR_NAME_IMGS = "IMGS";
	const srrectype_t SR_NAME_INFO = "INFO";
	const srrectype_t SR_NAME_INGR = "INGR";
	const srrectype_t SR_NAME_IPCT = "IPCT";
	const srrectype_t SR_NAME_IPDS = "IPDS";
	const srrectype_t SR_NAME_KEYM = "KEYM";
	const srrectype_t SR_NAME_KYWD = "KYWD";
	const srrectype_t SR_NAME_LAND = "LAND";
	const srrectype_t SR_NAME_LCRT = "LCRT";
	const srrectype_t SR_NAME_LCTN = "LCTN";
	const srrectype_t SR_NAME_LGTM = "LGTM";
	const srrectype_t SR_NAME_LIGH = "LIGH";
	const srrectype_t SR_NAME_LSCR = "LSCR";
	const srrectype_t SR_NAME_LTEX = "LTEX";
	const srrectype_t SR_NAME_LVLI = "LVLI";
	const srrectype_t SR_NAME_LVLN = "LVLN";
	const srrectype_t SR_NAME_LVSP = "LVSP";
	const srrectype_t SR_NAME_MATO = "MATO";
	const srrectype_t SR_NAME_MATT = "MATT";
	const srrectype_t SR_NAME_MESG = "MESG";
	const srrectype_t SR_NAME_MGEF = "MGEF";
	const srrectype_t SR_NAME_MISC = "MISC";
	const srrectype_t SR_NAME_MOVT = "MOVT";
	const srrectype_t SR_NAME_MSTT = "MSTT";
	const srrectype_t SR_NAME_MUSC = "MUSC";
	const srrectype_t SR_NAME_MUST = "MUST";
	const srrectype_t SR_NAME_NAVI = "NAVI";
	const srrectype_t SR_NAME_NAVM = "NAVM";
	const srrectype_t SR_NAME_NPC_ = "NPC_";
	const srrectype_t SR_NAME_OTFT = "OTFT";
	const srrectype_t SR_NAME_PACK = "PACK";
	const srrectype_t SR_NAME_PERK = "PERK";
	const srrectype_t SR_NAME_PGRE = "PGRE";
	const srrectype_t SR_NAME_PHZD = "PHZD";
	const srrectype_t SR_NAME_PROJ = "PROJ";
	const srrectype_t SR_NAME_QUST = "QUST";
	const srrectype_t SR_NAME_RACE = "RACE";
	const srrectype_t SR_NAME_REFR = "REFR";
	const srrectype_t SR_NAME_REGN = "REGN";
	const srrectype_t SR_NAME_RELA = "RELA";
	const srrectype_t SR_NAME_REVB = "REVB";
	const srrectype_t SR_NAME_RFCT = "RFCT";
	const srrectype_t SR_NAME_SCEN = "SCEN";
	const srrectype_t SR_NAME_SCRL = "SCRL";
	const srrectype_t SR_NAME_SHOU = "SHOU";
	const srrectype_t SR_NAME_SLGM = "SLGM";
	const srrectype_t SR_NAME_SMBN = "SMBN";
	const srrectype_t SR_NAME_SMEN = "SMEN";
	const srrectype_t SR_NAME_SMQN = "SMQN";
	const srrectype_t SR_NAME_SNCT = "SNCT";
	const srrectype_t SR_NAME_SNDR = "SNDR";
	const srrectype_t SR_NAME_SOPM = "SOPM";
	const srrectype_t SR_NAME_SOUN = "SOUN";
	const srrectype_t SR_NAME_SPEL = "SPEL";
	const srrectype_t SR_NAME_SPGD = "SPGD";
	const srrectype_t SR_NAME_STAT = "STAT";
	const srrectype_t SR_NAME_TACT = "TACT";
	const srrectype_t SR_NAME_TES4 = "TES4";
	const srrectype_t SR_NAME_TREE = "TREE";
	const srrectype_t SR_NAME_TXST = "TXST";
	const srrectype_t SR_NAME_VTYP = "VTYP";
	const srrectype_t SR_NAME_WATR = "WATR";
	const srrectype_t SR_NAME_WEAP = "WEAP";
	const srrectype_t SR_NAME_WOOP = "WOOP";
	const srrectype_t SR_NAME_WRLD = "WRLD";
	const srrectype_t SR_NAME_WTHR = "WTHR";
/*===========================================================================
 *		End of Standard Record Names
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Standard Subrecord Names
 *
 *=========================================================================*/
	const srrectype_t SR_NAME_00TX = "00TX";
	const srrectype_t SR_NAME_10TX = "10TX";
	const srrectype_t SR_NAME_20TX = "20TX";
	const srrectype_t SR_NAME_30TX = "30TX";
	const srrectype_t SR_NAME_40TX = "40TX";
	const srrectype_t SR_NAME_50TX = "50TX";
	const srrectype_t SR_NAME_60TX = "60TX";
	const srrectype_t SR_NAME_70TX = "70TX";
	const srrectype_t SR_NAME_80TX = "80TX";
	const srrectype_t SR_NAME_90TX = "90TX";
	const srrectype_t SR_NAME_A0TX = "A0TX";
	const srrectype_t SR_NAME_ACBS = "ACBS";
	const srrectype_t SR_NAME_AHCF = "AHCF";
	const srrectype_t SR_NAME_AHCM = "AHCM";
	const srrectype_t SR_NAME_AIAD = "AIAD";
	const srrectype_t SR_NAME_AIDT = "AIDT";
	const srrectype_t SR_NAME_ALCA = "ALCA";
	const srrectype_t SR_NAME_ALCL = "ALCL";
	const srrectype_t SR_NAME_ALCO = "ALCO";
	const srrectype_t SR_NAME_ALDN = "ALDN";
	const srrectype_t SR_NAME_ALEA = "ALEA";
	const srrectype_t SR_NAME_ALED = "ALED";
	const srrectype_t SR_NAME_ALEQ = "ALEQ";
	const srrectype_t SR_NAME_ALFA = "ALFA";
	const srrectype_t SR_NAME_ALFC = "ALFC";
	const srrectype_t SR_NAME_ALFD = "ALFD";
	const srrectype_t SR_NAME_ALFE = "ALFE";
	const srrectype_t SR_NAME_ALFI = "ALFI";
	const srrectype_t SR_NAME_ALFL = "ALFL";
	const srrectype_t SR_NAME_ALFR = "ALFR";
	const srrectype_t SR_NAME_ALID = "ALID";
	const srrectype_t SR_NAME_ALLS = "ALLS";
	const srrectype_t SR_NAME_ALNA = "ALNA";
	const srrectype_t SR_NAME_ALNT = "ALNT";
	const srrectype_t SR_NAME_ALPC = "ALPC";
	const srrectype_t SR_NAME_ALRT = "ALRT";
	const srrectype_t SR_NAME_ALSP = "ALSP";
	const srrectype_t SR_NAME_ALST = "ALST";
	const srrectype_t SR_NAME_ALUA = "ALUA";
	const srrectype_t SR_NAME_ANAM = "ANAM";
	const srrectype_t SR_NAME_ATKD = "ATKD";
	const srrectype_t SR_NAME_ATKE = "ATKE";
	const srrectype_t SR_NAME_ATKR = "ATKR";
	const srrectype_t SR_NAME_ATXT = "ATXT";
	const srrectype_t SR_NAME_AVSK = "AVSK";
	const srrectype_t SR_NAME_B0TX = "B0TX";
	const srrectype_t SR_NAME_BAMT = "BAMT";
	const srrectype_t SR_NAME_BIAD = "BIAD";
	const srrectype_t SR_NAME_BIDS = "BIDS";
	const srrectype_t SR_NAME_BNAM = "BNAM";
	const srrectype_t SR_NAME_BODT = "BODT";
	const srrectype_t SR_NAME_BPND = "BPND";
	const srrectype_t SR_NAME_BPNI = "BPNI";
	const srrectype_t SR_NAME_BPNN = "BPNN";
	const srrectype_t SR_NAME_BPNT = "BPNT";
	const srrectype_t SR_NAME_BPTN = "BPTN";
	const srrectype_t SR_NAME_BTXT = "BTXT";
	const srrectype_t SR_NAME_C0TX = "C0TX";
	const srrectype_t SR_NAME_CIAD = "CIAD";
	const srrectype_t SR_NAME_CIS1 = "CIS1";
	const srrectype_t SR_NAME_CIS2 = "CIS2";
	const srrectype_t SR_NAME_CITC = "CITC";
	const srrectype_t SR_NAME_CNAM = "CNAM";
	const srrectype_t SR_NAME_CNTO = "CNTO";
	const srrectype_t SR_NAME_COCT = "COCT";
	const srrectype_t SR_NAME_COED = "COED";
	const srrectype_t SR_NAME_CRDT = "CRDT";
	const srrectype_t SR_NAME_CRGR = "CRGR";
	const srrectype_t SR_NAME_CRIF = "CRIF";
	const srrectype_t SR_NAME_CRVA = "CRVA";
	const srrectype_t SR_NAME_CSCR = "CSCR";
	const srrectype_t SR_NAME_CSDC = "CSDC";
	const srrectype_t SR_NAME_CSDI = "CSDI";
	const srrectype_t SR_NAME_CSDT = "CSDT";
	const srrectype_t SR_NAME_CSFL = "CSFL";
	const srrectype_t SR_NAME_CSGD = "CSGD";
	const srrectype_t SR_NAME_CSLR = "CSLR";
	const srrectype_t SR_NAME_CSMD = "CSMD";
	const srrectype_t SR_NAME_CSME = "CSME";
	const srrectype_t SR_NAME_CTDA = "CTDA";
	const srrectype_t SR_NAME_D0TX = "D0TX";
	const srrectype_t SR_NAME_DALC = "DALC";
	const srrectype_t SR_NAME_DATA = "DATA";
	const srrectype_t SR_NAME_DEMO = "DEMO";
	const srrectype_t SR_NAME_DESC = "DESC";
	const srrectype_t SR_NAME_DEST = "DEST";
	const srrectype_t SR_NAME_DEVA = "DEVA";
	const srrectype_t SR_NAME_DFTF = "DFTF";
	const srrectype_t SR_NAME_DFTM = "DFTM";
	const srrectype_t SR_NAME_DIAD = "DIAD";
	const srrectype_t SR_NAME_DMAX = "DMAX";
	const srrectype_t SR_NAME_DMDL = "DMDL";
	const srrectype_t SR_NAME_DMDS = "DMDS";
	const srrectype_t SR_NAME_DMDT = "DMDT";
	const srrectype_t SR_NAME_DMIN = "DMIN";
	const srrectype_t SR_NAME_DNAM = "DNAM";
	const srrectype_t SR_NAME_DODT = "DODT";
	const srrectype_t SR_NAME_DOFT = "DOFT";
	const srrectype_t SR_NAME_DPLT = "DPLT";
	const srrectype_t SR_NAME_DSTD = "DSTD";
	const srrectype_t SR_NAME_DSTF = "DSTF";
	const srrectype_t SR_NAME_E0TX = "E0TX";
	const srrectype_t SR_NAME_EAMT = "EAMT";
	const srrectype_t SR_NAME_ECOR = "ECOR";
	const srrectype_t SR_NAME_EDID = "EDID";
	const srrectype_t SR_NAME_EFID = "EFID";
	const srrectype_t SR_NAME_EFIT = "EFIT";
	const srrectype_t SR_NAME_EIAD = "EIAD";
	const srrectype_t SR_NAME_EITM = "EITM";
	const srrectype_t SR_NAME_ENAM = "ENAM";
	const srrectype_t SR_NAME_ENIT = "ENIT";
	const srrectype_t SR_NAME_EPF2 = "EPF2";
	const srrectype_t SR_NAME_EPF3 = "EPF3";
	const srrectype_t SR_NAME_EPFD = "EPFD";
	const srrectype_t SR_NAME_EPFT = "EPFT";
	const srrectype_t SR_NAME_ESCE = "ESCE";	
	const srrectype_t SR_NAME_ETYP = "ETYP";
	const srrectype_t SR_NAME_F0TX = "F0TX";
	const srrectype_t SR_NAME_FCHT = "FCHT";
	const srrectype_t SR_NAME_FIAD = "FIAD";
	const srrectype_t SR_NAME_FLMV = "FLMV";
	const srrectype_t SR_NAME_FLTR = "FLTR";
	const srrectype_t SR_NAME_FLTV = "FLTV";
	const srrectype_t SR_NAME_FNAM = "FNAM";
	const srrectype_t SR_NAME_FNMK = "FNMK";
	const srrectype_t SR_NAME_FNPR = "FNPR";
	const srrectype_t SR_NAME_FPRT = "FPRT";
	const srrectype_t SR_NAME_FTSF = "FTSF";
	const srrectype_t SR_NAME_FTSM = "FTSM";
	const srrectype_t SR_NAME_FTST = "FTST";
	const srrectype_t SR_NAME_FULL = "FULL";
	const srrectype_t SR_NAME_G0TX = "G0TX";
	const srrectype_t SR_NAME_GIAD = "GIAD";
	const srrectype_t SR_NAME_GNAM = "GNAM";
	const srrectype_t SR_NAME_H0TX = "H0TX";
	const srrectype_t SR_NAME_HCLF = "HCLF";
	const srrectype_t SR_NAME_HEAD = "HEAD";
	const srrectype_t SR_NAME_HEDR = "HEDR";
	const srrectype_t SR_NAME_HIAD = "HIAD";
	const srrectype_t SR_NAME_HNAM = "HNAM";
	const srrectype_t SR_NAME_HTID = "HTID";
	const srrectype_t SR_NAME_I0TX = "I0TX";
	const srrectype_t SR_NAME_ICO2 = "ICO2";
	const srrectype_t SR_NAME_ICON = "ICON";
	const srrectype_t SR_NAME_IDLA = "IDLA";
	const srrectype_t SR_NAME_IDLC = "IDLC";
	const srrectype_t SR_NAME_IDLF = "IDLF";
	const srrectype_t SR_NAME_IDLT = "IDLT";
	const srrectype_t SR_NAME_IIAD = "IIAD";
	const srrectype_t SR_NAME_IMSP = "IMSP";
	const srrectype_t SR_NAME_INAM = "INAM";
	const srrectype_t SR_NAME_INDX = "INDX";
	const srrectype_t SR_NAME_INTV = "INTV";
	const srrectype_t SR_NAME_ITXT = "ITXT";
	const srrectype_t SR_NAME_J0TX = "J0TX";
	const srrectype_t SR_NAME_JAIL = "JAIL";
	const srrectype_t SR_NAME_JIAD = "JIAD";
	const srrectype_t SR_NAME_JNAM = "JNAM";
	const srrectype_t SR_NAME_JOUT = "JOUT";
	const srrectype_t SR_NAME_K0TX = "K0TX";
	const srrectype_t SR_NAME_KIAD = "KIAD";
	const srrectype_t SR_NAME_KNAM = "KNAM";
	const srrectype_t SR_NAME_KSIZ = "KSIZ";
	const srrectype_t SR_NAME_KWDA = "KWDA";
	const srrectype_t SR_NAME_L0TX = "L0TX";
	const srrectype_t SR_NAME_LCEC = "LCEC";
	const srrectype_t SR_NAME_LCEP = "LCEP";
	const srrectype_t SR_NAME_LCID = "LCID";
	const srrectype_t SR_NAME_LCPR = "LCPR";
	const srrectype_t SR_NAME_LCSR = "LCSR";
	const srrectype_t SR_NAME_LCUN = "LCUN";
	const srrectype_t SR_NAME_LIAD = "LIAD";
	const srrectype_t SR_NAME_LLCT = "LLCT";
	const srrectype_t SR_NAME_LNAM = "LNAM";
	const srrectype_t SR_NAME_LTMP = "LTMP";
	const srrectype_t SR_NAME_LVLD = "LVLD";
	const srrectype_t SR_NAME_LVLF = "LVLF";
	const srrectype_t SR_NAME_LVLG = "LVLG";
	const srrectype_t SR_NAME_LVLO = "LVLO";
	const srrectype_t SR_NAME_MAST = "MAST";
	const srrectype_t SR_NAME_MCHT = "MCHT";
	const srrectype_t SR_NAME_MDOB = "MDOB";
	const srrectype_t SR_NAME_MHDT = "MHDT";
	const srrectype_t SR_NAME_MIAD = "MIAD";
	const srrectype_t SR_NAME_MICO = "MICO";	
	const srrectype_t SR_NAME_MNAM = "MNAM";
	const srrectype_t SR_NAME_MO2S = "MO2S";
	const srrectype_t SR_NAME_MO2T = "MO2T";
	const srrectype_t SR_NAME_MO3S = "MO3S";
	const srrectype_t SR_NAME_MO3T = "MO3T";
	const srrectype_t SR_NAME_MO4S = "MO4S";
	const srrectype_t SR_NAME_MO4T = "MO4T";
	const srrectype_t SR_NAME_MO5T = "MO5T";
	const srrectype_t SR_NAME_MOD2 = "MOD2";
	const srrectype_t SR_NAME_MOD3 = "MOD3";
	const srrectype_t SR_NAME_MOD4 = "MOD4";
	const srrectype_t SR_NAME_MOD5 = "MOD5";
	const srrectype_t SR_NAME_MODL = "MODL";
	const srrectype_t SR_NAME_MODS = "MODS";
	const srrectype_t SR_NAME_MODT = "MODT";
	const srrectype_t SR_NAME_MPAI = "MPAI";
	const srrectype_t SR_NAME_MPAV = "MPAV";
	const srrectype_t SR_NAME_MPRT = "MPRT";
	const srrectype_t SR_NAME_MTNM = "MTNM";
	const srrectype_t SR_NAME_MTYP = "MTYP";
	const srrectype_t SR_NAME_NAM0 = "NAM0";
	const srrectype_t SR_NAME_NAM1 = "NAM1";
	const srrectype_t SR_NAME_NAM2 = "NAM2";
	const srrectype_t SR_NAME_NAM3 = "NAM3";
	const srrectype_t SR_NAME_NAM4 = "NAM4";
	const srrectype_t SR_NAME_NAM5 = "NAM5";
	const srrectype_t SR_NAME_NAM6 = "NAM6";
	const srrectype_t SR_NAME_NAM7 = "NAM7";
	const srrectype_t SR_NAME_NAM8 = "NAM8";
	const srrectype_t SR_NAME_NAM9 = "NAM9";
	const srrectype_t SR_NAME_NAMA = "NAMA";
	const srrectype_t SR_NAME_NAME = "NAME";
	const srrectype_t SR_NAME_NEXT = "NEXT";
	const srrectype_t SR_NAME_NIAD = "NIAD";
	const srrectype_t SR_NAME_NNAM = "NNAM";
	const srrectype_t SR_NAME_NVER = "NVER";
	const srrectype_t SR_NAME_NVMI = "NVMI";
	const srrectype_t SR_NAME_NVNM = "NVNM";
	const srrectype_t SR_NAME_NVPP = "NVPP";
	const srrectype_t SR_NAME_OBND = "OBND";
	const srrectype_t SR_NAME_OFST = "OFST";
	const srrectype_t SR_NAME_OIAD = "OIAD";
	const srrectype_t SR_NAME_ONAM = "ONAM";
	const srrectype_t SR_NAME_PDTO = "PDTO";
	const srrectype_t SR_NAME_PFIG = "PFIG";
	const srrectype_t SR_NAME_PFO2 = "PFO2";
	const srrectype_t SR_NAME_PFOR = "PFOR";
	const srrectype_t SR_NAME_PFPC = "PFPC";
	const srrectype_t SR_NAME_PHTN = "PHTN";
	const srrectype_t SR_NAME_PHWT = "PHWT";
	const srrectype_t SR_NAME_PIAD = "PIAD";
	const srrectype_t SR_NAME_PKC2 = "PKC2";
	const srrectype_t SR_NAME_PKCU = "PKCU";
	const srrectype_t SR_NAME_PKDT = "PKDT";
	const srrectype_t SR_NAME_PKID = "PKID";
	const srrectype_t SR_NAME_PLCN = "PLCN";
	const srrectype_t SR_NAME_PLDT = "PLDT";
	const srrectype_t SR_NAME_PLVD = "PLVD";
	const srrectype_t SR_NAME_PNAM = "PNAM";
	const srrectype_t SR_NAME_POBA = "POBA";
	const srrectype_t SR_NAME_POCA = "POCA";
	const srrectype_t SR_NAME_POEA = "POEA";
	const srrectype_t SR_NAME_PRCB = "PRCB";
	const srrectype_t SR_NAME_PRKC = "PRKC";
	const srrectype_t SR_NAME_PRKE = "PRKE";
	const srrectype_t SR_NAME_PRKF = "PRKF";
	const srrectype_t SR_NAME_PRKR = "PRKR";
	const srrectype_t SR_NAME_PRKZ = "PRKZ";
	const srrectype_t SR_NAME_PSDT = "PSDT";
	const srrectype_t SR_NAME_PTDA = "PTDA";
	const srrectype_t SR_NAME_QIAD = "QIAD";
	const srrectype_t SR_NAME_QNAM = "QNAM";
	const srrectype_t SR_NAME_QOBJ = "QOBJ";
	const srrectype_t SR_NAME_QSDT = "QSDT";
	const srrectype_t SR_NAME_QSTA = "QSTA";
	const srrectype_t SR_NAME_QTGL = "QTGL";
	const srrectype_t SR_NAME_QUAL = "QUAL";
	const srrectype_t SR_NAME_RCLR = "RCLR";
	const srrectype_t SR_NAME_RDAT = "RDAT";
	const srrectype_t SR_NAME_RDMO = "RDMO";
	const srrectype_t SR_NAME_RDMP = "RDMP";
	const srrectype_t SR_NAME_RDOT = "RDOT";
	const srrectype_t SR_NAME_RDSA = "RDSA";
	const srrectype_t SR_NAME_RDWT = "RDWT";
	const srrectype_t SR_NAME_RIAD = "RIAD";
	const srrectype_t SR_NAME_RNAM = "RNAM";
	const srrectype_t SR_NAME_RNMV = "RNMV";
	const srrectype_t SR_NAME_RPLD = "RPLD";
	const srrectype_t SR_NAME_RPLI = "RPLI";
	const srrectype_t SR_NAME_RPRF = "RPRF";
	const srrectype_t SR_NAME_RPRM = "RPRM";
	const srrectype_t SR_NAME_SCDA = "SCDA";
	const srrectype_t SR_NAME_SCHR = "SCHR";
	const srrectype_t SR_NAME_SCRO = "SCRO";
	const srrectype_t SR_NAME_SCTX = "SCTX";
	const srrectype_t SR_NAME_SDSC = "SDSC";
	const srrectype_t SR_NAME_SHRT = "SHRT";
	const srrectype_t SR_NAME_SIAD = "SIAD";
	const srrectype_t SR_NAME_SLCP = "SLCP";
	const srrectype_t SR_NAME_SNAM = "SNAM";
	const srrectype_t SR_NAME_SNDD = "SNDD";
	const srrectype_t SR_NAME_SNMV = "SNMV";
	const srrectype_t SR_NAME_SOFT = "SOFT";
	const srrectype_t SR_NAME_SOUL = "SOUL";
	const srrectype_t SR_NAME_SPCT = "SPCT";
	const srrectype_t SR_NAME_SPED = "SPED";
	const srrectype_t SR_NAME_SPIT = "SPIT";
	const srrectype_t SR_NAME_SPLO = "SPLO";
	const srrectype_t SR_NAME_SPOR = "SPOR";
	const srrectype_t SR_NAME_STOL = "STOL";
	const srrectype_t SR_NAME_SWMV = "SWMV";
	const srrectype_t SR_NAME_TCLT = "TCLT";
	const srrectype_t SR_NAME_TIAD = "TIAD";
	const srrectype_t SR_NAME_TIAS = "TIAS";
	const srrectype_t SR_NAME_TIFC = "TIFC";
	const srrectype_t SR_NAME_TINC = "TINC";
	const srrectype_t SR_NAME_TIND = "TIND";
	const srrectype_t SR_NAME_TINI = "TINI";
	const srrectype_t SR_NAME_TINL = "TINL";
	const srrectype_t SR_NAME_TINP = "TINP";
	const srrectype_t SR_NAME_TINT = "TINT";
	const srrectype_t SR_NAME_TINV = "TINV";
	const srrectype_t SR_NAME_TIRS = "TIRS";
	const srrectype_t SR_NAME_TNAM = "TNAM";
	const srrectype_t SR_NAME_TPIC = "TPIC";
	const srrectype_t SR_NAME_TPLT = "TPLT";
	const srrectype_t SR_NAME_TRDT = "TRDT";
	const srrectype_t SR_NAME_TVDT = "TVDT";
	const srrectype_t SR_NAME_TWAT = "TWAT";
	const srrectype_t SR_NAME_TX00 = "TX00";
	const srrectype_t SR_NAME_TX01 = "TX01";
	const srrectype_t SR_NAME_TX02 = "TX02";
	const srrectype_t SR_NAME_TX03 = "TX03";
	const srrectype_t SR_NAME_TX04 = "TX04";
	const srrectype_t SR_NAME_TX05 = "TX05";
	const srrectype_t SR_NAME_TX07 = "TX07";
	const srrectype_t SR_NAME_UNAM = "UNAM";
	const srrectype_t SR_NAME_UNES = "UNES";
	const srrectype_t SR_NAME_VCLR = "VCLR";
	const srrectype_t SR_NAME_VENC = "VENC";
	const srrectype_t SR_NAME_VEND = "VEND";
	const srrectype_t SR_NAME_VENV = "VENV";
	const srrectype_t SR_NAME_VHGT = "VHGT";
	const srrectype_t SR_NAME_VMAD = "VMAD";
	const srrectype_t SR_NAME_VNAM = "VNAM";
	const srrectype_t SR_NAME_VNML = "VNML";
	const srrectype_t SR_NAME_VTCK = "VTCK";
	const srrectype_t SR_NAME_VTXT = "VTXT";
	const srrectype_t SR_NAME_WAIT = "WAIT";
	const srrectype_t SR_NAME_WBDT = "WBDT";
	const srrectype_t SR_NAME_WCTR = "WCTR";
	const srrectype_t SR_NAME_WKMV = "WKMV";
	const srrectype_t SR_NAME_WLST = "WLST";
	const srrectype_t SR_NAME_WNAM = "WNAM";
	const srrectype_t SR_NAME_XACT = "XACT";
	const srrectype_t SR_NAME_XALP = "XALP";
	const srrectype_t SR_NAME_XAPD = "XAPD";
	const srrectype_t SR_NAME_XAPR = "XAPR";
	const srrectype_t SR_NAME_XCAS = "XCAS";
	const srrectype_t SR_NAME_XCCM = "XCCM";
	const srrectype_t SR_NAME_XCIM = "XCIM";
	const srrectype_t SR_NAME_XCLC = "XCLC";
	const srrectype_t SR_NAME_XCLL = "XCLL";
	const srrectype_t SR_NAME_XCLR = "XCLR";
	const srrectype_t SR_NAME_XCLW = "XCLW";
	const srrectype_t SR_NAME_XCMO = "XCMO";
	const srrectype_t SR_NAME_XCNT = "XCNT";
	const srrectype_t SR_NAME_XCVL = "XCVL";
	const srrectype_t SR_NAME_XCWT = "XCWT";
	const srrectype_t SR_NAME_XCZA = "XCZA";
	const srrectype_t SR_NAME_XCZC = "XCZC";
	const srrectype_t SR_NAME_XEMI = "XEMI";
	const srrectype_t SR_NAME_XESP = "XESP";
	const srrectype_t SR_NAME_XEZN = "XEZN";
	const srrectype_t SR_NAME_XFVC = "XFVC";
	const srrectype_t SR_NAME_XHOR = "XHOR";
	const srrectype_t SR_NAME_XHTW = "XHTW";
	const srrectype_t SR_NAME_XILL = "XILL";
	const srrectype_t SR_NAME_XIS2 = "XIS2";
	const srrectype_t SR_NAME_XLCM = "XLCM";
	const srrectype_t SR_NAME_XLCN = "XLCN";
	const srrectype_t SR_NAME_XLIB = "XLIB";
	const srrectype_t SR_NAME_XLIG = "XLIG";
	const srrectype_t SR_NAME_XLKR = "XLKR";
	const srrectype_t SR_NAME_XLOC = "XLOC";
	const srrectype_t SR_NAME_XLRM = "XLRM";
	const srrectype_t SR_NAME_XLRT = "XLRT";
	const srrectype_t SR_NAME_XLTW = "XLTW";
	const srrectype_t SR_NAME_XMBO = "XMBO";
	const srrectype_t SR_NAME_XMBP = "XMBP";
	const srrectype_t SR_NAME_XMBR = "XMBR";
	const srrectype_t SR_NAME_XMRK = "XMRK";
	const srrectype_t SR_NAME_XNAM = "XNAM";
	const srrectype_t SR_NAME_XNDP = "XNDP";
	const srrectype_t SR_NAME_XOCP = "XOCP";
	const srrectype_t SR_NAME_XOWN = "XOWN";
	const srrectype_t SR_NAME_XPOD = "XPOD";
	const srrectype_t SR_NAME_XPPA = "XPPA";
	const srrectype_t SR_NAME_XPRD = "XPRD";
	const srrectype_t SR_NAME_XPRM = "XPRM";
	const srrectype_t SR_NAME_XPWR = "XPWR";
	const srrectype_t SR_NAME_XRDS = "XRDS";
	const srrectype_t SR_NAME_XRGB = "XRGB";
	const srrectype_t SR_NAME_XRGD = "XRGD";
	const srrectype_t SR_NAME_XRMR = "XRMR";
	const srrectype_t SR_NAME_XRNK = "XRNK";
	const srrectype_t SR_NAME_XSCL = "XSCL";
	const srrectype_t SR_NAME_XSPC = "XSPC";
	const srrectype_t SR_NAME_XTEL = "XTEL";
	const srrectype_t SR_NAME_XTNM = "XTNM";
	const srrectype_t SR_NAME_XTRI = "XTRI";
	const srrectype_t SR_NAME_XWCN = "XWCN";
	const srrectype_t SR_NAME_XWCS = "XWCS";
	const srrectype_t SR_NAME_XWCU = "XWCU";
	const srrectype_t SR_NAME_XWEM = "XWEM";
	const srrectype_t SR_NAME_XXXX = "XXXX";
	const srrectype_t SR_NAME_YNAM = "YNAM";
	const srrectype_t SR_NAME_ZNAM = "ZNAM";


		/* Custom names for internal use */
	const srrectype_t SR_NAME_psec = "psec";
	const srrectype_t SR_NAME_pssc = "pssc";

/*===========================================================================
 *		End of Standard Subrecord Names
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Magic Effect IDs
 *
 *=========================================================================*/
  
/*===========================================================================
 *		End of Magic Effect IDs
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool ReadSrRecType (File, Name);
 *
 * Reads a 4-byte record type field returning false on any error.
 *
 *=========================================================================*/
bool ReadSrRecType (CSrFile& File, srrectype_t& Name)
{
  return File.Read((void *)&Name, SR_RECTYPE_SIZE);
}
/*===========================================================================
 *		End of Function ReadSrRecType()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool WriteSrRecType (File, Name);
 *
 * Writes a 4-byte record type field returning false on any error.
 *
 *=========================================================================*/
bool WriteSrRecType (CSrFile& File, const srrectype_t Name)
{
  return File.Write((void *)&Name, SR_RECTYPE_SIZE);
}
/*===========================================================================
 *		End of Function WriteSrRecType()
 *=========================================================================*/


