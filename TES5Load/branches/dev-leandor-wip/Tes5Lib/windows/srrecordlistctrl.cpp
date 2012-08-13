/*===========================================================================
 *
 * File:		Srrecordlistctrl.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	26 November 2011
 *
 * Implements the CSrRecordListCtrl class
 *
 *=========================================================================*/

	/* Include Files */
#include "stdafx.h"
#include "SrRecordListCtrl.h"
#include "Sredit.h"


/*===========================================================================
 *
 * Begin Local Definitions
 *
 *=========================================================================*/
#ifdef _DEBUG
	#define new DEBUG_NEW
	#undef THIS_FILE
	static char THIS_FILE[] = __FILE__;
#endif

	srreclistoptions_t CSrRecordListCtrl::m_Options;

	IMPLEMENT_DYNCREATE(CSrRecordListCtrl, CListCtrl);
/*===========================================================================
 *		End of Local Definitions
 *=========================================================================*/


/*===========================================================================
 *
 * Begin Record List Default Column Data
 *
 *=========================================================================*/
static srreclistcolinit_t s_AactListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
 };

static srreclistcolinit_t s_AchrListInit[] = 
{
	{ SR_FIELD_EDITORID,	160,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_ActiListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_FULLNAME,	100,	LVCFMT_LEFT },
	{ SR_FIELD_MODEL,		60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_AddnListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_AlchListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	150,	LVCFMT_LEFT },
	{ SR_FIELD_TYPE,		60,		LVCFMT_CENTER },
	{ SR_FIELD_WEIGHT,		60,		LVCFMT_CENTER },
	{ SR_FIELD_VALUE,		60,		LVCFMT_CENTER },
	{ SR_FIELD_MODEL,		60,		LVCFMT_CENTER },
	{ SR_FIELD_EFFECTCOUNT,	80,		LVCFMT_CENTER },
	{ SR_FIELD_PICKUPSOUND,	60,		LVCFMT_CENTER },
	{ SR_FIELD_DROPSOUND,	60,		LVCFMT_CENTER },
	{ SR_FIELD_USESOUND,	60,		LVCFMT_CENTER },
	//{ SR_FIELD_ICON,		60,		LVCFMT_CENTER },
	//{ SR_FIELD_AUTOCALC,	50,		LVCFMT_CENTER },
	//{ SR_FIELD_FOODITEM,	50,		LVCFMT_CENTER },
	//{ SR_FIELD_USERDATA,	80,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_AmmoListInit[] = 
{
	{ SR_FIELD_EDITORID,		150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,			5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,			50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,		150,	LVCFMT_LEFT },
	{ SR_FIELD_PROJECTILE,		80,		LVCFMT_CENTER },
	{ SR_FIELD_DAMAGE,			40,		LVCFMT_CENTER },
	{ SR_FIELD_VALUE,			40,		LVCFMT_CENTER },
	{ SR_FIELD_IGNORERESIST,	40,		LVCFMT_CENTER },
	{ SR_FIELD_VANISH,			40,		LVCFMT_CENTER },
	{ SR_FIELD_KEYWORDCOUNT,	40,		LVCFMT_CENTER },
	{ SR_FIELD_MODEL,			60,		LVCFMT_CENTER },
	{ SR_FIELD_PICKUPSOUND,		60,		LVCFMT_CENTER },
	{ SR_FIELD_DROPSOUND,		60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_AnioListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_AppaListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	150,	LVCFMT_LEFT },
	{ SR_FIELD_MODEL,		60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
 };

static srreclistcolinit_t s_ArmaListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_ArmoListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	150,	LVCFMT_LEFT },
	{ SR_FIELD_TYPE,		60,		LVCFMT_CENTER },
	{ SR_FIELD_EQUIPSLOT,	100,	LVCFMT_CENTER },
	{ SR_FIELD_RATING,		60,		LVCFMT_CENTER },
	{ SR_FIELD_VALUE,		60,		LVCFMT_CENTER },
	{ SR_FIELD_WEIGHT,		60,		LVCFMT_CENTER },
	{ SR_FIELD_ENCHANTMENT, 80,		LVCFMT_CENTER },
	{ SR_FIELD_MODEL,		60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
 };

static srreclistcolinit_t s_ArtoListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_AspcListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_AstpListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_AvifListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_BookListInit[] = {
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	150,	LVCFMT_LEFT },
	{ SR_FIELD_VALUE,		60,		LVCFMT_CENTER },
	{ SR_FIELD_WEIGHT,		60,		LVCFMT_CENTER },
	{ SR_FIELD_SCROLL,		40,		LVCFMT_CENTER },
	{ SR_FIELD_SPELLTOME,	40,		LVCFMT_CENTER },
	{ SR_FIELD_SKILL,		75,		LVCFMT_CENTER },
	{ SR_FIELD_MODEL,		60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
 };

static srreclistcolinit_t s_BptdListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_CamsListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_MODEL,		100,	LVCFMT_LEFT },
	{ SR_FIELD_IMAGESPACE,	100,	LVCFMT_LEFT },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_CellListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_ClasListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_ClfmListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_ClmtListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_CobjListInit[] = 
{
	{ SR_FIELD_EDITORID,		150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,			5,		LVCFMT_CENTER },
	{ SR_FIELD_FLAGS,			50,		LVCFMT_CENTER },
	{ SR_FIELD_COMPONENTCOUNT,	50,		LVCFMT_CENTER },
	{ SR_FIELD_RESULTITEM,		150,	LVCFMT_CENTER },
	{ SR_FIELD_RESULTCOUNT,		50,		LVCFMT_CENTER },
	{ SR_FIELD_STATION,			150,	LVCFMT_CENTER },
	{ SR_FIELD_CONDITIONCOUNT,	50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_CollListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_ContListInit[] = {
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	150,	LVCFMT_LEFT },
	{ SR_FIELD_ITEMCOUNT,   60,     LVCFMT_CENTER },
	{ SR_FIELD_OPENSOUND,	100,	LVCFMT_CENTER },
	{ SR_FIELD_CLOSESOUND,	100,	LVCFMT_CENTER },
	//{ SR_FIELD_RESPAWNS,    60,		LVCFMT_CENTER },
	{ SR_FIELD_MODEL,		60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
 };

static srreclistcolinit_t s_CpthListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_CstyListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_DebrListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_DialListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_DlbrListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_DlvwListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_DobjListInit[] = 
{
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_DoorListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_DualListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_EcznListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_LOCATION,	100,	LVCFMT_CENTER },
	{ SR_FIELD_FACTION,		100,	LVCFMT_CENTER },
	{ SR_FIELD_RANK,		50,		LVCFMT_CENTER },
	{ SR_FIELD_MINLEVEL,	50,		LVCFMT_CENTER },
	{ SR_FIELD_RESET,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_EfshListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_EnchListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	150,	LVCFMT_LEFT },
	{ SR_FIELD_CASTTYPE,	75,		LVCFMT_CENTER },
	{ SR_FIELD_DELIVERYTYPE,75,		LVCFMT_CENTER },
	{ SR_FIELD_ENCHANTTYPE,	75,		LVCFMT_CENTER },
	{ SR_FIELD_CHARGE,		60,		LVCFMT_CENTER },
	{ SR_FIELD_COST,		60,		LVCFMT_CENTER },
	{ SR_FIELD_AUTOCALC,	50,		LVCFMT_CENTER },
	{ SR_FIELD_EFFECTCOUNT,	80,		LVCFMT_CENTER },
	{ SR_FIELD_BASEENCHANT,	100,	LVCFMT_CENTER },
	{ SR_FIELD_ITEMTYPES,	100,	LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
 };

static srreclistcolinit_t s_EqupListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_ExplListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_EyesListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_FactListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_FlorListInit[] = {
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	//{ SR_FIELD_FULLNAME,	100,	LVCFMT_CENTER },
	//{ SR_FIELD_INGREDIANT,	100,	LVCFMT_CENTER },
	//{ SR_FIELD_SCRIPT,		100,	LVCFMT_CENTER },
	//{ SR_FIELD_SPRING,		60,	LVCFMT_CENTER },
	//{ SR_FIELD_SUMMER,		60,	LVCFMT_CENTER },
	//{ SR_FIELD_FALL,		60,	LVCFMT_CENTER },
	//{ SR_FIELD_WINTER,		60,	LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
 };

static srreclistcolinit_t s_FlstListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMCOUNT,	80,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_FstpListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_FstsListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_FurnListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	150,	LVCFMT_LEFT },
	{ SR_FIELD_MODEL,		60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_GlobListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_VALUE,		100,	LVCFMT_LEFT },
	{ SR_FIELD_TYPE,		50,		LVCFMT_LEFT },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_GmstListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_VALUE,		120,	LVCFMT_CENTER },
	{ SR_FIELD_TYPE,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_GrasListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_HazdListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_HdptListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_IdleListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_IdlmListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_ImadListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_ImgsListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_InfoListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_IngrListInit[] = {
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_FULLNAME,	100,	LVCFMT_LEFT },
	{ SR_FIELD_VALUE,		50,		LVCFMT_CENTER },
	{ SR_FIELD_WEIGHT,		50,		LVCFMT_CENTER },
	{ SR_FIELD_MODEL,		60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_IpctListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_IpdsListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_KeymListInit[] = {
	{ SR_FIELD_EDITORID,  150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,	  5,	LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,	  50,	LVCFMT_CENTER },
	//{ SR_FIELD_ITEMNAME,  150,	LVCFMT_LEFT },
	//{ SR_FIELD_VALUE,	  60,	LVCFMT_CENTER },
	//{ SR_FIELD_WEIGHT,	  60,	LVCFMT_CENTER },
	//{ SR_FIELD_SCRIPT,	  80,	LVCFMT_CENTER },
	{ SR_FIELD_MODEL,	  60,	LVCFMT_CENTER },
	//{ SR_FIELD_ICON,	  60,	LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
 };

static srreclistcolinit_t s_KywdListInit[] = 
{
	{ SR_FIELD_EDITORID,	   150,		LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		 	 5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,			50,		LVCFMT_CENTER },
	{ SR_FIELD_CNAM,		    50,		LVCFMT_CENTER },	
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_LcrtListInit[] = 
{
	{ SR_FIELD_EDITORID,	   150,		LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		 	 5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,			50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_LctnListInit[] = 
{
	{ SR_FIELD_EDITORID,		150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		 	5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,			50,		LVCFMT_CENTER },
	{ SR_FIELD_FULLNAME,		120,	LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_LgtmListInit[] = 
{
	{ SR_FIELD_EDITORID,		150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		 	5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,			50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_LighListInit[] = {
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	//{ SR_FIELD_ITEMNAME,    120,	LVCFMT_CENTER },
	//{ SR_FIELD_TIME,		60,		LVCFMT_CENTER },
	//{ SR_FIELD_RADIUS,		60,		LVCFMT_CENTER },
	//{ SR_FIELD_FOV,			60,		LVCFMT_CENTER },
	//{ SR_FIELD_TYPE,		80,		LVCFMT_CENTER },
	//{ SR_FIELD_CARRIED,		60,		LVCFMT_CENTER },
	//{ SR_FIELD_VALUE,		60,		LVCFMT_CENTER },
	//{ SR_FIELD_WEIGHT,		60,		LVCFMT_CENTER },
	//{ SR_FIELD_USERDATA,	80,		LVCFMT_CENTER },
	//{ SR_FIELD_COLOR,		80,		LVCFMT_CENTER },
	//{ SR_FIELD_MODEL,		60,		LVCFMT_CENTER },
	//{ SR_FIELD_ICON,	    60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_LscrListInit[] = 
{
	{ SR_FIELD_EDITORID,		150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		 	5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,			50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_LtexListInit[] = 
{
	{ SR_FIELD_EDITORID,		150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		 	5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,			50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_LvliListInit[] = 
{
	{ SR_FIELD_EDITORID,	  150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		  5,	LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		  50,	LVCFMT_CENTER },
	{ SR_FIELD_CHANCENONE,	  50,	LVCFMT_CENTER },
	{ SR_FIELD_CALCULATEALL,  40,	LVCFMT_CENTER },
	{ SR_FIELD_CALCULATEEACH, 40,	LVCFMT_CENTER },
	{ SR_FIELD_USEALL,        40,	LVCFMT_CENTER },
	{ SR_FIELD_ITEMCOUNT,     80,	LVCFMT_CENTER },
	{ SR_FIELD_GLOBAL,	      80,	LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_LvlnListInit[] = 
{
	{ SR_FIELD_EDITORID,	  150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		  5,	LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		  50,	LVCFMT_CENTER },
	{ SR_FIELD_CHANCENONE,	  50,	LVCFMT_CENTER },
	{ SR_FIELD_CALCULATEALL,  40,	LVCFMT_CENTER },
	{ SR_FIELD_CALCULATEEACH, 40,	LVCFMT_CENTER },
	{ SR_FIELD_USEALL,        40,	LVCFMT_CENTER },
	{ SR_FIELD_ITEMCOUNT,     80,	LVCFMT_CENTER },
	{ SR_FIELD_MODEL,	      80,	LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_LvspListInit[] = 
{
	{ SR_FIELD_EDITORID,	 150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		 5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		 50,	LVCFMT_CENTER },
	{ SR_FIELD_CHANCENONE,	 60,	LVCFMT_CENTER },
	{ SR_FIELD_CALCULATEALL, 60,	LVCFMT_CENTER },
	{ SR_FIELD_CALCULATEEACH,60,	LVCFMT_CENTER },
	{ SR_FIELD_USEALL,       60,	LVCFMT_CENTER },
	{ SR_FIELD_ITEMCOUNT,    80,	LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_MattListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_MatoListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_MODEL,		50,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_MgefListInit[] = 
{
	{ SR_FIELD_EDITORID,		150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,			5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,			50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,		150,	LVCFMT_LEFT },
	{ SR_FIELD_SCHOOL,			60,		LVCFMT_CENTER },
	{ SR_FIELD_BASECOST,		60,		LVCFMT_CENTER },
	{ SR_FIELD_CASTINGDELAY,	60,		LVCFMT_CENTER },
	{ SR_FIELD_AREA,			60,		LVCFMT_CENTER },
	{ SR_FIELD_EFFECTTYPE,		60,		LVCFMT_CENTER },
	{ SR_FIELD_CASTTYPE,		60,		LVCFMT_CENTER },
	{ SR_FIELD_DELIVERYTYPE,	60,		LVCFMT_CENTER },
	{ SR_FIELD_RESISTTYPE,		60,		LVCFMT_CENTER },
	{ SR_FIELD_SOUNDVOLUME,		60,		LVCFMT_CENTER },
	{ SR_FIELD_SKILLLEVEL,		60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0,	0 }
 };

static srreclistcolinit_t s_MiscListInit[] = {
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	150,	LVCFMT_LEFT },
	{ SR_FIELD_VALUE,		60,		LVCFMT_CENTER },
	{ SR_FIELD_WEIGHT,		60,		LVCFMT_CENTER },
	{ SR_FIELD_MODEL,		60,		LVCFMT_CENTER },
	{ SR_FIELD_PICKUPSOUND,	100,	LVCFMT_CENTER },
	{ SR_FIELD_DROPSOUND,	100,	LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
 };

static srreclistcolinit_t s_NpcListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_FULLNAME,	120,	LVCFMT_CENTER },
	{ SR_FIELD_SCRIPT,		80,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
 };

static srreclistcolinit_t s_OtftListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMCOUNT,	60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};

static srreclistcolinit_t s_PerkListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	150,	LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};


static srreclistcolinit_t s_ProjListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	150,	LVCFMT_CENTER },
	{ SR_FIELD_NONE,		0,		0 }
};


static srreclistcolinit_t s_RaceListInit[] = 
{
	{ SR_FIELD_EDITORID,		150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,			5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,			50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,		100,	LVCFMT_CENTER },
	{ SR_FIELD_BODYPARTS,		100,	LVCFMT_CENTER },
	{ SR_FIELD_DESCRIPTION,		120,	LVCFMT_LEFT },
	{ SR_FIELD_MALEHEIGHT,		60,		LVCFMT_CENTER },
	{ SR_FIELD_FEMALEHEIGHT,	60,		LVCFMT_CENTER },
	{ SR_FIELD_SPELLCOUNT,		60,		LVCFMT_CENTER },
	{ SR_FIELD_NAKEDARMOR,		100,	LVCFMT_CENTER },
	{ SR_FIELD_KEYWORDCOUNT,	60,		LVCFMT_CENTER },
	{ SR_FIELD_KEYWORDS,		120,	LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};


static srreclistcolinit_t s_ScrlListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	140,	LVCFMT_CENTER },
	{ SR_FIELD_VALUE,		50,		LVCFMT_CENTER },
	{ SR_FIELD_WEIGHT,		50,		LVCFMT_CENTER },
	{ SR_FIELD_COST,		50,		LVCFMT_CENTER },
	{ SR_FIELD_CASTTIME,	50,		LVCFMT_CENTER },
	{ SR_FIELD_CASTTYPE,	50,		LVCFMT_CENTER },
	{ SR_FIELD_CASTANIM,	50,		LVCFMT_CENTER },
	{ SR_FIELD_EFFECTCOUNT,	50,		LVCFMT_CENTER },
	{ SR_FIELD_EQUIPSLOT,	80,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_SgstListInit[] = 
{
	{ SR_FIELD_EDITORID,	100,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,	5,	LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,	50,	LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	140,	LVCFMT_CENTER },
	{ SR_FIELD_USES,	60,	LVCFMT_CENTER },
	{ SR_FIELD_VALUE,	60,	LVCFMT_CENTER },
	{ SR_FIELD_WEIGHT,	60,	LVCFMT_CENTER },
	{ SR_FIELD_EFFECTCOUNT,	80,	LVCFMT_CENTER },
	{ SR_FIELD_USERDATA,	80,	LVCFMT_CENTER },
	{ SR_FIELD_MODEL,	60,	LVCFMT_CENTER },
	{ SR_FIELD_ICON,	60,	LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
 };

static srreclistcolinit_t s_ShouListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	120,	LVCFMT_LEFT },
	{ SR_FIELD_DESCRIPTION, 100,	LVCFMT_LEFT },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_SlgmListInit[] = {
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	150,	LVCFMT_LEFT },
	{ SR_FIELD_CAPACITY,	60,		LVCFMT_CENTER },
	{ SR_FIELD_CURRENTSOUL,	60,		LVCFMT_CENTER },
	{ SR_FIELD_FILLEDGEM,	60,		LVCFMT_CENTER },
	{ SR_FIELD_VALUE,		60,		LVCFMT_CENTER },
	{ SR_FIELD_WEIGHT,		60,		LVCFMT_CENTER },
	{ SR_FIELD_MODEL,		60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
 };

static srreclistcolinit_t s_SounListInit[] = 
{
	{ SR_FIELD_EDITORID,			150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,   			5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,				50,		LVCFMT_CENTER },
	{ SR_FIELD_SOUNDFILE,			100,	LVCFMT_CENTER },
	{ SR_FIELD_SOUNDREF,			100,	LVCFMT_CENTER },
	//{ SR_FIELD_MINATTENUATION,    60,	LVCFMT_CENTER },
	//{ SR_FIELD_MAXATTENUATION,    60,	LVCFMT_CENTER },
	//{ SR_FIELD_STATICATTENUATION, 60,	LVCFMT_CENTER },
	//{ SR_FIELD_FREQADJUSTMENT,    60,	LVCFMT_CENTER },
	//{ SR_FIELD_STARTTIME,         60,	LVCFMT_CENTER },
	//{ SR_FIELD_STOPTIME,          60,	LVCFMT_CENTER },
	//{ SR_FIELD_RANDOMPLAY,        60,	LVCFMT_CENTER },
	//{ SR_FIELD_RANDOMLOCATION,    60,	LVCFMT_CENTER },
	//{ SR_FIELD_RANDOMFREQSHIFT,   60,	LVCFMT_CENTER },
	//{ SR_FIELD_LOOP,              60,	LVCFMT_CENTER },
	//{ SR_FIELD_MENUSOUND,         60,	LVCFMT_CENTER },
	//{ SR_FIELD_2DSOUND,           60,	LVCFMT_CENTER },
	//{ SR_FIELD_360LFE,            60,	LVCFMT_CENTER },
	//{ SR_FIELD_IGNOREENVIRONMENT, 60,	LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_SnctListInit[] = 
{
	{ SR_FIELD_EDITORID,			150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,   			5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,				50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,			150,	LVCFMT_LEFT },
	{ SR_FIELD_PARENT,				120,	LVCFMT_CENTER },
	{ SR_FIELD_SOUNDFLAGS,			60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_SopmListInit[] = 
{
	{ SR_FIELD_EDITORID,			150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,   			5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,				50,		LVCFMT_CENTER },
	{ SR_FIELD_SOUNDFLAGS,			60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }	
};

static srreclistcolinit_t s_SndrListInit[] = 
{
	{ SR_FIELD_EDITORID,			150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,   			5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,				50,		LVCFMT_CENTER },
	{ SR_FIELD_CATEGORY,			120,	LVCFMT_CENTER },
	{ SR_FIELD_OUTPUTMARKER,		120,	LVCFMT_CENTER },
	{ SR_FIELD_SOUND,				120,	LVCFMT_CENTER },
	{ SR_FIELD_SOUNDCOUNT,			60,		LVCFMT_CENTER },
	{ SR_FIELD_CONDITIONCOUNT,		60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_SpelListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	140,	LVCFMT_CENTER },
	{ SR_FIELD_SPELLTYPE,	75,		LVCFMT_CENTER },
	{ SR_FIELD_CASTTYPE,	75,		LVCFMT_CENTER },
	{ SR_FIELD_DELIVERYTYPE,75,		LVCFMT_CENTER },
	{ SR_FIELD_COST,		60,		LVCFMT_CENTER },
	{ SR_FIELD_RANGE,		75,		LVCFMT_CENTER },
	{ SR_FIELD_CASTTIME,	75,		LVCFMT_CENTER },
	{ SR_FIELD_CHARGETIME,	75,		LVCFMT_CENTER },
	{ SR_FIELD_PERK,		120,	LVCFMT_CENTER },
	{ SR_FIELD_AUTOCALC,	60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_StatListInit[] = 
{
	{ SR_FIELD_EDITORID,	150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		5,		LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,		50,		LVCFMT_CENTER },
	{ SR_FIELD_SCALE,		60,		LVCFMT_CENTER },
	{ SR_FIELD_MATERIAL,	60,		LVCFMT_CENTER },
	{ SR_FIELD_MODEL,		60,		LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
 };

static srreclistcolinit_t s_WeapListInit[] = 
{
	{ SR_FIELD_EDITORID,	   150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		 	 5,	LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,			50,	LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	   150,	LVCFMT_LEFT },
	{ SR_FIELD_TYPE,		   100,	LVCFMT_CENTER },
	{ SR_FIELD_MATERIAL,	   100,	LVCFMT_CENTER },
	{ SR_FIELD_EQUIPSLOT,		60,	LVCFMT_CENTER },
	{ SR_FIELD_VALUE,			60,	LVCFMT_CENTER },
	{ SR_FIELD_WEIGHT,			60,	LVCFMT_CENTER },
	{ SR_FIELD_DAMAGE,			60,	LVCFMT_CENTER },
	{ SR_FIELD_ENCHANTMENT,		80,	LVCFMT_CENTER },
	{ SR_FIELD_ENCHANTPOINTS,	60,	LVCFMT_CENTER },
	{ SR_FIELD_VNAM,			60,	LVCFMT_CENTER },
	{ SR_FIELD_MODEL,			60,	LVCFMT_CENTER },
	{ SR_FIELD_NONE, 0, 0 }
};

static srreclistcolinit_t s_WoopListInit[] = 
{
	{ SR_FIELD_EDITORID,	   150,	LVCFMT_LEFT },
	{ SR_FIELD_FORMID,		 	 5,	LVCFMT_LEFT },
	{ SR_FIELD_FLAGS,			50,	LVCFMT_CENTER },
	{ SR_FIELD_ITEMNAME,	   150,	LVCFMT_LEFT },
	{ SR_FIELD_TRANSLATION,	   150,	LVCFMT_LEFT },
	{ SR_FIELD_NONE, 0, 0 }
};


static srreclistinfoinit_t s_ListInit[] = 
{
	{ &SR_NAME_AACT, s_AactListInit, &CSrAactRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_ACHR, s_AchrListInit, &CSrAchrRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_ACTI, s_ActiListInit, &CSrActiRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_ADDN, s_AddnListInit, &CSrAddnRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_ALCH, s_AlchListInit, &CSrAlchRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_AMMO, s_AmmoListInit, &CSrAmmoRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_ANIO, s_AnioListInit, &CSrAnioRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_APPA, s_AppaListInit, &CSrAppaRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_ARMA, s_ArmaListInit, &CSrArmaRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_ARMO, s_ArmoListInit, &CSrArmoRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_ARTO, s_ArtoListInit, &CSrArtoRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_ASPC, s_AspcListInit, &CSrAspcRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_ASTP, s_AstpListInit, &CSrAstpRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_AVIF, s_AvifListInit, &CSrAvifRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_BOOK, s_BookListInit, &CSrBookRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_BPTD, s_BptdListInit, &CSrBptdRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_CAMS, s_CamsListInit, &CSrCamsRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_CELL, s_CellListInit, &CSrCellRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_CLAS, s_ClasListInit, &CSrClasRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_CLFM, s_ClfmListInit, &CSrClfmRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_CLMT, s_ClmtListInit, &CSrClmtRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_COBJ, s_CobjListInit, &CSrCobjRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_COLL, s_CollListInit, &CSrCollRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_CONT, s_ContListInit, &CSrContRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_CPTH, s_CpthListInit, &CSrCpthRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_CSTY, s_CstyListInit, &CSrCstyRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_DEBR, s_DebrListInit, &CSrDebrRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_DIAL, s_DialListInit, &CSrDialRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_DLBR, s_DlbrListInit, &CSrDlbrRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_DLVW, s_DlvwListInit, &CSrDlvwRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_DOBJ, s_DobjListInit, &CSrDobjRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_DOOR, s_DoorListInit, &CSrDoorRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_DUAL, s_DualListInit, &CSrDualRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_ECZN, s_EcznListInit, &CSrEcznRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_EFSH, s_EfshListInit, &CSrEfshRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_ENCH, s_EnchListInit, &CSrEnchRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_EQUP, s_EqupListInit, &CSrEqupRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_EXPL, s_ExplListInit, &CSrExplRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_EYES, s_EyesListInit, &CSrEyesRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_FACT, s_FactListInit, &CSrFactRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_FLOR, s_FlorListInit, &CSrFlorRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_FLST, s_FlstListInit, &CSrFlstRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_FSTP, s_FstpListInit, &CSrFstpRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_FSTS, s_FstsListInit, &CSrFstsRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_FURN, s_FurnListInit, &CSrFurnRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_GLOB, s_GlobListInit, &CSrGlobRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_GMST, s_GmstListInit, &CSrGmstRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_GRAS, s_GrasListInit, &CSrGrasRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_HAZD, s_HazdListInit, &CSrHazdRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_HDPT, s_HdptListInit, &CSrHdptRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_IDLE, s_IdleListInit, &CSrIdleRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_IDLM, s_IdlmListInit, &CSrIdlmRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_IMAD, s_ImadListInit, &CSrImadRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_IMGS, s_ImgsListInit, &CSrImgsRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_INFO, s_InfoListInit, &CSrInfoRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_INGR, s_IngrListInit, &CSrIngrRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_IPCT, s_IpctListInit, &CSrIpctRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_IPDS, s_IpdsListInit, &CSrIpdsRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_KEYM, s_KeymListInit, &CSrKeymRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_KYWD, s_KywdListInit, &CSrKywdRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_LCRT, s_LcrtListInit, &CSrLcrtRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_LCTN, s_LctnListInit, &CSrLctnRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_LGTM, s_LgtmListInit, &CSrLgtmRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_LIGH, s_LighListInit, &CSrLighRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_LSCR, s_LscrListInit, &CSrLscrRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_LTEX, s_LtexListInit, &CSrLtexRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_LVLI, s_LvliListInit, &CSrLvliRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_LVLN, s_LvlnListInit, &CSrLvlnRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_LVSP, s_LvspListInit, &CSrLvspRecord::s_FieldMap, SR_FIELD_EDITORID },	
	{ &SR_NAME_MGEF, s_MgefListInit, &CSrMgefRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_MISC, s_MiscListInit, &CSrMiscRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_MATO, s_MatoListInit, &CSrMatoRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_MATT, s_MattListInit, &CSrMattRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_OTFT, s_OtftListInit, &CSrOtftRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_PERK, s_PerkListInit, &CSrPerkRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_PROJ, s_ProjListInit, &CSrProjRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_RACE, s_RaceListInit, &CSrRaceRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_SCRL, s_ScrlListInit, &CSrScrlRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_SHOU, s_ShouListInit, &CSrShouRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_SLGM, s_SlgmListInit, &CSrSlgmRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_SNCT, s_SnctListInit, &CSrSnctRecord::s_FieldMap, SR_FIELD_EDITORID },	
	{ &SR_NAME_SNDR, s_SndrListInit, &CSrSndrRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_SOPM, s_SopmListInit, &CSrSopmRecord::s_FieldMap, SR_FIELD_EDITORID },	
	{ &SR_NAME_SOUN, s_SounListInit, &CSrSounRecord::s_FieldMap, SR_FIELD_EDITORID },	
	{ &SR_NAME_SPEL, s_SpelListInit, &CSrSpelRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_STAT, s_StatListInit, &CSrStatRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_WEAP, s_WeapListInit, &CSrWeapRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ &SR_NAME_WOOP, s_WoopListInit, &CSrWoopRecord::s_FieldMap, SR_FIELD_EDITORID },
	{ NULL, NULL, NULL }
 };
/*===========================================================================
 *		End of Record List Default Column Data
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecordListCtrl Message Map
 *
 *=========================================================================*/
BEGIN_MESSAGE_MAP(CSrRecordListCtrl, CListCtrl)
	ON_NOTIFY_REFLECT(HDN_ITEMCLICK, OnItemclick)
	ON_NOTIFY_REFLECT(LVN_COLUMNCLICK, OnColumnclick)
	ON_NOTIFY_REFLECT(NM_DBLCLK, OnDblclk)
	ON_NOTIFY_REFLECT(NM_CUSTOMDRAW, OnCustomdraw)
	ON_NOTIFY_REFLECT(LVN_BEGINDRAG, OnBeginDrag)
	ON_WM_MOUSEMOVE()
	ON_WM_LBUTTONUP()
	ON_WM_CAPTURECHANGED()
	ON_WM_GETDLGCODE()
	ON_WM_CHAR()
	ON_WM_KEYDOWN()
	ON_WM_CLOSE()
	ON_WM_DESTROY()
END_MESSAGE_MAP()
/*===========================================================================
 *		End of CSrRecordListCtrl Message Map
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int CALLBACK s_DefaultRecListSort (lParam1, lParam2, lParamSort);
 *
 * Default callback function for record list sorting.
 *
 *=========================================================================*/
int CALLBACK s_DefaultRecListSort(LPARAM lParam1, LPARAM lParam2, LPARAM lParamSort) {
  SRRL_SORTFUNC_GETPARAMS(lParam1, lParam2, lParamSort);

  if (pRecord1 == NULL  || pRecord2 == NULL) return (0);
  
  if (pSortData->Reverse) return -pRecord1->CompareFields(pSortData->FieldID, pRecord2);
  return pRecord1->CompareFields(pSortData->FieldID, pRecord2);
}
/*===========================================================================
 *		End of Function CALLBACK s_DefaultRecListSort()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - int CALLBACK s_DefaultCustomRecListSort (lParam1, lParam2, lParamSort);
 *
 * Default callback function for record list sorting with custom data.
 *
 *=========================================================================*/
int CALLBACK s_DefaultCustomRecListSort(LPARAM lParam1, LPARAM lParam2, LPARAM lParamSort) 
{
	SRRL_SORTFUNC_GETPARAMS(lParam1, lParam2, lParamSort);
	dword Index;
	bool  Result = false;
	int   Value;
	
		/* Ensure valid data */
	if (pCustomData1 == NULL || pCustomData2 == NULL) return (0);
	
		/* Check all subrecord fields first */
	for (Index = 0; Index < pCustomData1->Subrecords.GetSize() && Index < pCustomData2->Subrecords.GetSize(); ++Index) 
	{
		Result = pCustomData1->Subrecords[Index]->CompareFields(Value, pSortData->FieldID, pCustomData2->Subrecords[Index]);
		if (Result) break;
	 }  
	
		/* Use the record comparison only if all the subrecord comparison failed */
	if (pRecord1 == NULL || pRecord2 == NULL) return (0);
	if (!Result) Value = pRecord1->CompareFields(pSortData->FieldID, pRecord2);
	
	if (pSortData->Reverse) return (-Value);
	return (Value);
}
/*===========================================================================
 *		End of Function CALLBACK s_DefaultCustomRecListSort()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Constructor
 *
 *=========================================================================*/
CSrRecordListCtrl::CSrRecordListCtrl() {
  m_pCurrentList    = NULL;
  m_pCurrentFilter  = NULL;
  m_AutoResize      = false;
  m_EnableDrag      = true;
  m_ActNormalList   = false;
  m_IsDragging      = false;
  m_ActivateType    = SR_RLACTIVATE_DEFAULT;
  m_pDragImage      = NULL;
  m_AcceptDrop      = true;
  m_EnableSort      = true;
  m_LastDropValid   = false;
  m_EnableColors    = true;
  m_pLastDropWnd    = NULL;
  m_DragType        = SR_RECORDLIST_RECORD;

  m_ListName = "DefaultList";

  //m_WantKeys	    = true;
  
  m_hGoodDropCursor = LoadCursor(::AfxGetInstanceHandle(), MAKEINTRESOURCE(IDC_GOODDROP_CURSOR));
  m_hBadDropCursor  = LoadCursor(::AfxGetInstanceHandle(), MAKEINTRESOURCE(IDC_NODROP_CURSOR));
}
/*===========================================================================
 *		End of Class CSrRecordListCtrl Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Destructor
 *
 *=========================================================================*/
CSrRecordListCtrl::~CSrRecordListCtrl() {
  m_ListInfos.Destroy();

  if (m_pDragImage != NULL) {
    delete m_pDragImage;
    m_pDragImage = NULL;
  }

}
/*===========================================================================
 *		End of Class CSrRecordListCtrl Destructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - int AddRecord (pRecord);
 *
 * Adds a record to the list using the current setup. Does not check to see
 * if the record is a valid type or not based on the current settings.
 *
 *=========================================================================*/
int CSrRecordListCtrl::AddRecord (CSrRecord* pRecord) {
  if (pRecord == NULL) return (-1);
  return AddCustomRecord(pRecord, NULL, 0);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::AddRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - int AddCustomRecord (pRecord, pSubrecord, UserData);
 *
 * Adds a new record in a custom list type.
 *
 *=========================================================================*/
int CSrRecordListCtrl::AddCustomRecord (CSrRecord* pRecord, CSrSubrecord* pSubrecord, const int UserData) {
  srrlcustomdata_t CustomData;

  CustomData.pRecord        = pRecord;
  CustomData.UserData       = UserData;
  CustomData.Subrecords.Destroy();
  CustomData.Subrecords.Add(pSubrecord);

  return AddCustomRecord(CustomData);
 }
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::AddCustomRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - int AddCustomRecord (CustomData);
 *
 * Adds a new record in a custom list type.
 *
 *=========================================================================*/
int CSrRecordListCtrl::AddCustomRecord (srrlcustomdata_t& CustomData) {
  int ListIndex;
  
	/* Ignore if we don't know what we're displaying */
  if (m_pCurrentList == NULL) return (-1);

	/* Insert a new row */
  ListIndex = InsertItem(GetItemCount(), "");
  if (ListIndex < 0) return (ListIndex);
  SetItemData(ListIndex, CustomData);
  
	/* Update all column texts */
  SetColumnTexts(ListIndex, CustomData.pRecord, &CustomData.Subrecords);
  return (ListIndex);
 }
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::AddCustomRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - void AddAllRecords (File);
 *
 * Adds all records from the given file based on the current settings.
 *
 *=========================================================================*/
void CSrRecordListCtrl::AddAllRecords (CSrEspFile& File) {
  AddAllRecords(&File.GetRecords());
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::AddAllRecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - void AddAllRecords (pTopGroup);
 *
 * Adds all records from the given file based on the current settings.
 *
 *=========================================================================*/
void CSrRecordListCtrl::AddAllRecords (CSrGroup* pTopGroup)
{
  CSrTypeGroup*  pGroup;
  CSrBaseRecord* pBaseRecord;
  CSrRecord*     pRecord;
  dword		 Index;

  if (m_pCurrentList == NULL) return;
  if (pTopGroup      == NULL) return;

  pGroup = pTopGroup->GetTypeGroup(*m_pCurrentList->pRecordType);
  if (pGroup == NULL) return;

  SetRedraw(FALSE);

  for (Index = 0; Index < pGroup->GetNumRecords(); ++Index) {
    pBaseRecord = pGroup->GetRecord(Index);
    pRecord = SrCastClass(CSrRecord, pBaseRecord);
    if (pRecord == NULL) continue;

    if (m_pCurrentFilter != NULL) {
      if (m_pCurrentFilter->CheckRecord(pRecord, m_ExtraFilter)) AddRecord(pRecord);
     }
    else if (pRecord->GetRecordType() == *m_pCurrentList->pRecordType) 
      AddRecord(pRecord);
   }

	/* Sort the initial list */
  if (m_pCurrentList->SortField != SR_FIELD_NONE) SortListPriv(m_pCurrentList->SortField);
  SetRedraw(TRUE);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::AddAllRecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - void AutoResize (CX. CY);
 *
 * Description
 *
 *=========================================================================*/
void CSrRecordListCtrl::AutoResize (const int CX, const int CY)
{
  CRect ParentRect(1, 1, CX, CY);
  CRect NewSize;

  NewSize.top    = m_AutoResizeOffset.top;
  NewSize.bottom = m_AutoResizeOffset.bottom + ParentRect.bottom - 35;
  NewSize.right  = m_AutoResizeOffset.right  + ParentRect.right + 0;
  NewSize.left   = m_AutoResizeOffset.left;

  SetWindowPos(NULL, NewSize.left, NewSize.top, NewSize.Width(), NewSize.Height(), SWP_NOZORDER | SWP_NOMOVE );
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::AutoResize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - srreclistinfo_t* CreateListInfoObject (void);
 *
 * Create and return a new list information structure.
 *
 *=========================================================================*/
srreclistinfo_t* CSrRecordListCtrl::CreateListInfoObject (void) {
  srreclistinfo_t* pListInfo;

  pListInfo = new srreclistinfo_t;
  m_ListInfos.Add(pListInfo);
  memset(pListInfo, 0, sizeof(srreclistinfo_t));

  return (pListInfo);
 }
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::CreateListInfoObject()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - srreclistinfo_t* CreateDefaultListInfo (Type);
 *
 * Attempts to create a default list information object for the given
 * record type. Returns NULL if it cannot.
 *
 *=========================================================================*/
srreclistinfo_t* CSrRecordListCtrl::CreateDefaultListInfo (const srrectype_t Type) {
  srreclistinfo_t* pListInfo;
  dword            Index;

  for (Index = 0; s_ListInit[Index].pRecordType != NULL; ++Index) {
    if (Type == *s_ListInit[Index].pRecordType) {
      pListInfo = InitializeColumns(*s_ListInit[Index].pRecordType, s_ListInit[Index].pInit, s_ListInit[Index].pFieldMap, 0, s_ListInit[Index].SortField);
      if (pListInfo != NULL && m_Options.SaveState) ReadListInfoRegistry(pListInfo);
      return (pListInfo);
     }
   }

	/* Unknown type */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::CreateDefaultListInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void DefaultSettings (void);
 *
 *=========================================================================*/
void CSrRecordListCtrl::DefaultSettings (void) 
{
	SetExtendedStyle(LVS_EX_FULLROWSELECT | LVS_EX_GRIDLINES );
}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::DefaultSettings()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - void DeleteAllColumns (void);
 *
 *=========================================================================*/
void CSrRecordListCtrl::DeleteAllColumns (void) 
{
  
  while (DeleteColumn(0)) 
  {
  }
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::DeleteAllColumns()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - BOOL DeleteAllItems (void);
 *
 *=========================================================================*/
BOOL CSrRecordListCtrl::DeleteAllItems (void) {
  m_DragRecords.Destroy();
  m_DragCustomData.Destroy();
  m_CustomData.Destroy();
  
  return CListCtrl::DeleteAllItems();
 }
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::DeleteAllItems()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - int FindEditorID (pString);
 *
 *=========================================================================*/
int CSrRecordListCtrl::FindEditorID (const SSCHAR* pString) {
  CSString   Buffer;
  CSrRecord* pRecord;
  dword      Index;
  bool       Result;
  int        LastMatch = -1;
  int        LastMatchCount = 0;
  int	     Matching;

  for (Index = 0; Index < (dword) GetItemCount(); ++Index) {
    pRecord = GetRecord(Index);
    if (pRecord == NULL) continue;

    Result = pRecord->GetField(Buffer, SR_FIELD_EDITORID);
    if (!Result) continue;

    Matching = Buffer.CountMatchLengthNoCase(pString);

    if (Matching > LastMatchCount) {
      LastMatchCount = Matching;
      LastMatch      = Index;
    }
  } 

  return (LastMatch);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::FindEditorID()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - srreclistinfo_t* FindListInfo (Type);
 *
 * Finds the list information structure associated with the given
 * record type. Returns NULL if not found.
 *
 *=========================================================================*/
srreclistinfo_t* CSrRecordListCtrl::FindListInfo (const srrectype_t Type) {
  srreclistinfo_t* pListInfo;
  dword		   Index;

  for (Index = 0; Index < m_ListInfos.GetSize(); ++Index) {
    pListInfo = m_ListInfos[Index];
    if (*pListInfo->pRecordType == Type) return (pListInfo);
   }

	/* Not found */
  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::FindListInfo()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - bool FindRecord (pRecord);
 *
 * Finds the given record in the current list. Returns the list index or
 * -1 if not found.
 *
 *=========================================================================*/
int CSrRecordListCtrl::FindRecord (CSrRecord* pRecord) {
  CSrRecord* pListRecord;
  int	     Index;

  if (pRecord == NULL) return (-1);

  for (Index = 0; Index < this->GetItemCount(); ++Index) {
    pListRecord = GetRecord(Index);
    if (pListRecord == pRecord) return (Index);
  }

  return (-1);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::FindRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - CSrRecord* GetRecord (ListIndex);
 *
 *=========================================================================*/
CSrRecord* CSrRecordListCtrl::GetRecord (const int ListIndex) {
  dword Value;
 
  if (ListIndex < 0 || ListIndex >= GetItemCount()) return (NULL);
  if (m_pCurrentList == NULL) return (NULL);

  Value = GetItemData(ListIndex);
  if (Value == 0) return (NULL);

  switch (m_pCurrentList->Type) 
  {
    case SR_RECORDLIST_RECORD:
        return (CSrRecord *) Value;
    case SR_RECORDLIST_CUSTOM:
        return ((srrlcustomdata_t *) Value)->pRecord;
   }

  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::GetRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - srrlcustomdata_t* GetCustomData (ListIndex);
 *
 *=========================================================================*/
srrlcustomdata_t* CSrRecordListCtrl::GetCustomData (const int ListIndex) {
  dword Value;
 
  if (ListIndex < 0 || ListIndex >= GetItemCount()) return (NULL);
  if (m_pCurrentList == NULL) return (NULL);

  Value = GetItemData(ListIndex);
  if (Value == 0) return (NULL);

  switch (m_pCurrentList->Type) {
    case SR_RECORDLIST_RECORD:
	return (NULL);        
    case SR_RECORDLIST_CUSTOM:
        return ((srrlcustomdata_t *) Value);
   }

  return (NULL);
 }
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::GetCustomData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - CSrRecord* GetSelectedRecord (void);
 *
 * Returns the first selected record in the list or NULL;
 *
 *=========================================================================*/
CSrRecord* CSrRecordListCtrl::GetSelectedRecord (void) {
  POSITION ListPos;
  int      ListIndex;

  ListPos = GetFirstSelectedItemPosition();
  if (ListPos == NULL) return (NULL);

  ListIndex = GetNextSelectedItem(ListPos);
  return GetRecord(ListIndex);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::GetSelectedRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - CSrRecord* GetSelectedCustomData (void);
 *
 * Returns the first selected custom data in the list or NULL;
 *
 *=========================================================================*/
srrlcustomdata_t* CSrRecordListCtrl::GetSelectedCustomData (void) {
  POSITION ListPos;
  int      ListIndex;

  ListPos = GetFirstSelectedItemPosition();
  if (ListPos == NULL) return (NULL);

  ListIndex = GetNextSelectedItem(ListPos);
  return GetCustomData(ListIndex);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::GetSelectedCustomData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - int GetSelectedItem (void);
 *
 * Returns the first selected custom data in the list or NULL;
 *
 *=========================================================================*/
int CSrRecordListCtrl::GetSelectedItem (void) {
  POSITION ListPos;
  int      ListIndex;

  ListPos = GetFirstSelectedItemPosition();
  if (ListPos == NULL) return (-1);
  
  ListIndex = GetNextSelectedItem(ListPos);
  return (ListIndex);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::GetSelectedItem()
 *=========================================================================*/


void CSrRecordListCtrl::GetSelectedRecords (CSrRefRecordArray& Records)
{
	POSITION ListPos;
	int      ListIndex;

	ListPos = GetFirstSelectedItemPosition();
	if (ListPos == NULL) return;
  
	while (ListPos)
	{
		ListIndex = GetNextSelectedItem(ListPos);
		CSrRecord* pRecord = GetRecord(ListIndex);
		if (pRecord) Records.Add(pRecord);
	} 	
	
}


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - srreclistinfo_t* InitializeColumns (Type, ListInit, pFieldMap, Flags, SortField);
 *
 * Initialize the list info for the given record type. Returns the
 * new object on success or NULL on any error.
 *
 *=========================================================================*/
srreclistinfo_t* CSrRecordListCtrl::InitializeColumns (const srrectype_t& Type, srreclistcolinit_t* ListInit, const srrecfieldmap_t* pFieldMap, const dword Flags, const srrecfieldid_t SortField) {
  const srrecfieldmap_t*	pMap;
  srreclistinfo_t*			pListInfo = NULL;
  srreclistcolumn_t*		pColumn;
  dword						Index;
  dword						ColIndex;
  dword						SubItem = 0;

	/* Ignore invalid input */
  if (ListInit == NULL) return (NULL);

	/* Update an existing or create a new record */
  if ((Flags & SRRL_INITCOL_FORCENEW) == 0) pListInfo = FindListInfo(Type);
  if (pListInfo == NULL) pListInfo = CreateListInfoObject();

	/* Initialize the list info */
  pListInfo->Type        = SR_RECORDLIST_RECORD;
  pListInfo->pRecordType = &Type;
  pListInfo->NumColumns  = 0;
  pListInfo->SortSubItem = -1;
  pListInfo->SortField   = SortField;
  pListInfo->SortReverse = false;
  SubItem                = 0;

	/* Add all the predefined columns */
  for (Index = 0; ListInit[Index].FieldID != SR_FIELD_NONE; ++Index) {
    ColIndex = pListInfo->NumColumns;

    pListInfo->Columns[ColIndex].Display     = true;
    pListInfo->Columns[ColIndex].Format      = ListInit[Index].Format;
    pListInfo->Columns[ColIndex].Width       = ListInit[Index].Width;
    pListInfo->Columns[ColIndex].CompareFunc = ListInit[Index].CompareFunc;
    pListInfo->Columns[ColIndex].SubItem     = SubItem;
    pListInfo->Columns[ColIndex].FieldID     = ListInit[Index].FieldID;
    pListInfo->Columns[ColIndex].pField      = FindSrFieldEntry(pFieldMap, ListInit[Index].FieldID);
    pListInfo->Columns[ColIndex].ColumnIndex = -1;

    if (pListInfo->Columns[ColIndex].pField == NULL) {
      pListInfo->Columns[ColIndex].SetTitle(GetSrFieldString(pListInfo->Columns[ColIndex].FieldID));
    }
    else {
      pListInfo->Columns[ColIndex].SetTitle(pListInfo->Columns[ColIndex].pField->pName);
    }

    ++pListInfo->NumColumns;
    ++SubItem;
    if (pListInfo->NumColumns >= SR_RECLIST_MAXCOLS) break;
  }
  
	/* Add any remaining columns from the map heirarchy if required */
  if ((Flags & SRRL_INITCOL_NOEXTRAFIELDS) != 0) return (pListInfo);

  for (pMap = pFieldMap; pMap != NULL; pMap = pMap->pBaseFieldMap) {
    assert(pMap != pMap->pBaseFieldMap);

    for (Index = 0; pMap->pField[Index].GetMethod != NULL; ++Index) {
      pColumn = FindListColumn(pListInfo, pMap->pField[Index].FieldID);
      if (pColumn != NULL) continue;

      ColIndex = pListInfo->NumColumns;
       
      pListInfo->Columns[ColIndex].Display     = true;
      pListInfo->Columns[ColIndex].Format      = LVCFMT_CENTER;
      pListInfo->Columns[ColIndex].Width       = 20;
      pListInfo->Columns[ColIndex].SubItem     = SubItem;
      pListInfo->Columns[ColIndex].FieldID     = pMap->pField[Index].FieldID;
      pListInfo->Columns[ColIndex].pField      = &pMap->pField[Index];
      pListInfo->Columns[ColIndex].ColumnIndex = -1;
      pListInfo->Columns[ColIndex].SetTitle(pListInfo->Columns[ColIndex].pField->pName);
      
      ++pListInfo->NumColumns;
      ++SubItem;
      if (pListInfo->NumColumns >= SR_RECLIST_MAXCOLS) break;
    }
  }

  return (pListInfo);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::InitializeColumns()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void OnColumnclick (pNMHDR, pResult);
 *
 *=========================================================================*/
void CSrRecordListCtrl::OnColumnclick (NMHDR* pNMHDR, LRESULT* pResult) {
  NM_LISTVIEW*       pNMListView = (NM_LISTVIEW*)pNMHDR;
  srreclistcolumn_t* pColumn;
  int	             SubItem;
  *pResult = 0;

	/* Ignore if current list is invalid */
  if (m_pCurrentList == NULL || !m_EnableSort) return;
  SubItem = pNMListView->iSubItem;

  if (SubItem == m_pCurrentList->SortSubItem) 
  {
    m_pCurrentList->SortReverse = !m_pCurrentList->SortReverse;
  }
  else 
  {
    m_pCurrentList->SortReverse = false;
    m_pCurrentList->SortSubItem = SubItem;
  }

  pColumn = FindListColumnBySubItem(m_pCurrentList, SubItem);
  if (pColumn == NULL) return;
  m_pCurrentList->SortField = pColumn->FieldID;

  SortListPriv(m_pCurrentList->SortField);
}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::OnColumnclick()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void OnCustomdraw (pNMHDR, pResult);
 *
 *=========================================================================*/
void CSrRecordListCtrl::OnCustomdraw (NMHDR* pNMHDR, LRESULT* pResult) {
  NMLVCUSTOMDRAW* pLVCD = reinterpret_cast<NMLVCUSTOMDRAW*>( pNMHDR );

	/* Take the default processing unless we set this to something else below. */
  *pResult = CDRF_DODEFAULT; 
  if (!m_Options.EnableColors || !m_EnableColors) return;

	/* First thing - check the draw stage. If it's the control's prepaint
	 * stage, then tell Windows we want messages for every item. */
  if ( CDDS_PREPAINT == pLVCD->nmcd.dwDrawStage ) {
    *pResult = CDRF_NOTIFYITEMDRAW;
  }
        /* This is the prepaint stage for an item. Here's where we set the
           item's text/back color. */
  else if ( CDDS_ITEMPREPAINT == pLVCD->nmcd.dwDrawStage ) {
    CSrRecord* pRecord;

    pRecord = GetRecord(pLVCD->nmcd.dwItemSpec);

    if (pRecord != NULL) {
      int Score = INT_MAX;

      if (pRecord->IsDeleted() && m_Options.DeletedColor.Enable && m_Options.DeletedColor.Order < Score) {
        Score = m_Options.DeletedColor.Order;
        pLVCD->clrTextBk = m_Options.DeletedColor.Color;
      }

      if (pRecord->IsActive() && m_Options.ActiveColor.Enable && m_Options.ActiveColor.Order < Score) {
        Score = m_Options.ActiveColor.Order;
        pLVCD->clrTextBk = m_Options.ActiveColor.Color;
      }

      if (pRecord->IsIgnored() && m_Options.IgnoredColor.Enable && m_Options.IgnoredColor.Order < Score) {
        Score = m_Options.IgnoredColor.Order;
        pLVCD->clrTextBk = m_Options.IgnoredColor.Color;
      }

      if (pRecord->IsQuestItem() && m_Options.QuestColor.Enable && m_Options.QuestColor.Order < Score) {
        Score = m_Options.QuestColor.Order;
        pLVCD->clrTextBk = m_Options.QuestColor.Color;
      }

      if (pRecord->IsDangerous() && m_Options.DangerousColor.Enable && m_Options.DangerousColor.Order < Score) {
        Score = m_Options.DangerousColor.Order;
        pLVCD->clrTextBk = m_Options.DangerousColor.Color;
      }
    }
		/* Tell Windows to paint the control itself */
    *pResult = CDRF_DODEFAULT;
  }

}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::OnCustomdraw()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void OnDblclk (pNMHDR, pResult);
 *
 *=========================================================================*/
void CSrRecordListCtrl::OnDblclk (NMHDR* pNMHDR, LRESULT* pResult) {
  POSITION	    SelPos;
  CSrRecord*	pRecord;
  CWnd*	        pWnd;
  bool		    AltState;
  int		    MsgID = ID_SRRECORDLIST_ACTIVATE;
  int           SelIndex;

	/* Ignore if we are not activating items */
  if (m_ActivateType == SR_RLACTIVATE_NONE) return;

  AltState = GetAsyncKeyState(VK_MENU) != 0;
  if (AltState) MsgID = ID_SRRECORDLIST_ALTACTIVATE;
  
  SelPos = GetFirstSelectedItemPosition();
  if (SelPos == NULL) return;

  SelIndex = GetNextSelectedItem(SelPos);
  if (SelIndex < 0) return;

  pRecord = GetRecord(SelIndex);

  pWnd = GetOwner();
  if (pWnd == NULL) pWnd = GetParent();

  if (pWnd != NULL) {
    pWnd->PostMessage(MsgID, (WPARAM) pRecord, SelIndex);
  }

  *pResult = 0;
 }
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::OnDblclk()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void OnItemclick (pNMHDR, pResult);
 *
 *=========================================================================*/
void CSrRecordListCtrl::OnItemclick (NMHDR* pNMHDR, LRESULT* pResult) {
  HD_NOTIFY *phdn = (HD_NOTIFY *) pNMHDR;
	
  *pResult = 0;
 }
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::OnItemclick()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void OnSize (nType, cx, cy);
 *
 *=========================================================================*/
void CSrRecordListCtrl::OnSize (UINT nType, int cx, int cy) {
  CListCtrl::OnSize(nType, cx, cy);
 }
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::OnSize()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - void ResetContents (void);
 *
 *=========================================================================*/
void CSrRecordListCtrl::ResetContents (void) {
  DeleteAllItems();
  DeleteAllColumns();
 }
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::ResetContents()
 *=========================================================================*/


void CSrRecordListCtrl::ClearSelections(void)
{
	for (int i = 0; i < GetItemCount(); ++i)
	{
		SetItemState(i, 0, LVIS_SELECTED);    
	}

}


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - bool SelectRecord (pRecord);
 *
 *=========================================================================*/
bool CSrRecordListCtrl::SelectRecord (CSrRecord* pRecord) {
  CSrRecord* pListRecord;
  int	     Index;

  for (Index = 0; Index < GetItemCount(); ++Index) {
    SetItemState(Index, 0, LVIS_SELECTED);

    pListRecord = GetRecord(Index);
    if (pListRecord == NULL) continue;

    if (pListRecord == pRecord) {
      SetItemState(Index, LVIS_SELECTED, LVIS_SELECTED);
      EnsureVisible(Index, FALSE);
    }
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::SelectRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - void SelectRecord (ListIndex);
 *
 *=========================================================================*/
void CSrRecordListCtrl::SelectRecord (const int ListIndex) {
  SetItemState(ListIndex, LVIS_SELECTED, LVIS_SELECTED);
  EnsureVisible(ListIndex, FALSE);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::SelectRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - void SetItemData (ListIndex, pRecord);
 *
 *=========================================================================*/
void CSrRecordListCtrl::SetItemData (const int ListIndex, CSrRecord* pRecord) {
  srrlcustomdata_t* pCustomData;

  if (m_pCurrentList == NULL) return;

  switch (m_pCurrentList->Type) {  
    case SR_RECORDLIST_RECORD: 
        CListCtrl::SetItemData(ListIndex, (DWORD) (void *) pRecord);
		break;
    case SR_RECORDLIST_CUSTOM: 
        pCustomData = new srrlcustomdata_t;
		m_CustomData.Add(pCustomData);

		pCustomData->Destroy();
		pCustomData->pRecord = pRecord;

		CListCtrl::SetItemData(ListIndex, (DWORD) (void *) pCustomData);
		break;
   }

 }
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::SetItemData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - void SetItemData (ListIndex, pRecord, pSubrecord, UserData);
 *
 *=========================================================================*/
void CSrRecordListCtrl::SetItemData (const int ListIndex, CSrRecord* pRecord, CSrSubrecord* pSubrecord, const int UserData) {
  srrlcustomdata_t* pCustomData;

  if (m_pCurrentList == NULL) return;

  switch (m_pCurrentList->Type) {  
    case SR_RECORDLIST_RECORD: 
        CListCtrl::SetItemData(ListIndex, (DWORD) (void *) pRecord);
		break;
    case SR_RECORDLIST_CUSTOM: 
        pCustomData = new srrlcustomdata_t;
		m_CustomData.Add(pCustomData);

		pCustomData->Destroy();
		pCustomData->pRecord      = pRecord;
		pCustomData->UserData     = UserData;
		pCustomData->Subrecords.Destroy();
		pCustomData->Subrecords.Add(pSubrecord);

		CListCtrl::SetItemData(ListIndex, (DWORD) (void *) pCustomData);
		break;
   }

 }
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::SetItemData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - void SetItemData (ListIndex, CustomData);
 *
 *=========================================================================*/
void CSrRecordListCtrl::SetItemData (const int ListIndex, const srrlcustomdata_t CustomData) 
{
  srrlcustomdata_t* pCustomData;

  if (m_pCurrentList == NULL) return;

  switch (m_pCurrentList->Type) 
  {
    case SR_RECORDLIST_RECORD: 
        CListCtrl::SetItemData(ListIndex, (DWORD) (void *) CustomData.pRecord);
		break;
    case SR_RECORDLIST_CUSTOM: 
        pCustomData = new srrlcustomdata_t;
		m_CustomData.Add(pCustomData);
		*pCustomData = CustomData;
		CListCtrl::SetItemData(ListIndex, (DWORD) (void *) pCustomData);
		break;
  }

}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::SetItemData()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - bool SetCustomField (ListIndex, FieldID, pString);
 *
 *=========================================================================*/
bool CSrRecordListCtrl::SetCustomField (const int ListIndex, const srrecfieldid_t FieldID, const SSCHAR* pString) {
  srreclistcolumn_t* pColumn;

	/* Ignore if no current list to display */
  if (m_pCurrentList == NULL) return (false);

  pColumn = FindListColumn(m_pCurrentList, FieldID);
  if (pColumn == NULL) return (false);

  SetItemText(ListIndex, pColumn->SubItem, pString);  
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::SetCustomField()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - bool SetupList (pListInfo);
 *
 * Sets up a list based on the input list information.
 *
 *=========================================================================*/
bool CSrRecordListCtrl::SetupList (srreclistinfo_t* pListInfo) {
  srreclistcolumn_t* pColumn;
  dword		     Index;
  dword		     ColCount = 0;

  if (m_Options.SaveState) ReadListInfoRegistry(pListInfo);

  for (Index = 0; Index < pListInfo->NumColumns; ++Index) {
    pColumn = &pListInfo->Columns[Index];
    if (!pColumn->Display) continue;

    pColumn->ColumnIndex = InsertColumn(Index, pColumn->Title, pColumn->Format, pColumn->Width, pColumn->SubItem);
    ++ColCount;
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::SetupList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - bool SetupList (Type);
 *
 * Sets up the list for the given record type. Returns false if the 
 * column definition for the type is not found.
 *
 *=========================================================================*/
bool CSrRecordListCtrl::SetupList (const srrectype_t Type) 
{
  srreclistinfo_t* pListInfo;
  dword		   ColCount = 0;

	/* Clear the current list contents and columns */
  ResetContents();
  
	/* Attempt to find the given list definition */
  pListInfo = FindListInfo(Type);

  if (pListInfo == NULL) 
  {
	m_pCurrentList = NULL;
    pListInfo = CreateDefaultListInfo(Type);
    if (pListInfo == NULL) return (false);
  }

  m_pCurrentList = pListInfo;
  SetupList(pListInfo);

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::SetupList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - bool SetupList (pFilter);
 *
 * Sets up the list for the given filter.
 *
 *=========================================================================*/
bool CSrRecordListCtrl::SetupList (CSrRecordFilter* pFilter) {
  bool Result;

  if (m_pCurrentFilter == pFilter) return (true);
  UpdateCurrentList();
  
  if (pFilter == NULL) {
    ResetContents();
    m_pCurrentList   = NULL;
    m_pCurrentFilter = NULL;
    return (true);
  }

	/* Setup the list again if needed */
  if (m_pCurrentFilter == NULL || m_pCurrentFilter->GetRecordType() != pFilter->GetRecordType()) {
    Result = SetupList(pFilter->GetRecordType());
    m_pCurrentFilter = pFilter;
    if (!Result) return (false);
  }
  else {
    DeleteAllItems();
    m_pCurrentFilter = pFilter;
  }

  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::SetupList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - bool SetupList (Type, pListInit, pFieldMap);
 *
 *=========================================================================*/
bool CSrRecordListCtrl::SetupList (const srrectype_t& Type, srreclistcolinit_t* pListInit, const srrecfieldmap_t* pFieldMap) {
  srreclistinfo_t* pListInfo;
  
  m_pCurrentList = NULL;
  pListInfo = InitializeColumns(Type, pListInit, pFieldMap, SRRL_INITCOL_FORCENEW | SRRL_INITCOL_NOEXTRAFIELDS);
  if (pListInfo == NULL) return (false);

  m_pCurrentList = pListInfo;
  return SetupList(pListInfo);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::SetupList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - bool SetupCustomList (pColumns, pFieldMap);
 *
 *=========================================================================*/
bool CSrRecordListCtrl::SetupCustomList (srreclistcolinit_t* pColumns, const srrecfieldmap_t* pFieldMap, const srrecfield_t* pCustomFields) {
  const srrecfield_t* pField;
  dword	   	      Index;
  
	/* Ignore invalid input */
  if (pColumns == NULL) return (false);

	/* Save the current content */
  UpdateCurrentList();
  
	/* Destroy the current setup  */
  ResetContents();

	/* Create a new list object */
  m_pCurrentList = CreateListInfoObject();
  m_pCurrentList->pRecordType = NULL;
  m_pCurrentList->Type        = SR_RECORDLIST_CUSTOM;
  
  for (Index = 0; pColumns[Index].FieldID != SR_FIELD_NONE; ++Index) {
    if (m_pCurrentList->NumColumns >= SR_RECLIST_MAXCOLS) break;
    
    m_pCurrentList->Columns[m_pCurrentList->NumColumns].ColumnIndex = m_pCurrentList->NumColumns;
    m_pCurrentList->Columns[m_pCurrentList->NumColumns].SubItem     = m_pCurrentList->NumColumns;
    m_pCurrentList->Columns[m_pCurrentList->NumColumns].Display     = true;
    m_pCurrentList->Columns[m_pCurrentList->NumColumns].Width       = pColumns[Index].Width;
    m_pCurrentList->Columns[m_pCurrentList->NumColumns].Format      = pColumns[Index].Format;
    m_pCurrentList->Columns[m_pCurrentList->NumColumns].CompareFunc = pColumns[Index].CompareFunc;

    pField = FindSrField(pCustomFields, pColumns[Index].FieldID);
    if (pField == NULL && pFieldMap != NULL) pField = FindSrFieldEntry(pFieldMap, pColumns[Index].FieldID);

    if (pField != NULL) {
      m_pCurrentList->Columns[m_pCurrentList->NumColumns].pField  = pField;
      m_pCurrentList->Columns[m_pCurrentList->NumColumns].FieldID = pField->FieldID;
      m_pCurrentList->Columns[m_pCurrentList->NumColumns].SetTitle(pField->pName);
      ++m_pCurrentList->NumColumns;
    }
    else {
      m_pCurrentList->Columns[m_pCurrentList->NumColumns].pField  = NULL;
      m_pCurrentList->Columns[m_pCurrentList->NumColumns].FieldID = pColumns[Index].FieldID;
      m_pCurrentList->Columns[m_pCurrentList->NumColumns].SetTitle(GetSrFieldString(pColumns[Index].FieldID));
    }
   }

  SetupList(m_pCurrentList);
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::SetupCustomList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - void SetAutoResizeOffset (void);
 *
 *=========================================================================*/
void CSrRecordListCtrl::SetAutoResizeOffset (void) {
  CRect ParentRect;
  CRect ThisRect;
  CRect FrameRect;

  GetWindowRect(&ThisRect);
  //GetClientRect(&ThisRect);
  GetParent()->GetClientRect(&ParentRect);
  GetParentFrame()->GetClientRect(&FrameRect);

  m_AutoResizeOffset.top    = ThisRect.top;
  m_AutoResizeOffset.bottom = ThisRect.bottom - ParentRect.bottom;
  m_AutoResizeOffset.right  = ThisRect.right  - ParentRect.right;
  m_AutoResizeOffset.left   = ThisRect.left;

 }
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::SetAutoResizeOffset()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - void SetColumnTexts (ListIndex, pRecord, pSubrecords);
 *
 * Updates the given record text in the list.
 *
 *=========================================================================*/
void CSrRecordListCtrl::SetColumnTexts (const int ListIndex, CSrRecord* pRecord, CSrRefSubrecordArray* pSubrecords) {
  srreclistcolumn_t* pColumn;
  CSString	     Buffer;
  dword		     Index;
  dword		     SubIndex;
  bool		     Result;
  
  if (m_pCurrentList == NULL) return;
  if (pRecord        == NULL) return;
  
	/* Update all column texts */
  for (Index = 0; Index < m_pCurrentList->NumColumns; ++Index) {
    pColumn = &m_pCurrentList->Columns[Index];
    if (!pColumn->Display) continue;

		/* Use the supplied field method if available */
    if (pColumn->pField != NULL && pColumn->pField->GetMethod != NULL) {
      (pRecord ->*pColumn->pField->GetMethod)(Buffer, 0);
      SetItemText(ListIndex, pColumn->SubItem, Buffer);
      continue;
    }
    
		/* Try the record general field method */
    Result = pRecord->GetField(Buffer, pColumn->FieldID);

    if (Result) {
      SetItemText(ListIndex, pColumn->SubItem, Buffer);
      continue;
    }

		/* Try all valid subrecord general fields if present */
    if (pSubrecords == NULL) continue;

    for (SubIndex = 0; SubIndex < pSubrecords->GetSize(); ++SubIndex) {
      Result = (*pSubrecords)[SubIndex]->GetField(Buffer, pColumn->FieldID);

      if (Result) {
        SetItemText(ListIndex, pColumn->SubItem, Buffer);
        break;
      }
    }
  }

}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::SetColumnTexts()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - void SortList (FieldID);
 *
 *=========================================================================*/
void CSrRecordListCtrl::SortList (const srrecfieldid_t FieldID, const bool Reverse) {
  srreclistcolumn_t* pColumn;

  if (m_pCurrentList == NULL) return;
  pColumn = FindListColumn(m_pCurrentList, FieldID);
  if (pColumn == NULL) return;

  m_pCurrentList->SortField   = FieldID;
  m_pCurrentList->SortSubItem = pColumn->SubItem;
  m_pCurrentList->SortReverse = Reverse;

  SortListPriv(FieldID);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::SortList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - void SortListPriv (FieldID);
 *
 *=========================================================================*/
void CSrRecordListCtrl::SortListPriv (const srrecfieldid_t FieldID) {
  srreclistsort_t    SortData;
  srreclistcolumn_t* pColumn;

  if (m_pCurrentList == NULL) return;
  pColumn = FindListColumn(m_pCurrentList, FieldID);

  m_pCurrentList->SortField   = FieldID;
  m_pCurrentList->SortSubItem = pColumn->SubItem;

  SortData.FieldID  = m_pCurrentList->SortField;
  SortData.SubItem  = m_pCurrentList->SortSubItem;
  SortData.Reverse  = m_pCurrentList->SortReverse;
  SortData.ListType = m_pCurrentList->Type;

  if (pColumn == NULL || pColumn->CompareFunc == NULL) {

    if (m_pCurrentList->Type == SR_RECORDLIST_CUSTOM)
      SortItems(s_DefaultCustomRecListSort, (DWORD) (void *) &SortData);
    else
      SortItems(s_DefaultRecListSort, (DWORD) (void *) &SortData);
   }
  else
    SortItems(pColumn->CompareFunc, (DWORD) (void *) &SortData);

 }
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::SortListPriv()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - void UpdateCurrentList (void);
 *
 * Saves the current width/settings of the list to the list info object.
 *
 *=========================================================================*/
void CSrRecordListCtrl::UpdateCurrentList (void) {
  srreclistcolumn_t* pColumn;
  dword		     Index;
  
	/* Ignore if nothing to update */
  if (m_pCurrentList == NULL) return;  
  
  for (Index = 0; Index < m_pCurrentList->NumColumns; ++Index) {
    pColumn = &m_pCurrentList->Columns[Index];
    if (!pColumn->Display || pColumn->ColumnIndex < 0) continue;

    pColumn->Width = GetColumnWidth(pColumn->ColumnIndex);
  }

  if (m_Options.SaveState) WriteListInfoRegistry(m_pCurrentList);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::UpdateCurrentList()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - void UpdateRecord (ListIndex);
 *
 *=========================================================================*/
void CSrRecordListCtrl::UpdateRecord (const int ListIndex) 
{
	CSrRecord*        pRecord;
	srrlcustomdata_t* pCustomData;
	
	pCustomData = GetCustomData(ListIndex);
	
	if (pCustomData != NULL) {
	  SetColumnTexts(ListIndex, pCustomData->pRecord, &pCustomData->Subrecords);
	  return;
	}
	
	pRecord = GetRecord(ListIndex);
	if (pRecord == NULL) return;
	
	SetColumnTexts(ListIndex, pRecord, NULL);
}


void CSrRecordListCtrl::UpdateRecord (const int ListIndex, CSrRecord* pNewRecord) 
{
	CSrRecord*        pRecord;
	srrlcustomdata_t* pCustomData;
	
	pCustomData = GetCustomData(ListIndex);
	
	if (pCustomData != NULL) 
	{
		pCustomData->pRecord = pNewRecord;
		SetColumnTexts(ListIndex, pCustomData->pRecord, &pCustomData->Subrecords);
		return;
	}
	
	pRecord = GetRecord(ListIndex);
	if (pRecord == NULL) return;
	
	SetColumnTexts(ListIndex, pRecord, NULL);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::UpdateRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - int UpdateRecord (pNewRecord, pOldRecord);
 *
 * Updates an existing record or adds a new one. Returns the updated list
 * index or -1 on any error.
 *
 *=========================================================================*/
int CSrRecordListCtrl::UpdateRecord (CSrRecord* pNewRecord, CSrRecord* pOldRecord) {
  int ListIndex;

  ListIndex = FindRecord(pOldRecord);

  if (ListIndex < 0) {
    if (m_pCurrentFilter != NULL && !m_pCurrentFilter->CheckRecord(pNewRecord, m_ExtraFilter)) return (-1);
    return AddRecord(pNewRecord);
  }

  if (pNewRecord == NULL) {
    DeleteItem(ListIndex);
    return (-1);
  }

  SetItemData(ListIndex, pNewRecord);
  SetColumnTexts(ListIndex, pNewRecord, NULL);
  return (ListIndex);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::UpdateRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - bool RemoveItem (ListIndex);
 *
 *=========================================================================*/
bool CSrRecordListCtrl::RemoveItem (const int ListIndex) { 
  srrlcustomdata_t* pCustomData;

  if (ListIndex < 0 || ListIndex >= GetItemCount()) return (false);

  pCustomData = GetCustomData(ListIndex);
  
  DeleteItem(ListIndex);

  if (pCustomData != NULL) m_CustomData.Delete(pCustomData);
  return (true);
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::RemoveItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void OnBeginDrag (pNMHDR, pResult);
 *
 *=========================================================================*/
void CSrRecordListCtrl::OnBeginDrag (NMHDR* pNMHDR, LRESULT* pResult) {
  NM_LISTVIEW*      pNMListView = (NM_LISTVIEW *)pNMHDR;
  srrlcustomdata_t* pCustomData;
  CSrRecord*        pRecord;
  POINT		    DragPoint;
  POSITION	    SelPos;
  int		    Offset = 10;
  int		    ListIndex;
  *pResult = 0;

	/* Ignore if the dragging is disabled for the list */
  if (!m_EnableDrag || m_ActNormalList) return;

	/* Copy the records we wish to drag */
  m_DragRecords.Destroy();
  m_DragCustomData.Destroy();

	/* Get drag records */
  SelPos = GetFirstSelectedItemPosition();
  
  while (SelPos != NULL) {
    ListIndex   = GetNextSelectedItem(SelPos);
    pRecord     = GetRecord(ListIndex);
    pCustomData = GetCustomData(ListIndex);

    if (pRecord     != NULL && (m_DragType & SR_RECORDLIST_RECORD) != 0) m_DragRecords.Add(pRecord);
    if (pCustomData != NULL && (m_DragType & SR_RECORDLIST_CUSTOM) != 0) m_DragCustomData.Add(pCustomData);
  }

	/* Ignore if nothing to drag */
  if (m_DragRecords.GetSize() == 0 && m_DragCustomData.GetSize() == 0) return;

	/* Setup the dragging members */
  m_DragIndex  = pNMListView->iItem;
  DragPoint.x  = Offset;
  DragPoint.y  = Offset;
    
	/* Set the drag cursors */
  //m_hGoodDropCursor = GetCursor();
  SetCursor(m_hBadDropCursor);

  if (m_pDragImage != NULL) delete m_pDragImage;

	/* Create the image for dragging */
  m_pDragImage = CreateDragImage(m_DragIndex, &DragPoint);
  if (m_pDragImage == NULL) return;   
  
  m_IsDragging    = true;
  m_LastDropValid = false;
  m_pLastDropWnd  = NULL;

	/* Change the cursor to the drag image
	  (still must perform DragMove() in OnMouseMove() to show it moving) */
  m_pDragImage->BeginDrag(0, CPoint(Offset, Offset));
  m_pDragImage->DragEnter(NULL, pNMListView->ptAction);

	/* Cause this control to capture all the mouse messages */
  SetCapture();  
}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::OnBeginDrag()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void OnLButtonUp (nFlags, Point);
 *
 *=========================================================================*/
void CSrRecordListCtrl::OnLButtonUp (UINT nFlags, CPoint Point) {

  	/* Ignore if not handling any dragging messages */
  if (!m_IsDragging) {
    CListCtrl::OnLButtonUp(nFlags, Point);
    return;
   }

	/* Release mouse capture, so that other controls can get control/messages */
  ReleaseCapture();

	/* Update the dragging state */
  m_IsDragging = false;

	/* End dragging image */
  m_pDragImage->DragLeave(GetDesktopWindow());
  m_pDragImage->EndDrag();

	/* Clean up the image list */
  delete m_pDragImage;
  m_pDragImage = NULL;

	/* Get the mouse point in screen coordinates */
  CPoint MousePt(Point); 
  ClientToScreen(&MousePt);
	
	/* Get the CWnd pointer of the window that is under the mouse cursor */
  CWnd* pDropWnd = WindowFromPoint(MousePt);
  if (pDropWnd == NULL) return;

	/* Drop records/custom data on the window */
  DropRecords(pDropWnd);
  m_DragRecords.Destroy();
  m_DragCustomData.Destroy();
}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::OnLButtonUp()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void OnMouseMove (nFlags, Ppoint);
 *
 *=========================================================================*/
void CSrRecordListCtrl::OnMouseMove (UINT nFlags, CPoint Point) {
  srrldroprecords_t NotifyData;
  CWnd*		    pParentWnd = NULL;
  int		    Result = 0;

	/* Ignore if not handling any dragging messages */
  if (!m_IsDragging) {
    CListCtrl::OnMouseMove(nFlags, Point);
    return;
   }

	/* Get mouse coordinates in screen */
  CPoint MousePt(Point);
  ClientToScreen(&MousePt);

	/* Move the drag image to those coordinates */
  m_pDragImage->DragMove(MousePt); 
  m_pDragImage->DragShowNolock(false);	/* Smoother updates */

	/* Get the CWnd pointer of the window that is under the mouse cursor */
  CWnd* pDropWnd = WindowFromPoint(MousePt);

  if (pDropWnd == NULL) {
    m_pDragImage->DragShowNolock(true);
    return;
  }

  pDropWnd->ScreenToClient(&MousePt);
  if (pDropWnd == this) pDropWnd = NULL;

	/* Don't do anything if the window has not changed */
  if (m_pLastDropWnd == pDropWnd) {
    m_pDragImage->DragShowNolock(true);
    return;
  }

  m_pLastDropWnd = pDropWnd;

  if (pDropWnd != NULL) { 
    NotifyData.Notify.code     = ID_SRRECORDLIST_CHECKDROP;
    NotifyData.Notify.hwndFrom = pDropWnd->m_hWnd;
    NotifyData.Notify.idFrom   = pDropWnd->GetDlgCtrlID();
    NotifyData.pRecords        = &m_DragRecords;
    NotifyData.pCustomDatas    = &m_DragCustomData;

    pParentWnd = pDropWnd->GetParent();

    if (pParentWnd != NULL) {
      Result = pParentWnd->SendMessage(WM_NOTIFY, NotifyData.Notify.idFrom, (LPARAM) &NotifyData);
    }
  }
            
  if (Result == SRRL_DROPCHECK_OK) {
    m_LastDropValid = true;
    SetCursor(m_hGoodDropCursor); 
  }
  else {
    m_LastDropValid = false;
    SetCursor(m_hBadDropCursor);
  }

	/* Lock window updates */
  m_pDragImage->DragShowNolock(true);
}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::OnMouseMove()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Method - void DropRecords (pDropWnd);
 *
 * Used to drop dragged records between the current list and the given 
 * window.
 *
 *=========================================================================*/
void CSrRecordListCtrl::DropRecords (CWnd* pDropWnd) {
  srrldroprecords_t NotifyData;
  CWnd*		    pParentWnd;
  int		    Result;
  
	/* Ignore if we are just dropping onto itself */
  if (pDropWnd == NULL || pDropWnd == this) return;
  if (m_ActNormalList) return;
  if (!m_LastDropValid) return;

  NotifyData.Notify.hwndFrom = pDropWnd->m_hWnd;
  NotifyData.Notify.idFrom   = pDropWnd->GetDlgCtrlID();
  NotifyData.pRecords        = &m_DragRecords;
  NotifyData.pCustomDatas    = &m_DragCustomData;
  NotifyData.Notify.code     = ID_SRRECORDLIST_DROP;
  
  pParentWnd = pDropWnd->GetParent();

  if (pParentWnd != NULL) {
    Result = pParentWnd->SendMessage(WM_NOTIFY, NotifyData.Notify.idFrom, (LPARAM) &NotifyData);
  }
  
}
/*===========================================================================
 *		End of Class Method CSrRecordListCtrl::DropRecords()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void OnCaptureChanged ( pWnd);
 *
 *=========================================================================*/
void CSrRecordListCtrl::OnCaptureChanged (CWnd* pWnd) {

	/* TODO: Need an end drag method */
  if (m_IsDragging) {
    if (m_pDragImage != NULL) {
      delete m_pDragImage;
      m_pDragImage = NULL;
    }

    m_IsDragging = false;
  }

  CListCtrl::OnCaptureChanged(pWnd);
}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::OnCaptureChanged()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - UINT OnGetDlgCode ();
 *
 *=========================================================================*/
UINT CSrRecordListCtrl::OnGetDlgCode() 
{
	return (CListCtrl::OnGetDlgCode() | DLGC_WANTCHARS );
}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::OnGetDlgCode()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void OnChar (nChar, nRepCnt, nFlags);
 *
 *=========================================================================*/
void CSrRecordListCtrl::OnChar(UINT nChar, UINT nRepCnt, UINT nFlags) {
  CWnd* pWnd = GetParent();

  if (pWnd != NULL) {
  /*
    NMCHAR Notify;

    Notify.ch           = nChar;
    Notify.dwItemNext   = 0;
    Notify.dwItemPrev   = 0;
    Notify.hdr.code     = ID_SRRECORDLIST_CHAR;
    Notify.hdr.hwndFrom = m_hWnd;
    Notify.hdr.idFrom   = GetDlgCtrlID();

    pWnd->SendMessage(WM_NOTIFY, Notify.hdr.idFrom, (LPARAM) &Notify);  //*/
  }

  CListCtrl::OnChar(nChar, nRepCnt, nFlags);
}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::OnChar()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void OnKeyDown (nChar, nRepCnt, nFlags);
 *
 *=========================================================================*/
void CSrRecordListCtrl::OnKeyDown (UINT nChar, UINT nRepCnt, UINT nFlags) 
{
  CWnd* pWnd = GetParent();

  if (pWnd != NULL) 
  {
    srrlkeydown_t Notify;
    
    Notify.Alt   = (GetAsyncKeyState(VK_MENU)    & 0x8000) != 0;
    Notify.Ctrl  = (GetAsyncKeyState(VK_CONTROL) & 0x8000) != 0;
    Notify.Shift = (GetAsyncKeyState(VK_SHIFT)   & 0x8000) != 0;

    Notify.KeyDown.nVKey        = nChar;
    Notify.KeyDown.uFlags       = nFlags;
    Notify.KeyDown.hdr.code     = ID_SRRECORDLIST_KEYDOWN;
    Notify.KeyDown.hdr.hwndFrom = m_hWnd;
    Notify.KeyDown.hdr.idFrom   = GetDlgCtrlID();

	pWnd->SendMessage(WM_NOTIFY, Notify.KeyDown.hdr.idFrom, (LPARAM) &Notify); 
  }

  CListCtrl::OnChar(nChar, nRepCnt, nFlags);
}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::OnKeyDown()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void OnClose (void);
 *
 *=========================================================================*/
void CSrRecordListCtrl::OnClose (void) {
  UpdateCurrentList();
  CListCtrl::OnClose();
}


void CSrRecordListCtrl::OnDestroy (void) {
  UpdateCurrentList();
  CListCtrl::OnDestroy();
}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::OnKeyDown()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void CreateRegSectionName (pListInfo);
 *
 *=========================================================================*/
const char* CSrRecordListCtrl::CreateRegSectionName (srreclistinfo_t* pListInfo) {
  static CSString s_Buffer;

	/* Create the registry section name to output to */
  if (pListInfo->pRecordType == NULL)
    s_Buffer.Format("%s\\%s\\List_\\", SRRL_REGKEY_ROOT, m_ListName);
  else
    s_Buffer.Format("%s\\%s\\List_%4.4s\\", SRRL_REGKEY_ROOT, m_ListName, pListInfo->pRecordType->Name);

  return (s_Buffer);
}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::CreateRegSectionName()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void ReadListInfoRegistry (void);
 *
 *=========================================================================*/
void CSrRecordListCtrl::ReadListInfoRegistry (void) {
  dword   Index;

  if (!m_Options.SaveState) return;

  for (Index = 0; Index < m_ListInfos.GetSize(); ++Index) {
    ReadListInfoRegistry(m_ListInfos.GetAt(Index));
  }

}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::ReadListInfoRegistry()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void ReadListInfoRegistry (pListInfo);
 *
 *=========================================================================*/
void CSrRecordListCtrl::ReadListInfoRegistry (srreclistinfo_t* pListInfo) {
  srreclistcolumn_t* pColumn;
  CString            Section;
  CString            Section1;
  dword              Index;
  HKEY               hKey;
  long               Result;
  int                FieldID;

  if (pListInfo == NULL || !m_Options.SaveState) return;
  Section = CreateRegSectionName(pListInfo);

  pListInfo->SortField   = AfxGetApp()->GetProfileInt(Section, "SortField", pListInfo->SortField);
  pListInfo->SortReverse = (AfxGetApp()->GetProfileInt(Section, "SortReverse", pListInfo->SortReverse) != 0);
  pListInfo->SortSubItem = AfxGetApp()->GetProfileInt(Section, "SortSubItem", pListInfo->SortSubItem);
  //pListInfo->Type        = AfxGetApp()->GetProfileInt(Section, "Type", pListInfo->Type);
  
  for (Index = 0; Index < SR_RECLIST_MAXCOLS; ++Index) {
    Section1.Format("%s%sColumn%d\\", SREDIT_REGISTRY_BASE, Section, Index);

		/* See if the key exists */
    Result = RegOpenKeyEx(HKEY_CURRENT_USER, Section1, 0, KEY_READ, &hKey);
    if (Result != ERROR_SUCCESS) continue;
    RegCloseKey(hKey);

    Section1.Format("%s\\Column%d\\", Section, Index);

    FieldID = AfxGetApp()->GetProfileInt(Section1, "FieldID", -1);
    if (FieldID < 0) continue;

    pColumn = FindListColumn(pListInfo, FieldID);
    if (pColumn == NULL) continue;

    ReadListInfoRegistry(Section1, pColumn);
  }

}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::ReadListInfoRegistry()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void ReadListInfoRegistry (pSection, pListInfo);
 *
 *=========================================================================*/
void CSrRecordListCtrl::ReadListInfoRegistry (const char* pSection, srreclistcolumn_t* pColumn) 
{
  CString Buffer;

  pColumn->Display     = (AfxGetApp()->GetProfileInt   (pSection, "Display",     pColumn->Display) != 0);

  Buffer               = AfxGetApp()->GetProfileString (pSection, "Title",       pColumn->Title);
  strnncpy(pColumn->Title, Buffer, 60);

  pColumn->FieldID     = AfxGetApp()->GetProfileInt    (pSection, "FieldID",     pColumn->FieldID);
  pColumn->Width       = AfxGetApp()->GetProfileInt    (pSection, "Width",       pColumn->Width);
  pColumn->Format      = AfxGetApp()->GetProfileInt    (pSection, "Format",      pColumn->Format);
  //pColumn->SubItem     = AfxGetApp()->GetProfileInt    (pSection, "SubItem",     pColumn->SubItem);
  //pColumn->ColumnIndex = AfxGetApp()->GetProfileInt    (pSection, "ColumnIndex", pColumn->ColumnIndex);

}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::ReadListInfoRegistry()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void WriteListInfoRegistry (void);
 *
 *=========================================================================*/
void CSrRecordListCtrl::WriteListInfoRegistry (void) 
{
	dword   Index;

	if (!m_Options.SaveState) return;

	for (Index = 0; Index < m_ListInfos.GetSize(); ++Index) 
	{
		WriteListInfoRegistry(m_ListInfos.GetAt(Index));
	}

}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::WriteListInfoRegistry()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void WriteListInfoRegistry (pListInfo);
 *
 *=========================================================================*/
void CSrRecordListCtrl::WriteListInfoRegistry (srreclistinfo_t* pListInfo) 
{
  CString Section;
  CString Section1;
  dword   Index;

  if (pListInfo == NULL || !m_Options.SaveState) return;
  Section = CreateRegSectionName(pListInfo);

  if (pListInfo->pRecordType == NULL)
    AfxGetApp()->WriteProfileString(Section, "RecordType", "");
  else {
    CSString Buffer;
    Buffer.Copy(pListInfo->pRecordType->Name, 4);
    AfxGetApp()->WriteProfileString(Section, "RecordType", Buffer.c_str());
  }

  AfxGetApp()->WriteProfileInt(Section, "SortField", pListInfo->SortField);
  AfxGetApp()->WriteProfileInt(Section, "SortReverse", pListInfo->SortReverse);
  AfxGetApp()->WriteProfileInt(Section, "SortSubItem", pListInfo->SortSubItem);
  AfxGetApp()->WriteProfileInt(Section, "Type", pListInfo->Type);
  
  for (Index = 0; Index < pListInfo->NumColumns; ++Index) 
  {
    Section1.Format("%s\\Column%d\\", Section, Index);
    WriteListInfoRegistry(Section1, &pListInfo->Columns[Index]);
  }

}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::WriteListInfoRegistry()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRecordListCtrl Event - void WriteListInfoRegistry (pSection, pListInfo);
 *
 *=========================================================================*/
void CSrRecordListCtrl::WriteListInfoRegistry (const char* pSection, srreclistcolumn_t* pColumn) 
{

  AfxGetApp()->WriteProfileInt    (pSection, "Display",     pColumn->Display);
  AfxGetApp()->WriteProfileString (pSection, "Title",       pColumn->Title);
  AfxGetApp()->WriteProfileInt    (pSection, "FieldID",     pColumn->FieldID);
  AfxGetApp()->WriteProfileInt    (pSection, "Width",       pColumn->Width);
  AfxGetApp()->WriteProfileInt    (pSection, "Format",      pColumn->Format);
  AfxGetApp()->WriteProfileInt    (pSection, "SubItem",     pColumn->SubItem);
  AfxGetApp()->WriteProfileInt    (pSection, "ColumnIndex", pColumn->ColumnIndex);

}
/*===========================================================================
 *		End of Class Event CSrRecordListCtrl::WriteListInfoRegistry()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - srreclistcolumn_t* FindListColumnBySubItem (pListInfo, FieldID);
 *
 * Find the column with the given SubItem in the list data. Returns
 * NULL if not found.
 *
 *=========================================================================*/
srreclistcolumn_t* FindListColumnBySubItem (srreclistinfo_t* pListInfo, const int SubItem) {
  dword Index;

  for (Index = 0; Index < pListInfo->NumColumns; ++Index) {
    if (pListInfo->Columns[Index].SubItem == SubItem) return (&pListInfo->Columns[Index]);
   }

  return (NULL);
 }
/*===========================================================================
 *		End of Function FindListColumnBySubItem()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - srreclistcolumn_t* FindListColumn (pListInfo, FieldID);
 *
 * Find the column with the given FieldID in the list data. Returns
 * NULL if not found.
 *
 *=========================================================================*/
srreclistcolumn_t* FindListColumn (srreclistinfo_t* pListInfo, const srrecfieldid_t FieldID) {
  dword Index;

  for (Index = 0; Index < pListInfo->NumColumns; ++Index) {
    if (pListInfo->Columns[Index].FieldID == FieldID) return (&pListInfo->Columns[Index]);
   }

  return (NULL);
 }
/*===========================================================================
 *		End of Function FindListColumn()
 *=========================================================================*/


/*===========================================================================
 *
 * Function - const srrecfield_t* FindSrField (pFields, FieldID);
 *
 *=========================================================================*/
const srrecfield_t* FindSrField (const srrecfield_t* pFields, const srrecfieldid_t FieldID) {
  dword Index;

  if (pFields == NULL) return (NULL);

  for (Index = 0; pFields[Index].FieldID != SR_FIELD_NONE; ++Index) { 
    if (pFields[Index].FieldID == FieldID) return &pFields[Index];
   }

	/* No match */
  return (NULL);
 }
/*===========================================================================
 *		End of Function srrecfield_t* FindSrField()
 *=========================================================================*/



