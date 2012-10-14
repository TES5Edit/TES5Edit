/*===========================================================================
 *
 * File:	Obrecordcreate.CPP
 * Author:	Dave Humphrey (dave@uesp.net)
 * Created On:	August 25, 2006
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srespfile.h"


/*===========================================================================
 *
 * Begin Record Creation Array
 *
 * Holds information used to create each type of record (and group).
 *
 *=========================================================================*/
static srreccreate_t s_CreateRecords[] = {
	{ &SR_NAME_AACT, CSrAactRecord::Create },
	{ &SR_NAME_ACHR, CSrAchrRecord::Create },
	{ &SR_NAME_ACTI, CSrActiRecord::Create },
	{ &SR_NAME_ADDN, CSrAddnRecord::Create },
	{ &SR_NAME_ALCH, CSrAlchRecord::Create },
	{ &SR_NAME_AMMO, CSrAmmoRecord::Create },
	{ &SR_NAME_ANIO, CSrAnioRecord::Create },
	{ &SR_NAME_APPA, CSrAppaRecord::Create },
	{ &SR_NAME_ARMA, CSrArmaRecord::Create },
	{ &SR_NAME_ARMO, CSrArmoRecord::Create },
	{ &SR_NAME_ARTO, CSrArtoRecord::Create },
	{ &SR_NAME_ASPC, CSrAspcRecord::Create },
	{ &SR_NAME_ASTP, CSrAstpRecord::Create },
	{ &SR_NAME_AVIF, CSrAvifRecord::Create },
	{ &SR_NAME_BOOK, CSrBookRecord::Create },
	{ &SR_NAME_BPTD, CSrBptdRecord::Create },
	{ &SR_NAME_CAMS, CSrCamsRecord::Create },
	{ &SR_NAME_CELL, CSrCellRecord::Create },
	{ &SR_NAME_CLAS, CSrClasRecord::Create },
	{ &SR_NAME_CLFM, CSrClfmRecord::Create },
	{ &SR_NAME_CLMT, CSrClmtRecord::Create },
	{ &SR_NAME_COBJ, CSrCobjRecord::Create },
	{ &SR_NAME_COLL, CSrCollRecord::Create },
	{ &SR_NAME_CONT, CSrContRecord::Create },
	{ &SR_NAME_CPTH, CSrCpthRecord::Create },
	{ &SR_NAME_CSTY, CSrCstyRecord::Create },
	{ &SR_NAME_DEBR, CSrDebrRecord::Create },
	{ &SR_NAME_DIAL, CSrDialRecord::Create },
	{ &SR_NAME_DLBR, CSrDlbrRecord::Create },
	{ &SR_NAME_DLVW, CSrDlvwRecord::Create },
	{ &SR_NAME_DOBJ, CSrDobjRecord::Create },
	{ &SR_NAME_DOOR, CSrDoorRecord::Create },
	{ &SR_NAME_DUAL, CSrDualRecord::Create },
	{ &SR_NAME_ECZN, CSrEcznRecord::Create },
	{ &SR_NAME_EFSH, CSrEfshRecord::Create },
	{ &SR_NAME_ENCH, CSrEnchRecord::Create },
	{ &SR_NAME_EQUP, CSrEqupRecord::Create },
	{ &SR_NAME_EXPL, CSrExplRecord::Create },
	{ &SR_NAME_EYES, CSrEyesRecord::Create },
	{ &SR_NAME_FACT, CSrFactRecord::Create },
	{ &SR_NAME_FLOR, CSrFlorRecord::Create },
	{ &SR_NAME_FLST, CSrFlstRecord::Create },
	{ &SR_NAME_FSTP, CSrFstpRecord::Create },
	{ &SR_NAME_FSTS, CSrFstsRecord::Create },
	{ &SR_NAME_FURN, CSrFurnRecord::Create },
	{ &SR_NAME_GLOB, CSrGlobRecord::Create },
	{ &SR_NAME_GMST, CSrGmstRecord::Create },
	{ &SR_NAME_GRAS, CSrGrasRecord::Create },
	{ &SR_NAME_HAZD, CSrHazdRecord::Create },
	{ &SR_NAME_HDPT, CSrHdptRecord::Create },
	{ &SR_NAME_IDLE, CSrIdleRecord::Create },
	{ &SR_NAME_IDLM, CSrIdlmRecord::Create },
	{ &SR_NAME_IMAD, CSrImadRecord::Create },
	{ &SR_NAME_IMGS, CSrImgsRecord::Create },
	{ &SR_NAME_INFO, CSrInfoRecord::Create },
	{ &SR_NAME_INGR, CSrIngrRecord::Create },
	{ &SR_NAME_IPCT, CSrIpctRecord::Create },
	{ &SR_NAME_IPDS, CSrIpdsRecord::Create },
	{ &SR_NAME_KEYM, CSrKeymRecord::Create },
	{ &SR_NAME_KYWD, CSrKywdRecord::Create },
	{ &SR_NAME_LAND, CSrLandRecord::Create },
	{ &SR_NAME_LCRT, CSrLcrtRecord::Create },
	{ &SR_NAME_LCTN, CSrLctnRecord::Create },
	{ &SR_NAME_LGTM, CSrLgtmRecord::Create },
	{ &SR_NAME_LIGH, CSrLighRecord::Create },
	{ &SR_NAME_LSCR, CSrLscrRecord::Create },
	{ &SR_NAME_LTEX, CSrLtexRecord::Create },
	{ &SR_NAME_LVLI, CSrLvliRecord::Create },
	{ &SR_NAME_LVLN, CSrLvlnRecord::Create },
	{ &SR_NAME_LVSP, CSrLvspRecord::Create },
	{ &SR_NAME_MATO, CSrMatoRecord::Create },
	{ &SR_NAME_MATT, CSrMattRecord::Create },
	{ &SR_NAME_MESG, CSrMesgRecord::Create },
	{ &SR_NAME_MGEF, CSrMgefRecord::Create },
	{ &SR_NAME_MISC, CSrMiscRecord::Create },
	{ &SR_NAME_MOVT, CSrMovtRecord::Create },
	{ &SR_NAME_MSTT, CSrMsttRecord::Create },
	{ &SR_NAME_MUSC, CSrMuscRecord::Create },
	{ &SR_NAME_MUST, CSrMustRecord::Create },
	{ &SR_NAME_NAVI, CSrNaviRecord::Create },
	{ &SR_NAME_NAVM, CSrNavmRecord::Create },
	{ &SR_NAME_NPC_, CSrNpc_Record::Create },
	{ &SR_NAME_OTFT, CSrOtftRecord::Create },
	{ &SR_NAME_PACK, CSrPackRecord::Create },
	{ &SR_NAME_PERK, CSrPerkRecord::Create },
	{ &SR_NAME_PGRE, CSrPgreRecord::Create },
	{ &SR_NAME_PHZD, CSrPhzdRecord::Create },
	{ &SR_NAME_PROJ, CSrProjRecord::Create },
	{ &SR_NAME_QUST, CSrQustRecord::Create },
	{ &SR_NAME_RACE, CSrRaceRecord::Create },
	{ &SR_NAME_REFR, CSrRefrRecord::Create },
	{ &SR_NAME_REGN, CSrRegnRecord::Create },
	{ &SR_NAME_RELA, CSrRelaRecord::Create },
	{ &SR_NAME_REVB, CSrRevbRecord::Create },
	{ &SR_NAME_RFCT, CSrRfctRecord::Create },
	{ &SR_NAME_SCEN, CSrScenRecord::Create },
	{ &SR_NAME_SCRL, CSrScrlRecord::Create },
	{ &SR_NAME_SHOU, CSrShouRecord::Create },
	{ &SR_NAME_SLGM, CSrSlgmRecord::Create },
	{ &SR_NAME_SMBN, CSrSmbnRecord::Create },
	{ &SR_NAME_SMEN, CSrSmenRecord::Create },
	{ &SR_NAME_SMQN, CSrSmqnRecord::Create },
	{ &SR_NAME_SNCT, CSrSnctRecord::Create },
	{ &SR_NAME_SNDR, CSrSndrRecord::Create },
	{ &SR_NAME_SOPM, CSrSopmRecord::Create },
	{ &SR_NAME_SOUN, CSrSounRecord::Create },
	{ &SR_NAME_SPEL, CSrSpelRecord::Create },
	{ &SR_NAME_SPGD, CSrSpgdRecord::Create },
	{ &SR_NAME_STAT, CSrStatRecord::Create },
	{ &SR_NAME_TACT, CSrTactRecord::Create },
	{ &SR_NAME_TES4, CSrTes4Record::Create },
	{ &SR_NAME_TREE, CSrTreeRecord::Create },
	{ &SR_NAME_TXST, CSrTxstRecord::Create },
	{ &SR_NAME_VTYP, CSrVtypRecord::Create },
	{ &SR_NAME_WATR, CSrWatrRecord::Create },
	{ &SR_NAME_WEAP, CSrWeapRecord::Create },
	{ &SR_NAME_WOOP, CSrWoopRecord::Create },
	{ &SR_NAME_WRLD, CSrWrldRecord::Create },
	{ &SR_NAME_WTHR, CSrWthrRecord::Create },
	{ NULL,		 NULL }	/* Must be last */
  };
