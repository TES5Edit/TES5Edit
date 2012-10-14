/*===========================================================================
 *
 * File:		SrSndrRecord.CPP
 * Author:		Dave Humphrey (dave@uesp.net)
 * Created On:	5 December 2011
 *
 * Description
 *
 *=========================================================================*/

	/* Include Files */
#include "srSndrrecord.h"


srsndrbnamdata_t CSrSndrRecord::s_NullBnamData;


/*===========================================================================
 *
 * Begin Subrecord Creation Array
 *
 *=========================================================================*/
BEGIN_SRSUBRECCREATE(CSrSndrRecord, CSrIdRecord)
	DEFINE_SRSUBRECCREATE(SR_NAME_FNAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_SNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CNAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ONAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_GNAM, CSrFormidSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CTDA, CSrCtdaSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS1, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_CIS2, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_ANAM, CSrStringSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_LNAM, CSrDwordSubrecord::Create)
	DEFINE_SRSUBRECCREATE(SR_NAME_BNAM, CSrSndrBnamSubrecord::Create)
END_SRSUBRECCREATE()
/*===========================================================================
 *		End of Subrecord Creation Array
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrIdRecord Field Map
 *
 *=========================================================================*/
BEGIN_SRFIELDMAP(CSrSndrRecord, CSrIdRecord)
	ADD_SRFIELDALL("ConditionCount",	SR_FIELD_CONDITIONCOUNT,	0, CSrSndrRecord, FieldConditionCount)
	ADD_SRFIELDALL("SoundCount",		SR_FIELD_SOUNDCOUNT,		0, CSrSndrRecord, FieldSoundFileCount)
	ADD_SRFIELDALL("Category",			SR_FIELD_CATEGORY,			0, CSrSndrRecord, FieldCategory)
	ADD_SRFIELDALL("OutputMarker",		SR_FIELD_OUTPUTMARKER,		0, CSrSndrRecord, FieldOutputMarker)
	ADD_SRFIELDALL("Sound",				SR_FIELD_SOUND,				0, CSrSndrRecord, FieldSound)
	ADD_SRFIELDALL("FName",				SR_FIELD_FNAME,				0, CSrSndrRecord, FieldFName)
	ADD_SRFIELDALL("CName",				SR_FIELD_CNAME,				0, CSrSndrRecord, FieldCName)
	ADD_SRFIELDALL("SoundFlags",		SR_FIELD_SOUNDFLAGS,		0, CSrSndrRecord, FieldSoundFlags)
	ADD_SRFIELDALL("Unknown1",			SR_FIELD_UNKNOWN1,			0, CSrSndrRecord, FieldUnknown1)
	ADD_SRFIELDALL("Unknown2",			SR_FIELD_UNKNOWN2,			0, CSrSndrRecord, FieldUnknown2)
	ADD_SRFIELDALL("Unknown3",			SR_FIELD_UNKNOWN3,			0, CSrSndrRecord, FieldUnknown3)
END_SRFIELDMAP()
/*===========================================================================
 *		End of CObRecord Field Map
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSndrRecord Constructor
 *
 *=========================================================================*/
CSrSndrRecord::CSrSndrRecord () 
{
	m_pFnamData = NULL;
	m_pSound = NULL;
	m_pCnamData = NULL;
	m_pOutputMarker = NULL;
	m_pCategory = NULL;
	m_pFlags = NULL;
	m_pSndrData = NULL;
}
/*===========================================================================
 *		End of Class CSrSndrRecord Constructor
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSndrRecord Method - void Destroy (void);
 *
 *=========================================================================*/
void CSrSndrRecord::Destroy (void) 
{
	m_pFnamData = NULL;
	m_pSound = NULL;
	m_pCnamData = NULL;
	m_pOutputMarker = NULL;
	m_pCategory = NULL;
	m_pFlags = NULL;
	m_pSndrData = NULL;

	CSrIdRecord::Destroy();
}
/*===========================================================================
 *		End of Class Method CSrSndrRecord::Destroy()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSndrRecord Method - void InitializeNew (void);
 *
 *=========================================================================*/
