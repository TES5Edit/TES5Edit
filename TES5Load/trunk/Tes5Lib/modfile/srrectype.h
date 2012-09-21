/*===========================================================================
 *
 * File:		SrRecType.H
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Contains definitions related to the record, group, and subrecord type
 * fields. The type field is a 4 byte value that uses 4 characters to
 * describe it: "TES4", "HEDR", "GRUP", etc... While it is convienient
 * to consider them as a string (not nul terminated) from the user's
 * perspective, it is better to treat them as a 32-bit dword from a 
 * programming perspective. 
 *
 *=========================================================================*/
#ifndef __SRRECTYPE_H
#define __SRRECTYPE_H


/*===========================================================================
 *
 * Begin Required Includes
 *
 *=========================================================================*/
  #include "../common/srfile.h"
/*===========================================================================
 *		End of Required Includes
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Definitions
 *
 *=========================================================================*/

	/* Name field size */
  #define SR_RECTYPE_SIZE (4)

/*===========================================================================
 *		End of Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Type Definitions
 *
 *=========================================================================*/
#pragma pack(push, 1)

	/* Standard record/sub-record name field */
  union srrectype_t {
  
  		char  Name[SR_RECTYPE_SIZE];
		dword Value;

			/* Constructors */
		srrectype_t (const dword Val = 0) { Value = Val; }
		srrectype_t (const char* pString) { Value = *(dword *) pString; }

			/* Conversion Operators */
		operator const char* (void) const { return (Name); }
		operator const dword (void) const { return (Value); }

		const srrectype_t& operator= (const char* pString) 
		{
			Value = *(const dword *) pString; 
			Name[0] = toupper(Name[0]); 
			Name[1] = toupper(Name[1]); 
			Name[2] = toupper(Name[2]); 
			Name[3] = toupper(Name[3]); 
			return (*this); 
		}

		const srrectype_t& operator= (const dword InValue) 
		{ 
			Value = InValue; return (*this); 
		}

  };