/*===========================================================================
 *		End of Record Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Group Creation Array
 *
 *=========================================================================*/
static srgroupcreate_t s_CreateGroups[] = 
{
	{ SR_GROUP_TYPE,		CSrTypeGroup::Create },
	{ SR_GROUP_WORLDCHILD,	CSrFormIDGroup::Create },
	{ SR_GROUP_INTCELL,		CSrBlockGroup::Create },
	{ SR_GROUP_INTSUBCELL,	CSrBlockGroup::Create },
	{ SR_GROUP_EXTCELL,		CSrGridGroup::Create },
	{ SR_GROUP_EXTSUBCELL,	CSrGridGroup::Create },
	{ SR_GROUP_CELLCHILD,	CSrFormIDGroup::Create },
	{ SR_GROUP_TOPICCHILD,	CSrFormIDGroup::Create },
	{ SR_GROUP_CELLPERSIST,	CSrFormIDGroup::Create },
	{ SR_GROUP_CELLTEMP,	CSrFormIDGroup::Create },
	{ SR_GROUP_CELLDISTANT,	CSrFormIDGroup::Create },
	{ SR_GROUP_NONE,	NULL }	/* Must be last */
};


static srgroupcreate_t s_CreateRefGroups[] = 
{
	{ SR_GROUP_TYPE,		CSrRefTypeGroup::Create },
	{ SR_GROUP_WORLDCHILD,	CSrRefFormIDGroup::Create },
	{ SR_GROUP_INTCELL,		CSrRefBlockGroup::Create },
	{ SR_GROUP_INTSUBCELL,	CSrRefBlockGroup::Create },
	{ SR_GROUP_EXTCELL,		CSrRefGridGroup::Create },
	{ SR_GROUP_EXTSUBCELL,	CSrRefGridGroup::Create },
	{ SR_GROUP_CELLCHILD,	CSrRefFormIDGroup::Create },
	{ SR_GROUP_TOPICCHILD,	CSrRefFormIDGroup::Create },
	{ SR_GROUP_CELLPERSIST,	CSrRefFormIDGroup::Create },
	{ SR_GROUP_CELLTEMP,	CSrRefFormIDGroup::Create },
	{ SR_GROUP_CELLDISTANT,	CSrRefFormIDGroup::Create },
	{ SR_GROUP_NONE,		NULL }	/* Must be last */
};
/*===========================================================================
 *		End of Group Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Top Level Item Types
 *
 * This array lists the valid group/item types found at the top level 
 * of a mod file.
 *
 *=========================================================================*/
