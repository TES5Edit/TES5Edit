/*===========================================================================
 *
 * File:		SrArmaRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srArmarecord.h"


srarmadnamdata_t CSrArmaRecord::s_NullDnamData;
srbodtdata_t     CSrArmaRecord::s_NullBodtData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrArmaRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_MODL, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BODT, CSrBodtSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MOD2, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MOD3, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MOD4, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MOD5, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_RNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_DNAM, CSrArmaDnamSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNDD, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM0, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM1, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM2, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_NAM3, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MO2T, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MO3T, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MO3S, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MO2S, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MO4S, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MO5T, CSrDataSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_MO4T, CSrDataSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrArmaRecord, CSrIdRecord)
	ADD_SRFIELDALL("Race",				SR_FIELD_RACE,				0, CSrArmaRecord, FieldRace)
	ADD_SRFIELDALL("Playable",			SR_FIELD_PLAYABLE,			0, CSrArmaRecord, FieldPlayable)
	ADD_SRFIELDALL("BodyParts",			SR_FIELD_BODYPARTS,			0, CSrArmaRecord, FieldBodyParts)
	ADD_SRFIELDALL("Type",				SR_FIELD_TYPE,				0, CSrArmaRecord, FieldType)
	ADD_SRFIELDALL("FemaleModel",		SR_FIELD_FEMALEMODEL,		0, CSrArmaRecord, FieldFemaleModel)
	ADD_SRFIELDALL("MaleModel",			SR_FIELD_MALEMODEL,			0, CSrArmaRecord, FieldMaleModel)
	ADD_SRFIELDALL("Female1stModel",	SR_FIELD_FEMALE1STMODEL,	0, CSrArmaRecord, FieldFemale1stModel)
	ADD_SRFIELDALL("Male1stModel",		SR_FIELD_MALE1STMODEL,		0, CSrArmaRecord, FieldMale1stModel)
	ADD_SRFIELDALL("Footsteps",			SR_FIELD_FOOTSTEPS,			0, CSrArmaRecord, FieldFootsteps)
	ADD_SRFIELDALL("MaleTexture",		SR_FIELD_MALETEXTURE,		0, CSrArmaRecord, FieldMaleTexture)
	ADD_SRFIELDALL("FemaleTexture",		SR_FIELD_FEMALETEXTURE,		0, CSrArmaRecord, FieldFemaleTexture)
	ADD_SRFIELDALL("Male1stTexture",	SR_FIELD_MALE1STTEXTURE,	0, CSrArmaRecord, FieldMale1stTexture)
	ADD_SRFIELDALL("Female1stTexture",	SR_FIELD_FEMALE1STTEXTURE,	0, CSrArmaRecord, FieldFemale1stTexture)
	ADD_SRFIELDALL("Unknown1",			SR_FIELD_UNKNOWN1,			0, CSrArmaRecord, FieldUnknown1)
	ADD_SRFIELDALL("Unknown2",			SR_FIELD_UNKNOWN2,			0, CSrArmaRecord, FieldUnknown2)
	ADD_SRFIELDALL("Unknown3",			SR_FIELD_UNKNOWN3,			0, CSrArmaRecord, FieldUnknown3)
	ADD_SRFIELDALL("RaceCount",			SR_FIELD_RACECOUNT,			0, CSrArmaRecord, FieldRaceCount)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrArmaRecord Constructor
 *
 *=========================================================================*/
CSrArmaRecord::CSrArmaRecord () 
{
	m_pBodtData = NULL;
	m_pModel2 = NULL;
	m_pModel3 = NULL;
	m_pModel4 = NULL;
	m_pModel5 = NULL;
	m_pRace = NULL;
	m_pMaleTexture = NULL;
	m_pFemaleTexture = NULL;
	m_pMale1stTexture = NULL;
	m_pFemale1stTexture = NULL;
	m_pFootsteps = NULL;
	m_pDnamData = NULL;	
}
/*===========================================================================
 *		End of Class CSrArmaRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrArmaRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrArmaRecord::Destroy (void) 
{
	m_pBodtData = NULL;
	m_pModel2 = NULL;
	m_pModel3 = NULL;
	m_pModel4 = NULL;
	m_pModel5 = NULL;
	m_pRace = NULL;
	m_pMaleTexture = NULL;
	m_pFemaleTexture = NULL;
	m_pMale1stTexture = NULL;
	m_pFemale1stTexture = NULL;
	m_pFootsteps = NULL;
	m_pDnamData = NULL;	

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrArmaRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrArmaRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrArmaRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_BODT);
	if (m_pBodtData != NULL) m_pBodtData->InitializeNew();

	AddNewSubrecord(SR_NAME_RNAM);
	if (m_pRace != NULL) m_pRace->InitializeNew();

	AddNewSubrecord(SR_NAME_DNAM);
	if (m_pDnamData != NULL) m_pDnamData->InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrArmaRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrArmaRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrArmaRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_MOD4)
	{
		m_pModel4 = SrCastClass(CSrStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BODT)
	{
		m_pBodtData = SrCastClass(CSrBodtSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MOD3)
	{
		m_pModel3 = SrCastClass(CSrStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_RNAM)
	{
		m_pRace = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MOD2)
	{
		m_pModel2 = SrCastClass(CSrStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_DNAM)
	{
		m_pDnamData = SrCastClass(CSrArmaDnamSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM0)
	{
		m_pMaleTexture = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNDD)
	{
		m_pFootsteps = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM1)
	{
		m_pFemaleTexture = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_MOD5)
	{
		m_pModel5 = SrCastClass(CSrStringSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM2)
	{
		m_pMale1stTexture = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_NAM3)
	{
		m_pFemale1stTexture = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrArmaRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrArmaRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrArmaRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pModel4 == pSubrecord)
		m_pModel4 = NULL;
	else if (m_pBodtData == pSubrecord)
		m_pBodtData = NULL;
	else if (m_pModel3 == pSubrecord)
		m_pModel3 = NULL;
	else if (m_pRace == pSubrecord)
		m_pRace = NULL;
	else if (m_pModel2 == pSubrecord)
		m_pModel2 = NULL;
	else if (m_pDnamData == pSubrecord)
		m_pDnamData = NULL;
	else if (m_pMaleTexture == pSubrecord)
		m_pMaleTexture = NULL;
	else if (m_pFootsteps == pSubrecord)
		m_pFootsteps = NULL;
	else if (m_pFemaleTexture == pSubrecord)
		m_pFemaleTexture = NULL;
	else if (m_pModel5 == pSubrecord)
		m_pModel5 = NULL;
	else if (m_pMale1stTexture == pSubrecord)
		m_pMale1stTexture = NULL;
	else if (m_pFemale1stTexture == pSubrecord)
		m_pFemale1stTexture = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrArmaRecord::OnDeleteSubrecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrArmaRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrArmaRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrArmaRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrArmaRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrArmaRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrArmaRecord Set Field Methods
 *=========================================================================*/