#pragma pack(pop)
/*===========================================================================
 *		End of Type Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin External Definitions
 *
 *=========================================================================*/

		/* Special names */
	extern const srrectype_t SR_NAME_NULL;
	extern const srrectype_t SR_NAME_all;
	extern const srrectype_t SR_NAME_SCRI;

		/* Special group name */
	extern const srrectype_t SR_NAME_GRUP;
	
		/* Known record names */
	extern const srrectype_t SR_NAME_AACT;
	extern const srrectype_t SR_NAME_ACHR;
	extern const srrectype_t SR_NAME_ACTI;
	extern const srrectype_t SR_NAME_ADDN;
	extern const srrectype_t SR_NAME_ALCH;
	extern const srrectype_t SR_NAME_AMMO;
	extern const srrectype_t SR_NAME_ANIO;
	extern const srrectype_t SR_NAME_APPA;
	extern const srrectype_t SR_NAME_ARMA;
	extern const srrectype_t SR_NAME_ARMO;
	extern const srrectype_t SR_NAME_ARTO;
	extern const srrectype_t SR_NAME_ASPC;
	extern const srrectype_t SR_NAME_ASTP;
	extern const srrectype_t SR_NAME_AVIF;
	extern const srrectype_t SR_NAME_BOOK;
	extern const srrectype_t SR_NAME_BPTD;
	extern const srrectype_t SR_NAME_CAMS;
	extern const srrectype_t SR_NAME_CELL;
	extern const srrectype_t SR_NAME_CLAS;
	extern const srrectype_t SR_NAME_CLFM;
	extern const srrectype_t SR_NAME_CLMT;
	extern const srrectype_t SR_NAME_COBJ;
	extern const srrectype_t SR_NAME_COLL;
	extern const srrectype_t SR_NAME_CONT;
	extern const srrectype_t SR_NAME_CPTH;
	extern const srrectype_t SR_NAME_CSTY;
	extern const srrectype_t SR_NAME_DEBR;
	extern const srrectype_t SR_NAME_DIAL;
	extern const srrectype_t SR_NAME_DLBR;
	extern const srrectype_t SR_NAME_DLVW;
	extern const srrectype_t SR_NAME_DOBJ;
	extern const srrectype_t SR_NAME_DOOR;
	extern const srrectype_t SR_NAME_DUAL;
	extern const srrectype_t SR_NAME_ECZN;
	extern const srrectype_t SR_NAME_EFSH;
	extern const srrectype_t SR_NAME_ENCH;
	extern const srrectype_t SR_NAME_EQUP;
	extern const srrectype_t SR_NAME_EXPL;
	extern const srrectype_t SR_NAME_EYES;
	extern const srrectype_t SR_NAME_FACT;
	extern const srrectype_t SR_NAME_FLOR;
	extern const srrectype_t SR_NAME_FLST;
	extern const srrectype_t SR_NAME_FSTP;
	extern const srrectype_t SR_NAME_FSTS;
	extern const srrectype_t SR_NAME_FURN;
	extern const srrectype_t SR_NAME_GLOB;
	extern const srrectype_t SR_NAME_GMST;
	extern const srrectype_t SR_NAME_GRAS;
	extern const srrectype_t SR_NAME_HAZD;
	extern const srrectype_t SR_NAME_HDPT;
	extern const srrectype_t SR_NAME_IAD;
	extern const srrectype_t SR_NAME_IDLE;
	extern const srrectype_t SR_NAME_IDLM;
	extern const srrectype_t SR_NAME_IMAD;
	extern const srrectype_t SR_NAME_IMGS;
	extern const srrectype_t SR_NAME_INFO;
	extern const srrectype_t SR_NAME_INGR;
	extern const srrectype_t SR_NAME_IPCT;
	extern const srrectype_t SR_NAME_IPDS;
	extern const srrectype_t SR_NAME_KEYM;
	extern const srrectype_t SR_NAME_KYWD;
	extern const srrectype_t SR_NAME_LAND;
	extern const srrectype_t SR_NAME_LCRT;
	extern const srrectype_t SR_NAME_LCTN;
	extern const srrectype_t SR_NAME_LGTM;
	extern const srrectype_t SR_NAME_LIGH;
	extern const srrectype_t SR_NAME_LSCR;
	extern const srrectype_t SR_NAME_LTEX;
	extern const srrectype_t SR_NAME_LVLI;
	extern const srrectype_t SR_NAME_LVLN;
	extern const srrectype_t SR_NAME_LVSP;
	extern const srrectype_t SR_NAME_MATO;
	extern const srrectype_t SR_NAME_MATT;
	extern const srrectype_t SR_NAME_MESG;
	extern const srrectype_t SR_NAME_MGEF;
	extern const srrectype_t SR_NAME_MISC;
	extern const srrectype_t SR_NAME_MOVT;
	extern const srrectype_t SR_NAME_MSTT;
	extern const srrectype_t SR_NAME_MUSC;
	extern const srrectype_t SR_NAME_MUST;
	extern const srrectype_t SR_NAME_NAVI;
	extern const srrectype_t SR_NAME_NAVM;
	extern const srrectype_t SR_NAME_NPC_;
	extern const srrectype_t SR_NAME_OTFT;
	extern const srrectype_t SR_NAME_PACK;
	extern const srrectype_t SR_NAME_PERK;
	extern const srrectype_t SR_NAME_PGRE;
	extern const srrectype_t SR_NAME_PHZD;
	extern const srrectype_t SR_NAME_PROJ;
	extern const srrectype_t SR_NAME_QUST;
	extern const srrectype_t SR_NAME_RACE;
	extern const srrectype_t SR_NAME_REFR;
	extern const srrectype_t SR_NAME_REGN;
	extern const srrectype_t SR_NAME_RELA;
	extern const srrectype_t SR_NAME_REVB;
	extern const srrectype_t SR_NAME_RFCT;
	extern const srrectype_t SR_NAME_SCEN;
	extern const srrectype_t SR_NAME_SCRL;
	extern const srrectype_t SR_NAME_SHOU;
	extern const srrectype_t SR_NAME_SLGM;
	extern const srrectype_t SR_NAME_SMBN;
	extern const srrectype_t SR_NAME_SMEN;
	extern const srrectype_t SR_NAME_SMQN;
	extern const srrectype_t SR_NAME_SNCT;
	extern const srrectype_t SR_NAME_SNDR;
	extern const srrectype_t SR_NAME_SOPM;
	extern const srrectype_t SR_NAME_SOUN;
	extern const srrectype_t SR_NAME_SPEL;
	extern const srrectype_t SR_NAME_SPGD;
	extern const srrectype_t SR_NAME_STAT;
	extern const srrectype_t SR_NAME_TACT;
	extern const srrectype_t SR_NAME_TES4;
	extern const srrectype_t SR_NAME_TREE;
	extern const srrectype_t SR_NAME_TXST;
	extern const srrectype_t SR_NAME_VTYP;
	extern const srrectype_t SR_NAME_WATR;
	extern const srrectype_t SR_NAME_WEAP;
	extern const srrectype_t SR_NAME_WOOP;
	extern const srrectype_t SR_NAME_WRLD;
	extern const srrectype_t SR_NAME_WTHR;


		/* Known sub-records */
	extern const srrectype_t SR_NAME_00TX;
	extern const srrectype_t SR_NAME_10TX;
	extern const srrectype_t SR_NAME_20TX;
	extern const srrectype_t SR_NAME_30TX;
	extern const srrectype_t SR_NAME_40TX;
	extern const srrectype_t SR_NAME_50TX;
	extern const srrectype_t SR_NAME_60TX;
	extern const srrectype_t SR_NAME_70TX;
	extern const srrectype_t SR_NAME_80TX;
	extern const srrectype_t SR_NAME_90TX;
	extern const srrectype_t SR_NAME_A0TX;
	extern const srrectype_t SR_NAME_ACBS;
	extern const srrectype_t SR_NAME_AHCF;
	extern const srrectype_t SR_NAME_AHCM;
	extern const srrectype_t SR_NAME_AIAD;
	extern const srrectype_t SR_NAME_AIDT;
	extern const srrectype_t SR_NAME_ALCA;
	extern const srrectype_t SR_NAME_ALCL;
	extern const srrectype_t SR_NAME_ALCO;
	extern const srrectype_t SR_NAME_ALDN;
	extern const srrectype_t SR_NAME_ALEA;
	extern const srrectype_t SR_NAME_ALED;
	extern const srrectype_t SR_NAME_ALEQ;
	extern const srrectype_t SR_NAME_ALFA;
	extern const srrectype_t SR_NAME_ALFC;
	extern const srrectype_t SR_NAME_ALFD;
	extern const srrectype_t SR_NAME_ALFE;
	extern const srrectype_t SR_NAME_ALFI;
	extern const srrectype_t SR_NAME_ALFL;
	extern const srrectype_t SR_NAME_ALFR;
	extern const srrectype_t SR_NAME_ALID;
	extern const srrectype_t SR_NAME_ALLS;
	extern const srrectype_t SR_NAME_ALNA;
	extern const srrectype_t SR_NAME_ALNT;
	extern const srrectype_t SR_NAME_ALPC;
	extern const srrectype_t SR_NAME_ALRT;
	extern const srrectype_t SR_NAME_ALSP;
	extern const srrectype_t SR_NAME_ALST;
	extern const srrectype_t SR_NAME_ALUA;
	extern const srrectype_t SR_NAME_ANAM;
	extern const srrectype_t SR_NAME_ATKD;
	extern const srrectype_t SR_NAME_ATKE;
	extern const srrectype_t SR_NAME_ATKR;
	extern const srrectype_t SR_NAME_ATXT;
	extern const srrectype_t SR_NAME_AVSK;
	extern const srrectype_t SR_NAME_B0TX;
	extern const srrectype_t SR_NAME_BAMT;
	extern const srrectype_t SR_NAME_BIAD;
	extern const srrectype_t SR_NAME_BIDS;
	extern const srrectype_t SR_NAME_BNAM;
	extern const srrectype_t SR_NAME_BODT;
	extern const srrectype_t SR_NAME_BPND;
	extern const srrectype_t SR_NAME_BPNI;
	extern const srrectype_t SR_NAME_BPNN;
	extern const srrectype_t SR_NAME_BPNT;
	extern const srrectype_t SR_NAME_BPTN;
	extern const srrectype_t SR_NAME_BTXT;
	extern const srrectype_t SR_NAME_C0TX;
	extern const srrectype_t SR_NAME_CIAD;
	extern const srrectype_t SR_NAME_CIS1;
	extern const srrectype_t SR_NAME_CIS2;
	extern const srrectype_t SR_NAME_CITC;
	extern const srrectype_t SR_NAME_CNAM;
	extern const srrectype_t SR_NAME_CNTO;
	extern const srrectype_t SR_NAME_COCT;
	extern const srrectype_t SR_NAME_COED;
	extern const srrectype_t SR_NAME_CRDT;
	extern const srrectype_t SR_NAME_CRGR;
	extern const srrectype_t SR_NAME_CRIF;
	extern const srrectype_t SR_NAME_CRVA;
	extern const srrectype_t SR_NAME_CSCR;
	extern const srrectype_t SR_NAME_CSDC;
	extern const srrectype_t SR_NAME_CSDI;
	extern const srrectype_t SR_NAME_CSDT;
	extern const srrectype_t SR_NAME_CSFL;
	extern const srrectype_t SR_NAME_CSGD;
	extern const srrectype_t SR_NAME_CSLR;
	extern const srrectype_t SR_NAME_CSMD;
	extern const srrectype_t SR_NAME_CSME;
	extern const srrectype_t SR_NAME_CTDA;
	extern const srrectype_t SR_NAME_D0TX;
	extern const srrectype_t SR_NAME_DALC;
	extern const srrectype_t SR_NAME_DATA;
	extern const srrectype_t SR_NAME_DEMO;
	extern const srrectype_t SR_NAME_DESC;
	extern const srrectype_t SR_NAME_DEST;
	extern const srrectype_t SR_NAME_DEVA;
	extern const srrectype_t SR_NAME_DFTF;
	extern const srrectype_t SR_NAME_DFTM;
	extern const srrectype_t SR_NAME_DIAD;
	extern const srrectype_t SR_NAME_DMAX;
	extern const srrectype_t SR_NAME_DMDL;
	extern const srrectype_t SR_NAME_DMDS;
	extern const srrectype_t SR_NAME_DMDT;
	extern const srrectype_t SR_NAME_DMIN;
	extern const srrectype_t SR_NAME_DNAM;
	extern const srrectype_t SR_NAME_DODT;
	extern const srrectype_t SR_NAME_DOFT;
	extern const srrectype_t SR_NAME_DPLT;
	extern const srrectype_t SR_NAME_DSTD;
	extern const srrectype_t SR_NAME_DSTF;
	extern const srrectype_t SR_NAME_E0TX;
	extern const srrectype_t SR_NAME_EAMT;
	extern const srrectype_t SR_NAME_ECOR;
	extern const srrectype_t SR_NAME_EDID;
	extern const srrectype_t SR_NAME_EFID;
	extern const srrectype_t SR_NAME_EFIT;
	extern const srrectype_t SR_NAME_EIAD;
	extern const srrectype_t SR_NAME_EITM;
	extern const srrectype_t SR_NAME_ENAM;
	extern const srrectype_t SR_NAME_ENIT;
	extern const srrectype_t SR_NAME_EPF2;
	extern const srrectype_t SR_NAME_EPF3;
	extern const srrectype_t SR_NAME_EPFD;
	extern const srrectype_t SR_NAME_EPFT;
	extern const srrectype_t SR_NAME_ESCE;	
	extern const srrectype_t SR_NAME_ETYP;
	extern const srrectype_t SR_NAME_F0TX;
	extern const srrectype_t SR_NAME_FCHT;
	extern const srrectype_t SR_NAME_FIAD;
	extern const srrectype_t SR_NAME_FLMV;
	extern const srrectype_t SR_NAME_FLTR;
	extern const srrectype_t SR_NAME_FLTV;
	extern const srrectype_t SR_NAME_FNAM;
	extern const srrectype_t SR_NAME_FNMK;
	extern const srrectype_t SR_NAME_FNPR;
	extern const srrectype_t SR_NAME_FPRT;
	extern const srrectype_t SR_NAME_FTSF;
	extern const srrectype_t SR_NAME_FTSM;
	extern const srrectype_t SR_NAME_FTST;
	extern const srrectype_t SR_NAME_FULL;
	extern const srrectype_t SR_NAME_G0TX;
	extern const srrectype_t SR_NAME_GIAD;
	extern const srrectype_t SR_NAME_GNAM;
	extern const srrectype_t SR_NAME_H0TX;
	extern const srrectype_t SR_NAME_HCLF;
	extern const srrectype_t SR_NAME_HEAD;
	extern const srrectype_t SR_NAME_HEDR;
	extern const srrectype_t SR_NAME_HIAD;
	extern const srrectype_t SR_NAME_HNAM;
	extern const srrectype_t SR_NAME_HTID;
	extern const srrectype_t SR_NAME_I0TX;
	extern const srrectype_t SR_NAME_ICO2;
	extern const srrectype_t SR_NAME_ICON;
	extern const srrectype_t SR_NAME_IDLA;
	extern const srrectype_t SR_NAME_IDLC;
	extern const srrectype_t SR_NAME_IDLF;
	extern const srrectype_t SR_NAME_IDLT;
	extern const srrectype_t SR_NAME_IIAD;
	extern const srrectype_t SR_NAME_IMSP;
	extern const srrectype_t SR_NAME_INAM;
	extern const srrectype_t SR_NAME_INDX;
	extern const srrectype_t SR_NAME_INTV;
	extern const srrectype_t SR_NAME_ITXT;
	extern const srrectype_t SR_NAME_J0TX;
	extern const srrectype_t SR_NAME_JAIL;
	extern const srrectype_t SR_NAME_JIAD;
	extern const srrectype_t SR_NAME_JNAM;
	extern const srrectype_t SR_NAME_JOUT;
	extern const srrectype_t SR_NAME_K0TX;
	extern const srrectype_t SR_NAME_KIAD;
	extern const srrectype_t SR_NAME_KNAM;
	extern const srrectype_t SR_NAME_KSIZ;
	extern const srrectype_t SR_NAME_KWDA;
	extern const srrectype_t SR_NAME_L0TX;
	extern const srrectype_t SR_NAME_LCEC;
	extern const srrectype_t SR_NAME_LCEP;
	extern const srrectype_t SR_NAME_LCID;
	extern const srrectype_t SR_NAME_LCPR;
	extern const srrectype_t SR_NAME_LCSR;
	extern const srrectype_t SR_NAME_LCUN;
	extern const srrectype_t SR_NAME_LIAD;
	extern const srrectype_t SR_NAME_LLCT;
	extern const srrectype_t SR_NAME_LNAM;
	extern const srrectype_t SR_NAME_LTMP;
	extern const srrectype_t SR_NAME_LVLD;
	extern const srrectype_t SR_NAME_LVLF;
	extern const srrectype_t SR_NAME_LVLG;
	extern const srrectype_t SR_NAME_LVLO;
	extern const srrectype_t SR_NAME_MAST;
	extern const srrectype_t SR_NAME_MCHT;
	extern const srrectype_t SR_NAME_MDOB;
	extern const srrectype_t SR_NAME_MHDT;
	extern const srrectype_t SR_NAME_MIAD;
	extern const srrectype_t SR_NAME_MICO;	
	extern const srrectype_t SR_NAME_MNAM;
	extern const srrectype_t SR_NAME_MO2S;
	extern const srrectype_t SR_NAME_MO2T;
	extern const srrectype_t SR_NAME_MO3S;
	extern const srrectype_t SR_NAME_MO3T;
	extern const srrectype_t SR_NAME_MO4S;
	extern const srrectype_t SR_NAME_MO4T;
	extern const srrectype_t SR_NAME_MO5T;
	extern const srrectype_t SR_NAME_MOD2;
	extern const srrectype_t SR_NAME_MOD3;
	extern const srrectype_t SR_NAME_MOD4;
	extern const srrectype_t SR_NAME_MOD5;
	extern const srrectype_t SR_NAME_MODL;
	extern const srrectype_t SR_NAME_MODS;
	extern const srrectype_t SR_NAME_MODT;
	extern const srrectype_t SR_NAME_MPAI;
	extern const srrectype_t SR_NAME_MPAV;
	extern const srrectype_t SR_NAME_MPRT;
	extern const srrectype_t SR_NAME_MTNM;
	extern const srrectype_t SR_NAME_MTYP;
	extern const srrectype_t SR_NAME_NAM0;
	extern const srrectype_t SR_NAME_NAM1;
	extern const srrectype_t SR_NAME_NAM2;
	extern const srrectype_t SR_NAME_NAM3;
	extern const srrectype_t SR_NAME_NAM4;
	extern const srrectype_t SR_NAME_NAM5;
	extern const srrectype_t SR_NAME_NAM6;
	extern const srrectype_t SR_NAME_NAM7;
	extern const srrectype_t SR_NAME_NAM8;
	extern const srrectype_t SR_NAME_NAM9;
	extern const srrectype_t SR_NAME_NAMA;
	extern const srrectype_t SR_NAME_NAME;
	extern const srrectype_t SR_NAME_NEXT;
	extern const srrectype_t SR_NAME_NIAD;
	extern const srrectype_t SR_NAME_NNAM;
	extern const srrectype_t SR_NAME_NVER;
	extern const srrectype_t SR_NAME_NVMI;
	extern const srrectype_t SR_NAME_NVNM;
	extern const srrectype_t SR_NAME_NVPP;
	extern const srrectype_t SR_NAME_OBND;
	extern const srrectype_t SR_NAME_OFST;
	extern const srrectype_t SR_NAME_OIAD;
	extern const srrectype_t SR_NAME_ONAM;
	extern const srrectype_t SR_NAME_PDTO;
	extern const srrectype_t SR_NAME_PFIG;
	extern const srrectype_t SR_NAME_PFO2;
	extern const srrectype_t SR_NAME_PFOR;
	extern const srrectype_t SR_NAME_PFPC;
	extern const srrectype_t SR_NAME_PHTN;
	extern const srrectype_t SR_NAME_PHWT;
	extern const srrectype_t SR_NAME_PIAD;
	extern const srrectype_t SR_NAME_PKC2;
	extern const srrectype_t SR_NAME_PKCU;
	extern const srrectype_t SR_NAME_PKDT;
	extern const srrectype_t SR_NAME_PKID;
	extern const srrectype_t SR_NAME_PLCN;
	extern const srrectype_t SR_NAME_PLDT;
	extern const srrectype_t SR_NAME_PLVD;
	extern const srrectype_t SR_NAME_PNAM;
	extern const srrectype_t SR_NAME_POBA;
	extern const srrectype_t SR_NAME_POCA;
	extern const srrectype_t SR_NAME_POEA;
	extern const srrectype_t SR_NAME_PRCB;
	extern const srrectype_t SR_NAME_PRKC;
	extern const srrectype_t SR_NAME_PRKE;
	extern const srrectype_t SR_NAME_PRKF;
	extern const srrectype_t SR_NAME_PRKR;
	extern const srrectype_t SR_NAME_PRKZ;
	extern const srrectype_t SR_NAME_PSDT;
	extern const srrectype_t SR_NAME_PTDA;
	extern const srrectype_t SR_NAME_QIAD;
	extern const srrectype_t SR_NAME_QNAM;
	extern const srrectype_t SR_NAME_QOBJ;
	extern const srrectype_t SR_NAME_QSDT;
	extern const srrectype_t SR_NAME_QSTA;
	extern const srrectype_t SR_NAME_QTGL;
	extern const srrectype_t SR_NAME_QUAL;
	extern const srrectype_t SR_NAME_RCLR;
	extern const srrectype_t SR_NAME_RDAT;
	extern const srrectype_t SR_NAME_RDMO;
	extern const srrectype_t SR_NAME_RDMP;
	extern const srrectype_t SR_NAME_RDOT;
	extern const srrectype_t SR_NAME_RDSA;
	extern const srrectype_t SR_NAME_RDWT;
	extern const srrectype_t SR_NAME_RIAD;
	extern const srrectype_t SR_NAME_RNAM;
	extern const srrectype_t SR_NAME_RNMV;
	extern const srrectype_t SR_NAME_RPLD;
	extern const srrectype_t SR_NAME_RPLI;
	extern const srrectype_t SR_NAME_RPRF;
	extern const srrectype_t SR_NAME_RPRM;
	extern const srrectype_t SR_NAME_SCDA;
	extern const srrectype_t SR_NAME_SCHR;
	extern const srrectype_t SR_NAME_SCRO;
	extern const srrectype_t SR_NAME_SCTX;
	extern const srrectype_t SR_NAME_SDSC;
	extern const srrectype_t SR_NAME_SHRT;
	extern const srrectype_t SR_NAME_SIAD;
	extern const srrectype_t SR_NAME_SLCP;
	extern const srrectype_t SR_NAME_SNAM;
	extern const srrectype_t SR_NAME_SNDD;
	extern const srrectype_t SR_NAME_SNMV;
	extern const srrectype_t SR_NAME_SOFT;
	extern const srrectype_t SR_NAME_SOUL;
	extern const srrectype_t SR_NAME_SPCT;
	extern const srrectype_t SR_NAME_SPED;
	extern const srrectype_t SR_NAME_SPIT;
	extern const srrectype_t SR_NAME_SPLO;
	extern const srrectype_t SR_NAME_SPOR;
	extern const srrectype_t SR_NAME_STOL;
	extern const srrectype_t SR_NAME_SWMV;
	extern const srrectype_t SR_NAME_TCLT;
	extern const srrectype_t SR_NAME_TIAD;
	extern const srrectype_t SR_NAME_TIAS;
	extern const srrectype_t SR_NAME_TIFC;
	extern const srrectype_t SR_NAME_TINC;
	extern const srrectype_t SR_NAME_TIND;
	extern const srrectype_t SR_NAME_TINI;
	extern const srrectype_t SR_NAME_TINL;
	extern const srrectype_t SR_NAME_TINP;
	extern const srrectype_t SR_NAME_TINT;
	extern const srrectype_t SR_NAME_TINV;
	extern const srrectype_t SR_NAME_TIRS;
	extern const srrectype_t SR_NAME_TNAM;
	extern const srrectype_t SR_NAME_TPIC;
	extern const srrectype_t SR_NAME_TPLT;
	extern const srrectype_t SR_NAME_TRDT;
	extern const srrectype_t SR_NAME_TVDT;
	extern const srrectype_t SR_NAME_TWAT;
	extern const srrectype_t SR_NAME_TX00;
	extern const srrectype_t SR_NAME_TX01;
	extern const srrectype_t SR_NAME_TX02;
	extern const srrectype_t SR_NAME_TX03;
	extern const srrectype_t SR_NAME_TX04;
	extern const srrectype_t SR_NAME_TX05;
	extern const srrectype_t SR_NAME_TX07;
	extern const srrectype_t SR_NAME_UNAM;
	extern const srrectype_t SR_NAME_UNES;
	extern const srrectype_t SR_NAME_VCLR;
	extern const srrectype_t SR_NAME_VENC;
	extern const srrectype_t SR_NAME_VEND;
	extern const srrectype_t SR_NAME_VENV;
	extern const srrectype_t SR_NAME_VHGT;
	extern const srrectype_t SR_NAME_VMAD;
	extern const srrectype_t SR_NAME_VNAM;
	extern const srrectype_t SR_NAME_VNML;
	extern const srrectype_t SR_NAME_VTCK;
	extern const srrectype_t SR_NAME_VTXT;
	extern const srrectype_t SR_NAME_WAIT;
	extern const srrectype_t SR_NAME_WBDT;
	extern const srrectype_t SR_NAME_WCTR;
	extern const srrectype_t SR_NAME_WKMV;
	extern const srrectype_t SR_NAME_WLST;
	extern const srrectype_t SR_NAME_WNAM;
	extern const srrectype_t SR_NAME_XACT;
	extern const srrectype_t SR_NAME_XALP;
	extern const srrectype_t SR_NAME_XAPD;
	extern const srrectype_t SR_NAME_XAPR;
	extern const srrectype_t SR_NAME_XCAS;
	extern const srrectype_t SR_NAME_XCCM;
	extern const srrectype_t SR_NAME_XCIM;
	extern const srrectype_t SR_NAME_XCLC;
	extern const srrectype_t SR_NAME_XCLL;
	extern const srrectype_t SR_NAME_XCLR;
	extern const srrectype_t SR_NAME_XCLW;
	extern const srrectype_t SR_NAME_XCMO;
	extern const srrectype_t SR_NAME_XCNT;
	extern const srrectype_t SR_NAME_XCVL;
	extern const srrectype_t SR_NAME_XCWT;
	extern const srrectype_t SR_NAME_XCZA;
	extern const srrectype_t SR_NAME_XCZC;
	extern const srrectype_t SR_NAME_XEMI;
	extern const srrectype_t SR_NAME_XESP;
	extern const srrectype_t SR_NAME_XEZN;
	extern const srrectype_t SR_NAME_XFVC;
	extern const srrectype_t SR_NAME_XHOR;
	extern const srrectype_t SR_NAME_XHTW;
	extern const srrectype_t SR_NAME_XILL;
	extern const srrectype_t SR_NAME_XIS2;
	extern const srrectype_t SR_NAME_XLCM;
	extern const srrectype_t SR_NAME_XLCN;
	extern const srrectype_t SR_NAME_XLIB;
	extern const srrectype_t SR_NAME_XLIG;
	extern const srrectype_t SR_NAME_XLKR;
	extern const srrectype_t SR_NAME_XLOC;
	extern const srrectype_t SR_NAME_XLRM;
	extern const srrectype_t SR_NAME_XLRT;
	extern const srrectype_t SR_NAME_XLTW;
	extern const srrectype_t SR_NAME_XMBO;
	extern const srrectype_t SR_NAME_XMBP;
	extern const srrectype_t SR_NAME_XMBR;
	extern const srrectype_t SR_NAME_XMRK;
	extern const srrectype_t SR_NAME_XNAM;
	extern const srrectype_t SR_NAME_XNDP;
	extern const srrectype_t SR_NAME_XOCP;
	extern const srrectype_t SR_NAME_XOWN;
	extern const srrectype_t SR_NAME_XPOD;
	extern const srrectype_t SR_NAME_XPPA;
	extern const srrectype_t SR_NAME_XPRD;
	extern const srrectype_t SR_NAME_XPRM;
	extern const srrectype_t SR_NAME_XPWR;
	extern const srrectype_t SR_NAME_XRDS;
	extern const srrectype_t SR_NAME_XRGB;
	extern const srrectype_t SR_NAME_XRGD;
	extern const srrectype_t SR_NAME_XRMR;
	extern const srrectype_t SR_NAME_XRNK;
	extern const srrectype_t SR_NAME_XSCL;
	extern const srrectype_t SR_NAME_XSPC;
	extern const srrectype_t SR_NAME_XTEL;
	extern const srrectype_t SR_NAME_XTNM;
	extern const srrectype_t SR_NAME_XTRI;
	extern const srrectype_t SR_NAME_XWCN;
	extern const srrectype_t SR_NAME_XWCS;
	extern const srrectype_t SR_NAME_XWCU;
	extern const srrectype_t SR_NAME_XWEM;
	extern const srrectype_t SR_NAME_XXXX;
	extern const srrectype_t SR_NAME_YNAM;
	extern const srrectype_t SR_NAME_ZNAM;

		/* Custom names for internal use */
	extern const srrectype_t SR_NAME_psec;		/* Perk section */
	extern const srrectype_t SR_NAME_pssc;		/* Perk subsection */
	    
		/* Magic effect IDs */
  

/*===========================================================================
 *		End of External Definitions
 *=========================================================================*/



/*===========================================================================
 *
 * Begin Function Definitions
 *
 *=========================================================================*/
	
	/* Comparison operators */
  inline bool operator== (const srrectype_t Name, const char* pString)      { return (Name.Value == * (dword *) pString); }
  inline bool operator== (const srrectype_t Name, const dword Value)        { return (Name.Value == Value); }
  inline bool operator== (const srrectype_t Name1, const srrectype_t Name2) { return (Name1.Value == Name2.Value);  }
  inline bool operator!= (const srrectype_t Name, const char* pString)      { return (Name.Value != * (dword *) pString); }
  inline bool operator!= (const srrectype_t Name, const dword Value)        { return (Name.Value != Value); }
  inline bool operator!= (const srrectype_t Name1, const srrectype_t Name2) { return (Name1.Value != Name2.Value); }

	/* Read/write functions */
  bool ReadSrRecType  (CSrFile& File, srrectype_t& Name);
  bool WriteSrRecType (CSrFile& File, const srrectype_t Name);

/*===========================================================================
 *		End of Function Definitions
 *=========================================================================*/



#endif
/*===========================================================================
 *		End of File ObRecType.H
 *=========================================================================*/

