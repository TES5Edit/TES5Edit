/*===========================================================================
 *
 * File:		SrRaceRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srRacerecord.h"


srracedata_t CSrRaceRecord::s_NullRaceData;
srbodtdata_t CSrRaceRecord::s_NullBodtData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrRaceRecord, CSrIdKeyRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_DESC, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FULL, CSrLStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SPCT, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SPLO, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_WNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BODT, CSrBodtSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DATA, CSrRaceDataSubrecord::Create)

	DEFINE_SRSUBRECCREATE(SR_NAME_MNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ANAM, CSrStringSubrecord::Create)	
	DEFINE_SRSUBRECCREATE(SR_NAME_MODT, CSrDataSubrecord::Create)

	DEFINE_SRSUBRECCREATE(SR_NAME_MTNM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VTCK, CSrFormidArraySubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_HCLF, CSrFormidArraySubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrFormidArraySubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TINL, CSrWordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PNAM, CSrFloatSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_UNAM, CSrFloatSubrecord::Create)

	DEFINE_SRSUBRECCREATE(SR_NAME_ATKD, CSrAtkdSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ATKE, CSrStringSubrecord::Create)

	DEFINE_SRSUBRECCREATE(SR_NAME_NAM1, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_INDX, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrStringSubrecord::Create)

	DEFINE_SRSUBRECCREATE(SR_NAME_GNAM, CSrFormidSubrecord::Create)

	DEFINE_SRSUBRECCREATE(SR_NAME_NAM3, CSrDataSubrecord::Create)

	DEFINE_SRSUBRECCREATE(SR_NAME_NAM4, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM5, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM7, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ONAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAME, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MTYP, CSrFormidSubrecord::Create)	
	DEFINE_SRSUBRECCREATE(SR_NAME_SPED, CSrSpedSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_VNAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_QNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_UNES, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PHTN, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_PHWT, CSrPhwtSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM0, CSrDataSubrecord::Create)	

	DEFINE_SRSUBRECCREATE(SR_NAME_HEAD, CSrDwordSubrecord::Create)

	DEFINE_SRSUBRECCREATE(SR_NAME_MPAI, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MPAV, CSrMpavSubrecord::Create)	

	DEFINE_SRSUBRECCREATE(SR_NAME_RPRM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RPRF, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_AHCM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_AHCF, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FTSM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FTSF, CSrFormidSubrecord::Create)	
	DEFINE_SRSUBRECCREATE(SR_NAME_DFTF, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DFTM, CSrFormidSubrecord::Create)

	DEFINE_SRSUBRECCREATE(SR_NAME_TINI, CSrWordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TINT, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TINP, CSrWordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TIND, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TINC, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TINV, CSrFloatSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_TIRS, CSrWordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM8, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RNAM, CSrFormidSubrecord::Create)
	
	DEFINE_SRSUBRECCREATE(SR_NAME_WKMV, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RNMV, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SWMV, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_FLMV, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNMV, CSrFormidSubrecord::Create)	
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdKeyRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrRaceRecord, CSrIdKeyRecord)
	ADD_SRFIELDALL("RaceName",		SR_FIELD_ITEMNAME,		0, CSrRaceRecord, FieldItemName)
	ADD_SRFIELDALL("Description",	SR_FIELD_DESCRIPTION,	0, CSrRaceRecord, FieldDescription)
	ADD_SRFIELDALL("SpellCount",	SR_FIELD_SPELLCOUNT,	0, CSrRaceRecord, FieldSpellCount)
	ADD_SRFIELDALL("NakedArmor",	SR_FIELD_NAKEDARMOR,	0, CSrRaceRecord, FieldNakedArmor)
	ADD_SRFIELDALL("BodyParts",		SR_FIELD_BODYPARTS,		0, CSrRaceRecord, FieldBodyParts)
	ADD_SRFIELDALL("MaleHeight",	SR_FIELD_MALEHEIGHT,	0, CSrRaceRecord, FieldMaleHeight)
	ADD_SRFIELDALL("FemaleHeight",	SR_FIELD_FEMALEHEIGHT,	0, CSrRaceRecord, FieldFemaleHeight)
	ADD_SRFIELDALL("ActorValue1",	SR_FIELD_ACTORVALUE1,	0, CSrRaceRecord, FieldActorValue1)
	ADD_SRFIELDALL("Skill1",		SR_FIELD_SKILL1,		0, CSrRaceRecord, FieldSkill1)
	ADD_SRFIELDALL("ActorValue2",	SR_FIELD_ACTORVALUE2,	0, CSrRaceRecord, FieldActorValue2)
	ADD_SRFIELDALL("Skill2",		SR_FIELD_SKILL2,		0, CSrRaceRecord, FieldSkill2)
	ADD_SRFIELDALL("ActorValue3",	SR_FIELD_ACTORVALUE3,	0, CSrRaceRecord, FieldActorValue3)
	ADD_SRFIELDALL("Skill3",		SR_FIELD_SKILL3,		0, CSrRaceRecord, FieldSkill3)
	ADD_SRFIELDALL("ActorValue4",	SR_FIELD_ACTORVALUE4,	0, CSrRaceRecord, FieldActorValue4)
	ADD_SRFIELDALL("Skill4",		SR_FIELD_SKILL4,		0, CSrRaceRecord, FieldSkill4)
	ADD_SRFIELDALL("ActorValue5",	SR_FIELD_ACTORVALUE5,	0, CSrRaceRecord, FieldActorValue5)
	ADD_SRFIELDALL("Skill5",		SR_FIELD_SKILL5,		0, CSrRaceRecord, FieldSkill5)
	ADD_SRFIELDALL("ActorValue6",	SR_FIELD_ACTORVALUE6,	0, CSrRaceRecord, FieldActorValue6)
	ADD_SRFIELDALL("Skill6",		SR_FIELD_SKILL6,		0, CSrRaceRecord, FieldSkill6)
	ADD_SRFIELDALL("ActorValue7",	SR_FIELD_ACTORVALUE7,	0, CSrRaceRecord, FieldActorValue7)
	ADD_SRFIELDALL("Skill7",		SR_FIELD_SKILL7,		0, CSrRaceRecord, FieldSkill7)
	ADD_SRFIELDALL("Unknown1",		SR_FIELD_UNKNOWN1,		0, CSrRaceRecord, FieldUnknown1)
	ADD_SRFIELDALL("Unknown2",		SR_FIELD_UNKNOWN2,		0, CSrRaceRecord, FieldUnknown2)
	ADD_SRFIELDALL("Unknown3",		SR_FIELD_UNKNOWN3,		0, CSrRaceRecord, FieldUnknown3)
	ADD_SRFIELDALL("Unknown4",		SR_FIELD_UNKNOWN4,		0, CSrRaceRecord, FieldUnknown4)
	ADD_SRFIELDALL("Unknown5",		SR_FIELD_UNKNOWN5,		0, CSrRaceRecord, FieldUnknown5)
	ADD_SRFIELDALL("Unknown6",		SR_FIELD_UNKNOWN6,		0, CSrRaceRecord, FieldUnknown6)
	ADD_SRFIELDALL("Unknown7",		SR_FIELD_UNKNOWN7,		0, CSrRaceRecord, FieldUnknown7)
	ADD_SRFIELDALL("Unknown8",		SR_FIELD_UNKNOWN8,		0, CSrRaceRecord, FieldUnknown8)
	ADD_SRFIELDALL("Unknown9",		SR_FIELD_UNKNOWN9,		0, CSrRaceRecord, FieldUnknown9)
	ADD_SRFIELDALL("Unknown10",		SR_FIELD_UNKNOWN10,		0, CSrRaceRecord, FieldUnknown10)
	ADD_SRFIELDALL("Unknown11",		SR_FIELD_UNKNOWN11,		0, CSrRaceRecord, FieldUnknown11)
	ADD_SRFIELDALL("Unknown12",		SR_FIELD_UNKNOWN12,		0, CSrRaceRecord, FieldUnknown12)
	ADD_SRFIELDALL("Unknown13",		SR_FIELD_UNKNOWN13,		0, CSrRaceRecord, FieldUnknown13)
	ADD_SRFIELDALL("Unknown14",		SR_FIELD_UNKNOWN14,		0, CSrRaceRecord, FieldUnknown14)
	ADD_SRFIELDALL("Unknown15",		SR_FIELD_UNKNOWN15,		0, CSrRaceRecord, FieldUnknown15)
	ADD_SRFIELDALL("Unknown16",		SR_FIELD_UNKNOWN16,		0, CSrRaceRecord, FieldUnknown16)
	ADD_SRFIELDALL("Unknown17",		SR_FIELD_UNKNOWN17,		0, CSrRaceRecord, FieldUnknown17)
	ADD_SRFIELDALL("Unknown18",		SR_FIELD_UNKNOWN18,		0, CSrRaceRecord, FieldUnknown18)
	ADD_SRFIELDALL("Unknown19",		SR_FIELD_UNKNOWN19,		0, CSrRaceRecord, FieldUnknown19)
	ADD_SRFIELDALL("Unknown20",		SR_FIELD_UNKNOWN20,		0, CSrRaceRecord, FieldUnknown20)
	ADD_SRFIELDALL("Unknown21",		SR_FIELD_UNKNOWN21,		0, CSrRaceRecord, FieldUnknown21)
	ADD_SRFIELDALL("Unknown22",		SR_FIELD_UNKNOWN22,		0, CSrRaceRecord, FieldUnknown22)
	ADD_SRFIELDALL("Unknown23",		SR_FIELD_UNKNOWN23,		0, CSrRaceRecord, FieldUnknown23)
	ADD_SRFIELDALL("Unknown24",		SR_FIELD_UNKNOWN24,		0, CSrRaceRecord, FieldUnknown24)
	ADD_SRFIELDALL("Unknown25",		SR_FIELD_UNKNOWN25,		0, CSrRaceRecord, FieldUnknown25)
	ADD_SRFIELDALL("Unknown26",		SR_FIELD_UNKNOWN26,		0, CSrRaceRecord, FieldUnknown26)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRaceRecord Constructor
 *
 *=========================================================================*/