const srrectype_t* s_TopLevelTypes[] = 
{ 
	&SR_NAME_FACT,
	&SR_NAME_KYWD,
	&SR_NAME_GMST,
	&SR_NAME_ENCH,
	&SR_NAME_AMMO,
	&SR_NAME_TREE,
	&SR_NAME_DOOR,
	&SR_NAME_ARMO,
	&SR_NAME_LCRT,
	&SR_NAME_GLOB,
	&SR_NAME_AACT,
	&SR_NAME_DEBR,
	&SR_NAME_NAVM,
	&SR_NAME_TXST,
	&SR_NAME_CLAS,
	&SR_NAME_RFCT,
	&SR_NAME_HDPT,
	&SR_NAME_DUAL,
	&SR_NAME_DIAL,
	&SR_NAME_EYES,
	&SR_NAME_IDLM,
	&SR_NAME_RACE,
	&SR_NAME_GRAS,
	&SR_NAME_TACT,
	&SR_NAME_INGR,
	&SR_NAME_SOUN,
	&SR_NAME_ASPC,
	&SR_NAME_MGEF,
	&SR_NAME_LTEX,
	&SR_NAME_MUSC,
	&SR_NAME_MISC,
	&SR_NAME_ACTI,
	&SR_NAME_SPEL,
	&SR_NAME_SCRL,
	&SR_NAME_BOOK,
	&SR_NAME_WOOP,
	&SR_NAME_CLMT,
	&SR_NAME_CONT,
	&SR_NAME_SHOU,
	&SR_NAME_APPA,
	&SR_NAME_LIGH,
	&SR_NAME_LAND,
	&SR_NAME_STAT,
	&SR_NAME_MUST,
	&SR_NAME_MATT,
	&SR_NAME_MSTT,
	&SR_NAME_FLOR,
	&SR_NAME_FURN,
	&SR_NAME_SPGD,
	&SR_NAME_IDLE,
	&SR_NAME_WEAP,
	&SR_NAME_PGRE,
	&SR_NAME_NPC_,
	&SR_NAME_LVLN,
	&SR_NAME_KEYM,
	&SR_NAME_ALCH,
	&SR_NAME_COBJ,
	&SR_NAME_PROJ,
	&SR_NAME_HAZD,
	&SR_NAME_INFO,
	&SR_NAME_SLGM,
	&SR_NAME_WRLD,
	&SR_NAME_LVLI,
	&SR_NAME_WTHR,
	&SR_NAME_REGN,
	&SR_NAME_PHZD,
	&SR_NAME_NAVI,
	&SR_NAME_ARTO,
	&SR_NAME_QUST,
	&SR_NAME_COLL,
	&SR_NAME_CELL,
	&SR_NAME_REFR,
	&SR_NAME_ACHR,
	&SR_NAME_PACK,
	&SR_NAME_CSTY,
	&SR_NAME_LSCR,
	&SR_NAME_LVSP,
	&SR_NAME_ANIO,
	&SR_NAME_WATR,
	&SR_NAME_EFSH,
	&SR_NAME_DLVW,
	&SR_NAME_EXPL,
	&SR_NAME_IMGS,
	&SR_NAME_IMAD,
	&SR_NAME_IAD,
	&SR_NAME_FLST,
	&SR_NAME_PERK,
	&SR_NAME_BPTD,
	&SR_NAME_ADDN,
	&SR_NAME_AVIF,
	&SR_NAME_CAMS,
	&SR_NAME_CPTH,
	&SR_NAME_VTYP,
	&SR_NAME_IPCT,
	&SR_NAME_IPDS,
	&SR_NAME_ARMA,
	&SR_NAME_ECZN,
	&SR_NAME_LCTN,
	&SR_NAME_MESG,
	&SR_NAME_DOBJ,
	&SR_NAME_LGTM,
	&SR_NAME_FSTP,
	&SR_NAME_FSTS,
	&SR_NAME_SMBN,
	&SR_NAME_SMQN,
	&SR_NAME_SCEN,
	&SR_NAME_SMEN,
	&SR_NAME_DLBR,
	&SR_NAME_EQUP,
	&SR_NAME_RELA,
	&SR_NAME_ASTP,
	&SR_NAME_OTFT,
	&SR_NAME_MATO,
	&SR_NAME_MOVT,
	&SR_NAME_SNDR,
	&SR_NAME_SNCT,
	&SR_NAME_SOPM,
	&SR_NAME_CLFM,
	&SR_NAME_REVB,
	NULL	/* Must be last */
};