void CSrSndrRecord::InitializeNew (void) 
{
	CSrIdRecord::InitializeNew();

	AddNewSubrecord(SR_NAME_CNAM);
	if (m_pCnamData != NULL) m_pCnamData->InitializeNew();

	AddNewSubrecord(SR_NAME_ONAM);
	if (m_pOutputMarker != NULL) m_pOutputMarker->InitializeNew();

	AddNewSubrecord(SR_NAME_BNAM);
	if (m_pSndrData != NULL) m_pSndrData->InitializeNew();

}
/*===========================================================================
 *		End of Class Method CSrSndrRecord::InitializeNew()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSndrRecord Event - void OnAddSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSndrRecord::OnAddSubrecord (CSrSubrecord* pSubrecord) {

	if (pSubrecord->GetRecordType() == SR_NAME_FNAM)
	{
		m_pFnamData = SrCastClass(CSrDwordSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_SNAM)
	{
		m_pSound = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_CNAM)
	{
		m_pCnamData = SrCastClass(CSrDwordSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_ONAM)
	{
		m_pOutputMarker = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_GNAM)
	{
		m_pCategory = SrCastClass(CSrFormidSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_LNAM)
	{
		m_pFlags = SrCastClass(CSrDwordSubrecord, pSubrecord);
	}
	else if (pSubrecord->GetRecordType() == SR_NAME_BNAM)
	{
		m_pSndrData = SrCastClass(CSrSndrBnamSubrecord, pSubrecord);
	}
	else
	{
		CSrIdRecord::OnAddSubrecord(pSubrecord);
	}

}
/*===========================================================================
 *		End of Class Event CSrSndrRecord::OnAddSubRecord()
 *=========================================================================*/


/*===========================================================================
 *
 * Class CSrSndrRecord Event - void OnDeleteSubrecord (pSubrecord);
 *
 *=========================================================================*/
void CSrSndrRecord::OnDeleteSubrecord (CSrSubrecord* pSubrecord) {

	if (m_pFnamData == pSubrecord)
		m_pFnamData = NULL;
	else if (m_pSound == pSubrecord)
		m_pSound = NULL;
	else if (m_pCnamData == pSubrecord)
		m_pCnamData = NULL;
	else if (m_pOutputMarker == pSubrecord)
		m_pOutputMarker = NULL;
	else if (m_pCategory == pSubrecord)
		m_pCategory = NULL;
	else if (m_pFlags == pSubrecord)
		m_pFlags = NULL;
	else if (m_pSndrData == pSubrecord)
		m_pSndrData = NULL;
	else
		CSrIdRecord::OnDeleteSubrecord(pSubrecord);

}
/*===========================================================================
 *		End of Class Event CSrSndrRecord::OnDeleteSubrecord()
 *=========================================================================*/


CSrStringSubrecord* CSrSndrRecord::AddSoundFile (const char* pFilename)
{
	CSrStringSubrecord* pNewString;

	if (pFilename == NULL || pFilename[0] == 0) return NULL;

	CSrSubrecord* pSubrecord = AddNewSubrecord(SR_NAME_ANAM);
	pNewString = SrCastClassNull(CSrStringSubrecord, pSubrecord);
	if (pNewString == NULL) return NULL;

	pNewString->InitializeNew();
	pNewString->SetString(pFilename);

	return pNewString;
}


/*===========================================================================
 *
 * Begin CSrSndrRecord Get Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSndrRecord Get Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSndrRecord Compare Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSndrRecord Compare Field Methods
 *=========================================================================*/


/*===========================================================================
 *
 * Begin CSrSndrRecord Set Field Methods
 *
 *=========================================================================*/
/*===========================================================================
 *		End of CSrSndrRecord Set Field Methods
 *=========================================================================*/