CSrRaceRecord::CSrRaceRecord () 
{
	m_pDescription = NULL;
	m_pItemName = NULL;
	m_pSpellCount = NULL;
	m_pNakedArmor = NULL;
	m_pBodyData = NULL;
	m_pRaceData = NULL;
}
/*===========================================================================
 *		End of Class CSrRaceRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRaceRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrRaceRecord::Destroy (void) 
{
	m_pDescription = NULL;
	m_pItemName = NULL;
	m_pSpellCount = NULL;
	m_pNakedArmor = NULL;
	m_pBodyData = NULL;
	m_pRaceData = NULL;

	CSrIdKeyRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrRaceRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRaceRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrRaceRecord::InitializeNew (void) 
{
	CSrIdKeyRecord::InitializeNew();

	AddInitNewSubrecord(SR_NAME_FULL);
	AddInitNewSubrecord(SR_NAME_DESC);
	AddInitNewSubrecord(SR_NAME_SPCT);
	AddInitNewSubrecord(SR_NAME_WNAM);
	AddInitNewSubrecord(SR_NAME_BODT);
	AddInitNewSubrecord(SR_NAME_DATA);

	AddInitNewSubrecord(SR_NAME_MNAM);
	AddInitNewSubrecord(SR_NAME_ANAM);
	InitializeModtData(AddInitNewSubrecord(SR_NAME_MODT));

	AddInitNewSubrecord(SR_NAME_FNAM);
		//Omit female skeletal model by default

	InitializeDwordData(AddInitNewSubrecord(SR_NAME_MTNM), SR_RACE_MOVENAME_WALK);
	InitializeDwordData(AddInitNewSubrecord(SR_NAME_MTNM), SR_RACE_MOVENAME_RUN1);
	InitializeDwordData(AddInitNewSubrecord(SR_NAME_MTNM), SR_RACE_MOVENAME_SNEK);
	InitializeDwordData(AddInitNewSubrecord(SR_NAME_MTNM), SR_RACE_MOVENAME_BLD0);
	InitializeDwordData(AddInitNewSubrecord(SR_NAME_MTNM), SR_RACE_MOVENAME_SWIM);		

	InitializeFormid2Data(AddInitNewSubrecord(SR_NAME_VTCK));
		//No HCLF
		//No DNAM
		//No TINL

	InitializeFloatData(AddInitNewSubrecord(SR_NAME_PNAM), 5);
	InitializeFloatData(AddInitNewSubrecord(SR_NAME_UNAM), 3);

		//No ATKD/ATKE

	AddInitNewSubrecord(SR_NAME_NAM1);
	AddInitNewSubrecord(SR_NAME_MNAM);
	AddInitNewSubrecord(SR_NAME_INDX);
	AddInitNewSubrecord(SR_NAME_MODL);
	InitializeModtData(AddInitNewSubrecord(SR_NAME_MODT));

	AddInitNewSubrecord(SR_NAME_FNAM);
	AddInitNewSubrecord(SR_NAME_INDX);
	AddInitNewSubrecord(SR_NAME_MODL);
	InitializeModtData(AddInitNewSubrecord(SR_NAME_MODT));

	AddInitNewSubrecord(SR_NAME_GNAM);

	AddInitNewSubrecord(SR_NAME_NAM3);
	AddInitNewSubrecord(SR_NAME_MNAM);
	AddInitNewSubrecord(SR_NAME_MODL);
	InitializeModtData(AddInitNewSubrecord(SR_NAME_MODT));

	AddInitNewSubrecord(SR_NAME_FNAM);
	AddInitNewSubrecord(SR_NAME_MODL);
	InitializeModtData(AddInitNewSubrecord(SR_NAME_MODT));

	AddInitNewSubrecord(SR_NAME_NAM4);
		//No NAM5
		//No NAM7
		//No ONAM
		//No LNAM

	for (dword i = 0; i < 32; ++i)
	{
		AddInitNewSubrecord(SR_NAME_NAME);
	}

		//No MTYP/SPED
		//No VNAM
		//No QNAM
	AddInitNewSubrecord(SR_NAME_UNES);
		
		//No PHTN
		//No PHWT

		//No Male Head Data

		//No INDX/HEAD
		//No MPAI/MPAV
		//No RPRM
		//No AHCM
		//No FTSM
		//No DFTM
		//No TIN*

		//No Female Head Data	
	
		//No INDX/HEAD
		//No MPAI/MPAV
		//No RPRF
		//No AHCF
		//No FTSF
		//No DFTF
		//No TIN*

		//No NAM8
		//No RNAM

		//No WKMV
		//No RNMV
		//No SWMV
		//No FLMV
		//No SNMV
}
/*===========================================================================
 *		End of Class Method CSrRaceRecord::InitializeNew()
 *=========================================================================*/


void CSrRaceRecord::InitializeFloatData (CSrSubrecord* pSubrecord, const float Value)
{
	CSrFloatSubrecord* pFloat = SrCastClassNull(CSrFloatSubrecord, pSubrecord);
	if (pFloat == NULL) return;
	pFloat->SetValue(Value);
}


void CSrRaceRecord::InitializeDwordData (CSrSubrecord* pSubrecord, const dword Value)
{
	CSrDwordSubrecord* pDword = SrCastClassNull(CSrDwordSubrecord, pSubrecord);
	if (pDword == NULL) return;
	pDword->SetValue(Value);
}