const srrectype_t* s_TopLevelTypeOrder[] = 
{ 
	&SR_NAME_TES4,
	&SR_NAME_FACT,
	&SR_NAME_KYWD,
	&SR_NAME_GMST,
	&SR_NAME_ENCH,
	&SR_NAME_AMMO,
	&SR_NAME_TREE,
	&SR_NAME_DOOR,
	&SR_NAME_ARMO,
	&SR_NAME_LCRT,
	&SR_NAME_GLOB,
	&SR_NAME_AACT,
	&SR_NAME_DEBR,
	&SR_NAME_NAVM,
	&SR_NAME_TXST,
	&SR_NAME_CLAS,
	&SR_NAME_RFCT,
	&SR_NAME_HDPT,
	&SR_NAME_DUAL,
	&SR_NAME_DIAL,
	&SR_NAME_EYES,
	&SR_NAME_IDLM,
	&SR_NAME_RACE,
	&SR_NAME_GRAS,
	&SR_NAME_TACT,
	&SR_NAME_INGR,
	&SR_NAME_SOUN,
	&SR_NAME_ASPC,
	&SR_NAME_MGEF,
	&SR_NAME_LTEX,
	&SR_NAME_MUSC,
	&SR_NAME_MISC,
	&SR_NAME_ACTI,
	&SR_NAME_SPEL,
	&SR_NAME_SCRL,
	&SR_NAME_BOOK,
	&SR_NAME_WOOP,
	&SR_NAME_CLMT,
	&SR_NAME_CONT,
	&SR_NAME_SHOU,
	&SR_NAME_APPA,
	&SR_NAME_LIGH,
	&SR_NAME_LAND,
	&SR_NAME_STAT,
	&SR_NAME_MUST,
	&SR_NAME_MATT,
	&SR_NAME_MSTT,
	&SR_NAME_FLOR,
	&SR_NAME_FURN,
	&SR_NAME_SPGD,
	&SR_NAME_IDLE,
	&SR_NAME_WEAP,
	&SR_NAME_PGRE,
	&SR_NAME_NPC_,
	&SR_NAME_LVLN,
	&SR_NAME_KEYM,
	&SR_NAME_ALCH,
	&SR_NAME_COBJ,
	&SR_NAME_PROJ,
	&SR_NAME_HAZD,
	&SR_NAME_INFO,
	&SR_NAME_SLGM,
	&SR_NAME_WRLD,
	&SR_NAME_LVLI,
	&SR_NAME_WTHR,
	&SR_NAME_REGN,
	&SR_NAME_PHZD,
	&SR_NAME_NAVI,
	&SR_NAME_ARTO,
	&SR_NAME_QUST,
	&SR_NAME_COLL,
	&SR_NAME_CELL,
	&SR_NAME_REFR,
	&SR_NAME_ACHR,
	&SR_NAME_PACK,
	&SR_NAME_CSTY,
	&SR_NAME_LSCR,
	&SR_NAME_LVSP,
	&SR_NAME_ANIO,
	&SR_NAME_WATR,
	&SR_NAME_EFSH,
	&SR_NAME_DLVW,
	&SR_NAME_EXPL,
	&SR_NAME_IMGS,
	&SR_NAME_IMAD,
	&SR_NAME_IAD,
	&SR_NAME_FLST,
	&SR_NAME_PERK,
	&SR_NAME_BPTD,
	&SR_NAME_ADDN,
	&SR_NAME_AVIF,
	&SR_NAME_CAMS,
	&SR_NAME_CPTH,
	&SR_NAME_VTYP,
	&SR_NAME_IPCT,
	&SR_NAME_IPDS,
	&SR_NAME_ARMA,
	&SR_NAME_ECZN,
	&SR_NAME_LCTN,
	&SR_NAME_MESG,
	&SR_NAME_DOBJ,
	&SR_NAME_LGTM,
	&SR_NAME_FSTP,
	&SR_NAME_FSTS,
	&SR_NAME_SMBN,
	&SR_NAME_SMQN,
	&SR_NAME_SCEN,
	&SR_NAME_SMEN,
	&SR_NAME_DLBR,
	&SR_NAME_EQUP,
	&SR_NAME_RELA,
	&SR_NAME_ASTP,
	&SR_NAME_OTFT,
	&SR_NAME_MATO,
	&SR_NAME_MOVT,
	&SR_NAME_SNDR,
	&SR_NAME_SNCT,
	&SR_NAME_SOPM,
	&SR_NAME_CLFM,
	&SR_NAME_REVB,
	NULL
};
/*==========================================================================
 *		End of Top Level Item Types
 *=========================================================================*/


/*===========================================================================
 *
 * Function - CSrBaseRecord* CreateSrRecordGroup (Header);
 *
 * Creates and returns a group or record based on the input header data. 
 *
 *=========================================================================*/
CSrBaseRecord* CreateSrRecordGroup (const srbaseheader_t Header) {

	/* Determine whether to create a group or record */
  if (Header.Type == SR_NAME_GRUP) 
    return CreateSrGroup(Header);
  else
    return CreateSrRecord(Header);

 }
/*===========================================================================
 *		End of Function CreateSrRecordGroup()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - CSrBaseRecord* CreateSrRecord (Header);
 *
 * Creates and returns a new record based on the input header
 * data. Should only return NULL on an out of memory error.
 * *=========================================================================*/
CSrRecord* CreateSrRecord (const srbaseheader_t Header) 
{
  CSrRecord* pNewRecord = NULL;
  int	     Index;

  for (Index = 0; s_CreateRecords[Index].CreateMethod != NULL; ++Index) {
    if (Header.Type == *s_CreateRecords[Index].pType) {
      pNewRecord = s_CreateRecords[Index].CreateMethod();
      break;
     }
   }

	/* Create a base class record by default */
  if (pNewRecord == NULL)
  {
    //SystemLog.Printf("Unknown record type '%4.4s' created!", Header.Type.Name);
    pNewRecord = CSrRecord::Create();
  }

	/* Initialize and return the new record */
  pNewRecord->Initialize(Header);
  return (pNewRecord);
 }