void CSrRaceRecord::InitializeFormid2Data (CSrSubrecord* pSubrecord)
{
	CSrFormidArraySubrecord* pFormids = SrCastClassNull(CSrFormidArraySubrecord, pSubrecord);
	if (pFormids == NULL) return;
	
	while (pFormids->GetArraySize() > 2)
	{
		pFormids->GetFormIDArray().Delete(pFormids->GetArraySize() - 1);
	}

	while (pFormids->GetArraySize() < 2)
	{
		pFormids->GetFormIDArray().Add(srformid_t(0));
	}

}


void CSrRaceRecord::InitializeModtData (CSrSubrecord* pSubrecord)
{
	static byte s_ModtData[12] = { 0x02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

	CSrDataSubrecord* pDataSubrecord = SrCastClassNull(CSrDataSubrecord, pSubrecord);
	if (pDataSubrecord == NULL) return;

	pDataSubrecord->SetData(s_ModtData, 12);
}


/*===========================================================================
 *
 * Class CSrRaceRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrRaceRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_DESC)
	{
		m_pDescription = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_FULL)
	{
		m_pItemName = SrCastClass(CSrLStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_WNAM)
	{
		m_pNakedArmor = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DATA)
	{
		m_pRaceData = SrCastClass(CSrRaceDataSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BODT)
	{
		m_pBodyData = SrCastClass(CSrBodtSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SPCT)
	{
		m_pSpellCount = SrCastClass(CSrDwordSubrecord, pSubrecord);
	}
	else
	{
		CSrIdKeyRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrRaceRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrRaceRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrRaceRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pDescription == pSubrecord)
		m_pDescription = NULL;
	else if (m_pItemName == pSubrecord)
		m_pItemName = NULL;
	else if (m_pNakedArmor == pSubrecord)
		m_pNakedArmor = NULL;
	else if (m_pRaceData == pSubrecord)
		m_pRaceData = NULL;
	else if (m_pBodyData == pSubrecord)
		m_pBodyData = NULL;
	else if (m_pSpellCount == pSubrecord)
		m_pSpellCount = NULL;
	else
		CSrIdKeyRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrRaceRecord::OnDeleteSubrecord()
 *=========================================================================*/


void CSrRaceRecord::UpdateSpellCount (void)
{

	if (m_pSpellCount == NULL)
	{
		AddInitNewSubrecordAfter(SR_NAME_SPCT, SR_NAME_DESC);
		if (m_pSpellCount == NULL) return;
	}

	m_pSpellCount->SetValue(CountSubrecords(SR_NAME_SPLO));
}


CSrFormidSubrecord* CSrRaceRecord::AddSpell (const srformid_t FormID)
{

	if (m_pSpellCount == NULL)
	{
		AddInitNewSubrecordAfter(SR_NAME_SPCT, SR_NAME_DESC);
		if (m_pSpellCount == NULL) return NULL;
	}

	CSrSubrecord* pSubrecord = AddInitNewSubrecordAfter(SR_NAME_SPLO, SR_NAME_SPCT);
	CSrFormidSubrecord* pFormID = SrCastClassNull(CSrFormidSubrecord, pSubrecord);
	if (pFormID == NULL) return NULL;

	pFormID->SetValue(FormID);
	return pFormID;
}


bool CSrRaceRecord::CreateRaceInfo (srraceinfo_t& RaceInfo)
{

#define ASSERTLAST1(TYPE, LASTTYPE)             if (LastType != SR_NAME_##LASTTYPE) SystemLog.Printf("Warning: A " #TYPE " subrecord should follow a " #LASTTYPE " and not a %4.4s!", LastType.Name);
#define ASSERTLAST2(TYPE, LASTTYPE1, LASTTYPE2) if (LastType != SR_NAME_##LASTTYPE1 && LastType != SR_NAME_##LASTTYPE2) SystemLog.Printf("Warning: A " #TYPE " subrecord should follow a " #LASTTYPE1 "/" #LASTTYPE2 " and not a %4.4s!", LastType.Name);
#define ASSERTLAST3(TYPE, LASTTYPE1, LASTTYPE2, LASTTYPE3) if (LastType != SR_NAME_##LASTTYPE1 && LastType != SR_NAME_##LASTTYPE2 && LastType != SR_NAME_##LASTTYPE3) SystemLog.Printf("Warning: A " #TYPE " subrecord should follow a " #LASTTYPE1 "/" #LASTTYPE2 "/" #LASTTYPE3 " and not a %4.4s!", LastType.Name);
#define ASSERTLAST4(TYPE, LASTTYPE1, LASTTYPE2, LASTTYPE3, LASTTYPE4) if (LastType != SR_NAME_##LASTTYPE1 && LastType != SR_NAME_##LASTTYPE2 && LastType != SR_NAME_##LASTTYPE3 && LastType != SR_NAME_##LASTTYPE4) SystemLog.Printf("Warning: A " #TYPE " subrecord should follow a " #LASTTYPE1 "/" #LASTTYPE2 "/" #LASTTYPE3 "/" #LASTTYPE4 " and not a %4.4s!", LastType.Name);
#define ASSERTLAST5(TYPE, LASTTYPE1, LASTTYPE2, LASTTYPE3, LASTTYPE4, LASTTYPE5) if (LastType != SR_NAME_##LASTTYPE1 && LastType != SR_NAME_##LASTTYPE2 && LastType != SR_NAME_##LASTTYPE3 && LastType != SR_NAME_##LASTTYPE4 && LastType != SR_NAME_##LASTTYPE5) SystemLog.Printf("Warning: A " #TYPE " subrecord should follow a " #LASTTYPE1 "/" #LASTTYPE2 "/" #LASTTYPE3 "/" #LASTTYPE4 "/" #LASTTYPE5 " and not a %4.4s!", LastType.Name);
#define ASSERTLAST6(TYPE, LASTTYPE1, LASTTYPE2, LASTTYPE3, LASTTYPE4, LASTTYPE5, LASTTYPE6) if (LastType != SR_NAME_##LASTTYPE1 && LastType != SR_NAME_##LASTTYPE2 && LastType != SR_NAME_##LASTTYPE3 && LastType != SR_NAME_##LASTTYPE4 && LastType != SR_NAME_##LASTTYPE5 && LastType != SR_NAME_##LASTTYPE6) SystemLog.Printf("Warning: A " #TYPE " subrecord should follow a " #LASTTYPE1 "/" #LASTTYPE2 "/" #LASTTYPE3 "/" #LASTTYPE4 "/" #LASTTYPE5 "/" #LASTTYPE6 " and not a %4.4s!", LastType.Name);
#define ASSERTLAST7(TYPE, LASTTYPE1, LASTTYPE2, LASTTYPE3, LASTTYPE4, LASTTYPE5, LASTTYPE6, LASTTYPE7) if (LastType != SR_NAME_##LASTTYPE1 && LastType != SR_NAME_##LASTTYPE2 && LastType != SR_NAME_##LASTTYPE3 && LastType != SR_NAME_##LASTTYPE4 && LastType != SR_NAME_##LASTTYPE5 && LastType != SR_NAME_##LASTTYPE6 && LastType != SR_NAME_##LASTTYPE7) SystemLog.Printf("Warning: A " #TYPE " subrecord should follow a " #LASTTYPE1 "/" #LASTTYPE2 "/" #LASTTYPE3 "/" #LASTTYPE4 "/" #LASTTYPE5 "/" #LASTTYPE6 "/" #LASTTYPE7 " and not a %4.4s!", LastType.Name);
#define ASSERTLAST8(TYPE, LASTTYPE1, LASTTYPE2, LASTTYPE3, LASTTYPE4, LASTTYPE5, LASTTYPE6, LASTTYPE7, LASTTYPE8) if (LastType != SR_NAME_##LASTTYPE1 && LastType != SR_NAME_##LASTTYPE2 && LastType != SR_NAME_##LASTTYPE3 && LastType != SR_NAME_##LASTTYPE4 && LastType != SR_NAME_##LASTTYPE5 && LastType != SR_NAME_##LASTTYPE6 && LastType != SR_NAME_##LASTTYPE7 && LastType != SR_NAME_##LASTTYPE8) SystemLog.Printf("Warning: A " #TYPE " subrecord should follow a " #LASTTYPE1 "/" #LASTTYPE2 "/" #LASTTYPE3 "/" #LASTTYPE4 "/" #LASTTYPE5 "/" #LASTTYPE6 "/" #LASTTYPE7 "/" #LASTTYPE8 " and not a %4.4s!", LastType.Name);

	srrectype_t LastType = SR_NAME_NULL;
	srrectype_t LastMarker = SR_NAME_NULL;
	int MNameCount = 0;
	int FNameCount = 0;
	int Name0Count = 0;

	srracemodelinfo_t*    pCurrentModel = NULL;
	srraceattackinfo_t*	  pCurrentAttack = NULL;
	srraceegtinfo_t*      pCurrentEGT = NULL;
	srracehavokinfo_t*    pCurrentHavok = NULL;
	srracemoveinfo_t*     pCurrentMovement = NULL;
	srraceheadinfo_t*	  pCurrentHead = NULL;
	srraceheaddata_t*     pCurrentHeadData = NULL;
	srraceheadmpadata_t*  pCurrentMpaData = NULL;
	srraceheadtintinfo_t* pCurrentTint = NULL;
	srraceheadtintdata_t* pCurrentTintData = NULL;

	RaceInfo.Destroy();

	for (dword i = 0; i < m_Subrecords.GetSize(); ++i)
	{
		CSrSubrecord* pSubrecord = m_Subrecords[i];

		if (pSubrecord->GetRecordType() == SR_NAME_MNAM)
		{
			pCurrentAttack = NULL;
			pCurrentEGT = NULL;
			pCurrentHavok = NULL;
			pCurrentHead = NULL;
			pCurrentTint = NULL;
			pCurrentTintData = NULL;

			if (LastMarker == SR_NAME_NULL)
			{
				ASSERTLAST3(MNAM, DATA, FULL, DESC);
				pCurrentModel = &RaceInfo.MaleModel;
				RaceInfo.MaleModel.Marker.CopyFull(pSubrecord);
			}
			else if (LastMarker == SR_NAME_NAM1)
			{
				ASSERTLAST1(MNAM, NAM1);
				pCurrentEGT = &RaceInfo.MaleEgt;
				pCurrentEGT->Marker.CopyFull(pSubrecord);
			}
			else if (LastMarker == SR_NAME_NAM3)
			{
				ASSERTLAST1(MNAM, NAM3);
				pCurrentHavok = &RaceInfo.MaleHavok;
				pCurrentHavok->Marker.CopyFull(pSubrecord);
			}
			else if (LastMarker == SR_NAME_NAM0)
			{
				ASSERTLAST1(MNAM, NAM0);
				RaceInfo.pName0M = new CSrDataSubrecord;
				RaceInfo.pName0M->Initialize(SR_NAME_NAM0, 0);
				pCurrentHead = &RaceInfo.MaleHead;
				pCurrentHead->Marker.CopyFull(pSubrecord);
			}
			else
			{
				SystemLog.Printf("Warning: Unknown extra MNAM subrecord found in RACE!");
			}

			++MNameCount;
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
		{
			pCurrentAttack = NULL;
			pCurrentEGT = NULL;
			pCurrentHavok = NULL;
			pCurrentHead = NULL;
			pCurrentTint = NULL;
			pCurrentTintData = NULL;

			if (LastMarker == SR_NAME_NULL)
			{
				ASSERTLAST1(FNAM, MODT)
				pCurrentModel = &RaceInfo.FemaleModel;
				RaceInfo.FemaleModel.Marker.CopyFull(pSubrecord);
			}
			else if (LastMarker == SR_NAME_NAM1)
			{
				ASSERTLAST1(FNAM, MODT);
				pCurrentEGT = &RaceInfo.FemaleEgt;
				pCurrentEGT->Marker.CopyFull(pSubrecord);
			}
			else if (LastMarker == SR_NAME_NAM3)
			{
				ASSERTLAST1(FNAM, MODT);
				pCurrentHavok = &RaceInfo.FemaleHavok;
				pCurrentHavok->Marker.CopyFull(pSubrecord);
			}
			else if (LastMarker == SR_NAME_NAM0)
			{
				ASSERTLAST1(FNAM, NAM0);
				RaceInfo.pName0F = new CSrDataSubrecord;
				RaceInfo.pName0F->Initialize(SR_NAME_NAM0, 0);
				pCurrentHead = &RaceInfo.FemaleHead;
				pCurrentHead->Marker.CopyFull(pSubrecord);
			}
			else
			{
				SystemLog.Printf("Warning: Unknown extra FNAM subrecord found in RACE!");
			}

			++FNameCount;
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_ANAM)
		{
			ASSERTLAST2(MODT, MNAM, FNAM);

			if (pCurrentModel) 
			{
				pCurrentModel->pModel = new CSrStringSubrecord;
				pCurrentModel->pModel->CopyFull(pSubrecord);
			}
			else
			{
				SystemLog.Printf("Warning: Unknown ANAM subrecord found in RACE!");
			}
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_MODL)
		{
			if (pCurrentEGT)
			{
				ASSERTLAST1(MODL, INDX);
				pCurrentEGT->Model.CopyFull(pSubrecord);
			}
			else if (pCurrentHavok)
			{
				ASSERTLAST2(MODL, FNAM, MNAM);
				pCurrentHavok->Model.CopyFull(pSubrecord);
			}
			else
			{
				SystemLog.Printf("Warning: Unknown MODL subrecord found in RACE!");
			}

		}
		else if (pSubrecord->GetRecordType() == SR_NAME_MODT)
		{
			ASSERTLAST2(MODT, ANAM, MODL);

			if (pCurrentModel) 
			{
				pCurrentModel->pModt = new CSrDataSubrecord;
				pCurrentModel->pModt->CopyFull(pSubrecord);
			}
			else if (pCurrentEGT)
				pCurrentEGT->Modt.CopyFull(pSubrecord);
			else if (pCurrentHavok)
				pCurrentHavok->Modt.CopyFull(pSubrecord);
			else
			{
				SystemLog.Printf("Warning: Unknown MODT subrecord found in RACE!");
			}

			pCurrentEGT   = NULL;
			pCurrentModel = NULL;
			pCurrentHavok = NULL;
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_MTNM)
		{
			ASSERTLAST3(MTNM, MTNM, MODT, FNAM);
			pCurrentModel = NULL;
			RaceInfo.MovementNames.AddNew()->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_VTCK)
		{
			ASSERTLAST2(VTCK, MTNM, MODT);
			pCurrentModel = NULL;
			RaceInfo.VoiceTypes.CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_HCLF)
		{
			ASSERTLAST2(HCLF, VTCK, DNAM);
			pCurrentModel = NULL;
			RaceInfo.HairColors.CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
		{
			ASSERTLAST2(DNAM, HCLF, VTCK);
			pCurrentModel = NULL;
			RaceInfo.DecapitatedHeads.CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_TINL)
		{
			ASSERTLAST2(TINL, DNAM, HCLF);
			pCurrentModel = NULL;
			RaceInfo.pTinl = new CSrWordSubrecord;
			RaceInfo.pTinl->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_PNAM)
		{
			ASSERTLAST4(PNAM, TINL, VTCK, HCLF, DNAM);
			pCurrentModel = NULL;
			RaceInfo.PName.CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_UNAM)
		{
			ASSERTLAST1(UNAM, PNAM);
			pCurrentModel = NULL;
			RaceInfo.UName.CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_ATKD)
		{
			pCurrentModel = NULL;
			ASSERTLAST2(ATKD, UNAM, ATKE);

			pCurrentAttack = RaceInfo.Attacks.AddNew();
			pCurrentAttack->Data.CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_ATKE)
		{
			pCurrentModel = NULL;
			ASSERTLAST1(ATKE, ATKD);
			if (pCurrentAttack != NULL) pCurrentAttack->Event.CopyFull(pSubrecord);
			pCurrentAttack = NULL;
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_NAM1)
		{
			ASSERTLAST2(NAM1, ATKE, UNAM);
			pCurrentModel = NULL;
			pCurrentAttack = NULL;
			RaceInfo.Name1.CopyFull(pSubrecord);
			LastMarker = pSubrecord->GetRecordType();
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_INDX)
		{
			if (pCurrentEGT != NULL) 
			{
				ASSERTLAST2(INDX, FNAM, MNAM);
				pCurrentEGT->Index.CopyFull(pSubrecord);
			}
			else if (pCurrentHead != NULL) 
			{
				ASSERTLAST3(INDX, FNAM, MNAM, HEAD);
				pCurrentHeadData = pCurrentHead->HeadData.AddNew();
				pCurrentHeadData->Index.CopyFull(pSubrecord);
			}
			else
			{
				SystemLog.Printf("Warning: Unknown INDX subrecord found in RACE!");
			}
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_GNAM)
		{
			pCurrentHavok = NULL;
			pCurrentEGT   = NULL;
			ASSERTLAST1(GNAM, MODT);
			RaceInfo.BodyData.CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_NAM3)
		{
			ASSERTLAST2(NAM3, GNAM, DATA);
			pCurrentHavok = &RaceInfo.MaleHavok;
			LastMarker = pSubrecord->GetRecordType();
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_NAM4)
		{
			ASSERTLAST1(NAM4, MODT);
			pCurrentHavok = NULL;
			RaceInfo.pMaterial = new CSrFormidSubrecord;
			RaceInfo.pMaterial->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_NAM5)
		{
			ASSERTLAST1(NAM5, NAM4);
			pCurrentHavok = NULL;
			RaceInfo.pImpactData = new CSrFormidSubrecord;
			RaceInfo.pImpactData->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_NAM7)
		{
			ASSERTLAST4(NAM7, NAM5, NAM4, MODT, FNAM);
			pCurrentHavok = NULL;
			RaceInfo.pBloodFX = new CSrFormidSubrecord;
			RaceInfo.pBloodFX->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_ONAM)
		{
			ASSERTLAST5(ONAM, NAM7, NAM5, NAM4, MODT, FNAM);
			pCurrentHavok = NULL;
			RaceInfo.pOpenSound = new CSrFormidSubrecord;
			RaceInfo.pOpenSound->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_LNAM)
		{
			ASSERTLAST1(LNAM, ONAM);
			pCurrentHavok = NULL;
			RaceInfo.pCloseSound = new CSrFormidSubrecord;
			RaceInfo.pCloseSound->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_NAME)
		{
			ASSERTLAST5(NAME, LNAM, NAME, NAM4, NAM5, NAM7);
			pCurrentHavok = NULL;
			RaceInfo.BodyNames.AddNew()->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_MTYP)
		{
			ASSERTLAST2(MTYP, NAME, SPED);
			pCurrentHavok = NULL;

			pCurrentMovement = RaceInfo.MovementTypes.AddNew();
			pCurrentMovement->MoveType.CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_SPED)
		{
			ASSERTLAST1(SPED, MTYP);
			if (pCurrentMovement) pCurrentMovement->SpeedData.CopyFull(pSubrecord);
			pCurrentMovement = NULL;
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_VNAM)
		{
			ASSERTLAST2(VNAM, NAME, SPED);
			pCurrentMovement = NULL;
			RaceInfo.pVName = new CSrDwordSubrecord;
			RaceInfo.pVName->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_QNAM)
		{
			ASSERTLAST3(QNAM, VNAM, SPED, QNAM);
			pCurrentMovement = NULL;
			RaceInfo.EquipSlots.AddNew()->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_UNES)
		{
			ASSERTLAST1(UNES, QNAM);
			pCurrentMovement = NULL;
			RaceInfo.UnequipSlot.CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_PHTN)
		{
			ASSERTLAST2(PHTN, UNES, PHTN);
			pCurrentMovement = NULL;
			RaceInfo.FacialKeys.AddNew()->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_PHWT)
		{
			ASSERTLAST3(PHWT, PHTN, PHWT, UNES);
			pCurrentMovement = NULL;
			RaceInfo.FacialWeights.AddNew()->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_NAM0)
		{
			pCurrentMovement = NULL;

			if (Name0Count == 0)
			{
				//ASSERTLAST2(NAM0, PHWT, PHTN);
			}
			else if (Name0Count == 1)
			{
				//ASSERTLAST6(NAM0, TIRS, MPAV, FTSM, AHCM, RPRM, DFTM);
			}
			else
			{
				SystemLog.Printf("Warning: Found #%d NAM0 but only expecting 2!", Name0Count+1);
			}

			++Name0Count;
			LastMarker = pSubrecord->GetRecordType();
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_HEAD)
		{
			ASSERTLAST1(HEAD, INDX);
			if (pCurrentHeadData != NULL) pCurrentHeadData->Data.CopyFull(pSubrecord);
			pCurrentHeadData = NULL;
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_MPAI)
		{
			ASSERTLAST4(MPAI, HEAD, MPAV, FNAM, MNAM);
			pCurrentHeadData = NULL;

			if (pCurrentHead)
			{
				pCurrentMpaData = pCurrentHead->MPAData.AddNew();
				pCurrentMpaData->Index.CopyFull(pSubrecord);
			}
			else
			{
				SystemLog.Printf("Warning: Unknown MPAI subrecord found in RACE!");
			}
			
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_MPAV)
		{
			ASSERTLAST1(MPAV, MPAI);
			if (pCurrentMpaData) pCurrentMpaData->Data.CopyFull(pSubrecord);
			pCurrentMpaData = NULL;			
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_RPRM)
		{
			ASSERTLAST2(RPRM, MPAV, RPRM);
			if (pCurrentHead) pCurrentHead->RacialPresets.AddNew()->CopyFull(pSubrecord);
			pCurrentMpaData = NULL;			
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_RPRF)
		{
			ASSERTLAST2(RPRF, MPAV, RPRF);
			if (pCurrentHead) pCurrentHead->RacialPresets.AddNew()->CopyFull(pSubrecord);
			pCurrentMpaData = NULL;			
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_AHCM)
		{
			ASSERTLAST3(AHCM, RPRM, MPAV, AHCM);
			if (pCurrentHead) pCurrentHead->HairColors.AddNew()->CopyFull(pSubrecord);
			pCurrentMpaData = NULL;			
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_AHCF)
		{
			ASSERTLAST3(AHCF, RPRF, MPAV, AHCF);
			if (pCurrentHead) pCurrentHead->HairColors.AddNew()->CopyFull(pSubrecord);
			pCurrentMpaData = NULL;			
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_FTSM)
		{
			ASSERTLAST3(FTSM, AHCM, FTSM, MPAV);
			if (pCurrentHead) pCurrentHead->FeatureSets.AddNew()->CopyFull(pSubrecord);
			pCurrentMpaData = NULL;			
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_FTSF)
		{
			ASSERTLAST3(FTSF, AHCF, FTSF, MPAV);
			if (pCurrentHead) pCurrentHead->FeatureSets.AddNew()->CopyFull(pSubrecord);
			pCurrentMpaData = NULL;			
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_DFTM)
		{
			ASSERTLAST1(DFTM, FTSM);
			pCurrentMpaData = NULL;

			if (pCurrentHead)
			{
				pCurrentHead->pHeadFeature = new CSrFormidSubrecord; 
				pCurrentHead->pHeadFeature->CopyFull(pSubrecord);
			}			
			else
			{
				SystemLog.Printf("Warning: Unknown DFTM subrecord found in RACE!");
			}
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_DFTF)
		{
			ASSERTLAST1(DFTF, FTSF);
			pCurrentMpaData = NULL;

			if (pCurrentHead)
			{
				pCurrentHead->pHeadFeature = new CSrFormidSubrecord; 
				pCurrentHead->pHeadFeature->CopyFull(pSubrecord);
			}			
			else
			{
				SystemLog.Printf("Warning: Unknown DFTF subrecord found in RACE!");
			}
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_TINI)
		{
			ASSERTLAST8(TINI, DFTM, DFTF, TIRS, FTSM, FTSF, AHCM, AHCF, TINT);
			pCurrentMpaData = NULL;
			pCurrentTintData = NULL;

			if (pCurrentHead)
			{
				pCurrentTint = pCurrentHead->Tints.AddNew();
				pCurrentTint->Index.CopyFull(pSubrecord);
			}
			else
			{
				SystemLog.Printf("Warning: Unknown TINI subrecord found in RACE!");
			}
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_TINT)
		{
			ASSERTLAST1(TINT, TINI);
			
			if (pCurrentTint) 
			{
				pCurrentTint->pMaskFile = new CSrStringSubrecord;
				pCurrentTint->pMaskFile->CopyFull(pSubrecord);
			}
			else
			{
				SystemLog.Printf("Warning: Unknown TINT subrecord found in RACE!");
			}
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_TINP)
		{
			ASSERTLAST2(TINP, TINI, TINT);
			
			if (pCurrentTint) 
			{
				pCurrentTint->pTinp = new CSrWordSubrecord;
				pCurrentTint->pTinp->CopyFull(pSubrecord);
			}
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_TIND)
		{
			ASSERTLAST2(TIND, TINP, TINT);
			
			if (pCurrentTint) 
			{
				pCurrentTint->pColor = new CSrFormidSubrecord;
				pCurrentTint->pColor->CopyFull(pSubrecord);
			}
			else
			{
				SystemLog.Printf("Warning: Unknown TIND subrecord found in RACE!");
			}
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_TINC)
		{
			ASSERTLAST5(TINC, TIND, TINI, TIRS, TINP, TINT);
			
			if (pCurrentTint) 
			{
				pCurrentTintData = pCurrentTint->Tints.AddNew();
				pCurrentTintData->Tinc.CopyFull(pSubrecord);
			}
			else
			{
				SystemLog.Printf("Warning: Unknown TINC subrecord found in RACE!");
			}
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_TINV)
		{
			ASSERTLAST1(TINV, TINC);
			if (pCurrentTintData) pCurrentTintData->Tinv.CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_TIRS)
		{
			ASSERTLAST1(TIRS, TINV);
			if (pCurrentTintData) pCurrentTintData->Tirs.CopyFull(pSubrecord);
			pCurrentTintData = NULL;
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_TIRS)
		{
			ASSERTLAST1(TIRS, TINV);
			if (pCurrentTintData) pCurrentTintData->Tirs.CopyFull(pSubrecord);
			pCurrentTintData = NULL;
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_NAM8)
		{
			ASSERTLAST1(NAM8, TIRS);
			RaceInfo.pNam8 = new CSrFormidSubrecord;
			RaceInfo.pNam8->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_RNAM)
		{
			ASSERTLAST2(RNAM, NAM8, TIRS);
			RaceInfo.pRName = new CSrFormidSubrecord;
			RaceInfo.pRName->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_WKMV)
		{
			ASSERTLAST3(WKMV, TIRS, PHWT, UNES);
			
			pCurrentTintData = NULL;
			pCurrentTint = NULL;
			pCurrentHead = NULL;

			RaceInfo.pWalkMove = new CSrFormidSubrecord;
			RaceInfo.pWalkMove->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_RNMV)
		{
			ASSERTLAST1(RNMV, WKMV);
			
			pCurrentTintData = NULL;
			pCurrentTint = NULL;
			pCurrentHead = NULL;

			RaceInfo.pRunMove = new CSrFormidSubrecord;
			RaceInfo.pRunMove->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_SWMV)
		{
			ASSERTLAST1(SWMV, RNMV);
			
			pCurrentTintData = NULL;
			pCurrentTint = NULL;
			pCurrentHead = NULL;

			RaceInfo.pSwimMove = new CSrFormidSubrecord;
			RaceInfo.pSwimMove->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_FLMV)
		{
			ASSERTLAST1(FLMV, SWMV);
			
			pCurrentTintData = NULL;
			pCurrentTint = NULL;
			pCurrentHead = NULL;

			RaceInfo.pFlyMove = new CSrFormidSubrecord;
			RaceInfo.pFlyMove->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_SNMV)
		{
			ASSERTLAST5(SNMV, FLMV, SWMV, RNMV, WKMV, TIRS);
			
			pCurrentTintData = NULL;
			pCurrentTint = NULL;
			pCurrentHead = NULL;

			RaceInfo.pSneakMove = new CSrFormidSubrecord;
			RaceInfo.pSneakMove->CopyFull(pSubrecord);
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_EDID) 
		{
				//Ignore
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_FULL) 
		{
				//Ignore
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_DESC) 
		{
				//Ignore
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_SPCT) 
		{
				//Ignore
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_SPLO) 
		{
				//Ignore
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_WNAM) 
		{
				//Ignore
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_BODT) 
		{
				//Ignore
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_KSIZ) 
		{
				//Ignore
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_KWDA) 
		{
				//Ignore
		}
		else if (pSubrecord->GetRecordType() == SR_NAME_DATA) 
		{
				//Ignore
		}
		else
		{
			SystemLog.Printf("Warning: Unknown subrecord %4.4s found in RACE!", pSubrecord->GetRecordType().Name);
		}

		LastType = pSubrecord->GetRecordType();
	}

	return true;
}


bool CSrRaceRecord::CreateFromRaceInfo (srraceinfo_t& RaceInfo)
{
#define COPYARRAY(TYPE, ARRAY) for (dword i = 0; i < ARRAY.GetSize(); ++i) { AddNewSubrecord(TYPE)->Copy(ARRAY[i]); }

	CSrSubrecord* pSubrecord;

	DeleteSubrecords(SR_NAME_MNAM);	DeleteSubrecords(SR_NAME_FNAM);	DeleteSubrecords(SR_NAME_ANAM);	DeleteSubrecords(SR_NAME_MODT);
	DeleteSubrecords(SR_NAME_MTNM);	DeleteSubrecords(SR_NAME_VTCK);	DeleteSubrecords(SR_NAME_HCLF);	DeleteSubrecords(SR_NAME_DNAM);
	DeleteSubrecords(SR_NAME_TINL);	DeleteSubrecords(SR_NAME_PNAM);	DeleteSubrecords(SR_NAME_UNAM);	DeleteSubrecords(SR_NAME_ATKD);
	DeleteSubrecords(SR_NAME_ATKE);	DeleteSubrecords(SR_NAME_NAM1);	DeleteSubrecords(SR_NAME_INDX);	DeleteSubrecords(SR_NAME_MODL);
	DeleteSubrecords(SR_NAME_GNAM);	DeleteSubrecords(SR_NAME_NAM4);	DeleteSubrecords(SR_NAME_NAM5);	DeleteSubrecords(SR_NAME_NAM7);
	DeleteSubrecords(SR_NAME_ONAM);	DeleteSubrecords(SR_NAME_LNAM);	DeleteSubrecords(SR_NAME_NAME);	DeleteSubrecords(SR_NAME_MTYP);
	DeleteSubrecords(SR_NAME_SPED);	DeleteSubrecords(SR_NAME_VNAM);	DeleteSubrecords(SR_NAME_QNAM);	DeleteSubrecords(SR_NAME_UNES);
	DeleteSubrecords(SR_NAME_PHTN);	DeleteSubrecords(SR_NAME_PHWT);	DeleteSubrecords(SR_NAME_NAM0);	DeleteSubrecords(SR_NAME_HEAD);
	DeleteSubrecords(SR_NAME_MPAI);	DeleteSubrecords(SR_NAME_MPAV);	DeleteSubrecords(SR_NAME_RPRM);	DeleteSubrecords(SR_NAME_RPRF);
	DeleteSubrecords(SR_NAME_AHCM);	DeleteSubrecords(SR_NAME_AHCF);	DeleteSubrecords(SR_NAME_FTSM);	DeleteSubrecords(SR_NAME_FTSF);	
	DeleteSubrecords(SR_NAME_DFTF);	DeleteSubrecords(SR_NAME_DFTM);	DeleteSubrecords(SR_NAME_TINI);	DeleteSubrecords(SR_NAME_TINT);
	DeleteSubrecords(SR_NAME_TINP);	DeleteSubrecords(SR_NAME_TIND);	DeleteSubrecords(SR_NAME_TINC);	DeleteSubrecords(SR_NAME_TINV);
	DeleteSubrecords(SR_NAME_TIRS);	DeleteSubrecords(SR_NAME_NAM8);	DeleteSubrecords(SR_NAME_RNAM);	DeleteSubrecords(SR_NAME_WKMV);
	DeleteSubrecords(SR_NAME_RNMV);	DeleteSubrecords(SR_NAME_SWMV);	DeleteSubrecords(SR_NAME_FLMV);	DeleteSubrecords(SR_NAME_SNMV);
	DeleteSubrecords(SR_NAME_NAM3);

	AddNewSubrecord(SR_NAME_MNAM);
	pSubrecord = AddNewSubrecord(SR_NAME_ANAM);
	if (RaceInfo.MaleModel.pModel) pSubrecord->Copy(RaceInfo.MaleModel.pModel);
	if (RaceInfo.MaleModel.pModt)  AddNewSubrecord(SR_NAME_MODT)->Copy(RaceInfo.MaleModel.pModt);

	AddNewSubrecord(SR_NAME_FNAM);
	if (RaceInfo.FemaleModel.pModel) AddNewSubrecord(SR_NAME_ANAM)->Copy(RaceInfo.FemaleModel.pModel);
	if (RaceInfo.FemaleModel.pModt)  AddNewSubrecord(SR_NAME_MODT)->Copy(RaceInfo.FemaleModel.pModt);

	COPYARRAY(SR_NAME_MTNM, RaceInfo.MovementNames);
		
	AddNewSubrecord(SR_NAME_VTCK)->Copy(&RaceInfo.VoiceTypes);
	if (RaceInfo.HairColors.GetArraySize()       > 0) AddNewSubrecord(SR_NAME_HCLF)->Copy(&RaceInfo.HairColors);
	if (RaceInfo.DecapitatedHeads.GetArraySize() > 0) AddNewSubrecord(SR_NAME_DNAM)->Copy(&RaceInfo.DecapitatedHeads);
	if (RaceInfo.pTinl != NULL) AddNewSubrecord(SR_NAME_TINL)->Copy(RaceInfo.pTinl);

	AddNewSubrecord(SR_NAME_PNAM)->Copy(&RaceInfo.PName);
	AddNewSubrecord(SR_NAME_UNAM)->Copy(&RaceInfo.UName);

	for (dword i = 0; i < RaceInfo.Attacks.GetSize(); ++i)
	{
		AddNewSubrecord(SR_NAME_ATKD)->Copy(&RaceInfo.Attacks[i]->Data);
		AddNewSubrecord(SR_NAME_ATKE)->Copy(&RaceInfo.Attacks[i]->Event);
	}

	AddNewSubrecord(SR_NAME_NAM1);
	AddNewSubrecord(SR_NAME_MNAM);
	AddNewSubrecord(SR_NAME_INDX)->Copy(&RaceInfo.MaleEgt.Index);
	AddNewSubrecord(SR_NAME_MODL)->Copy(&RaceInfo.MaleEgt.Model);
	AddNewSubrecord(SR_NAME_MODT)->Copy(&RaceInfo.MaleEgt.Modt);

	AddNewSubrecord(SR_NAME_FNAM);
	AddNewSubrecord(SR_NAME_INDX)->Copy(&RaceInfo.FemaleEgt.Index);
	AddNewSubrecord(SR_NAME_MODL)->Copy(&RaceInfo.FemaleEgt.Model);
	AddNewSubrecord(SR_NAME_MODT)->Copy(&RaceInfo.FemaleEgt.Modt);

	AddNewSubrecord(SR_NAME_GNAM)->Copy(&RaceInfo.BodyData);

	AddNewSubrecord(SR_NAME_NAM3);
	AddNewSubrecord(SR_NAME_MNAM);
	AddNewSubrecord(SR_NAME_MODL)->Copy(&RaceInfo.MaleHavok.Model);
	AddNewSubrecord(SR_NAME_MODT)->Copy(&RaceInfo.MaleHavok.Modt);

	AddNewSubrecord(SR_NAME_FNAM);
	AddNewSubrecord(SR_NAME_MODL)->Copy(&RaceInfo.FemaleHavok.Model);
	AddNewSubrecord(SR_NAME_MODT)->Copy(&RaceInfo.FemaleHavok.Modt);

	if (RaceInfo.pMaterial   != NULL) AddNewSubrecord(SR_NAME_NAM4)->Copy(RaceInfo.pMaterial);
	if (RaceInfo.pImpactData != NULL) AddNewSubrecord(SR_NAME_NAM5)->Copy(RaceInfo.pImpactData);
	if (RaceInfo.pBloodFX    != NULL) AddNewSubrecord(SR_NAME_NAM7)->Copy(RaceInfo.pBloodFX);
	if (RaceInfo.pOpenSound  != NULL) AddNewSubrecord(SR_NAME_ONAM)->Copy(RaceInfo.pOpenSound);
	if (RaceInfo.pCloseSound != NULL) AddNewSubrecord(SR_NAME_LNAM)->Copy(RaceInfo.pCloseSound);

	COPYARRAY(SR_NAME_NAME, RaceInfo.BodyNames);

	for (dword i = 0; i < RaceInfo.MovementTypes.GetSize(); ++i)
	{
		AddNewSubrecord(SR_NAME_MTYP)->Copy(&RaceInfo.MovementTypes[i]->MoveType);
		AddNewSubrecord(SR_NAME_SPED)->Copy(&RaceInfo.MovementTypes[i]->SpeedData);
	}

	if (RaceInfo.pVName != NULL) AddNewSubrecord(SR_NAME_VNAM)->Copy(RaceInfo.pVName);

	COPYARRAY(SR_NAME_QNAM, RaceInfo.EquipSlots);
	AddNewSubrecord(SR_NAME_UNES)->Copy(&RaceInfo.UnequipSlot);

	COPYARRAY(SR_NAME_PHTN, RaceInfo.FacialKeys);
	COPYARRAY(SR_NAME_PHWT, RaceInfo.FacialWeights);

		/* Start male head data */
	if (RaceInfo.pName0M != NULL)
	{
		AddNewSubrecord(SR_NAME_NAM0);
		AddNewSubrecord(SR_NAME_MNAM);

		for (dword i = 0; i < RaceInfo.MaleHead.HeadData.GetSize(); ++i)
		{
			AddNewSubrecord(SR_NAME_INDX)->Copy(&RaceInfo.MaleHead.HeadData[i]->Index);
			AddNewSubrecord(SR_NAME_HEAD)->Copy(&RaceInfo.MaleHead.HeadData[i]->Data);
		}

		for (dword i = 0; i < RaceInfo.MaleHead.MPAData.GetSize(); ++i)
		{
			AddNewSubrecord(SR_NAME_MPAI)->Copy(&RaceInfo.MaleHead.MPAData[i]->Index);
			AddNewSubrecord(SR_NAME_MPAV)->Copy(&RaceInfo.MaleHead.MPAData[i]->Data);
		}

		COPYARRAY(SR_NAME_RPRM, RaceInfo.MaleHead.RacialPresets);
		COPYARRAY(SR_NAME_AHCM, RaceInfo.MaleHead.HairColors);
		COPYARRAY(SR_NAME_FTSM, RaceInfo.MaleHead.FeatureSets);
		if (RaceInfo.MaleHead.pHeadFeature != NULL) AddNewSubrecord(SR_NAME_DFTM)->Copy(RaceInfo.MaleHead.pHeadFeature);

		for (dword i = 0; i < RaceInfo.MaleHead.Tints.GetSize(); ++i)
		{
			srraceheadtintinfo_t& Tint = *RaceInfo.MaleHead.Tints[i];

			AddNewSubrecord(SR_NAME_TINI)->Copy(&Tint.Index);
			if (Tint.pMaskFile != NULL) AddNewSubrecord(SR_NAME_TINT)->Copy(Tint.pMaskFile);
			if (Tint.pTinp     != NULL) AddNewSubrecord(SR_NAME_TINP)->Copy(Tint.pTinp);
			if (Tint.pColor    != NULL) AddNewSubrecord(SR_NAME_TIND)->Copy(Tint.pColor);

			for (dword j = 0; j < Tint.Tints.GetSize(); ++j)
			{
				AddNewSubrecord(SR_NAME_TINC)->Copy(&Tint.Tints[j]->Tinc);
				AddNewSubrecord(SR_NAME_TINV)->Copy(&Tint.Tints[j]->Tinv);
				AddNewSubrecord(SR_NAME_TIRS)->Copy(&Tint.Tints[j]->Tirs);
			}

		} 
	} //End of male head data

		/* Start female head data */
	if (RaceInfo.pName0F != NULL)
	{
		AddNewSubrecord(SR_NAME_NAM0);
		AddNewSubrecord(SR_NAME_FNAM);

		for (dword i = 0; i < RaceInfo.FemaleHead.HeadData.GetSize(); ++i)
		{
			AddNewSubrecord(SR_NAME_INDX)->Copy(&RaceInfo.FemaleHead.HeadData[i]->Index);
			AddNewSubrecord(SR_NAME_HEAD)->Copy(&RaceInfo.FemaleHead.HeadData[i]->Data);
		}

		for (dword i = 0; i < RaceInfo.FemaleHead.MPAData.GetSize(); ++i)
		{
			AddNewSubrecord(SR_NAME_MPAI)->Copy(&RaceInfo.FemaleHead.MPAData[i]->Index);
			AddNewSubrecord(SR_NAME_MPAV)->Copy(&RaceInfo.FemaleHead.MPAData[i]->Data);
		}

		COPYARRAY(SR_NAME_RPRF, RaceInfo.FemaleHead.RacialPresets);
		COPYARRAY(SR_NAME_AHCF, RaceInfo.FemaleHead.HairColors);
		COPYARRAY(SR_NAME_FTSF, RaceInfo.FemaleHead.FeatureSets);
		if (RaceInfo.FemaleHead.pHeadFeature != NULL) AddNewSubrecord(SR_NAME_DFTF)->Copy(RaceInfo.FemaleHead.pHeadFeature);

		for (dword i = 0; i < RaceInfo.FemaleHead.Tints.GetSize(); ++i)
		{
			srraceheadtintinfo_t& Tint = *RaceInfo.FemaleHead.Tints[i];

			AddNewSubrecord(SR_NAME_TINI)->Copy(&Tint.Index);
			if (Tint.pMaskFile != NULL) AddNewSubrecord(SR_NAME_TINT)->Copy(Tint.pMaskFile);
			if (Tint.pTinp     != NULL) AddNewSubrecord(SR_NAME_TINP)->Copy(Tint.pTinp);
			if (Tint.pColor    != NULL) AddNewSubrecord(SR_NAME_TIND)->Copy(Tint.pColor);

			for (dword j = 0; j < Tint.Tints.GetSize(); ++j)
			{
				AddNewSubrecord(SR_NAME_TINC)->Copy(&Tint.Tints[j]->Tinc);
				AddNewSubrecord(SR_NAME_TINV)->Copy(&Tint.Tints[j]->Tinv);
				AddNewSubrecord(SR_NAME_TIRS)->Copy(&Tint.Tints[j]->Tirs);
			}

		}
	}//End of female head data

	if (RaceInfo.pNam8  != NULL) AddNewSubrecord(SR_NAME_NAM8)->Copy(RaceInfo.pNam8);
	if (RaceInfo.pRName != NULL) AddNewSubrecord(SR_NAME_RNAM)->Copy(RaceInfo.pRName);

	if (RaceInfo.pWalkMove  != NULL) AddNewSubrecord(SR_NAME_WKMV)->Copy(RaceInfo.pWalkMove);
	if (RaceInfo.pRunMove   != NULL) AddNewSubrecord(SR_NAME_RNMV)->Copy(RaceInfo.pRunMove);
	if (RaceInfo.pSwimMove  != NULL) AddNewSubrecord(SR_NAME_SWMV)->Copy(RaceInfo.pSwimMove);
	if (RaceInfo.pFlyMove   != NULL) AddNewSubrecord(SR_NAME_FLMV)->Copy(RaceInfo.pFlyMove);
	if (RaceInfo.pSneakMove != NULL) AddNewSubrecord(SR_NAME_SNMV)->Copy(RaceInfo.pSneakMove);

	return true;
}



void srracemodelinfo_t::SetModel (const char* pString)
{
	if (pString == NULL || *pString == '\0')
	{
		Destroy();
		return;
	}

	if (pModel == NULL)
	{
		pModel = new CSrStringSubrecord;
		pModel->InitializeNew(SR_NAME_ANAM, 0);
	}

	if (pModt == NULL)
	{
		pModt = new CSrDataSubrecord;
		CSrRaceRecord::InitializeModtData(pModt);
	}

	pModel->SetString(pString);
}


void srraceegtinfo_t::CheckNew()
{
	if (Model.GetRecordType() != SR_NAME_MODL) 
	{
		SystemLog.Printf("Warning: Race MODL subrecord in EGT model section is not initialized!");
		Model.Initialize(SR_NAME_MODL, 0);
	}

	if (Index.GetRecordType() != SR_NAME_INDX) 
	{
		SystemLog.Printf("Warning: Race INDX subrecord in EGT model section is not initialized!");
		Index.Initialize(SR_NAME_INDX, 0);
	}

	if (Modt.GetRecordType() != SR_NAME_MODT)
	{
		SystemLog.Printf("Warning: Race MODT subrecord in EGT model section is not initialized!");
		Modt.Initialize(SR_NAME_MODT, 12);
		CSrRaceRecord::InitializeModtData(&Modt);
	}
}


void srracehavokinfo_t::CheckNew()
{
	if (Model.GetRecordType() != SR_NAME_MODL) 
	{
		SystemLog.Printf("Warning: Race MODL subrecord in Havok model section is not initialized!");
		Model.Initialize(SR_NAME_MODL, 0);
	}

	if (Modt.GetRecordType() != SR_NAME_MODT)
	{
		SystemLog.Printf("Warning: Race MODT subrecord in Havok model section is not initialized!");
		Modt.Initialize(SR_NAME_MODT, 12);
		CSrRaceRecord::InitializeModtData(&Modt);
	}
}