CSrRecord* CreateSrRecord (const srrectype_t Type) 
{
  CSrRecord* pNewRecord = NULL;
  int	     Index;

  for (Index = 0; s_CreateRecords[Index].CreateMethod != NULL; ++Index)
  {
    if (Type == *s_CreateRecords[Index].pType) 
	{
      pNewRecord = s_CreateRecords[Index].CreateMethod();
      break;
    }
  }

	/* Create a base class record by default */
  if (pNewRecord == NULL) 
  {
    //SystemLog.Printf("Warning: Unknown record type '%4.4s' created!", Type.Name);
    pNewRecord = CSrRecord::Create();
  }

	/* Initialize and return the new record */
  pNewRecord->Initialize(Type);
  return (pNewRecord);
}
/*===========================================================================
 *		End of Function CreateSrRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - CSrGroup* CreateSrGroup (Header);
 *
 * Creates and returns a new group based on the input header
 * data. Should only return NULL on an out of memory error.
 *
 *=========================================================================*/
CSrGroup* CreateSrGroup (const srbaseheader_t Header) 
{
  CSrGroup* pNewGroup = NULL;
  int	    Index;

  for (Index = 0; s_CreateGroups[Index].CreateMethod != NULL; ++Index) 
  {
	if (Header.GroupType == s_CreateGroups[Index].GroupType) 
	{
	  //SystemLog.Printf("Creating group for type %d...", Header.GroupType);
      pNewGroup = s_CreateGroups[Index].CreateMethod();
      break;
    }
  }

	/* Create a base class group by default */
  if (pNewGroup == NULL) 
  {
	  SystemLog.Printf("Warning: Creating default group for type %d...", Header.GroupType);
	  pNewGroup = CSrGroup::Create();
  }

	/* Initialize and return the new group */
  pNewGroup->Initialize(Header);
  return (pNewGroup);
}


CSrGroup* CreateSrGroup (const int Type) 
{
  CSrGroup* pNewGroup = NULL;
  int	    Index;

  for (Index = 0; s_CreateGroups[Index].CreateMethod != NULL; ++Index)
  {
    if (Type == s_CreateGroups[Index].GroupType)
	{
      pNewGroup = s_CreateGroups[Index].CreateMethod();
      break;
    }
  }

	/* Create a base class group by default */
  if (pNewGroup == NULL) pNewGroup = CSrGroup::Create();

	/* Initialize and return the new group */
  pNewGroup->Initialize(Type);
  return (pNewGroup);
}


CSrGroup* CreateSrRefGroup (const int Type) 
{
  CSrGroup* pNewGroup = NULL;
  int	    Index;

  for (Index = 0; s_CreateRefGroups[Index].CreateMethod != NULL; ++Index)
  {
    if (Type == s_CreateRefGroups[Index].GroupType)
	{
      pNewGroup = s_CreateRefGroups[Index].CreateMethod();
      break;
    }
  }

	/* Create a base class group by default */
  if (pNewGroup == NULL) pNewGroup = CSrRefGroup::Create();

	/* Initialize and return the new group */
  pNewGroup->Initialize(Type);
  return (pNewGroup);
} 
/*===========================================================================
 *		End of Function CreateSrGroup()
 *=========================================================================*/
 

/*===========================================================================
 *
 * Function - srreccreate_t* FindSrRecCreate (Type);
 *
 *=========================================================================*/
srreccreate_t* FindObRecCreate (const srrectype_t Type)
{
  dword Index;

  for (Index = 0; s_CreateRecords[Index].CreateMethod != NULL; ++Index)
  {
    if (Type == *s_CreateRecords[Index].pType) return &s_CreateRecords[Index];
  }

  return (NULL);
}
/*===========================================================================
 *		End of Function FindObRecCreate()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - srreccreate_t* FindSrRecCreate (pName);
 *
 *=========================================================================*/
srreccreate_t* FindSrRecCreate (const SSCHAR* pName)
{
  dword Index;

  for (Index = 0; s_CreateRecords[Index].CreateMethod != NULL; ++Index)
  {
    if (*s_CreateRecords[Index].pType == pName) return &s_CreateRecords[Index];
  }

  return (NULL);
}
/*===========================================================================
 *		End of Function FindObRecCreate()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - bool IsSrTopLevelGroup (Type);
 *
 *=========================================================================*/
bool IsSrTopLevelGroup (const srrectype_t Type)
{
  dword Index;

  for (Index = 0; s_TopLevelTypeOrder[Index] != NULL; ++Index)
  {
    if (Type == *s_TopLevelTypeOrder[Index]) return (true);
  }

	/* Unknown type */
  return (false);
}
/*===========================================================================
 *		End of Function IsSrTopLevelGroup()
 *=========================================================================*/
